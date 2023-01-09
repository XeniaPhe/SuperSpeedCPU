using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace SSCPU
{
    internal class Assembler
    {
        private static Instruction currentInstruction = null;
        private static int lineCounter = 0;

        public static void Main(string[] args)
        {
            if (args.Length != 4)
            {
                Console.WriteLine("You should specify one input and three output files");
                return;
            }

            if (!(File.Exists(args[0]) && File.Exists(args[1]) && File.Exists(args[2]) && File.Exists(args[3])))
            {
                Console.WriteLine("File doesn't exist!");
                return;
            }

            string[] ops = ReadInputFile(args[0]);
            string machineCode = "";
            StringBuilder logisimMemoryImage = new StringBuilder("v2.0 raw\n");

            try
            {
                machineCode = Assemble(ops);
                logisimMemoryImage.Append(machineCode);

                if (machineCode is null)
                    return;
            }
            catch (Exception)
            {
                PrintError("Number Error!");
                return;
            }

            WriteToOutputFile(args[1], machineCode);
            WriteToOutputFile(args[2], logisimMemoryImage.ToString());
            WriteToOutputFile(args[3], machineCode);
        }

        private static string Assemble(string[] ops)
        {
            StringBuilder assembler = new StringBuilder();


            InstructionRule currentInstructionRule = null;


            foreach (var op in ops)
            {
                if ((currentInstructionRule = InstructionRule.GetInstruction(op)) is not null)
                {
                    if (currentInstruction is not null)
                    {
                        if (currentInstruction.IsInstructionComplete())
                        {
                            assembler.AppendLine(currentInstruction.ToString());
                        }
                        else
                        {
                            PrintError("Instruction is not Complete!");
                            return null;
                        }
                    }

                    currentInstruction = new Instruction(currentInstructionRule);
                    lineCounter++;
                }
                else if (op.StartsWith('R'))
                {
                    int registerNo = Convert.ToInt32(op[1..]);
                    string register = Convert.ToString(registerNo, 2);
                    int extensionBits = 4 - register.Length;

                    if (extensionBits > 0)
                    {
                        StringBuilder reg = new StringBuilder();

                        for (int i = 0; i < extensionBits; i++)
                        {
                            reg.Append("0");
                        }

                        reg.Append(register);
                        register = reg.ToString();
                    }
                    else if (extensionBits < 0)
                    {
                        PrintError("Unknown register!");
                        return null;
                    }

                    if (!currentInstruction.AddRegister(register))
                    {
                        PrintError("Invalid instruction order!");
                        return null;
                    }
                }
                else if (op.StartsWith("0x"))
                {
                    int immediateValue = Convert.ToInt32(op, 16);

                    if (op[0] >= '8')
                    {
                        immediateValue -= 2 * (1 << (4 * op.Length - 1));
                    }

                    if (!currentInstruction.AddImmediate(immediateValue))
                    {
                        PrintError("Immediate error!");
                        return null;
                    }
                }
                else if (op.StartsWith("0b"))
                {
                    StringBuilder temp = new StringBuilder(op);
                    temp.Remove(0, 2);
                    int immediateValue = Convert.ToInt32(temp.ToString(), 2);

                    if (temp[0] == '1')
                    {
                        immediateValue -= 2 * (1 << (temp.Length - 1));
                    }

                    if (!currentInstruction.AddImmediate(immediateValue))
                    {
                        PrintError("Immediate error!");
                        return null;
                    }
                }
                else
                {
                    int immediateValue = Convert.ToInt32(op);

                    if (!currentInstruction.AddImmediate(immediateValue))
                    {
                        PrintError("Immediate error!");
                        return null;
                    }
                }
            }

            assembler.AppendLine(currentInstruction.ToString());
            return assembler.ToString();
        }

        private static void PrintError(string error)
        {
            Console.WriteLine($"Error : {error}");
            Console.WriteLine("Error Details : ");
            Console.WriteLine($"At Line {lineCounter}");
            Console.WriteLine($"At Instruction {currentInstruction.Opcode}");
        }

        private static string[] ReadInputFile(string file)
        {
            using (StreamReader reader = new StreamReader(file))
            {
                Regex whiteSpaceRegex = new Regex("\\s+");
                string fileContents = reader.ReadToEnd();
                return whiteSpaceRegex.Split(fileContents);
            }
        }

        private static void WriteToOutputFile(string file, string content)
        {
            using (StreamWriter writer = new StreamWriter(file))
            {
                writer.Write(content);
            }
        }
    }
}
