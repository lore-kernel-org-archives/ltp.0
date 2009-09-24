Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1MqtU5-00061C-MK
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 18:56:05 +0000
Received: from mail-yx0-f173.google.com ([209.85.210.173])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MqtTz-000573-T3
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 18:56:05 +0000
Received: by mail-yx0-f173.google.com with SMTP id 3so2215115yxe.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2009 11:55:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200909241423.45226.jpalecek@web.de>
References: <b9d696240909211602o51c38c2ei41a8622d3250f06b@mail.gmail.com>
	<200909241423.45226.jpalecek@web.de>
Date: Thu, 24 Sep 2009 11:55:57 -0700
Message-ID: <b9d696240909241155x5be217a3t4564e6b1bb64a9be@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: Re: [LTP] Buffer Overflow with ftest03 and ftest07
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3648090309029338439=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

--===============3648090309029338439==
Content-Type: multipart/alternative; boundary=001636c92575ce474f047457612c

--001636c92575ce474f047457612c
Content-Type: text/plain; charset=ISO-8859-1

Ok, I applied your patch, and it didn't compile initially so I had to clean
up a few things. They were mostly minor like casting a few vars to integers,
or changing the format specifiers from %XL to %ld, etc, and adding the
variable char fuss[40] back into ftest07.c.

After that I tested them. Both ftest03.c and ftest07.c passes when run from
the command line. But when executed by runltp, they fail with return code
11. This is identical to the behavior without your patch.

Thanks for attempting to fix this. Any other ideas?

Kelly

2009/9/24 Jiri Palecek <jpalecek@web.de>

