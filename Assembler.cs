using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace SSCPU
{
    internal class Assembler
    {

        static readonly Regex whiteSpaceRegex = new Regex("\\s+");
        static void Main(string[] args)
        {
            if (args.Length != 2)
            {
                Console.WriteLine("You should specify one input and one output file");
                return;
            }

            if (!(File.Exists(args[0]) && File.Exists(args[1])))
            {
                Console.WriteLine("File doesn't exist!");
                return;
            }

            string[] ops = ReadInputFile(args[0]);

            string machineCode = "";

            try
            {
                machineCode = Assemble(ops);

                if (machineCode is null)
                {
                    Console.WriteLine("Instruction Error");
                    return;
                }
            }
            catch (Exception)
            {
                Console.WriteLine("Instruction Error");
                return;
            }

            WriteToOutputFile(args[1], machineCode);
            Console.WriteLine(machineCode);
        }

        static string[] ReadInputFile(string file)
        {
            using (StreamReader reader = new StreamReader(file))
            {
                string fileContents = reader.ReadToEnd();
                return whiteSpaceRegex.Split(fileContents);
            }
        }

        static string Assemble(string[] ops)
        {
            StringBuilder assembler = new StringBuilder();
            Instruction currentInstruction = null;
            InstructionRule currentInstructionRule = null;

            foreach (var op in ops)
            {
                if ((currentInstructionRule = InstructionRule.GetInstruction(op)) is not null)
                {
                    if(currentInstruction is not null)
                    {
                        if(currentInstruction.IsInstructionComplete())
                        {
                            assembler.AppendLine(currentInstruction.ToString());
                        }
                        else
                        {
                            Console.WriteLine("lol");
                            return null;
                        }
                    }

                    currentInstruction = new Instruction(currentInstructionRule);
                }
                else if (op.StartsWith('R'))
                {
                    int registerNo = Convert.ToInt32(op[1..]);
                    string register = Convert.ToString(registerNo, 2);
                    int extensionBits = 4 - register.Length;

                    if(extensionBits > 0)
                    {
                        StringBuilder reg = new StringBuilder();

                        for (int i = 0; i < extensionBits; i++)
                        {
                            reg.Append("0");
                        }

                        reg.Append(register);
                        register = reg.ToString();
                    }
                    else if(extensionBits < 0)
                    {
                        Console.WriteLine("fuck you");
                        return null;
                    }

                    currentInstruction.AddRegister(register);
                }
                else if (op.StartsWith("0x"))
                {
                    int immediateValue = Convert.ToInt32(op, 16);
                    currentInstruction.AddImmediate(immediateValue);
                }
                else if (op.StartsWith("0b"))
                {
                    StringBuilder temp = new StringBuilder(op);
                    temp.Remove(0, 2);
                    int immediateValue = Convert.ToInt32(temp.ToString(), 2);
                    currentInstruction.AddImmediate(immediateValue);
                }
                else
                {
                    int immediateValue = Convert.ToInt32(op);
                    currentInstruction.AddImmediate(immediateValue);
                }
            }

            assembler.AppendLine(currentInstruction.ToString());

            return assembler.ToString();
        }

        static void WriteToOutputFile(string file, string content)
        {
            using (StreamWriter writer = new StreamWriter(file))
            {
                writer.Write(content);
            }
        }
    }
}
