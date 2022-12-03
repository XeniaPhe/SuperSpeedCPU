using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace SSCPU
{
    internal class Program
    {
        static readonly Dictionary<string, string> opcodes = new Dictionary<string, string>()
        {
            { "ADD", "00001" },
            { "SUB", "00011" },
            { "AND", "00101" },
            { "OR", "00111" },
            { "XOR", "01001" },
            { "ADDI", "00010" },
            { "SUBI", "00100" },
            { "ANDI", "00110" },
            { "ORI", "01000" },
            { "XORI", "01010" },
            { "LD", "01011" },
            { "ST", "01100" },
            { "PUSH", "01101" },
            { "POP", "01110" },
            { "JUMP", "01111" },
            { "BE", "10000" },
            { "BNE", "10001" }
        };

        static readonly Regex whiteSpaceRegex = new Regex("\\s+");

        static void Main(string[] args)
        {
            //supply input and output file from command line arguments
            //read input file wholely
            //split by whitespaces
            //iterate splitted strings

            if (args.Length != 2)
                Console.WriteLine("You should specify one input and one output file");

            if (!(File.Exists(args[0]) && File.Exists(args[1])))
                Console.WriteLine("File doesn't exist!");

            string[] instructions = ReadInputFile(args[0]);
            string machineCode = Assemble(instructions);
            WriteToOutputFile(args[1], machineCode);
        }

        static string[] ReadInputFile(string file)
        {
            using (StreamReader reader = new StreamReader(file))
            {
                string fileContents = reader.ReadToEnd();
                return fileContents.Split("\n");
            }
        }

        static string Assemble(string[] instructions)
        {
            StringBuilder assembler = new StringBuilder();

            foreach (var instruction in instructions)
            {
                //error handling
                //not error handling
                int maxImmediate;

                if (opcodes.ContainsKey(instruction))
                {
                    assembler.Append(opcodes[instruction]);
                }
                else if (instruction.StartsWith('R'))
                {
                    int registerNo = Convert.ToInt32(instruction[1..]);
                    string register = Convert.ToString(registerNo, 2);
                    assembler.Append(register);
                }
                else if (instruction.StartsWith("0x"))
                {
                    int immediateValue = Convert.ToInt32(instruction, 16);
                    //21433231312
                }
                else if (instruction.StartsWith("0b"))
                {
                    //0x15
                }
                else
                {

                }

                assembler.AppendLine();
            }

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
