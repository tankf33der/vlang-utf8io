module utf8io

fn test_read_from0_1() {
	mut u := Utf8io{}
	u.open('./testdata/readfrom0.dat')
	res := u.read_from(':')!
	assert res == []
	u.close()
}

fn test_read_from1_1() {
	mut u := Utf8io{}
	u.open('./testdata/readfrom1.dat')
	res := u.read_from(':')!
	assert res == [u8(58)]
	assert u.peek_char()! == [u8(100)]
	u.close()
}
