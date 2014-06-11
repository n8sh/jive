module math.factorring;

import std.algorithm : move;
import math.integer;


struct Coset(Ring)
{
	Ring val;
	Ring mod;

	this(Ring val, Ring mod)
	{
		this.val = val % mod;
		this.mod = mod;
	}

	string toString() const @property
	{
		return "["~val.toString~"]";
	}

	/** return 1/this */
	Coset inverse() @property
	{
		static if(is(Ring == Integer))
		{
			return Coset(val.inverseMod(mod), mod);
		}
		else
		{
			assert(false, "TODO");
		}
	}

	Coset opBinary(string op, T)(T rhs)
		if(is(T == int) || is(T == Integer) || is(T == Ring))
	{
		     static if(op == "+") return Coset(val + rhs, mod);
		else static if(op == "-") return Coset(val - rhs, mod);
		else static if(op == "*") return Coset(val * rhs, mod);
		else static assert(false, "binary assign '"~op~"' is not defined");
	}

	Coset opBinary(string op)(Coset rhs)
	{
		assert(this.mod == rhs.mod);

		return opBinary!op(rhs.val);
	}

	bool opEquals(const Coset r) const
	{
		return opEquals(r);
	}

	bool opEquals(ref const Coset r) const
	{
		return val == r.val;
	}
}
