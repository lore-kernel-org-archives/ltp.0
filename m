Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1Mpru5-0002nn-Sa
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 23:02:41 +0000
Received: from an-out-0708.google.com ([209.85.132.241])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mpru0-00084Y-3w
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 23:02:41 +0000
Received: by an-out-0708.google.com with SMTP id c38so1274869ana.37
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 Sep 2009 16:02:30 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 21 Sep 2009 16:02:29 -0700
Message-ID: <b9d696240909211602o51c38c2ei41a8622d3250f06b@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: [LTP] Buffer Overflow with ftest03 and ftest07
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3951793423790607578=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3951793423790607578==
Content-Type: multipart/alternative; boundary=0016e68ed77eed40fe04741e792b

--0016e68ed77eed40fe04741e792b
Content-Type: text/plain; charset=ISO-8859-1

Since I started using LTP 20090831 I've been seeing buffer overflow messages
when running ftest03 and ftest07. The back trace is:

*** buffer overflow detected ***: ftest03 terminated
======= Backtrace: =========
/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xa17038]
/lib/tls/i686/cmov/libc.so.6[0xa15140]
/lib/tls/i686/cmov/libc.so.6[0xa14838]
/lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x986d18]
/lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x95981c]
/lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xa148e4]
/lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0xa1482d]
ftest03[0x804a7d9]
ftest03[0x804a884]
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x92f7a5]
ftest03[0x8049461]
======= Memory map: ========
00919000-00a75000 r-xp 00000000 08:01 132417     /lib/tls/i686/cmov/
libc-2.9.so
00a75000-00a76000 ---p 0015c000 08:01 132417     /lib/tls/i686/cmov/
libc-2.9.so
00a76000-00a78000 r--p 0015c000 08:01 132417     /lib/tls/i686/cmov/
libc-2.9.so
00a78000-00a79000 rw-p 0015e000 08:01 132417     /lib/tls/i686/cmov/
libc-2.9.so
00a79000-00a7c000 rw-p 00000000 00:00 0
00a8c000-00aa8000 r-xp 00000000 08:01 367        /lib/ld-2.9.so
00aa8000-00aa9000 r--p 0001b000 08:01 367        /lib/ld-2.9.so
00aa9000-00aaa000 rw-p 0001c000 08:01 367        /lib/ld-2.9.so
00c91000-00cbb000 r-xp 00000000 08:01 409        /lib/libgcc_s.so.1
00cbb000-00cbc000 r--p 00029000 08:01 409        /lib/libgcc_s.so.1
00cbc000-00cbd000 rw-p 0002a000 08:01 409        /lib/libgcc_s.so.1
00cce000-00ccf000 r-xp 00000000 00:00 0          [vdso]
08048000-08050000 r-xp 00000000 08:01 231138
/var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
08050000-08051000 r--p 00007000 08:01 231138
/var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
08051000-08052000 rw-p 00008000 08:01 231138
/var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
08052000-08056000 rw-p 00000000 00:00 0
09ead000-09ece000 rw-p 00000000 00:00 0          [heap]
b7f8d000-b7f8e000 rw-p 00000000 00:00 0
b7f9b000-b7f9d000 rw-p 00000000 00:00 0
bff91000-bffa6000 rw-p 00000000 00:00 0          [stack]
*** buffer overflow detected ***: ftest07 terminated
======= Backtrace: =========
/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0x20e038]
/lib/tls/i686/cmov/libc.so.6[0x20c140]
/lib/tls/i686/cmov/libc.so.6[0x20b838]
/lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x17dd18]
/lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x15081c]
/lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0x20b8e4]
/lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0x20b82d]
ftest07[0x804a9d1]
ftest07[0x804aa74]
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x1267a5]
ftest07[0x8049421]
======= Memory map: ========
00110000-0026c000 r-xp 00000000 08:01 132417     /lib/tls/i686/cmov/
libc-2.9.so
0026c000-0026d000 ---p 0015c000 08:01 132417     /lib/tls/i686/cmov/
libc-2.9.so
0026d000-0026f000 r--p 0015c000 08:01 132417     /lib/tls/i686/cmov/
libc-2.9.so
0026f000-00270000 rw-p 0015e000 08:01 132417     /lib/tls/i686/cmov/
libc-2.9.so
00270000-00273000 rw-p 00000000 00:00 0
00642000-0066c000 r-xp 00000000 08:01 409        /lib/libgcc_s.so.1
0066c000-0066d000 r--p 00029000 08:01 409        /lib/libgcc_s.so.1
0066d000-0066e000 rw-p 0002a000 08:01 409        /lib/libgcc_s.so.1
00d7c000-00d7d000 r-xp 00000000 00:00 0          [vdso]
00dfe000-00e1a000 r-xp 00000000 08:01 367        /lib/ld-2.9.so
00e1a000-00e1b000 r--p 0001b000 08:01 367        /lib/ld-2.9.so
00e1b000-00e1c000 rw-p 0001c000 08:01 367        /lib/ld-2.9.so
08048000-08050000 r-xp 00000000 08:01 231142
/var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
08050000-08051000 r--p 00007000 08:01 231142
/var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
08051000-08052000 rw-p 00008000 08:01 231142
/var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
08052000-08057000 rw-p 00000000 00:00 0
09fce000-09fef000 rw-p 00000000 00:00 0          [heap]
b802f000-b8030000 rw-p 00000000 00:00 0
b803d000-b803f000 rw-p 00000000 00:00 0
bfdfb000-bfe10000 rw-p 00000000 00:00 0          [stack]


