module utf8io

fn test_read_till1() {
	mut u := utf8io.Utf8io{}
	u.open('./testdata/readtill1.dat')

	res := u.read_till(':')!
	println(res)
	println(u.read_char()!)

	u.close()
}
