Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1NbMIm-0001oF-W6
	for ltp-list@lists.sourceforge.net; Sat, 30 Jan 2010 23:00:28 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NbMIl-0004vp-Q2
	for ltp-list@lists.sourceforge.net; Sat, 30 Jan 2010 23:00:28 +0000
Received: by pxi38 with SMTP id 38so2799284pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 30 Jan 2010 15:00:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001292129odcec445t1514787fb65d69f1@mail.gmail.com>
References: <364299f41001292129odcec445t1514787fb65d69f1@mail.gmail.com>
Date: Sat, 30 Jan 2010 15:00:21 -0800
Message-ID: <b9d696241001301500g6e36e013g2a8d3bb2ca09ed44@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: Re: [LTP] `buffer overflow detected' from ftest0[37] with glibc 2.10
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3264142382232467199=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

--===============3264142382232467199==
Content-Type: multipart/alternative; boundary=000e0cd13b247d5ef5047e69b7f9

--000e0cd13b247d5ef5047e69b7f9
Content-Type: text/plain; charset=ISO-8859-1

Garrett,

I see this issue all the time, since the July 2009 release.

kdl

On Fri, Jan 29, 2010 at 9:29 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

> Hi,
>    I've been seeing the following messages when ftest03 and ftest07
> are executed on a regular basis as of late (may be due to a recent
> glibc upgrade):
>
> *** buffer overflow detected ***: ftest03 terminated
> ======= Backtrace: =========
> /lib/libc.so.6(__fortify_fail+0x37)[0x7f100b0c3867]
> /lib/libc.so.6[0x7f100b0c1680]
> /lib/libc.so.6[0x7f100b0c0979]
> /lib/libc.so.6(_IO_default_xsputn+0x85)[0x7f100b04ef25]
> /lib/libc.so.6(_IO_vfprintf+0x1fed)[0x7f100b0216dd]
> /lib/libc.so.6(__vsprintf_chk+0x9d)[0x7f100b0c0a1d]
> /lib/libc.so.6(__sprintf_chk+0x80)[0x7f100b0c0960]
> ftest03[0x401f05]
> ftest03[0x402a76]
> /lib/libc.so.6(__libc_start_main+0xe6)[0x7f100affba26]
> ftest03[0x401d59]
> ======= Memory map: ========
> 00400000-00408000 r-xp 00000000 fd:03 74957
>  /tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest03
> 00608000-00609000 r--p 00008000 fd:03 74957
>  /tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest03
> 00609000-0060a000 rw-p 00009000 fd:03 74957
>  /tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest03
> 0060a000-0060f000 rw-p 00000000 00:00 0
> 01f91000-01fb2000 rw-p 00000000 00:00 0
>  [heap]
> 7f100adc6000-7f100addc000 r-xp 00000000 fd:03 6454
>  /lib64/libgcc_s.so.1
> 7f100addc000-7f100afdb000 ---p 00016000 fd:03 6454
>  /lib64/libgcc_s.so.1
> 7f100afdb000-7f100afdc000 r--p 00015000 fd:03 6454
>  /lib64/libgcc_s.so.1
> 7f100afdc000-7f100afdd000 rw-p 00016000 fd:03 6454
>  /lib64/libgcc_s.so.1
> 7f100afdd000-7f100b12c000 r-xp 00000000 fd:03 5882
>  /lib64/libc-2.10.1.so
> 7f100b12c000-7f100b32c000 ---p 0014f000 fd:03 5882
>  /lib64/libc-2.10.1.so
> 7f100b32c000-7f100b330000 r--p 0014f000 fd:03 5882
>  /lib64/libc-2.10.1.so
> 7f100b330000-7f100b331000 rw-p 00153000 fd:03 5882
>  /lib64/libc-2.10.1.so
> 7f100b331000-7f100b336000 rw-p 00000000 00:00 0
> 7f100b336000-7f100b353000 r-xp 00000000 fd:03 5871
>  /lib64/ld-2.10.1.so
> 7f100b536000-7f100b538000 rw-p 00000000 00:00 0
> 7f100b550000-7f100b552000 rw-p 00000000 00:00 0
> 7f100b552000-7f100b553000 r--p 0001c000 fd:03 5871
>  /lib64/ld-2.10.1.so
> 7f100b553000-7f100b554000 rw-p 0001d000 fd:03 5871
>  /lib64/ld-2.10.1.so
> 7fffe07b0000-7fffe07c5000 rw-p 00000000 00:00 0
>  [stack]
> 7fffe07ff000-7fffe0800000 r-xp 00000000 00:00 0
>  [vdso]
> ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
>  [vsyscall]
> *** buffer overflow detected ***: ftest07 terminated
> ======= Backtrace: =========
> /lib/libc.so.6(__fortify_fail+0x37)[0x7f8678b10867]
> /lib/libc.so.6[0x7f8678b0e680]
> /lib/libc.so.6[0x7f8678b0d979]
> /lib/libc.so.6(_IO_default_xsputn+0x85)[0x7f8678a9bf25]
> /lib/libc.so.6(_IO_vfprintf+0x1fed)[0x7f8678a6e6dd]
> /lib/libc.so.6(__vsprintf_chk+0x9d)[0x7f8678b0da1d]
> /lib/libc.so.6(__sprintf_chk+0x80)[0x7f8678b0d960]
> ftest07[0x401ec5]
> ftest07[0x402a76]
> /lib/libc.so.6(__libc_start_main+0xe6)[0x7f8678a48a26]
> ftest07[0x401d19]
> ======= Memory map: ========
> 00400000-00408000 r-xp 00000000 fd:03 74961
>  /tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest07
> 00608000-00609000 r--p 00008000 fd:03 74961
>  /tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest07
> 00609000-0060a000 rw-p 00009000 fd:03 74961
>  /tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest07
> 0060a000-0060f000 rw-p 00000000 00:00 0
> 01f3f000-01f60000 rw-p 00000000 00:00 0
>  [heap]
> 7f8678813000-7f8678829000 r-xp 00000000 fd:03 6454
>  /lib64/libgcc_s.so.1
> 7f8678829000-7f8678a28000 ---p 00016000 fd:03 6454
>  /lib64/libgcc_s.so.1
> 7f8678a28000-7f8678a29000 r--p 00015000 fd:03 6454
>  /lib64/libgcc_s.so.1
> 7f8678a29000-7f8678a2a000 rw-p 00016000 fd:03 6454
>  /lib64/libgcc_s.so.1
> 7f8678a2a000-7f8678b79000 r-xp 00000000 fd:03 5882
>  /lib64/libc-2.10.1.so
> 7f8678b79000-7f8678d79000 ---p 0014f000 fd:03 5882
>  /lib64/libc-2.10.1.so
> 7f8678d79000-7f8678d7d000 r--p 0014f000 fd:03 5882
>  /lib64/libc-2.10.1.so
> 7f8678d7d000-7f8678d7e000 rw-p 00153000 fd:03 5882
>  /lib64/libc-2.10.1.so
> 7f8678d7e000-7f8678d83000 rw-p 00000000 00:00 0
> 7f8678d83000-7f8678da0000 r-xp 00000000 fd:03 5871
>  /lib64/ld-2.10.1.so
> 7f8678f83000-7f8678f85000 rw-p 00000000 00:00 0
> 7f8678f9d000-7f8678f9f000 rw-p 00000000 00:00 0
> 7f8678f9f000-7f8678fa0000 r--p 0001c000 fd:03 5871
>  /lib64/ld-2.10.1.so
> 7f8678fa0000-7f8678fa1000 rw-p 0001d000 fd:03 5871
>  /lib64/ld-2.10.1.so
> 7fffeffa2000-7fffeffb7000 rw-p 00000000 00:00 0
>  [stack]
> 7fffeffff000-7ffff0000000 r-xp 00000000 00:00 0
>  [vdso]
> ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
>  [vsyscall]
>
>    gcooper@orangebox /scratch/ltp $ emerge --info
> Portage 2.1.6.13 (default/linux/amd64/10.0, gcc-4.3.4,
> glibc-2.10.1-r1, 2.6.31-gentoo-r6 x86_64)
> =================================================================
> System uname:
> Linux-2.6.31-gentoo-r6-x86_64-Intel-R-_Core-TM-2_Quad_CPU_Q9400_@
> _2.66GHz-with-gentoo-1.12.13
> Timestamp of tree: Sun, 24 Jan 2010 07:00:21 +0000
> app-shells/bash:     4.0_p35
> dev-java/java-config: 2.1.9-r2
> dev-lang/python:     2.6.4
> sys-apps/baselayout: 1.12.13
> sys-apps/sandbox:    1.6-r2
> sys-devel/autoconf:  2.13, 2.63-r1
> sys-devel/automake:  1.9.6-r2, 1.10.2
> sys-devel/binutils:  2.18-r3
> sys-devel/gcc-config: 1.4.1
> sys-devel/libtool:   2.2.6b
> virtual/os-headers:  2.6.27-r2
>
>    Figuring that ftest07.c compiled (mostly) without warnings, I
> thought it might be an issue common to both tests. Here's what I did
> and it didn't crash when I ran them, but I was wondering if others
> could verify whether or not they run into similar issues as well, and
> if so, tell me whether or not this patch functionality a) makes sense
> and b) resolves the issue:
>
> Index: testcases/kernel/fs/ftest/libftest.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/ftest/libftest.c,v
> retrieving revision 1.1
> diff -u -r1.1 libftest.c
> --- testcases/kernel/fs/ftest/libftest.c        18 Sep 2009 17:44:08
> -0000      1.1
> +++ testcases/kernel/fs/ftest/libftest.c        30 Jan 2010 05:24:42 -0000
> @@ -17,6 +17,7 @@
>  */
>
>  #include <sys/uio.h>
> +#include <assert.h>
>  #include "test.h"
>  #include "libftest.h"
>
> @@ -61,16 +62,18 @@
>  /*
>  * Dump bits string.
>  */
> -void ft_dumpbits(char *bits, int size)
> +void ft_dumpbits(void *bits, size_t size)
>  {
> -       char *buf;
> +       void *buf;
>
>        tst_resm(TINFO, "\tBits array:");
>
>        for (buf = bits; size > 0; --size, ++buf) {
> -               if ((buf-bits) % 16 == 0)
> -                       tst_resm(TINFO, "\t%04x:\t", 8*(buf-bits));
> -               tst_resm(TINFO, "\t%02x ", *buf & 0xff);
> +               if ((buf-bits) % 16 == 0) {
> +                       assert (0 < (buf-bits));
> +                       tst_resm(TINFO, "\t%lu:\t", 8*(buf-bits));
> +               }
> +               tst_resm(TINFO, "\t%02x ", *((char*) buf) & 0xff);
>        }
>
>        tst_resm(TINFO, "\t");
> Index: testcases/kernel/fs/ftest/libftest.h
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/ftest/libftest.h,v
> retrieving revision 1.1
> diff -u -r1.1 libftest.h
> --- testcases/kernel/fs/ftest/libftest.h        18 Sep 2009 17:44:08
> -0000      1.1
> +++ testcases/kernel/fs/ftest/libftest.h        30 Jan 2010 05:24:42 -0000
> @@ -34,7 +34,7 @@
>  /*
>  * Dump bits string.
>  */
> -void ft_dumpbits(char *bits, int size);
> +void ft_dumpbits(void *bits, size_t size);
>
>  /*
>  * Do logical or of hold and bits (of size)
>
>    I did what I did above because it's doing pointer arithmetic of
> virtual memory addresses, which means that that could be wreaking
> havoc if the value is truly rolling over / overflowing.
> Thanks,
> -Garrett
>
>
> ------------------------------------------------------------------------------
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the
> business
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
K.D. Lucas
kdlucas@gmail.com

--000e0cd13b247d5ef5047e69b7f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Garrett,<br><br>I see this issue all the time, since the July 2009 release.=
<br><br>kdl<br><br><div class=3D"gmail_quote">On Fri, Jan 29, 2010 at 9:29 =
PM, Garrett Cooper <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.c=
om">yanegomi@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
 =A0 =A0I&#39;ve been seeing the following messages when ftest03 and ftest0=
7<br>
are executed on a regular basis as of late (may be due to a recent<br>
glibc upgrade):<br>
<br>
*** buffer overflow detected ***: ftest03 terminated<br>
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
/lib/libc.so.6(__fortify_fail+0x37)[0x7f100b0c3867]<br>
/lib/libc.so.6[0x7f100b0c1680]<br>
/lib/libc.so.6[0x7f100b0c0979]<br>
/lib/libc.so.6(_IO_default_xsputn+0x85)[0x7f100b04ef25]<br>
/lib/libc.so.6(_IO_vfprintf+0x1fed)[0x7f100b0216dd]<br>
/lib/libc.so.6(__vsprintf_chk+0x9d)[0x7f100b0c0a1d]<br>
/lib/libc.so.6(__sprintf_chk+0x80)[0x7f100b0c0960]<br>
ftest03[0x401f05]<br>
ftest03[0x402a76]<br>
/lib/libc.so.6(__libc_start_main+0xe6)[0x7f100affba26]<br>
ftest03[0x401d59]<br>
=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>
00400000-00408000 r-xp 00000000 fd:03 74957<br>
 =A0/tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest03<br>
00608000-00609000 r--p 00008000 fd:03 74957<br>
 =A0/tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest03<br>
00609000-0060a000 rw-p 00009000 fd:03 74957<br>
 =A0/tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest03<br>
0060a000-0060f000 rw-p 00000000 00:00 0<br>
01f91000-01fb2000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[heap]<br>
7f100adc6000-7f100addc000 r-xp 00000000 fd:03 6454<br>
 =A0/lib64/libgcc_s.so.1<br>
7f100addc000-7f100afdb000 ---p 00016000 fd:03 6454<br>
 =A0/lib64/libgcc_s.so.1<br>
7f100afdb000-7f100afdc000 r--p 00015000 fd:03 6454<br>
 =A0/lib64/libgcc_s.so.1<br>
7f100afdc000-7f100afdd000 rw-p 00016000 fd:03 6454<br>
 =A0/lib64/libgcc_s.so.1<br>
7f100afdd000-7f100b12c000 r-xp 00000000 fd:03 5882<br>
 =A0/lib64/<a href=3D"http://libc-2.10.1.so" target=3D"_blank">libc-2.10.1.=
so</a><br>
7f100b12c000-7f100b32c000 ---p 0014f000 fd:03 5882<br>
 =A0/lib64/<a href=3D"http://libc-2.10.1.so" target=3D"_blank">libc-2.10.1.=
so</a><br>
7f100b32c000-7f100b330000 r--p 0014f000 fd:03 5882<br>
 =A0/lib64/<a href=3D"http://libc-2.10.1.so" target=3D"_blank">libc-2.10.1.=
so</a><br>
7f100b330000-7f100b331000 rw-p 00153000 fd:03 5882<br>
 =A0/lib64/<a href=3D"http://libc-2.10.1.so" target=3D"_blank">libc-2.10.1.=
so</a><br>
7f100b331000-7f100b336000 rw-p 00000000 00:00 0<br>
7f100b336000-7f100b353000 r-xp 00000000 fd:03 5871<br>
 =A0/lib64/<a href=3D"http://ld-2.10.1.so" target=3D"_blank">ld-2.10.1.so</=
a><br>
7f100b536000-7f100b538000 rw-p 00000000 00:00 0<br>
7f100b550000-7f100b552000 rw-p 00000000 00:00 0<br>
7f100b552000-7f100b553000 r--p 0001c000 fd:03 5871<br>
 =A0/lib64/<a href=3D"http://ld-2.10.1.so" target=3D"_blank">ld-2.10.1.so</=
a><br>
7f100b553000-7f100b554000 rw-p 0001d000 fd:03 5871<br>
 =A0/lib64/<a href=3D"http://ld-2.10.1.so" target=3D"_blank">ld-2.10.1.so</=
a><br>
7fffe07b0000-7fffe07c5000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0[stack]<br>
7fffe07ff000-7fffe0800000 r-xp 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0[vdso]<br>
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0<br>
 =A0[vsyscall]<br>
*** buffer overflow detected ***: ftest07 terminated<br>
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
/lib/libc.so.6(__fortify_fail+0x37)[0x7f8678b10867]<br>
/lib/libc.so.6[0x7f8678b0e680]<br>
/lib/libc.so.6[0x7f8678b0d979]<br>
/lib/libc.so.6(_IO_default_xsputn+0x85)[0x7f8678a9bf25]<br>
/lib/libc.so.6(_IO_vfprintf+0x1fed)[0x7f8678a6e6dd]<br>
/lib/libc.so.6(__vsprintf_chk+0x9d)[0x7f8678b0da1d]<br>
/lib/libc.so.6(__sprintf_chk+0x80)[0x7f8678b0d960]<br>
ftest07[0x401ec5]<br>
ftest07[0x402a76]<br>
/lib/libc.so.6(__libc_start_main+0xe6)[0x7f8678a48a26]<br>
ftest07[0x401d19]<br>
=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>
00400000-00408000 r-xp 00000000 fd:03 74961<br>
 =A0/tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest07<br>
00608000-00609000 r--p 00008000 fd:03 74961<br>
 =A0/tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest07<br>
00609000-0060a000 rw-p 00009000 fd:03 74961<br>
 =A0/tmp/tmp.9O93FRsMhN/ltp/testcases/bin/ftest07<br>
0060a000-0060f000 rw-p 00000000 00:00 0<br>
01f3f000-01f60000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[heap]<br>
7f8678813000-7f8678829000 r-xp 00000000 fd:03 6454<br>
 =A0/lib64/libgcc_s.so.1<br>
7f8678829000-7f8678a28000 ---p 00016000 fd:03 6454<br>
 =A0/lib64/libgcc_s.so.1<br>
7f8678a28000-7f8678a29000 r--p 00015000 fd:03 6454<br>
 =A0/lib64/libgcc_s.so.1<br>
7f8678a29000-7f8678a2a000 rw-p 00016000 fd:03 6454<br>
 =A0/lib64/libgcc_s.so.1<br>
7f8678a2a000-7f8678b79000 r-xp 00000000 fd:03 5882<br>
 =A0/lib64/<a href=3D"http://libc-2.10.1.so" target=3D"_blank">libc-2.10.1.=
so</a><br>
7f8678b79000-7f8678d79000 ---p 0014f000 fd:03 5882<br>
 =A0/lib64/<a href=3D"http://libc-2.10.1.so" target=3D"_blank">libc-2.10.1.=
so</a><br>
7f8678d79000-7f8678d7d000 r--p 0014f000 fd:03 5882<br>
 =A0/lib64/<a href=3D"http://libc-2.10.1.so" target=3D"_blank">libc-2.10.1.=
so</a><br>
7f8678d7d000-7f8678d7e000 rw-p 00153000 fd:03 5882<br>
 =A0/lib64/<a href=3D"http://libc-2.10.1.so" target=3D"_blank">libc-2.10.1.=
so</a><br>
7f8678d7e000-7f8678d83000 rw-p 00000000 00:00 0<br>
7f8678d83000-7f8678da0000 r-xp 00000000 fd:03 5871<br>
 =A0/lib64/<a href=3D"http://ld-2.10.1.so" target=3D"_blank">ld-2.10.1.so</=
a><br>
7f8678f83000-7f8678f85000 rw-p 00000000 00:00 0<br>
7f8678f9d000-7f8678f9f000 rw-p 00000000 00:00 0<br>
7f8678f9f000-7f8678fa0000 r--p 0001c000 fd:03 5871<br>
 =A0/lib64/<a href=3D"http://ld-2.10.1.so" target=3D"_blank">ld-2.10.1.so</=
a><br>
7f8678fa0000-7f8678fa1000 rw-p 0001d000 fd:03 5871<br>
 =A0/lib64/<a href=3D"http://ld-2.10.1.so" target=3D"_blank">ld-2.10.1.so</=
a><br>
7fffeffa2000-7fffeffb7000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0[stack]<br>
7fffeffff000-7ffff0000000 r-xp 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0[vdso]<br>
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0<br>
 =A0[vsyscall]<br>
<br>
 =A0 =A0gcooper@orangebox /scratch/ltp $ emerge --info<br>
Portage 2.1.6.13 (default/linux/amd64/10.0, gcc-4.3.4,<br>
glibc-2.10.1-r1, 2.6.31-gentoo-r6 x86_64)<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
System uname: Linux-2.6.31-gentoo-r6-x86_64-Intel-R-_Core-TM-2_Quad_CPU_Q94=
00_@_2.66GHz-with-gentoo-1.12.13<br>
Timestamp of tree: Sun, 24 Jan 2010 07:00:21 +0000<br>
app-shells/bash: =A0 =A0 4.0_p35<br>
dev-java/java-config: 2.1.9-r2<br>
dev-lang/python: =A0 =A0 2.6.4<br>
sys-apps/baselayout: 1.12.13<br>
sys-apps/sandbox: =A0 =A01.6-r2<br>
sys-devel/autoconf: =A02.13, 2.63-r1<br>
sys-devel/automake: =A01.9.6-r2, 1.10.2<br>
sys-devel/binutils: =A02.18-r3<br>
sys-devel/gcc-config: 1.4.1<br>
sys-devel/libtool: =A0 2.2.6b<br>
virtual/os-headers: =A02.6.27-r2<br>
<br>
 =A0 =A0Figuring that ftest07.c compiled (mostly) without warnings, I<br>
thought it might be an issue common to both tests. Here&#39;s what I did<br=
>
and it didn&#39;t crash when I ran them, but I was wondering if others<br>
could verify whether or not they run into similar issues as well, and<br>
if so, tell me whether or not this patch functionality a) makes sense<br>
and b) resolves the issue:<br>
<br>
Index: testcases/kernel/fs/ftest/libftest.c<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/ftest/libftest.c,v<br>
retrieving revision 1.1<br>
diff -u -r1.1 libftest.c<br>
--- testcases/kernel/fs/ftest/libftest.c =A0 =A0 =A0 =A018 Sep 2009 17:44:0=
8<br>
-0000 =A0 =A0 =A01.1<br>
+++ testcases/kernel/fs/ftest/libftest.c =A0 =A0 =A0 =A030 Jan 2010 05:24:4=
2 -0000<br>
@@ -17,6 +17,7 @@<br>
 =A0*/<br>
<br>
=A0#include &lt;sys/uio.h&gt;<br>
+#include &lt;assert.h&gt;<br>
=A0#include &quot;test.h&quot;<br>
=A0#include &quot;libftest.h&quot;<br>
<br>
@@ -61,16 +62,18 @@<br>
=A0/*<br>
 =A0* Dump bits string.<br>
 =A0*/<br>
-void ft_dumpbits(char *bits, int size)<br>
+void ft_dumpbits(void *bits, size_t size)<br>
=A0{<br>
- =A0 =A0 =A0 char *buf;<br>
+ =A0 =A0 =A0 void *buf;<br>
<br>
 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;\tBits array:&quot;);<br>
<br>
 =A0 =A0 =A0 =A0for (buf =3D bits; size &gt; 0; --size, ++buf) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buf-bits) % 16 =3D=3D 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, &quot;\t%04x:=
\t&quot;, 8*(buf-bits));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, &quot;\t%02x &quot;, *buf &am=
p; 0xff);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buf-bits) % 16 =3D=3D 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 assert (0 &lt; (buf-bits));<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, &quot;\t%lu:\=
t&quot;, 8*(buf-bits));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, &quot;\t%02x &quot;, *((char*=
) buf) &amp; 0xff);<br>
 =A0 =A0 =A0 =A0}<br>
<br>
 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;\t&quot;);<br>
Index: testcases/kernel/fs/ftest/libftest.h<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/ftest/libftest.h,v<br>
retrieving revision 1.1<br>
diff -u -r1.1 libftest.h<br>
--- testcases/kernel/fs/ftest/libftest.h =A0 =A0 =A0 =A018 Sep 2009 17:44:0=
8<br>
-0000 =A0 =A0 =A01.1<br>
+++ testcases/kernel/fs/ftest/libftest.h =A0 =A0 =A0 =A030 Jan 2010 05:24:4=
2 -0000<br>
@@ -34,7 +34,7 @@<br>
=A0/*<br>
 =A0* Dump bits string.<br>
 =A0*/<br>
-void ft_dumpbits(char *bits, int size);<br>
+void ft_dumpbits(void *bits, size_t size);<br>
<br>
=A0/*<br>
 =A0* Do logical or of hold and bits (of size)<br>
<br>
 =A0 =A0I did what I did above because it&#39;s doing pointer arithmetic of=
<br>
virtual memory addresses, which means that that could be wreaking<br>
havoc if the value is truly rolling over / overflowing.<br>
Thanks,<br>
-Garrett<br>
<br>
---------------------------------------------------------------------------=
---<br>
The Planet: dedicated and managed hosting, cloud storage, colocation<br>
Stay online with enterprise data centers and the best network in the busine=
ss<br>
Choose flexible plans and management services without long-term contracts<b=
r>
Personal 24x7 support from experience hosting pros just a phone call away.<=
br>
<a href=3D"http://p.sf.net/sfu/theplanet-com" target=3D"_blank">http://p.sf=
.net/sfu/theplanet-com</a><br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>K.D. Lucas<br><a href=
=3D"mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>

--000e0cd13b247d5ef5047e69b7f9--


--===============3264142382232467199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
--===============3264142382232467199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3264142382232467199==--

