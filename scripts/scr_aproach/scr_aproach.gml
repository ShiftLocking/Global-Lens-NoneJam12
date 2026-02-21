function apr(_val1, _val2, _apr)
{
	if (_val1 < _val2)
	{
		_val1 += _apr;
		if (_val1 > _val2)
			return _val2;
	}
	else
	{
		_val1 -= _apr;
		if (_val1 < _val2)
			return _val2;
	}
	return _val1;
}