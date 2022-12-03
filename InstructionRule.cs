using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SSCPU
{
    internal class InstructionRule
    {
        private static List<InstructionRule> instructions = new List<InstructionRule>();
        internal static List<InstructionRule> Instructions => instructions;


        private string opcodeASCII;
        private string opcodeBinary;
        private List<OperandType> operands;
        private int immediateLength;
        private int extraBitCount;


        internal string OpcodeASCII => opcodeASCII;
        internal string OpCodeBinary => opcodeBinary;
        internal int ImmediateLength => immediateLength;
        internal int ExtraBitCount => extraBitCount;
        internal int MinImmediate => immediateLength > 0 ? -1 << (immediateLength - 1) : 0;
        internal int MaxImmediate => immediateLength > 0 ? (1 << (immediateLength - 1)) - 1 : 0;


        internal List<OperandType> Operands => operands;


        private InstructionRule(string opcodeASCII, string opcodeBinary, List<OperandType> operands, int immediateLength = 0)
        {
            this.opcodeASCII = opcodeASCII;
            this.opcodeBinary = opcodeBinary;
            this.operands = operands;
            this.immediateLength = operands.Contains(OperandType.Immediate) ? immediateLength : 0;

            extraBitCount = 15;

            foreach (var operand in operands)
            {
                switch (operand)
                {
                    case OperandType.Register:
                        extraBitCount -= 4;
                        break;
                    case OperandType.Immediate:
                        extraBitCount -= immediateLength;
                        break;
                }
            }
        }

        internal string GetExtraBits()
        {
            StringBuilder extraBits = new StringBuilder();

            for (int i = 0; i < extraBitCount; i++)
            {
                extraBits.Append("0");
            }

            return extraBits.ToString();
        }


        static InstructionRule()
        {
            List<OperandType> operands = new List<OperandType>()
            {
                OperandType.ExtraBits,
                OperandType.Register,
                OperandType.Register,
                OperandType.Register
            };

            instructions.Add(new InstructionRule("ADD", "00001", operands));
            instructions.Add(new InstructionRule("SUB", "00011", operands));
            instructions.Add(new InstructionRule("AND", "00101", operands));
            instructions.Add(new InstructionRule("OR", "00111", operands));
            instructions.Add(new InstructionRule("XOR", "01001", operands));

            operands = new List<OperandType>()
            {
                OperandType.Register,
                OperandType.Register,
                OperandType.Immediate
            };

            instructions.Add(new InstructionRule("ADDI", "00010", operands, 7));
            instructions.Add(new InstructionRule("SUBI", "00100", operands, 7));
            instructions.Add(new InstructionRule("ANDI", "00110", operands, 7));
            instructions.Add(new InstructionRule("ORI", "01000", operands, 7));
            instructions.Add(new InstructionRule("XORI", "01010", operands, 7));

            instructions.Add(new InstructionRule("BE", "10000", operands, 7));
            instructions.Add(new InstructionRule("BNE", "10001", operands, 7));


            operands = new List<OperandType>()
            {
                OperandType.ExtraBits,
                OperandType.Register,
                OperandType.Immediate
            };

            instructions.Add(new InstructionRule("LD", "01011", operands, 10));
            instructions.Add(new InstructionRule("ST", "01100", operands, 10));

            operands = new List<OperandType>()
            {
                OperandType.ExtraBits,
                OperandType.Register,
            };

            instructions.Add(new InstructionRule("PUSH", "01101", operands));
            instructions.Add(new InstructionRule("POP", "01110", operands));

            operands = new List<OperandType>()
            {
                OperandType.ExtraBits,
                OperandType.Immediate,
            };

            instructions.Add(new InstructionRule("JUMP", "01111", operands, 10));
        }

        internal static InstructionRule GetInstruction(string opcodeASCII)
        {
            return instructions.Where(i => i.opcodeASCII.Equals(opcodeASCII)).FirstOrDefault();
        }
    }
}
