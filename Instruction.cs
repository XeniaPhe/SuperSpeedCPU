using System;
using System.Collections.Generic;
using System.Linq;

namespace SSCPU
{
    internal class Instruction
    {
        private static List<Instruction> instructions = new List<Instruction>();
        internal static List<Instruction> Instructions => instructions;



        private string opcodeASCII;
        private string opcodeBinary;
        private List<OperandType> operands;
        private int maxImmediateLength;


        internal string OpcodeASCII => opcodeASCII;
        internal string OpCodeBinary => opcodeBinary;
        internal int MaxImmediateLength => maxImmediateLength;


        private Instruction(string opcodeASCII,string opcodeBinary, List<OperandType> operands, int maxImmediateLength = 0) 
        {
            this.opcodeASCII = opcodeASCII;
            this.opcodeBinary = opcodeBinary;
            this.operands = operands;
            this.maxImmediateLength = operands.Contains(OperandType.Immediate) ? maxImmediateLength : 0;
        }

        static Instruction()
        {
            List<OperandType> operands = new List<OperandType>()
            {
                OperandType.Register,
                OperandType.Register,
                OperandType.Register
            };

            instructions.Add(new Instruction("ADD", "00001", operands));
            instructions.Add(new Instruction("SUB", "00011", operands));
            instructions.Add(new Instruction("AND", "00101", operands));
            instructions.Add(new Instruction("OR", "00111", operands));
            instructions.Add(new Instruction("XOR", "01001", operands));

            operands.RemoveAt(2);
            operands.Add(OperandType.Immediate);

            instructions.Add(new Instruction("ADDI", "00010", operands,7));
            instructions.Add(new Instruction("SUBI", "00100", operands,7));
            instructions.Add(new Instruction("ANDI", "00110", operands,7));
            instructions.Add(new Instruction("ORI", "01000", operands,7));
            instructions.Add(new Instruction("XORI", "01010", operands,7));

            instructions.Add(new Instruction("BE", "10000", operands, 7));
            instructions.Add(new Instruction("BNE", "10001", operands, 7));

            operands.RemoveAt(1);

            instructions.Add(new Instruction("LD", "01011", operands, 10));
            instructions.Add(new Instruction("ST", "01100", operands, 10));

            operands.RemoveAt(1);

            instructions.Add(new Instruction("PUSH", "01101", operands));
            instructions.Add(new Instruction("POP", "01110", operands));

            operands.RemoveAt(0);

            instructions.Add(new Instruction("JUMP", "01111", operands,10));
        }

        internal static Instruction GetInstruction(string opcodeASCII)
        {
            return instructions.Where(i => i.opcodeASCII.Equals(opcodeASCII)).FirstOrDefault();
        }
    }
}