This is running against an Ubuntu Karmic Alpha netbook remix. I don't see
this issue when testing on dapper or hardy distros. I saw some other posts
about this, but no one has offered any suggestions or solutions yet.

The kernel is 2.6.30-8-generic, i686 arch.

kdl

--0016e68ed77eed40fe04741e792b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Since I started using LTP 20090831 I&#39;ve been seeing buffer overflow mes=
sages when running ftest03 and ftest07. The back trace is:<br><br>*** buffe=
r overflow detected ***: ftest03 terminated<br>=3D=3D=3D=3D=3D=3D=3D Backtr=
ace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
/lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xa17038]<br>/lib/tls/i68=
6/cmov/libc.so.6[0xa15140]<br>/lib/tls/i686/cmov/libc.so.6[0xa14838]<br>/li=
b/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x986d18]<br>/lib/tls/i6=
86/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x95981c]<br>
/lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xa148e4]<br>/lib/tls/i68=
6/cmov/libc.so.6(__sprintf_chk+0x2d)[0xa1482d]<br>ftest03[0x804a7d9]<br>fte=
st03[0x804a884]<br>/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x9=
2f7a5]<br>
ftest03[0x8049461]<br>=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=
=3D=3D<br>00919000-00a75000 r-xp 00000000 08:01 132417=A0=A0=A0=A0 /lib/tls=
/i686/cmov/<a href=3D"http://libc-2.9.so">libc-2.9.so</a><br>00a75000-00a76=
000 ---p 0015c000 08:01 132417=A0=A0=A0=A0 /lib/tls/i686/cmov/<a href=3D"ht=
tp://libc-2.9.so">libc-2.9.so</a><br>
00a76000-00a78000 r--p 0015c000 08:01 132417=A0=A0=A0=A0 /lib/tls/i686/cmov=
/<a href=3D"http://libc-2.9.so">libc-2.9.so</a><br>00a78000-00a79000 rw-p 0=
015e000 08:01 132417=A0=A0=A0=A0 /lib/tls/i686/cmov/<a href=3D"http://libc-=
2.9.so">libc-2.9.so</a><br>
00a79000-00a7c000 rw-p 00000000 00:00 0<br>00a8c000-00aa8000 r-xp 00000000 =
08:01 367=A0=A0=A0=A0=A0=A0=A0 /lib/<a href=3D"http://ld-2.9.so">ld-2.9.so<=
/a><br>00aa8000-00aa9000 r--p 0001b000 08:01 367=A0=A0=A0=A0=A0=A0=A0 /lib/=
<a href=3D"http://ld-2.9.so">ld-2.9.so</a><br>
00aa9000-00aaa000 rw-p 0001c000 08:01 367=A0=A0=A0=A0=A0=A0=A0 /lib/<a href=
=3D"http://ld-2.9.so">ld-2.9.so</a><br>00c91000-00cbb000 r-xp 00000000 08:0=
1 409=A0=A0=A0=A0=A0=A0=A0 /lib/libgcc_s.so.1<br>00cbb000-00cbc000 r--p 000=
29000 08:01 409=A0=A0=A0=A0=A0=A0=A0 /lib/libgcc_s.so.1<br>
00cbc000-00cbd000 rw-p 0002a000 08:01 409=A0=A0=A0=A0=A0=A0=A0 /lib/libgcc_=
s.so.1<br>00cce000-00ccf000 r-xp 00000000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 [vdso]<br>08048000-08050000 r-xp 00000000 08:01 231138=A0=A0=A0=A0 /var=
/tmp/tests/ltp-full-20090831/testcases/bin/ftest03<br>
08050000-08051000 r--p 00007000 08:01 231138=A0=A0=A0=A0 /var/tmp/tests/ltp=
-full-20090831/testcases/bin/ftest03<br>08051000-08052000 rw-p 00008000 08:=
01 231138=A0=A0=A0=A0 /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest0=
3<br>08052000-08056000 rw-p 00000000 00:00 0<br>
09ead000-09ece000 rw-p 00000000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [heap]<b=
r>b7f8d000-b7f8e000 rw-p 00000000 00:00 0<br>b7f9b000-b7f9d000 rw-p 0000000=
0 00:00 0<br>bff91000-bffa6000 rw-p 00000000 00:00 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 [stack]<br>*** buffer overflow detected ***: ftest07 terminated<br>
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>/lib/tls/i6=
86/cmov/libc.so.6(__fortify_fail+0x48)[0x20e038]<br>/lib/tls/i686/cmov/libc=
.so.6[0x20c140]<br>/lib/tls/i686/cmov/libc.so.6[0x20b838]<br>/lib/tls/i686/=
cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x17dd18]<br>
/lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x15081c]<br>/lib/tls/i686=
/cmov/libc.so.6(__vsprintf_chk+0xa4)[0x20b8e4]<br>/lib/tls/i686/cmov/libc.s=
o.6(__sprintf_chk+0x2d)[0x20b82d]<br>ftest07[0x804a9d1]<br>ftest07[0x804aa7=
4]<br>
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x1267a5]<br>ftest07[0=
x8049421]<br>=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>=
00110000-0026c000 r-xp 00000000 08:01 132417=A0=A0=A0=A0 /lib/tls/i686/cmov=
/<a href=3D"http://libc-2.9.so">libc-2.9.so</a><br>
0026c000-0026d000 ---p 0015c000 08:01 132417=A0=A0=A0=A0 /lib/tls/i686/cmov=
/<a href=3D"http://libc-2.9.so">libc-2.9.so</a><br>0026d000-0026f000 r--p 0=
015c000 08:01 132417=A0=A0=A0=A0 /lib/tls/i686/cmov/<a href=3D"http://libc-=
2.9.so">libc-2.9.so</a><br>
0026f000-00270000 rw-p 0015e000 08:01 132417=A0=A0=A0=A0 /lib/tls/i686/cmov=
/<a href=3D"http://libc-2.9.so">libc-2.9.so</a><br>00270000-00273000 rw-p 0=
0000000 00:00 0<br>00642000-0066c000 r-xp 00000000 08:01 409=A0=A0=A0=A0=A0=
=A0=A0 /lib/libgcc_s.so.1<br>
0066c000-0066d000 r--p 00029000 08:01 409=A0=A0=A0=A0=A0=A0=A0 /lib/libgcc_=
s.so.1<br>0066d000-0066e000 rw-p 0002a000 08:01 409=A0=A0=A0=A0=A0=A0=A0 /l=
ib/libgcc_s.so.1<br>00d7c000-00d7d000 r-xp 00000000 00:00 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 [vdso]<br>00dfe000-00e1a000 r-xp 00000000 08:01 367=A0=A0=A0=
=A0=A0=A0=A0 /lib/<a href=3D"http://ld-2.9.so">ld-2.9.so</a><br>
00e1a000-00e1b000 r--p 0001b000 08:01 367=A0=A0=A0=A0=A0=A0=A0 /lib/<a href=
=3D"http://ld-2.9.so">ld-2.9.so</a><br>00e1b000-00e1c000 rw-p 0001c000 08:0=
1 367=A0=A0=A0=A0=A0=A0=A0 /lib/<a href=3D"http://ld-2.9.so">ld-2.9.so</a><=
br>08048000-08050000 r-xp 00000000 08:01 231142=A0=A0=A0=A0 /var/tmp/tests/=
ltp-full-20090831/testcases/bin/ftest07<br>
08050000-08051000 r--p 00007000 08:01 231142=A0=A0=A0=A0 /var/tmp/tests/ltp=
-full-20090831/testcases/bin/ftest07<br>08051000-08052000 rw-p 00008000 08:=
01 231142=A0=A0=A0=A0 /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest0=
7<br>08052000-08057000 rw-p 00000000 00:00 0<br>
09fce000-09fef000 rw-p 00000000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [heap]<b=
r>b802f000-b8030000 rw-p 00000000 00:00 0<br>b803d000-b803f000 rw-p 0000000=
0 00:00 0<br>bfdfb000-bfe10000 rw-p 00000000 00:00 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 [stack]<br clear=3D"all"><br>
<br>This is running against an Ubuntu Karmic Alpha netbook remix. I don&#39=
;t see this issue when testing on dapper or hardy distros. I saw some other=
 posts about this, but no one has offered any suggestions or solutions yet.=
<br>
<br>The kernel is 2.6.30-8-generic, i686 arch.<br><br>kdl<br><br>

--0016e68ed77eed40fe04741e792b--


--===============3951793423790607578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--===============3951793423790607578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3951793423790607578==--