> Hi,
>
> On Tuesday 22 September 2009 01:02:29 K.D. Lucas wrote:
> > Since I started using LTP 20090831 I've been seeing buffer overflow
> messages
> > when running ftest03 and ftest07. The back trace is:
> >
> > *** buffer overflow detected ***: ftest03 terminated
> > ======= Backtrace: =========
> > /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xa17038]
> > /lib/tls/i686/cmov/libc.so.6[0xa15140]
> > /lib/tls/i686/cmov/libc.so.6[0xa14838]
> > /lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x986d18]
> > /lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x95981c]
> > /lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xa148e4]
> > /lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0xa1482d]
> > ftest03[0x804a7d9]
> > ftest03[0x804a884]
> > /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x92f7a5]
> > ftest03[0x8049461]
> > ======= Memory map: ========
> > 00919000-00a75000 r-xp 00000000 08:01 132417     /lib/tls/i686/cmov/
> > libc-2.9.so
> > 00a75000-00a76000 ---p 0015c000 08:01 132417     /lib/tls/i686/cmov/
> > libc-2.9.so
> > 00a76000-00a78000 r--p 0015c000 08:01 132417     /lib/tls/i686/cmov/
> > libc-2.9.so
> > 00a78000-00a79000 rw-p 0015e000 08:01 132417     /lib/tls/i686/cmov/
> > libc-2.9.so
> > 00a79000-00a7c000 rw-p 00000000 00:00 0
> > 00a8c000-00aa8000 r-xp 00000000 08:01 367        /lib/ld-2.9.so
> > 00aa8000-00aa9000 r--p 0001b000 08:01 367        /lib/ld-2.9.so
> > 00aa9000-00aaa000 rw-p 0001c000 08:01 367        /lib/ld-2.9.so
> > 00c91000-00cbb000 r-xp 00000000 08:01 409        /lib/libgcc_s.so.1
> > 00cbb000-00cbc000 r--p 00029000 08:01 409        /lib/libgcc_s.so.1
> > 00cbc000-00cbd000 rw-p 0002a000 08:01 409        /lib/libgcc_s.so.1
> > 00cce000-00ccf000 r-xp 00000000 00:00 0          [vdso]
> > 08048000-08050000 r-xp 00000000 08:01 231138
> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
> > 08050000-08051000 r--p 00007000 08:01 231138
> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
> > 08051000-08052000 rw-p 00008000 08:01 231138
> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
> > 08052000-08056000 rw-p 00000000 00:00 0
> > 09ead000-09ece000 rw-p 00000000 00:00 0          [heap]
> > b7f8d000-b7f8e000 rw-p 00000000 00:00 0
> > b7f9b000-b7f9d000 rw-p 00000000 00:00 0
> > bff91000-bffa6000 rw-p 00000000 00:00 0          [stack]
> > *** buffer overflow detected ***: ftest07 terminated
> > ======= Backtrace: =========
> > /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0x20e038]
> > /lib/tls/i686/cmov/libc.so.6[0x20c140]
> > /lib/tls/i686/cmov/libc.so.6[0x20b838]
> > /lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x17dd18]
> > /lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x15081c]
> > /lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0x20b8e4]
> > /lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0x20b82d]
> > ftest07[0x804a9d1]
> > ftest07[0x804aa74]
> > /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x1267a5]
> > ftest07[0x8049421]
> > ======= Memory map: ========
> > 00110000-0026c000 r-xp 00000000 08:01 132417     /lib/tls/i686/cmov/
> > libc-2.9.so
> > 0026c000-0026d000 ---p 0015c000 08:01 132417     /lib/tls/i686/cmov/
> > libc-2.9.so
> > 0026d000-0026f000 r--p 0015c000 08:01 132417     /lib/tls/i686/cmov/
> > libc-2.9.so
> > 0026f000-00270000 rw-p 0015e000 08:01 132417     /lib/tls/i686/cmov/
> > libc-2.9.so
> > 00270000-00273000 rw-p 00000000 00:00 0
> > 00642000-0066c000 r-xp 00000000 08:01 409        /lib/libgcc_s.so.1
> > 0066c000-0066d000 r--p 00029000 08:01 409        /lib/libgcc_s.so.1
> > 0066d000-0066e000 rw-p 0002a000 08:01 409        /lib/libgcc_s.so.1
> > 00d7c000-00d7d000 r-xp 00000000 00:00 0          [vdso]
> > 00dfe000-00e1a000 r-xp 00000000 08:01 367        /lib/ld-2.9.so
> > 00e1a000-00e1b000 r--p 0001b000 08:01 367        /lib/ld-2.9.so
> > 00e1b000-00e1c000 rw-p 0001c000 08:01 367        /lib/ld-2.9.so
> > 08048000-08050000 r-xp 00000000 08:01 231142
> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
> > 08050000-08051000 r--p 00007000 08:01 231142
> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
> > 08051000-08052000 rw-p 00008000 08:01 231142
> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
> > 08052000-08057000 rw-p 00000000 00:00 0
> > 09fce000-09fef000 rw-p 00000000 00:00 0          [heap]
> > b802f000-b8030000 rw-p 00000000 00:00 0
> > b803d000-b803f000 rw-p 00000000 00:00 0
> > bfdfb000-bfe10000 rw-p 00000000 00:00 0          [stack]
> >
> >
> > This is running against an Ubuntu Karmic Alpha netbook remix. I don't see
> > this issue when testing on dapper or hardy distros. I saw some other
> posts
> > about this, but no one has offered any suggestions or solutions yet.
>
> It seems the problem is with some sprintf() call, and indeed, there is one
> in the code. I propose deleting it (with other code) altogether, because it
>  was needed just for creation of a temporary directory and we have
> tst_tmpdir() for that. See the attachment and please report whether it works
> and whether such solution is acceptable.
>
> Note that the code was not tested in any way.
>
> Regards
>     Jiri Palecek
>



-- 
K.D. Lucas
kdlucas@gmail.com

--001636c92575ce474f047457612c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ok, I applied your patch, and it didn&#39;t compile initially so I had to c=
lean up a few things. They were mostly minor like casting a few vars to int=
egers, or changing the format specifiers from %XL to %ld, etc, and adding t=
he variable char fuss[40] back into ftest07.c. <br>
<br>After that I tested them. Both ftest03.c and ftest07.c passes when run =
from the command line. But when executed by runltp, they fail with return c=
ode 11. This is identical to the behavior without your patch.<br><br>Thanks=
 for attempting to fix this. Any other ideas?<br>
