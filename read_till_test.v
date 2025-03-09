module utf8io

fn test_read_till1_1() {
	mut u := Utf8io{}
	u.open('./testdata/readtill1.dat')
	res := u.read_till(':')!
	assert res == [u8(97), 98, 99]
	u.read_char()!
	assert u.read_char()! == [u8(100)]
	u.close()
}

fn test_read_till1_2() {
	mut u := Utf8io{}
	u.open('./testdata/readtill1.dat')
	res := u.read_till(';')!
	assert res == [u8(97), 98, 99, 58, 100, 101, 102, 10]
	u.close()
}

fn test_read_till1_3() {
	mut u := Utf8io{}
	u.open('./testdata/readtill1.dat')
	res := u.read_till(':;')!
	assert res == [u8(97), 98, 99, 58, 100, 101, 102, 10]
	u.close()
}

fn test_read_till1_4() {
	mut u := Utf8io{}
	u.open('./testdata/readtill1.dat')
	res := u.read_till(':;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;')!
	assert res == [u8(97), 98, 99, 58, 100, 101, 102, 10]
	u.close()
}

fn test_read_till2_1() {
	mut u := Utf8io{}
	u.open('./testdata/readtill2.dat')
	res := u.read_till(':::::::::::::::::::::::::::')!
	assert res == [u8(97), 98, 99]
	u.close()
}

fn test_read_till2_2() {
	mut u := Utf8io{}
	u.open('./testdata/readtill2.dat')
	res := u.read_till(':::::::::::::::::::::::::::;')!
	assert res == [u8(97), 98, 99, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58,
		58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 100, 101, 102, 10]
	u.close()
}

fn test_read_till2_3() {
	mut u := Utf8io{}
	u.open('./testdata/readtill2.dat')
	res := u.read_till('::::::::::::::::::::::::::::;')!
	assert res == [u8(97), 98, 99, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58,
		58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 100, 101, 102, 10]
	u.close()
}

fn test_read_till3_1() {
	mut u := Utf8io{}
	u.open('./testdata/readtill3.dat')
	res := u.read_till(';')!
	assert res == [u8(208), 188, 208, 184, 209, 136, 208, 176, 58, 58, 208, 188, 208, 176, 209, 136, 208, 176]
	u.close()
}

fn test_read_till3_2() {
	mut u := Utf8io{}
	u.open('./testdata/readtill3.dat')
	res := u.read_till(':')!
	assert res == [u8(208), 188, 208, 184, 209, 136, 208, 176]
	assert res.bytestr() == 'миша'
	u.close()
}
