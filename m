From: Alex =?unknown-8bit?q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 16 Mar 2017 17:24:19 +0000
Subject: [LTP] Support for static builds
Message-ID: <87y3w5nni4.fsf@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it


Hi,

I'm in the process of trying to package up an LTP build for QEMU's
various target architectures. For ease of testing I'd like to build all
the testcases as static binaries to avoid having to mess about with
chroots during the actual testing. However I've been running into
problems. I run configure as:

  ./configure CFLAGS=3D-pthread LDFLAGS=3D-static

This seems to avoid most of the linking problems I have (undefined
reference to `pthread_mutex_foo' etc). However it seems the convention
of passing CFLAGS down to sub-makes isn't uniform in the code base.

For example building on PowerPC I ran into this:

  gcc -pthread -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-defin=
ition  -I/ltp.git/testcases/kernel/include -I/ltp.git/testcases/network/tcp=
_cmds/sendfile/../include -I../../../../inc
  lude -I../../../../include -I../../../../include/old/ -static  -L../../..=
/../lib  testsf_c.c   -lltp -o testsf_c
  gcc -pthread -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-defin=
ition  -I/ltp.git/testcases/kernel/include -I/ltp.git/testcases/network/tcp=
_cmds/sendfile/../include -I../../../../inc
  lude -I../../../../include -I../../../../include/old/ -static  -L../../..=
/../lib  testsf_s.c   -lltp -o testsf_s
  gcc -static  -L../../../../lib  testsf_c6.o   -lltp -o testsf_c6
  gcc -static  -L../../../../lib  testsf_s6.o   -lltp -o testsf_s6
  ../../../../lib/libltp.a(safe_macros.o): In function `safe_getpwnam':
  /ltp.git/lib/safe_macros.c:119: warning: Using 'getpwnam' in statically l=
inked applications requires at runtime the shared libraries from the glibc =
version used for linking
  testsf_s6.o: In function `main':
  /ltp.git/testcases/network/tcp_cmds/sendfile/testsf_s.c:59: warning: Usin=
g 'getaddrinfo' in statically linked applications requires at runtime the s=
hared libraries from the glibc version used
   for linking
  ../../../../lib/libltp.a(tst_res.o): In function `tst_res__':
  /ltp.git/lib/tst_res.c:153: undefined reference to `pthread_mutex_lock'
  /ltp.git/lib/tst_res.c:199: undefined reference to `pthread_mutex_unlock'
  /ltp.git/lib/tst_res.c:199: undefined reference to `pthread_mutex_unlock'

And when I looked at my host built x86_64 build which completed fine it
hadn't actually done what I asked:

  17:10 alex@zen/x86_64  [sendfile/master@origin] >file testsf_s6
testsf_s6: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically=
 linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, Bui=
ldID[sha1]=3D17a6b13234c805f7a5499acc714ebf5197a7c4ea, not stripped

So my questions:

  - is this the correct way to build a static-linked LTP?
  - is the testsf_06 failure because its not using the common build machine=
ry?

Cheers,

--
Alex Benn=C3=A9e
