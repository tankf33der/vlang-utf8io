Great and the only PicoLisp language has simple and robust IO for reading from file.

Lets implement API on Vlang:

```v
module tankf33der.utf8io

struct Utf8io {
mut:
        f os.File
}
fn (mut u Utf8io) open(path string)
fn (mut u Utf8io) peek_char() ![]u8
fn (mut u Utf8io) read_char() ![]u8
fn (mut u Utf8io) read_line() ![]u8
fn (mut u Utf8io) read_till(pattern string) ![]u8
fn (mut u Utf8io) read_from(pattern string) ![]u8
fn (mut u Utf8io) close()
fn (mut u Utf8io) free()
```
