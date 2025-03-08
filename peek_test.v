module utf8io

fn test_peek() {
	mut u := utf8io.Utf8io{}
	u.open('./testdata/zero.dat')
	println(u.read_char()!)
	u.close()
	unsafe { u.free() }
}