<br>Kelly<br><br><div class=3D"gmail_quote">2009/9/24 Jiri Palecek <span di=
r=3D"ltr">&lt;<a href=3D"mailto:jpalecek@web.de">jpalecek@web.de</a>&gt;</s=
pan><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid r=
gb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<div><div></div><div class=3D"h5"><br>
On Tuesday 22 September 2009 01:02:29 K.D. Lucas wrote:<br>
&gt; Since I started using LTP 20090831 I&#39;ve been seeing buffer overflo=
w messages<br>
&gt; when running ftest03 and ftest07. The back trace is:<br>
&gt;<br>
&gt; *** buffer overflow detected ***: ftest03 terminated<br>
&gt; =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xa17038]<br>
&gt; /lib/tls/i686/cmov/libc.so.6[0xa15140]<br>
&gt; /lib/tls/i686/cmov/libc.so.6[0xa14838]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x986d18]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x95981c]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xa148e4]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0xa1482d]<br>
&gt; ftest03[0x804a7d9]<br>
&gt; ftest03[0x804a884]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x92f7a5]<br>
&gt; ftest03[0x8049461]<br>
&gt; =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; 00919000-00a75000 r-xp 00000000 08:01 132417 =A0 =A0 /lib/tls/i686/cmo=
v/<br>
&gt; <a href=3D"http://libc-2.9.so" target=3D"_blank">libc-2.9.so</a><br>
&gt; 00a75000-00a76000 ---p 0015c000 08:01 132417 =A0 =A0 /lib/tls/i686/cmo=
v/<br>
&gt; <a href=3D"http://libc-2.9.so" target=3D"_blank">libc-2.9.so</a><br>
&gt; 00a76000-00a78000 r--p 0015c000 08:01 132417 =A0 =A0 /lib/tls/i686/cmo=
v/<br>
&gt; <a href=3D"http://libc-2.9.so" target=3D"_blank">libc-2.9.so</a><br>
&gt; 00a78000-00a79000 rw-p 0015e000 08:01 132417 =A0 =A0 /lib/tls/i686/cmo=
v/<br>
&gt; <a href=3D"http://libc-2.9.so" target=3D"_blank">libc-2.9.so</a><br>
&gt; 00a79000-00a7c000 rw-p 00000000 00:00 0<br>
&gt; 00a8c000-00aa8000 r-xp 00000000 08:01 367 =A0 =A0 =A0 =A0/lib/<a href=
=3D"http://ld-2.9.so" target=3D"_blank">ld-2.9.so</a><br>
&gt; 00aa8000-00aa9000 r--p 0001b000 08:01 367 =A0 =A0 =A0 =A0/lib/<a href=
=3D"http://ld-2.9.so" target=3D"_blank">ld-2.9.so</a><br>
&gt; 00aa9000-00aaa000 rw-p 0001c000 08:01 367 =A0 =A0 =A0 =A0/lib/<a href=
=3D"http://ld-2.9.so" target=3D"_blank">ld-2.9.so</a><br>
&gt; 00c91000-00cbb000 r-xp 00000000 08:01 409 =A0 =A0 =A0 =A0/lib/libgcc_s=
.so.1<br>
&gt; 00cbb000-00cbc000 r--p 00029000 08:01 409 =A0 =A0 =A0 =A0/lib/libgcc_s=
.so.1<br>
&gt; 00cbc000-00cbd000 rw-p 0002a000 08:01 409 =A0 =A0 =A0 =A0/lib/libgcc_s=
.so.1<br>
&gt; 00cce000-00ccf000 r-xp 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[vdso]<br>
&gt; 08048000-08050000 r-xp 00000000 08:01 231138<br>
&gt; /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03<br>
&gt; 08050000-08051000 r--p 00007000 08:01 231138<br>
&gt; /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03<br>
&gt; 08051000-08052000 rw-p 00008000 08:01 231138<br>
&gt; /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03<br>
&gt; 08052000-08056000 rw-p 00000000 00:00 0<br>
&gt; 09ead000-09ece000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[heap]<br>
&gt; b7f8d000-b7f8e000 rw-p 00000000 00:00 0<br>
&gt; b7f9b000-b7f9d000 rw-p 00000000 00:00 0<br>
&gt; bff91000-bffa6000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[stack]<br>
&gt; *** buffer overflow detected ***: ftest07 terminated<br>
&gt; =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0x20e038]<br>
&gt; /lib/tls/i686/cmov/libc.so.6[0x20c140]<br>
&gt; /lib/tls/i686/cmov/libc.so.6[0x20b838]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x17dd18]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x15081c]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0x20b8e4]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0x20b82d]<br>
&gt; ftest07[0x804a9d1]<br>
&gt; ftest07[0x804aa74]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x1267a5]<br>
&gt; ftest07[0x8049421]<br>
&gt; =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; 00110000-0026c000 r-xp 00000000 08:01 132417 =A0 =A0 /lib/tls/i686/cmo=
v/<br>
&gt; <a href=3D"http://libc-2.9.so" target=3D"_blank">libc-2.9.so</a><br>
&gt; 0026c000-0026d000 ---p 0015c000 08:01 132417 =A0 =A0 /lib/tls/i686/cmo=
v/<br>
&gt; <a href=3D"http://libc-2.9.so" target=3D"_blank">libc-2.9.so</a><br>
&gt; 0026d000-0026f000 r--p 0015c000 08:01 132417 =A0 =A0 /lib/tls/i686/cmo=
v/<br>
&gt; <a href=3D"http://libc-2.9.so" target=3D"_blank">libc-2.9.so</a><br>
&gt; 0026f000-00270000 rw-p 0015e000 08:01 132417 =A0 =A0 /lib/tls/i686/cmo=
v/<br>
&gt; <a href=3D"http://libc-2.9.so" target=3D"_blank">libc-2.9.so</a><br>
&gt; 00270000-00273000 rw-p 00000000 00:00 0<br>
&gt; 00642000-0066c000 r-xp 00000000 08:01 409 =A0 =A0 =A0 =A0/lib/libgcc_s=
.so.1<br>
&gt; 0066c000-0066d000 r--p 00029000 08:01 409 =A0 =A0 =A0 =A0/lib/libgcc_s=
.so.1<br>
&gt; 0066d000-0066e000 rw-p 0002a000 08:01 409 =A0 =A0 =A0 =A0/lib/libgcc_s=
.so.1<br>
&gt; 00d7c000-00d7d000 r-xp 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[vdso]<br>
&gt; 00dfe000-00e1a000 r-xp 00000000 08:01 367 =A0 =A0 =A0 =A0/lib/<a href=
=3D"http://ld-2.9.so" target=3D"_blank">ld-2.9.so</a><br>
&gt; 00e1a000-00e1b000 r--p 0001b000 08:01 367 =A0 =A0 =A0 =A0/lib/<a href=
=3D"http://ld-2.9.so" target=3D"_blank">ld-2.9.so</a><br>
&gt; 00e1b000-00e1c000 rw-p 0001c000 08:01 367 =A0 =A0 =A0 =A0/lib/<a href=
=3D"http://ld-2.9.so" target=3D"_blank">ld-2.9.so</a><br>
&gt; 08048000-08050000 r-xp 00000000 08:01 231142<br>
&gt; /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07<br>
&gt; 08050000-08051000 r--p 00007000 08:01 231142<br>
&gt; /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07<br>
&gt; 08051000-08052000 rw-p 00008000 08:01 231142<br>
&gt; /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07<br>
&gt; 08052000-08057000 rw-p 00000000 00:00 0<br>
&gt; 09fce000-09fef000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[heap]<br>
&gt; b802f000-b8030000 rw-p 00000000 00:00 0<br>
&gt; b803d000-b803f000 rw-p 00000000 00:00 0<br>
&gt; bfdfb000-bfe10000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[stack]<br>
&gt;<br>
&gt;<br>
&gt; This is running against an Ubuntu Karmic Alpha netbook remix. I don&#3=
9;t see<br>
&gt; this issue when testing on dapper or hardy distros. I saw some other p=
osts<br>
&gt; about this, but no one has offered any suggestions or solutions yet.<b=
r>
<br>
</div></div>It seems the problem is with some sprintf() call, and indeed, t=
here is one in the code. I propose deleting it (with other code) altogether=
, because it =A0was needed just for creation of a temporary directory and w=
e have tst_tmpdir() for that. See the attachment and please report whether =
it works and whether such solution is acceptable.<br>

<br>
Note that the code was not tested in any way.<br>
<br>
Regards<br>
<font color=3D"#888888"> =A0 =A0Jiri Palecek<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>K.D. Lucas<br><a=
 href=3D"mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>

--001636c92575ce474f047457612c--


--===============3648090309029338439==
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
--===============3648090309029338439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3648090309029338439==--

