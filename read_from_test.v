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

fn test_read_from1_2() {
	mut u := Utf8io{}
	u.open('./testdata/readfrom1.dat')
	res := u.read_from(':;')!
	assert res == []
	u.close()
}

fn test_read_from2_1() {
	mut u := Utf8io{}
	u.open('./testdata/readfrom2.dat')
	res := u.read_from('vlang')!
	assert res.bytestr() == 'vlang'
	assert u.read_char()!.bytestr() == 'b'
	u.close()
}

fn test_read_from3_1() {
	mut u := Utf8io{}
	u.open('./testdata/readfrom3.dat')
	res := u.read_from(':')!
	assert res.bytestr() == ':'
	u.close()
}
