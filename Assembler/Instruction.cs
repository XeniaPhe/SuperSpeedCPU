using System;
using System.Collections.Generic;
using System.Text;

namespace SSCPU
{
    internal class Instruction
    {
        private InstructionRule rule;
        private List<OperandType> operands;
        private StringBuilder assembledInstruction;

        internal string Opcode => rule.OpcodeASCII;

        internal Instruction(InstructionRule rule)
        {
            this.rule = rule;
            operands = new List<OperandType>();

            if (rule.ExtraBitCount > 0)
                operands.Add(OperandType.ExtraBits);

            assembledInstruction = new StringBuilder(rule.OpCodeBinary);
            assembledInstruction.Append(rule.GetExtraBits());
        }

        private bool Validate()
        {
            int len = operands.Count;
            var validOperands = rule.Operands;

            if (len > validOperands.Count)
                return false;

            bool isValid = true;

            for (int i = 0; i < len; i++)
            {
                if (operands[i] != validOperands[i])
                {
                    isValid = false;
                    break;
                }
            }

            return isValid;
        }

        internal bool AddRegister(string registerBinary)
        {
            assembledInstruction.Append(registerBinary);
            operands.Add(OperandType.Register);

            return Validate();
        }

        internal bool AddImmediate(int immediateValue)
        {
            if (immediateValue < rule.MinImmediate || immediateValue > rule.MaxImmediate)
                return false;

            string immediateBinary = Convert.ToString(immediateValue, 2);

            if (immediateBinary.Length == 32 && immediateBinary[0] == '1')
            {
                immediateBinary = immediateBinary[^rule.ImmediateLength..];
            }
            else
            {
                int bitsToAdd = rule.ImmediateLength - immediateBinary.Length;
                StringBuilder immediate = new StringBuilder();

                for (int i = 0; i < bitsToAdd; i++)
                {
                    immediate.Append("0");
                }

                immediate.Append(immediateBinary);

                immediateBinary = immediate.ToString();
            }

            assembledInstruction.Append(immediateBinary);
            operands.Add(OperandType.Immediate);

            return Validate();
        }

        internal bool IsInstructionComplete()
        {
            if (operands.Count != rule.Operands.Count)
                return false;

            if (!Validate())
                return false;

            return true;
        }

        public override string ToString()
        {
            Console.WriteLine(assembledInstruction.ToString());
            return Convert.ToInt32(assembledInstruction.ToString(), 2).ToString("X5");
        }
    }
}
