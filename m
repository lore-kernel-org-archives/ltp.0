Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ashish.g@teldevice.co.jp>) id 1NapRI-0004n9-9d
	for ltp-list@lists.sourceforge.net; Fri, 29 Jan 2010 11:55:04 +0000
Received: from mail-gw.teldevice.co.jp ([124.215.243.245] helo=teldevice.co.jp)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NapRF-0000jy-Jl
	for ltp-list@lists.sourceforge.net; Fri, 29 Jan 2010 11:55:04 +0000
Message-ID: <4B62C8E0.90606@teldevice.co.jp>
Date: Fri, 29 Jan 2010 20:39:12 +0900
From: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
MIME-Version: 1.0
References: <mailman.305740.1263813468.5845.ltp-list@lists.sourceforge.net>
	<OF918F8646.FA1E0AB1-ON652576B6.0031EE52-652576B6.0032789D@tcs.com>
In-Reply-To: <OF918F8646.FA1E0AB1-ON652576B6.0031EE52-652576B6.0032789D@tcs.com>
Subject: Re: [LTP] Ltp-list Digest, Vol 44, Issue 44
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Anish Rawat <anish.rawat@tcs.com>
Cc: ltp-list@lists.sourceforge.net, ltp-list@lists.sf.net

Hello Anish

Thanks a lot dear for your helping hands.

It was delayed because i got stuck with my another project, so i left this =
LTP stuff for a while.


 > 8.                 export PATH=3D/usr/local/arm/bin/:$PATH
 > 9.                 export CC=3D/usr/local/arm/bin/arm-XXX-gcc

basically i downloaded the LTIB from Freescale and it has the toolchain so =
i try to use via that only.

i followed the steps same as you guided.

i set the above PATH and CC as

export PATH=3D/opt/freescale/usr/local/gcc-4.1.2-glibc-2.5-nptl-3/arm-none-=
linux-gnueabi/bin/:$PATH
export CC=3D/opt/freescale/usr/local/gcc-4.1.2-glibc-2.5-nptl-3/arm-none-li=
nux-gnueabi/bin/arm-none-linux-gnueabi-gcc

and tried to $make

and it landed to an make error as:  :S

make[4]: Leaving directory `/home/ydcd011/imx31ADS/ltp/ltp-full-20090831/te=
stcases/kernel/syscalls/sighold'
make[4]: Entering directory `/home/ydcd011/imx31ADS/ltp/ltp-full-20090831/t=
estcases/kernel/syscalls/signalfd4'
/opt/freescale/usr/local/gcc-4.1.2-glibc-2.5-nptl-3/arm-none-linux-gnueabi/=
bin/arm-none-linux-gnueabi-gcc -Wall  -I../../include -g -Wall -I../../../.=
./include -Wall    signalfd4_01.c  -L../../../../lib -lltp -o signalfd4_01
/opt/freescale/usr/local/gcc-4.1.2-glibc-2.5-nptl-3/arm-none-linux-gnueabi/=
bin/arm-none-linux-gnueabi-gcc -Wall  -I../../include -g -Wall -I../../../.=
./include -Wall    signalfd4_02.c  -L../../../../lib -lltp -o signalfd4_02
make[4]: Leaving directory `/home/ydcd011/imx31ADS/ltp/ltp-full-20090831/te=
stcases/kernel/syscalls/signalfd4'
make[4]: Entering directory `/home/ydcd011/imx31ADS/ltp/ltp-full-20090831/t=
estcases/kernel/syscalls/signalfd'
/opt/freescale/usr/local/gcc-4.1.2-glibc-2.5-nptl-3/arm-none-linux-gnueabi/=
bin/arm-none-linux-gnueabi-gcc -Wall  -I../../include -g -Wall -I../../../.=
./include -Wall    signalfd01.c  -L../../../../lib -lltp -o signalfd01
signalfd01.c:57:26: error: sys/signalfd.h: No such file or directory
signalfd01.c: In function 'do_test1':
signalfd01.c:104: error: storage size of 'fdsi' isn't known
signalfd01.c:115: warning: implicit declaration of function 'signalfd'
signalfd01.c:145: error: invalid application of 'sizeof' to incomplete type=
 'struct signalfd_siginfo'
signalfd01.c:146: error: invalid application of 'sizeof' to incomplete type=
 'struct signalfd_siginfo'
signalfd01.c:150: error: invalid application of 'sizeof' to incomplete type=
 'struct signalfd_siginfo'
signalfd01.c:104: warning: unused variable 'fdsi'
signalfd01.c: In function 'do_test2':
signalfd01.c:196: error: storage size of 'fdsi' isn't known
signalfd01.c:235: error: invalid application of 'sizeof' to incomplete type=
 'struct signalfd_siginfo'
signalfd01.c:236: error: invalid application of 'sizeof' to incomplete type=
 'struct signalfd_siginfo'
signalfd01.c:240: error: invalid application of 'sizeof' to incomplete type=
 'struct signalfd_siginfo'
signalfd01.c:196: warning: unused variable 'fdsi'
make[4]: *** [signalfd01] Error 1
make[4]: Leaving directory `/home/ydcd011/imx31ADS/ltp/ltp-full-20090831/te=
stcases/kernel/syscalls/signalfd'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/home/ydcd011/imx31ADS/ltp/ltp-full-20090831/te=
stcases/kernel/syscalls'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/ydcd011/imx31ADS/ltp/ltp-full-20090831/te=
stcases/kernel'
make[1]: *** [all] Error 2



Please Help



Anish Rawat ????????:
> =

> Hello Ashish,
> =

> try the following steps to compile the LTP for your target board i.e.iMX31
> Steps:
> 1.                 Host machine: with fedora or centos with cross arm =

> tool chain installed.
> 2.                 Target board: any arm target board booted with Linux =

> kernel.
> 3.                 Download the ltp source from the below link
> http://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20090831/ltp-f=
ull-20090831.tgz/download
> 4.                 Currently I am using ltp-full-20090831.tgz because =

> latest versions
> are merged with autoconfig and configure rules.
> 5.                 untar the ltp source.
> 6.                 There are two ways to do this a. cross compile and =

> execute on
> target b. native compilation and execute.
> 7.                 to cross compile export the PATH and CC
> 8.                 export PATH=3D/usr/local/arm/bin/:$PATH
> 9.                 export CC=3D/usr/local/arm/bin/arm-XXX-gcc
> 10.                 cd  ltp-full-20090831
> 11.                 make
> 12.                 make install
> 13.                 cd ..
> 14.                 copy the ltp-full-20090831 to target file system =

> where hard disk is mounted.
> 15.                 log in to target machine
> 16.                 cd ltp-full-20090831
> 17.                 sh runltp  or sh runltp =96g file.html
> 18.                 if you want to compile and execute on target with =

> native compile u
> can do it directly as skip step 8 and step 9
> =

> you can also make 1 change to it i.e. during ./config command
>  =

> For embedded systems, you can customize. What C library does your =

> embedded platform support - uclibc or standard libc. With uclibc, you =

> may have some work to compile, but for libc it compiles easily. For eg: =

> ./configure --build=3Di386-linux --host=3Darm-none-linux-gnueabi =

> --prefix=3D/home/xyz  will cross compile ltp using arm-none-linux-gnueabi =

> toolchain and install in the prefix location.
> =

> Regards
> Anish Rawat
> =

> =

> Mailto: anish.rawat@tcs.com
> Website: http://www.tcs.com <http://www.tcs.com/>
> ____________________________________________
> Experience certainty.        IT Services
>                        Business Solutions
>                        Outsourcing
> ____________________________________________
> =

> =

> From: 	ltp-list-request@lists.sourceforge.net
> To: 	ltp-list@lists.sourceforge.net
> Date: 	01/18/2010 04:48 PM
> Subject: 	Ltp-list Digest, Vol 44, Issue 44
> =

> =

> ------------------------------------------------------------------------
> =

> =

> =

> Send Ltp-list mailing list submissions to
>                 ltp-list@lists.sourceforge.net
> =

> To subscribe or unsubscribe via the World Wide Web, visit
>                 https://lists.sourceforge.net/lists/listinfo/ltp-list
> or, via email, send a message with subject or body 'help' to
>                 ltp-list-request@lists.sourceforge.net
> =

> You can reach the person managing the list at
>                 ltp-list-owner@lists.sourceforge.net
> =

> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Ltp-list digest..."
> =

> =

> Today's Topics:
> =

>   1. [ ltp-Bugs-2931756 ] Mangled C++ names in LCOV functions
>      (SourceForge.net)
>   2. Ran into a brick wall with make 3.80 (Garrett Cooper)
>   3. i.MX31 Platform Embedded Linux LTP Test (TED ITC Agarwal Ashish)
>   4. Re: i.MX31 Platform Embedded Linux LTP Test (Garrett Cooper)
>   5. Re: [PATCH] Add make 3.80 $(abspath ) and $(realpath )
>      emulation scripts (Garrett Cooper)
> =

> =

> ----------------------------------------------------------------------
> =

> Message: 1
> Date: Thu, 14 Jan 2010 01:20:08 +0000
> From: "SourceForge.net" <noreply@sourceforge.net>
> Subject: [LTP] [ ltp-Bugs-2931756 ] Mangled C++ names in LCOV
>                 functions
> To: noreply@sourceforge.net
> Message-ID: <E1NVENc-00010w-Uj@cdv4jf1.ch3.sourceforge.com>
> Content-Type: text/plain; charset=3D"UTF-8"
> =

> Bugs item #2931756, was opened at 2010-01-13 18:20
> Message generated for change (Tracker Item Submitted) made by crispydev
> You can respond by visiting:
> https://sourceforge.net/tracker/?func=3Ddetail&atid=3D103382&aid=3D293175=
6&group_id=3D3382 =

> <https://sourceforge.net/tracker/?func=3Ddetail&atid=3D103382&aid=3D29317=
56&group_id=3D3382>
> =

> Please note that this message will contain a full copy of the comment =

> thread,
> including the initial issue submission, for this request,
> not just the latest update.
> Category: None
> Group: None
> Status: Open
> Resolution: None
> Priority: 5
> Private: No
> Submitted By: Marc Alff (crispydev)
> Assigned to: Nobody/Anonymous (nobody)
> Summary: Mangled C++ names in LCOV functions
> =

> Initial Comment:
> Hi.
> =

> I just looked at a LCOV report for some code using C++, generated with =

> LCOV 1.7.
> =

> First, thanks a lot for the new function coverage feature.
> =

> A minor bug:
> In the report showing the function_name / hit count table,
> names for C++ methods are using the C++ encoded name =

> (_ZN13MYSQL_BIN_LOG25set_purge_index_file_nameEPKc),
> where the demangled name (MYSQL_BIN_LOG::set_purge_index_file_name(char =

> const*)) would be much nicer.
> =

> malff@linux-su11:~> c++filt --version
> GNU c++filt (GNU Binutils; openSUSE 11.1) 2.19
> =

> malff@linux-su11:~> c++filt
> "_ZN13MYSQL_BIN_LOG25set_purge_index_file_nameEPKc"
> MYSQL_BIN_LOG::set_purge_index_file_name(char const*)
> =

> Regards,
> -- Marc Alff
> =

> =

> ----------------------------------------------------------------------
> =

> You can respond by visiting:
> https://sourceforge.net/tracker/?func=3Ddetail&atid=3D103382&aid=3D293175=
6&group_id=3D3382 =

> <https://sourceforge.net/tracker/?func=3Ddetail&atid=3D103382&aid=3D29317=
56&group_id=3D3382>
> =

> =

> =

> ------------------------------
> =

> Message: 2
> Date: Sun, 17 Jan 2010 23:33:46 -0800
> From: Garrett Cooper <yanegomi@gmail.com>
> Subject: [LTP] Ran into a brick wall with make 3.80
> To: LTP list <ltp-list@lists.sourceforge.net>
> Message-ID:
>                 =

> <364299f41001172333q76264309tc613fca2329f8bbd@mail.gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
> =

>    So... it appears that I've run into a serious brick wall with make
> 3.80 with eval blocks, which looks like:
> =

> make[4]: Leaving directory
> `/scratch/ltp/testcases/kernel/controllers/libcontrollers'
> make[4]: Entering directory
> `/scratch/ltp/testcases/kernel/controllers/libcontrollers'
> /scratch/ltp/include/mk/env_post.mk:72: *** missing `endif'.  Stop.
> =

>    There are so many bugfixes that have gone into read.c and a few
> other things in make that I don't know which one is causing the
> problem, yet. I honestly don't know if getting past this would be
> possible, or fruitful, but I'll keep on trying...
> Thanks,
> -Garrett
> =

> =

> =

> ------------------------------
> =

> Message: 3
> Date: Mon, 18 Jan 2010 19:49:20 +0900
> From: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
> Subject: [LTP] i.MX31 Platform Embedded Linux LTP Test
> To: ltp-list@lists.sourceforge.net
> Message-ID: <4B543CB0.8090801@teldevice.co.jp>
> Content-Type: text/plain; charset=3DISO-2022-JP
> =

> Hello All,
> =

> This is Ashish Agarwal, I am new to LTP.
> =

> Last day i was succeeded to install the LTP over Fedora 7 system. and =

> run test as well.
> =

> As my main motive of LTP learn is to Test a customized Embedded Linux =

> system for Freescale i.Mx31 CPU.
> =

> My Project specs are as below:
> =

> Kernel: 2.6.19.2
> CPU: i.MX31
> Rootfs mounted over : Flash (jffs2 file system, 256MB)
> =

> So my motive is to install the LTP and run the test.
> =

> Because my system is mounted over Flash, so it can be seen as the memory =

> is remained is not so much as we can use in general projects (PC's).
> and i had not include any "make" and "gcc" components to my customized =

> kernel. (because of memory)
> =

> So how can i install the LTP over the system.  (i have USB ports, and =

> mass storage driver support).
> =

> --
> =

> Ashish Agarwal
> =

> =

> =

> ------------------------------
> =

> Message: 4
> Date: Mon, 18 Jan 2010 03:09:20 -0800
> From: Garrett Cooper <yanegomi@gmail.com>
> Subject: Re: [LTP] i.MX31 Platform Embedded Linux LTP Test
> To: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
> Cc: ltp-list@lists.sourceforge.net
> Message-ID:
>                 =

> <364299f41001180309m68619dcat7271b0e52b678652@mail.gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
> =

> On Mon, Jan 18, 2010 at 2:49 AM, TED ITC Agarwal Ashish
> <ashish.g@teldevice.co.jp> wrote:
>  > Hello All,
>  >
>  > This is Ashish Agarwal, I am new to LTP.
>  >
>  > Last day i was succeeded to install the LTP over Fedora 7 system. and =

> run test as well.
>  >
>  > As my main motive of LTP learn is to Test a customized Embedded Linux =

> system for Freescale i.Mx31 CPU.
>  >
>  > My Project specs are as below:
>  >
>  > Kernel: 2.6.19.2
>  > CPU: i.MX31
>  > Rootfs mounted over : Flash (jffs2 file system, 256MB)
>  >
>  > So my motive is to install the LTP and run the test.
>  >
>  > Because my system is mounted over Flash, so it can be seen as the =

> memory is remained is not so much as we can use in general projects (PC's=
).
>  > and i had not include any "make" and "gcc" components to my =

> customized kernel. (because of memory)
>  >
>  > So how can i install the LTP over the system. ?(i have USB ports, and =

> mass storage driver support).
> =

>    Please read the INSTALL file for more details on how to configure,
> compile, and install LTP. The out-of-build-tree method may be suitable
> for your needs.
> HTH,
> -Garrett
> =

> =

> =

> ------------------------------
> =

> Message: 5
> Date: Mon, 18 Jan 2010 03:17:33 -0800
> From: Garrett Cooper <yanegomi@gmail.com>
> Subject: Re: [LTP] [PATCH] Add make 3.80 $(abspath ) and $(realpath )
>                 emulation scripts
> To: Mike Frysinger <vapier@gentoo.org>
> Cc: LTP list <ltp-list@lists.sourceforge.net>, Andi Kleen
>                 <andi@firstfloor.org>, ???? <mitani@ryobi.co.jp>
> Message-ID:
>                 <364299f41001180317n840e769g4d073853e8e0c135@mail.gmail.c=
om>
> Content-Type: text/plain; charset=3DISO-8859-1
> =

> 2010/1/17 Garrett Cooper <yanegomi@gmail.com>:
>  > 2010/1/17 Garrett Cooper <yanegomi@gmail.com>:
>  >> 2010/1/16 Garrett Cooper <yanegomi@gmail.com>:
>  >>> 2010/1/15 Mike Frysinger <vapier@gentoo.org>:
>  >>>> On Friday 15 January 2010 17:07:48 Garrett Cooper wrote:
>  >>>>> Shortly after I sent out this email, I received some helpful repli=
es
>  >>>>> as to why my code wasn't working. It turns out that the curly brac=
ket
>  >>>>> regexp quantifier operators available in many other popular
>  >>>>> implementations of regexps (perl, python, tcl) isn't supported in =

> awk.
>  >>>>> Here's the new patch with less bloat.
>  >>>>
>  >>>> the patch itself is word wrapped in the e-mail though :(
>  >>>>
>  >>>>> +_abspath() {
>  >>>>> + ? ? echo "$@" | awk '{ sub(/\/$/, ""); while (gsub(/\/\//, =

> "/")) { };
>  >>>>> while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { }; while (gsub(/\/\.\//,
>  >>>>> "/")) { } print }'
>  >>>>> +}
>  >>>>
>  >>>> it's easy to line wrap awk scripts, and this sucker really needs it
>  >>>>
>  >>>> btw, this doesnt quite handle:
>  >>>> /a/b/c/.././
>  >>>>
>  >>>> how about this (largely untested) sed:
>  >>>> sed -r -e 's:/+[.]/+:/:g' -e 's:(^|/+[^/]*)/+[.][.]/+:/:g' -e =

> 's:/+$::'
>  >>>>
>  >>>>> --- /dev/null 1 Jan 1970 00:00:00 -0000
>  >>>>> +++ tests/test_abspath.sh ? ? 15 Jan 2010 22:04:59 -0000
>  >>>>> +# NOTE (garrcoop): I usually don't use bashisms, but it was just =

> easier to
>  >>>>> +# express these values as an array of values instead of one =

> whacky long
>  >>>>> +# string.
>  >>>>> +test_strings=3D( ? ? foo/bar /foo/bar /foo/../bar /foo/bar/../baz
>  >>>>> /foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../
>  >>>>> /foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar
>  >>>>> //////foo/bar /foo/////bar )
>  >>>>> +expected_strings=3D( foo/bar /foo/bar /bar ? ? ? ?/foo/baz
>  >>>>> /foo/baz ? ? ? ? /bar ? ? ? ? / ? ? ? ? ? ? ?/ ? ? ? ? ? ? ? /foo/=
baz
>  >>>>> ? ? ? /foo/bar ? /foo/bar ? ? /foo/bar ?/foo/bar ?/foo/bar
>  >>>>> /foo/bar )
>  >>>>
>  >>>> probably be good if the source were better wrapped
>  >>>>
>  >>>> however, two parallel arrays makes it hard to correlate the =

> input/expected
>  >>>> values. ?how about something like:
>  >>>> set -- \
>  >>>> ? ? ? ?foo/bar:foo/bar \
>  >>>> ? ? ? ?/foo/bar:/foo/bar \
>  >>>> ? ? ? ?/foo/../bar:/bar \
>  >>>> ? ? ? ?...........
>  >>>>
>  >>>> then you can easily do:
>  >>>> for test in "$@" ; do
>  >>>> ? ? ? ?input=3D${test%:*}
>  >>>> ? ? ? ?expect=3D${test#*:}
>  >>>> ? ? ? ?...
>  >>>> done
>  >>>>
>  >>>> this should be POSIX and avoid /bin/bash
>  >>>
>  >>> Version 2:
>  >>>
>  >>> 1. Incorporate comments from Mike F.
>  >>> 2. Resolve a negative testcase failure.
>  >>>
>  >>> gcooper@orangebox /scratch/ltp $ scripts/tests/test_abspath.sh
>  >>> test_abspath ? ?1 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(foo/bar) =3D> foo/bar =3D=3D foo/bar)
>  >>> test_abspath ? ?2 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >>> test_abspath ? ?3 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
>  >>> test_abspath ? ?4 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>  >>> test_abspath ? ?5 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
>  >>> test_abspath ? ?6 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
>  >>> test_abspath ? ?7 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/../bar/..) =3D> / =3D=3D /)
>  >>> test_abspath ? ?8 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/../bar/../) =3D> / =3D=3D /)
>  >>> test_abspath ? ?9 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>  >>> test_abspath ? 10 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >>> test_abspath ? 11 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >>> test_abspath ? 12 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >>> test_abspath ? 13 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >>> test_abspath ? 14 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >>> test_abspath ? 15 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >>> test_abspath ? 16 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
>  >>> test_abspath ? 17 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/.foo) =3D> /.foo =3D=3D /.foo)
>  >>> test_abspath ? 18 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(./.foo) =3D> /.foo =3D=3D /.foo)
>  >>> test_abspath ? 19 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>  >>> test_abspath ? 20 ?TPASS ?: ?Test string matches expected string
>  >>> _abspath(./.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>  >>>
>  >>> Index: scripts/lib/file_functions.sh
>  >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  >>> RCS file: scripts/lib/file_functions.sh
>  >>> diff -N scripts/lib/file_functions.sh
>  >>> --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  >>> +++ scripts/lib/file_functions.sh ? ? ? 17 Jan 2010 06:18:33 -0000
>  >>> @@ -0,0 +1,50 @@
>  >>> +#!/bin/sh
>  >>> +#
>  >>> +# File functions utilized as part of abspath.sh, realpath.sh, etc.
>  >>> +#
>  >>> +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  >>> +#
>  >>> +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  >>> +# ? ?it under the terms of the GNU General Public License as =

> published by
>  >>> +# ? ?the Free Software Foundation; either version 2 of the License,=
 or
>  >>> +# ? ?(at your option) any later version.
>  >>> +#
>  >>> +# ? ?This program is distributed in the hope that it will be useful,
>  >>> +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  >>> +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  >>> +# ? ?GNU General Public License for more details.
>  >>> +#
>  >>> +# ? ?You should have received a copy of the GNU General Public =

> License along
>  >>> +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  >>> +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  >>> +#
>  >>> +# Garrett Cooper, January 2010
>  >>> +#
>  >>> +# POSIX compliant bourne shell functions for performing make 3.81
>  >>> +# compliancy in 3.80 with a minimal set of external commands
>  >>> +# [awk(1) // readlink(1) only required].
>  >>> +#
>  >>> +
>  >>> +# 1. Replace /+ with /.
>  >>> +# 2. Replace a/b/../c with a/c
>  >>> +# 3. Replace /./ with /
>  >>> +# 4. Replace trailing /. with /
>  >>> +# 5. Replace heading ./ with /
>  >>> +_abspath() {
>  >>> + ? ? ? echo "$@" | awk '{
>  >>> + ? ? ? while (gsub(/\/\//, "/")) { };
>  >>> + ? ? ? while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { };
>  >>> + ? ? ? while (gsub(/\/\.\//, "/")) { };
>  >>> + ? ? ? sub(/(\/\.)?\/$/, "");
>  >>> + ? ? ? sub(/^\.\//, "/") ;
>  >>> + ? ? ? if ($0 =3D=3D "") {
>  >>> + ? ? ? ? ? ? ? print "/";
>  >>> + ? ? ? } else {
>  >>> + ? ? ? ? ? ? ? print;
>  >>> + ? ? ? }
>  >>> +}'
>  >>> +}
>  >>> +
>  >>> +_realpath() {
>  >>> + ? ? ? readlink -f "$@"
>  >>> +}
>  >>> Index: scripts/tests/test_abspath.sh
>  >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  >>> RCS file: scripts/tests/test_abspath.sh
>  >>> diff -N scripts/tests/test_abspath.sh
>  >>> --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  >>> +++ scripts/tests/test_abspath.sh ? ? ? 17 Jan 2010 06:18:33 -0000
>  >>> @@ -0,0 +1,73 @@
>  >>> +#!/bin/sh
>  >>> +#
>  >>> +# Test the _abspath function, utilized as part of abspath.sh
>  >>> +#
>  >>> +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  >>> +#
>  >>> +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  >>> +# ? ?it under the terms of the GNU General Public License as =

> published by
>  >>> +# ? ?the Free Software Foundation; either version 2 of the License,=
 or
>  >>> +# ? ?(at your option) any later version.
>  >>> +#
>  >>> +# ? ?This program is distributed in the hope that it will be useful,
>  >>> +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  >>> +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  >>> +# ? ?GNU General Public License for more details.
>  >>> +#
>  >>> +# ? ?You should have received a copy of the GNU General Public =

> License along
>  >>> +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  >>> +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  >>> +#
>  >>> +# Garrett Cooper, January 2010
>  >>> +#
>  >>> +
>  >>> +set -- foo/bar:foo/bar ? ? ? ? ? ? ? ? \
>  >>> + ? ? ? /foo/bar:/foo/bar ? ? ? ? ? ? ? \
>  >>> + ? ? ? /foo/../bar:/bar ? ? ? ? ? ? ? ?\
>  >>> + ? ? ? /foo/bar/../baz:/foo/baz ? ? ? ?\
>  >>> + ? ? ? /foo/bar/../baz/:/foo/baz ? ? ? \
>  >>> + ? ? ? /foo/../bar/:/bar ? ? ? ? ? ? ? \
>  >>> + ? ? ? /foo/../bar/..:/ ? ? ? ? ? ? ? ?\
>  >>> + ? ? ? /foo/../bar/../:/ ? ? ? ? ? ? ? \
>  >>> + ? ? ? /foo/bar/../baz:/foo/baz ? ? ? ?\
>  >>> + ? ? ? /foo/./bar:/foo/bar ? ? ? ? ? ? \
>  >>> + ? ? ? /./foo/./bar:/foo/bar ? ? ? ? ? \
>  >>> + ? ? ? /foo//bar:/foo/bar ? ? ? ? ? ? ?\
>  >>> + ? ? ? //foo/bar:/foo/bar ? ? ? ? ? ? ?\
>  >>> + ? ? ? //////foo/bar:/foo/bar ? ? ? ? ?\
>  >>> + ? ? ? /foo/////bar:/foo/bar ? ? ? ? ? \
>  >>> + ? ? ? /a/b/c/.././:/a/b ? ? ? ? ? ? ? \
>  >>> + ? ? ? /.foo:/.foo ? ? ? ? ? ? ? ? ? ? \
>  >>> + ? ? ? ./.foo:/.foo ? ? ? ? ? ? ? ? ? ?\
>  >>> + ? ? ? /.foo/.bar:/.foo/.bar ? ? ? ? ? \
>  >>> + ? ? ? ./.foo/.bar:/.foo/.bar
>  >>> +
>  >>> +export TCID=3Dtest_abspath
>  >>> +export TST_TOTAL=3D$#
>  >>> +export TST_COUNT=3D1
>  >>> +
>  >>> +. "${0%/*}/../lib/file_functions.sh"
>  >>> +
>  >>> +for i in "$@"; do
>  >>> +
>  >>> + ? ? ? test_string=3D${i%:*}
>  >>> + ? ? ? expected_string=3D${i#*:}
>  >>> +
>  >>> + ? ? ? result=3D$(_abspath "$test_string")
>  >>> +
>  >>> + ? ? ? if [ "$result" =3D "$expected_string" ]; then
>  >>> + ? ? ? ? ? ? ? result_s=3D"matches expected string =

> _abspath(${test_string}) =3D>
>  >>> $result =3D=3D $expected_string)"
>  >>> + ? ? ? ? ? ? ? result_v=3DTPASS
>  >>> + ? ? ? else
>  >>> + ? ? ? ? ? ? ? result_s=3D"doesn't match expected string =

> _abspath(${test_string}) =3D>
>  >>> $result !=3D $expected_string)"
>  >>> + ? ? ? ? ? ? ? result_v=3DTFAIL
>  >>> + ? ? ? ? ? ? ? FAILED=3D1
>  >>> + ? ? ? fi
>  >>> +
>  >>> + ? ? ? tst_resm $result_v "Test string $result_s"
>  >>> +
>  >>> + ? ? ? : $(( TST_COUNT +=3D 1 ))
>  >>> +
>  >>> +done
>  >>> +
>  >>> +exit ${FAILED:=3D0}
>  >>> Index: scripts/abspath.sh
>  >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  >>> RCS file: scripts/abspath.sh
>  >>> diff -N scripts/abspath.sh
>  >>> --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  >>> +++ scripts/abspath.sh ?17 Jan 2010 06:18:33 -0000
>  >>> @@ -0,0 +1,29 @@
>  >>> +#!/bin/sh
>  >>> +#
>  >>> +# ? ?make 3.81 $(abspath .. ) emulation layer
>  >>> +#
>  >>> +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  >>> +#
>  >>> +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  >>> +# ? ?it under the terms of the GNU General Public License as =

> published by
>  >>> +# ? ?the Free Software Foundation; either version 2 of the License,=
 or
>  >>> +# ? ?(at your option) any later version.
>  >>> +#
>  >>> +# ? ?This program is distributed in the hope that it will be useful,
>  >>> +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  >>> +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  >>> +# ? ?GNU General Public License for more details.
>  >>> +#
>  >>> +# ? ?You should have received a copy of the GNU General Public =

> License along
>  >>> +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  >>> +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  >>> +#
>  >>> +# Garrett Cooper, January 2010
>  >>> +#
>  >>> +
>  >>> +. "${0%/*}/lib/file_functions.sh"
>  >>> +
>  >>> +while [ $# -gt 0 ] ; do
>  >>> + ? ? ? _abspath "$1"
>  >>> + ? ? ? shift
>  >>> +done
>  >>> Index: scripts/realpath.sh
>  >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  >>> RCS file: scripts/realpath.sh
>  >>> diff -N scripts/realpath.sh
>  >>> --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  >>> +++ scripts/realpath.sh 17 Jan 2010 06:18:33 -0000
>  >>> @@ -0,0 +1,29 @@
>  >>> +#!/bin/sh
>  >>> +#
>  >>> +# ? ?make 3.81 $(realpath .. ) emulation layer
>  >>> +#
>  >>> +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  >>> +#
>  >>> +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  >>> +# ? ?it under the terms of the GNU General Public License as =

> published by
>  >>> +# ? ?the Free Software Foundation; either version 2 of the License,=
 or
>  >>> +# ? ?(at your option) any later version.
>  >>> +#
>  >>> +# ? ?This program is distributed in the hope that it will be useful,
>  >>> +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  >>> +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  >>> +# ? ?GNU General Public License for more details.
>  >>> +#
>  >>> +# ? ?You should have received a copy of the GNU General Public =

> License along
>  >>> +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  >>> +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  >>> +#
>  >>> +# Garrett Cooper, January 2010
>  >>> +#
>  >>> +
>  >>> +. "${0%/*}/lib/file_functions.sh"
>  >>> +
>  >>> +while [ $# -gt 0 ] ; do
>  >>> + ? ? ? _realpath "$1"
>  >>> + ? ? ? shift
>  >>> +done
>  >>>
>  >>
>  >> It appears that GNU make 3.81 makes some interesting assumptions about
>  >> some corner cases (`', `.', relative paths), where it does the
>  >> following:
>  >>
>  >> 1. relative paths automatically are prefixed with $PWD.
>  >> 2. `' and '.' automatically translate to $PWD.
>  >>
>  >> This diff takes that behavior into account and adds appropriate
>  >> testcases to match the behavior:
>  >>
>  >> gcooper@optimus /scratch/ltp $ scripts/tests/test_abspath.sh
>  >> test_abspath ? ?1 ?TPASS ?: ?Test string matches expected string
>  >> _abspath() =3D> /scratch/ltp =3D=3D /scratch/ltp)
>  >> test_abspath ? ?2 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(.) =3D> /scratch/ltp =3D=3D /scratch/ltp)
>  >> test_abspath ? ?3 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(foo/bar) =3D> /scratch/ltp/foo/bar =3D=3D /scratch/ltp/foo/b=
ar)
>  >> test_abspath ? ?4 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >> test_abspath ? ?5 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
>  >> test_abspath ? ?6 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>  >> test_abspath ? ?7 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
>  >> test_abspath ? ?8 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
>  >> test_abspath ? ?9 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/../bar/..) =3D> / =3D=3D /)
>  >> test_abspath ? 10 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/../bar/../) =3D> / =3D=3D /)
>  >> test_abspath ? 11 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>  >> test_abspath ? 12 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >> test_abspath ? 13 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >> test_abspath ? 14 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >> test_abspath ? 15 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >> test_abspath ? 16 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >> test_abspath ? 17 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
>  >> test_abspath ? 18 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
>  >> test_abspath ? 19 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/.foo) =3D> /.foo =3D=3D /.foo)
>  >> test_abspath ? 20 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(./.foo) =3D> /.foo =3D=3D /.foo)
>  >> test_abspath ? 21 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>  >> test_abspath ? 22 ?TPASS ?: ?Test string matches expected string
>  >> _abspath(./.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>  >>
>  >> Unless there are some style or implementation issues with the code
>  >> here, I'd say it's ready for commit.
>  >>
>  >> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>  >>
>  >> Index: scripts/lib/file_functions.sh
>  >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  >> RCS file: scripts/lib/file_functions.sh
>  >> diff -N scripts/lib/file_functions.sh
>  >> --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  >> +++ scripts/lib/file_functions.sh ? ? ? 18 Jan 2010 01:15:32 -0000
>  >> @@ -0,0 +1,64 @@
>  >> +#!/bin/sh
>  >> +#
>  >> +# File functions utilized as part of abspath.sh, realpath.sh, etc.
>  >> +#
>  >> +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  >> +#
>  >> +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  >> +# ? ?it under the terms of the GNU General Public License as =

> published by
>  >> +# ? ?the Free Software Foundation; either version 2 of the License, =
or
>  >> +# ? ?(at your option) any later version.
>  >> +#
>  >> +# ? ?This program is distributed in the hope that it will be useful,
>  >> +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  >> +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  >> +# ? ?GNU General Public License for more details.
>  >> +#
>  >> +# ? ?You should have received a copy of the GNU General Public =

> License along
>  >> +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  >> +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  >> +#
>  >> +# Garrett Cooper, January 2010
>  >> +#
>  >> +# POSIX compliant bourne shell functions for performing make 3.81
>  >> +# compliancy in 3.80 with a minimal set of external commands
>  >> +# [awk(1) // readlink(1) only required].
>  >> +#
>  >> +
>  >> +# 1. Strip all heading and leading space.
>  >> +# 1. Replace /+ with /.
>  >> +# 2. Replace a/b/../c with a/c
>  >> +# 3. Replace /./ with /
>  >> +# 4. Replace trailing /. with /
>  >> +# 5. Replace heading ./ with /
>  >> +_abspath() {
>  >> + ? ? ? echo "$@" | awk -v PWD=3D$(pwd) '{
>  >> + ? ? ? sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, "")
>  >> + ? ? ? if ($0 =3D=3D "") {
>  >> + ? ? ? ? ? ? ? print PWD
>  >> + ? ? ? } else {
>  >> + ? ? ? ? ? ? ? while (gsub(/\/\//, "/")) { };
>  >> + ? ? ? ? ? ? ? while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { };
>  >> + ? ? ? ? ? ? ? while (gsub(/\/\.\//, "/")) { };
>  >> + ? ? ? ? ? ? ? sub(/(\/\.)?\/$/, "");
>  >> + ? ? ? ? ? ? ? sub(/^\.\//, "/") ;
>  >> + ? ? ? ? ? ? ? if ($0 =3D=3D "") {
>  >> + ? ? ? ? ? ? ? ? ? ? ? print "/"
>  >> + ? ? ? ? ? ? ? } else {
>  >> + ? ? ? ? ? ? ? ? ? ? ? if ($0 =3D=3D ".") {
>  >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? print PWD
>  >> + ? ? ? ? ? ? ? ? ? ? ? } else {
>  >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (!($0 ~ /^\//)) {
>  >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? print PWD "/" $0
>  >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? } else {
>  >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? print
>  >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? }
>  >> + ? ? ? ? ? ? ? ? ? ? ? }
>  >> + ? ? ? ? ? ? ? }
>  >> + ? ? ? }
>  >> +}'
>  >> +}
>  >> +
>  >> +_realpath() {
>  >> + ? ? ? readlink -f "$@"
>  >> +}
>  >> Index: scripts/tests/test_abspath.sh
>  >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  >> RCS file: scripts/tests/test_abspath.sh
>  >> diff -N scripts/tests/test_abspath.sh
>  >> --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  >> +++ scripts/tests/test_abspath.sh ? ? ? 18 Jan 2010 01:15:32 -0000
>  >> @@ -0,0 +1,76 @@
>  >> +#!/bin/sh
>  >> +#
>  >> +# Test the _abspath function, utilized as part of abspath.sh
>  >> +#
>  >> +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  >> +#
>  >> +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  >> +# ? ?it under the terms of the GNU General Public License as =

> published by
>  >> +# ? ?the Free Software Foundation; either version 2 of the License, =
or
>  >> +# ? ?(at your option) any later version.
>  >> +#
>  >> +# ? ?This program is distributed in the hope that it will be useful,
>  >> +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  >> +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  >> +# ? ?GNU General Public License for more details.
>  >> +#
>  >> +# ? ?You should have received a copy of the GNU General Public =

> License along
>  >> +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  >> +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  >> +#
>  >> +# Garrett Cooper, January 2010
>  >> +#
>  >> +
>  >> +set -- \
>  >> + ? ? ? :$PWD ? ? ? ? ? ? ? ? ? ? ? ? ? \
>  >> + ? ? ? .:$PWD ? ? ? ? ? ? ? ? ? ? ? ? ?\
>  >> + ? ? ? foo/bar:$PWD/foo/bar ? ? ? ? ? ?\
>  >> + ? ? ? /foo/bar:/foo/bar ? ? ? ? ? ? ? \
>  >> + ? ? ? /foo/../bar:/bar ? ? ? ? ? ? ? ?\
>  >> + ? ? ? /foo/bar/../baz:/foo/baz ? ? ? ?\
>  >> + ? ? ? /foo/bar/../baz/:/foo/baz ? ? ? \
>  >> + ? ? ? /foo/../bar/:/bar ? ? ? ? ? ? ? \
>  >> + ? ? ? /foo/../bar/..:/ ? ? ? ? ? ? ? ?\
>  >> + ? ? ? /foo/../bar/../:/ ? ? ? ? ? ? ? \
>  >> + ? ? ? /foo/bar/../baz:/foo/baz ? ? ? ?\
>  >> + ? ? ? /foo/./bar:/foo/bar ? ? ? ? ? ? \
>  >> + ? ? ? /./foo/./bar:/foo/bar ? ? ? ? ? \
>  >> + ? ? ? /foo//bar:/foo/bar ? ? ? ? ? ? ?\
>  >> + ? ? ? //foo/bar:/foo/bar ? ? ? ? ? ? ?\
>  >> + ? ? ? //////foo/bar:/foo/bar ? ? ? ? ?\
>  >> + ? ? ? /foo/////bar:/foo/bar ? ? ? ? ? \
>  >> + ? ? ? /a/b/c/.././:/a/b ? ? ? ? ? ? ? \
>  >> + ? ? ? /.foo:/.foo ? ? ? ? ? ? ? ? ? ? \
>  >> + ? ? ? ./.foo:/.foo ? ? ? ? ? ? ? ? ? ?\
>  >> + ? ? ? /.foo/.bar:/.foo/.bar ? ? ? ? ? \
>  >> + ? ? ? ./.foo/.bar:/.foo/.bar
>  >> +
>  >> +export TCID=3Dtest_abspath
>  >> +export TST_TOTAL=3D$#
>  >> +export TST_COUNT=3D1
>  >> +
>  >> +. "${0%/*}/../lib/file_functions.sh"
>  >> +
>  >> +for i in "$@"; do
>  >> +
>  >> + ? ? ? test_string=3D${i%:*}
>  >> + ? ? ? expected_string=3D${i#*:}
>  >> +
>  >> + ? ? ? result=3D$(_abspath "$test_string")
>  >> +
>  >> + ? ? ? if [ "$result" =3D "$expected_string" ]; then
>  >> + ? ? ? ? ? ? ? result_s=3D"matches expected string =

> _abspath(${test_string}) =3D>
>  >> $result =3D=3D $expected_string)"
>  >> + ? ? ? ? ? ? ? result_v=3DTPASS
>  >> + ? ? ? else
>  >> + ? ? ? ? ? ? ? result_s=3D"doesn't match expected string =

> _abspath(${test_string}) =3D>
>  >> $result !=3D $expected_string)"
>  >> + ? ? ? ? ? ? ? result_v=3DTFAIL
>  >> + ? ? ? ? ? ? ? FAILED=3D1
>  >> + ? ? ? fi
>  >> +
>  >> + ? ? ? tst_resm $result_v "Test string $result_s"
>  >> +
>  >> + ? ? ? : $(( TST_COUNT +=3D 1 ))
>  >> +
>  >> +done
>  >> +
>  >> +exit ${FAILED:=3D0}
>  >> Index: scripts/abspath.sh
>  >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  >> RCS file: scripts/abspath.sh
>  >> diff -N scripts/abspath.sh
>  >> --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  >> +++ scripts/abspath.sh ?18 Jan 2010 01:15:32 -0000
>  >> @@ -0,0 +1,29 @@
>  >> +#!/bin/sh
>  >> +#
>  >> +# ? ?make 3.81 $(abspath .. ) emulation layer
>  >> +#
>  >> +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  >> +#
>  >> +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  >> +# ? ?it under the terms of the GNU General Public License as =

> published by
>  >> +# ? ?the Free Software Foundation; either version 2 of the License, =
or
>  >> +# ? ?(at your option) any later version.
>  >> +#
>  >> +# ? ?This program is distributed in the hope that it will be useful,
>  >> +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  >> +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  >> +# ? ?GNU General Public License for more details.
>  >> +#
>  >> +# ? ?You should have received a copy of the GNU General Public =

> License along
>  >> +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  >> +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  >> +#
>  >> +# Garrett Cooper, January 2010
>  >> +#
>  >> +
>  >> +. "${0%/*}/lib/file_functions.sh"
>  >> +
>  >> +while [ $# -gt 0 ] ; do
>  >> + ? ? ? _abspath "$1"
>  >> + ? ? ? shift
>  >> +done
>  >> Index: scripts/realpath.sh
>  >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  >> RCS file: scripts/realpath.sh
>  >> diff -N scripts/realpath.sh
>  >> --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  >> +++ scripts/realpath.sh 18 Jan 2010 01:15:32 -0000
>  >> @@ -0,0 +1,29 @@
>  >> +#!/bin/sh
>  >> +#
>  >> +# ? ?make 3.81 $(realpath .. ) emulation layer
>  >> +#
>  >> +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  >> +#
>  >> +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  >> +# ? ?it under the terms of the GNU General Public License as =

> published by
>  >> +# ? ?the Free Software Foundation; either version 2 of the License, =
or
>  >> +# ? ?(at your option) any later version.
>  >> +#
>  >> +# ? ?This program is distributed in the hope that it will be useful,
>  >> +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  >> +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  >> +# ? ?GNU General Public License for more details.
>  >> +#
>  >> +# ? ?You should have received a copy of the GNU General Public =

> License along
>  >> +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  >> +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  >> +#
>  >> +# Garrett Cooper, January 2010
>  >> +#
>  >> +
>  >> +. "${0%/*}/lib/file_functions.sh"
>  >> +
>  >> +while [ $# -gt 0 ] ; do
>  >> + ? ? ? _realpath "$1"
>  >> + ? ? ? shift
>  >> +done
>  >>
>  >
>  > Of course me being conservative and curious, I discovered a coverage
>  > gap (the .sh files themselves). This fixes that behavior because the
>  > output from abspath.sh // realpath.sh had newlines in it before. make
>  > 3.81 calls to $(abspath ) // $(realpath ) don't have newlines in them
>  > and while make does a pretty good job at mashing newlines in
>  > variables, I'd rather take the conservative route and ensure that the
>  > end-behavior in the emulation scripts matches the behavior in make
>  > verbatim:
>  >
>  > gcooper@optimus /scratch/ltp $ scripts/tests/test_abspath.sh
>  > test_abspath ? ?1 ?TPASS ?: ?Test string matches expected string
>  > _abspath() =3D> /scratch/ltp =3D=3D /scratch/ltp)
>  > test_abspath ? ?2 ?TPASS ?: ?Test string matches expected string
>  > _abspath(.) =3D> /scratch/ltp =3D=3D /scratch/ltp)
>  > test_abspath ? ?3 ?TPASS ?: ?Test string matches expected string
>  > _abspath(foo/bar) =3D> /scratch/ltp/foo/bar =3D=3D /scratch/ltp/foo/ba=
r)
>  > test_abspath ? ?4 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  > test_abspath ? ?5 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
>  > test_abspath ? ?6 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>  > test_abspath ? ?7 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
>  > test_abspath ? ?8 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
>  > test_abspath ? ?9 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/../bar/..) =3D> / =3D=3D /)
>  > test_abspath ? 10 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/../bar/../) =3D> / =3D=3D /)
>  > test_abspath ? 11 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>  > test_abspath ? 12 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>  > test_abspath ? 13 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>  > test_abspath ? 14 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
>  > test_abspath ? 15 ?TPASS ?: ?Test string matches expected string
>  > _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  > test_abspath ? 16 ?TPASS ?: ?Test string matches expected string
>  > _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>  > test_abspath ? 17 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
>  > test_abspath ? 18 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
>  > test_abspath ? 19 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/.foo) =3D> /.foo =3D=3D /.foo)
>  > test_abspath ? 20 ?TPASS ?: ?Test string matches expected string
>  > _abspath(./.foo) =3D> /.foo =3D=3D /.foo)
>  > test_abspath ? 21 ?TPASS ?: ?Test string matches expected string
>  > _abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>  > test_abspath ? 22 ?TPASS ?: ?Test string matches expected string
>  > _abspath(./.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>  > test_abspath ? 23 ?TPASS ?: ?Test string matches expected string
>  > _abspath() =3D> /scratch/ltp =3D=3D /scratch/ltp)
>  > test_abspath ? 24 ?TPASS ?: ?Test string matches expected string
>  > _abspath("" .) =3D> /scratch/ltp /scratch/ltp =3D=3D /scratch/ltp
>  > /scratch/ltp)
>  >
>  > Index: scripts/lib/file_functions.sh
>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > RCS file: scripts/lib/file_functions.sh
>  > diff -N scripts/lib/file_functions.sh
>  > --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  > +++ scripts/lib/file_functions.sh ? ? ? 18 Jan 2010 01:40:35 -0000
>  > @@ -0,0 +1,64 @@
>  > +#!/bin/sh
>  > +#
>  > +# File functions utilized as part of abspath.sh, realpath.sh, etc.
>  > +#
>  > +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  > +#
>  > +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  > +# ? ?it under the terms of the GNU General Public License as =

> published by
>  > +# ? ?the Free Software Foundation; either version 2 of the License, or
>  > +# ? ?(at your option) any later version.
>  > +#
>  > +# ? ?This program is distributed in the hope that it will be useful,
>  > +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  > +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  > +# ? ?GNU General Public License for more details.
>  > +#
>  > +# ? ?You should have received a copy of the GNU General Public =

> License along
>  > +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  > +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  > +#
>  > +# Garrett Cooper, January 2010
>  > +#
>  > +# POSIX compliant bourne shell functions for performing make 3.81
>  > +# compliancy in 3.80 with a minimal set of external commands
>  > +# [awk(1) // readlink(1) only required].
>  > +#
>  > +
>  > +# 1. Strip all heading and leading space.
>  > +# 1. Replace /+ with /.
>  > +# 2. Replace a/b/../c with a/c
>  > +# 3. Replace /./ with /
>  > +# 4. Replace trailing /. with /
>  > +# 5. Replace heading ./ with /
>  > +_abspath() {
>  > + ? ? ? echo "$@" | awk -v PWD=3D$(pwd) '{
>  > + ? ? ? sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, "")
>  > + ? ? ? if ($0 =3D=3D "") {
>  > + ? ? ? ? ? ? ? print PWD
>  > + ? ? ? } else {
>  > + ? ? ? ? ? ? ? while (gsub(/\/\//, "/")) { };
>  > + ? ? ? ? ? ? ? while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { };
>  > + ? ? ? ? ? ? ? while (gsub(/\/\.\//, "/")) { };
>  > + ? ? ? ? ? ? ? sub(/(\/\.)?\/$/, "");
>  > + ? ? ? ? ? ? ? sub(/^\.\//, "/") ;
>  > + ? ? ? ? ? ? ? if ($0 =3D=3D "") {
>  > + ? ? ? ? ? ? ? ? ? ? ? print "/"
>  > + ? ? ? ? ? ? ? } else {
>  > + ? ? ? ? ? ? ? ? ? ? ? if ($0 =3D=3D ".") {
>  > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? print PWD
>  > + ? ? ? ? ? ? ? ? ? ? ? } else {
>  > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (!($0 ~ /^\//)) {
>  > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? print PWD "/" $0
>  > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? } else {
>  > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? print
>  > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? }
>  > + ? ? ? ? ? ? ? ? ? ? ? }
>  > + ? ? ? ? ? ? ? }
>  > + ? ? ? }
>  > +}'
>  > +}
>  > +
>  > +_realpath() {
>  > + ? ? ? readlink -f "$@"
>  > +}
>  > Index: scripts/tests/test_abspath.sh
>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > RCS file: scripts/tests/test_abspath.sh
>  > diff -N scripts/tests/test_abspath.sh
>  > --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  > +++ scripts/tests/test_abspath.sh ? ? ? 18 Jan 2010 01:40:35 -0000
>  > @@ -0,0 +1,110 @@
>  > +#!/bin/sh
>  > +#
>  > +# Test the _abspath function, utilized as part of abspath.sh
>  > +#
>  > +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  > +#
>  > +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  > +# ? ?it under the terms of the GNU General Public License as =

> published by
>  > +# ? ?the Free Software Foundation; either version 2 of the License, or
>  > +# ? ?(at your option) any later version.
>  > +#
>  > +# ? ?This program is distributed in the hope that it will be useful,
>  > +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  > +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  > +# ? ?GNU General Public License for more details.
>  > +#
>  > +# ? ?You should have received a copy of the GNU General Public =

> License along
>  > +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  > +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  > +#
>  > +# Garrett Cooper, January 2010
>  > +#
>  > +
>  > +set -- \
>  > + ? ? ? :$PWD ? ? ? ? ? ? ? ? ? ? ? ? ? \
>  > + ? ? ? .:$PWD ? ? ? ? ? ? ? ? ? ? ? ? ?\
>  > + ? ? ? foo/bar:$PWD/foo/bar ? ? ? ? ? ?\
>  > + ? ? ? /foo/bar:/foo/bar ? ? ? ? ? ? ? \
>  > + ? ? ? /foo/../bar:/bar ? ? ? ? ? ? ? ?\
>  > + ? ? ? /foo/bar/../baz:/foo/baz ? ? ? ?\
>  > + ? ? ? /foo/bar/../baz/:/foo/baz ? ? ? \
>  > + ? ? ? /foo/../bar/:/bar ? ? ? ? ? ? ? \
>  > + ? ? ? /foo/../bar/..:/ ? ? ? ? ? ? ? ?\
>  > + ? ? ? /foo/../bar/../:/ ? ? ? ? ? ? ? \
>  > + ? ? ? /foo/bar/../baz:/foo/baz ? ? ? ?\
>  > + ? ? ? /foo/./bar:/foo/bar ? ? ? ? ? ? \
>  > + ? ? ? /./foo/./bar:/foo/bar ? ? ? ? ? \
>  > + ? ? ? /foo//bar:/foo/bar ? ? ? ? ? ? ?\
>  > + ? ? ? //foo/bar:/foo/bar ? ? ? ? ? ? ?\
>  > + ? ? ? //////foo/bar:/foo/bar ? ? ? ? ?\
>  > + ? ? ? /foo/////bar:/foo/bar ? ? ? ? ? \
>  > + ? ? ? /a/b/c/.././:/a/b ? ? ? ? ? ? ? \
>  > + ? ? ? /.foo:/.foo ? ? ? ? ? ? ? ? ? ? \
>  > + ? ? ? ./.foo:/.foo ? ? ? ? ? ? ? ? ? ?\
>  > + ? ? ? /.foo/.bar:/.foo/.bar ? ? ? ? ? \
>  > + ? ? ? ./.foo/.bar:/.foo/.bar
>  > +
>  > +export TCID=3Dtest_abspath
>  > +export TST_TOTAL=3D$#
>  > +export TST_COUNT=3D1
>  > +
>  > +SCRIPTS_DIR=3D"${0%/*}/.."
>  > +
>  > +. "$SCRIPTS_DIR/lib/file_functions.sh"
>  > +
>  > +for i in "$@"; do
>  > +
>  > + ? ? ? test_string=3D${i%:*}
>  > + ? ? ? expected_string=3D${i#*:}
>  > +
>  > + ? ? ? result=3D$(_abspath "$test_string")
>  > +
>  > + ? ? ? if [ "$result" =3D "$expected_string" ] ; then
>  > + ? ? ? ? ? ? ? result_s=3D"matches expected string =

> _abspath(${test_string}) =3D>
>  > $result =3D=3D $expected_string)"
>  > + ? ? ? ? ? ? ? result_v=3DTPASS
>  > + ? ? ? else
>  > + ? ? ? ? ? ? ? result_s=3D"doesn't match expected string =

> _abspath(${test_string}) =3D>
>  > $result !=3D $expected_string)"
>  > + ? ? ? ? ? ? ? result_v=3DTFAIL
>  > + ? ? ? ? ? ? ? FAILED=3D1
>  > + ? ? ? fi
>  > +
>  > + ? ? ? tst_resm $result_v "Test string $result_s"
>  > +
>  > + ? ? ? : $(( TST_COUNT +=3D 1 ))
>  > +
>  > +done
>  > +
>  > +expected_string=3D"$PWD"
>  > +test_string=3D''
>  > +result=3D$("$SCRIPTS_DIR/abspath.sh" "$test_string")
>  > +
>  > +if [ "$result" =3D "$expected_string" ] ; then
>  > + ? ? ? result_s=3D"matches expected string _abspath(${test_string}) =
=3D>
>  > $result =3D=3D $expected_string)"
>  > +else
>  > + ? ? ? result_s=3D"doesn't match expected string =

> _abspath(${test_string}) =3D>
>  > $result !=3D $expected_string)"
>  > + ? ? ? result_v=3DTFAIL
>  > + ? ? ? FAILED=3D1
>  > +fi
>  > +
>  > +tst_resm $result_v "Test string $result_s"
>  > +
>  > +: $(( TST_COUNT +=3D 1 ))
>  > +
>  > +expected_string=3D"$PWD $PWD"
>  > +test_string=3D"\"\" ."
>  > +result=3D$("$SCRIPTS_DIR/abspath.sh" "" .)
>  > +
>  > +if [ "$result" =3D "$expected_string" ] ; then
>  > + ? ? ? result_s=3D"matches expected string _abspath(${test_string}) =
=3D>
>  > $result =3D=3D $expected_string)"
>  > +else
>  > + ? ? ? result_s=3D"doesn't match expected string =

> _abspath(${test_string}) =3D>
>  > $result !=3D $expected_string)"
>  > + ? ? ? result_v=3DTFAIL
>  > + ? ? ? FAILED=3D1
>  > +fi
>  > +
>  > +tst_resm $result_v "Test string $result_s"
>  > +
>  > +: $(( TST_COUNT +=3D 1 ))
>  > +
>  > +exit ${FAILED:=3D0}
>  > Index: scripts/abspath.sh
>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > RCS file: scripts/abspath.sh
>  > diff -N scripts/abspath.sh
>  > --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  > +++ scripts/abspath.sh ?18 Jan 2010 01:40:35 -0000
>  > @@ -0,0 +1,30 @@
>  > +#!/bin/sh
>  > +#
>  > +# ? ?make 3.81 $(abspath .. ) emulation layer
>  > +#
>  > +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  > +#
>  > +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  > +# ? ?it under the terms of the GNU General Public License as =

> published by
>  > +# ? ?the Free Software Foundation; either version 2 of the License, or
>  > +# ? ?(at your option) any later version.
>  > +#
>  > +# ? ?This program is distributed in the hope that it will be useful,
>  > +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  > +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  > +# ? ?GNU General Public License for more details.
>  > +#
>  > +# ? ?You should have received a copy of the GNU General Public =

> License along
>  > +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  > +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  > +#
>  > +# Garrett Cooper, January 2010
>  > +#
>  > +
>  > +. "${0%/*}/lib/file_functions.sh"
>  > +
>  > +while [ $# -gt 0 ] ; do
>  > + ? ? ? echo -n $(_abspath "$1")
>  > + ? ? ? [ $# -gt 1 ] && echo -n " "
>  > + ? ? ? shift
>  > +done
>  > Index: scripts/realpath.sh
>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > RCS file: scripts/realpath.sh
>  > diff -N scripts/realpath.sh
>  > --- /dev/null ? 1 Jan 1970 00:00:00 -0000
>  > +++ scripts/realpath.sh 18 Jan 2010 01:40:35 -0000
>  > @@ -0,0 +1,30 @@
>  > +#!/bin/sh
>  > +#
>  > +# ? ?make 3.81 $(realpath .. ) emulation layer
>  > +#
>  > +# ? ?Copyright (C) 2010, Cisco Systems Inc.
>  > +#
>  > +# ? ?This program is free software; you can redistribute it and/or =

> modify
>  > +# ? ?it under the terms of the GNU General Public License as =

> published by
>  > +# ? ?the Free Software Foundation; either version 2 of the License, or
>  > +# ? ?(at your option) any later version.
>  > +#
>  > +# ? ?This program is distributed in the hope that it will be useful,
>  > +# ? ?but WITHOUT ANY WARRANTY; without even the implied warranty of
>  > +# ? ?MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
>  > +# ? ?GNU General Public License for more details.
>  > +#
>  > +# ? ?You should have received a copy of the GNU General Public =

> License along
>  > +# ? ?with this program; if not, write to the Free Software =

> Foundation, Inc.,
>  > +# ? ?51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  > +#
>  > +# Garrett Cooper, January 2010
>  > +#
>  > +
>  > +. "${0%/*}/lib/file_functions.sh"
>  > +
>  > +while [ $# -gt 0 ] ; do
>  > + ? ? ? echo -n $(_realpath "$1")
>  > + ? ? ? [ $# -gt 1 ] && echo -n " "
>  > + ? ? ? shift
>  > +done
> =

> Summary:
> Resolve one final corner case required for make 3.80 compatibility to
> be complete (../.. -> $PWD/../..):
> 1. Add two additional testcases for the above corner case.
> 2. Fix expected output for ./.foo:/.foo and ./.foo/.bar:/.foo/.bar
> testcases; each of the expected results should have been correct from
> $PWD, as the input path was relative from $PWD.
> 2. Revise the library to use sub instead of gsub because it's being
> called from a loop already.
> 3. Reorder steps to correct for corner case. and document
> =

> I'm confident that this is 100% ok for commit now after my subsequent
> testing and careful inspection. Committing this will enable 3.80
> compilation in mainline after I uncomment the $(error ) in env_pre.mk.
> =

> gcooper@optimus /scratch/ltp $ ./scripts/tests/test_abspath.sh
> test_abspath    1  TPASS  :  Test string matches expected string
> _abspath() =3D> /scratch/ltp/scripts/lib =3D=3D /scratch/ltp/scripts/lib)
> test_abspath    2  TPASS  :  Test string matches expected string
> _abspath(.) =3D> /scratch/ltp/scripts/lib =3D=3D /scratch/ltp/scripts/lib)
> test_abspath    3  TPASS  :  Test string matches expected string
> _abspath(foo/bar) =3D> /scratch/ltp/scripts/lib/foo/bar =3D=3D
> /scratch/ltp/scripts/lib/foo/bar)
> test_abspath    4  TPASS  :  Test string matches expected string
> _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath    5  TPASS  :  Test string matches expected string
> _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
> test_abspath    6  TPASS  :  Test string matches expected string
> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath    7  TPASS  :  Test string matches expected string
> _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath    8  TPASS  :  Test string matches expected string
> _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
> test_abspath    9  TPASS  :  Test string matches expected string
> _abspath(/foo/../bar/..) =3D> / =3D=3D /)
> test_abspath   10  TPASS  :  Test string matches expected string
> _abspath(/foo/../bar/../) =3D> / =3D=3D /)
> test_abspath   11  TPASS  :  Test string matches expected string
> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath   12  TPASS  :  Test string matches expected string
> _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   13  TPASS  :  Test string matches expected string
> _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   14  TPASS  :  Test string matches expected string
> _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   15  TPASS  :  Test string matches expected string
> _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   16  TPASS  :  Test string matches expected string
> _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   17  TPASS  :  Test string matches expected string
> _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   18  TPASS  :  Test string matches expected string
> _abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
> test_abspath   19  TPASS  :  Test string matches expected string
> _abspath(/.foo) =3D> /.foo =3D=3D /.foo)
> test_abspath   20  TPASS  :  Test string matches expected string
> _abspath(./.foo) =3D> /scratch/ltp/scripts/lib/.foo =3D=3D
> /scratch/ltp/scripts/lib/.foo)
> test_abspath   21  TPASS  :  Test string matches expected string
> _abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
> test_abspath   22  TPASS  :  Test string matches expected string
> _abspath(./.foo/.bar) =3D> /scratch/ltp/scripts/lib/.foo/.bar =3D=3D
> /scratch/ltp/scripts/lib/.foo/.bar)
> test_abspath   23  TPASS  :  Test string matches expected string
> _abspath(/scratch/ltp/testcases/realtime/../..) =3D> /scratch/ltp =3D=3D
> /scratch/ltp)
> test_abspath   24  TPASS  :  Test string matches expected string
> _abspath(..) =3D> /scratch/ltp/scripts =3D=3D /scratch/ltp/scripts)
> test_abspath   25  TPASS  :  Test string matches expected string
> _abspath(../..) =3D> /scratch/ltp =3D=3D /scratch/ltp)
> test_abspath   26  TPASS  :  Test string matches expected string
> _abspath(testcases/kernel/controllers/libcontrollers/../../../..) =3D>
> /scratch/ltp/scripts/lib =3D=3D /scratch/ltp/scripts/lib)
> test_abspath   27  TPASS  :  Test string matches expected string
> abspath.sh "" =3D> /scratch/ltp =3D=3D /scratch/ltp)
> test_abspath   28  TPASS  :  Test string matches expected string
> abspath.sh "" . =3D> /scratch/ltp /scratch/ltp =3D=3D /scratch/ltp
> /scratch/ltp)
> =

> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> =

> Index: scripts/abspath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: scripts/abspath.sh
> diff -N scripts/abspath.sh
> --- /dev/null                 1 Jan 1970 00:00:00 -0000
> +++ scripts/abspath.sh                 18 Jan 2010 11:13:32 -0000
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +#
> +#    make 3.81 $(abspath .. ) emulation layer
> +#
> +#    Copyright (C) 2010, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License =

> along
> +#    with this program; if not, write to the Free Software Foundation, =

> Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +. "${0%/*}/lib/file_functions.sh"
> +
> +while [ $# -gt 0 ] ; do
> +                 echo -n $(_abspath "$1")
> +                 [ $# -gt 1 ] && echo -n " "
> +                 shift
> +done
> Index: scripts/realpath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: scripts/realpath.sh
> diff -N scripts/realpath.sh
> --- /dev/null                 1 Jan 1970 00:00:00 -0000
> +++ scripts/realpath.sh                 18 Jan 2010 11:13:32 -0000
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +#
> +#    make 3.81 $(realpath .. ) emulation layer
> +#
> +#    Copyright (C) 2010, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License =

> along
> +#    with this program; if not, write to the Free Software Foundation, =

> Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +. "${0%/*}/lib/file_functions.sh"
> +
> +while [ $# -gt 0 ] ; do
> +                 echo -n $(_realpath "$1")
> +                 [ $# -gt 1 ] && echo -n " "
> +                 shift
> +done
> Index: scripts/lib/file_functions.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: scripts/lib/file_functions.sh
> diff -N scripts/lib/file_functions.sh
> --- /dev/null                 1 Jan 1970 00:00:00 -0000
> +++ scripts/lib/file_functions.sh                 18 Jan 2010 11:13:32 -0=
000
> @@ -0,0 +1,71 @@
> +#!/bin/sh
> +#
> +# File functions utilized as part of abspath.sh, realpath.sh, etc.
> +#
> +#    Copyright (C) 2010, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License =

> along
> +#    with this program; if not, write to the Free Software Foundation, =

> Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +# POSIX compliant bourne shell functions for performing make 3.81
> +# compliancy in 3.80 with a minimal set of external commands
> +# [awk(1) // readlink(1) only required].
> +#
> +
> +# 0. Strip all heading and leading space.
> +# Paths:
> +# 1. Empty string - print out $PWD.
> +# 2. Not empty string...
> +#    i. Prefix all relative paths with $PWD.
> +#    ii. Replace /+ with /.
> +#    iii. Replace a/b/../c with a/c
> +#    iv. Replace /./ with /
> +#    v. Replace trailing /. with /
> +#    vi. Replace heading ./ with /
> +#    vii. Replace /. with "".
> +
> +# testcases/kernel/controllers/libcontrollers/../../../..
> +_abspath() {
> +                 echo "$@" | awk -v PWD=3D$(pwd) '{
> +                 sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, ""); # 1.
> +                 if ($0 =3D=3D "") {
> +                                  print PWD
> +                 } else {
> +                                  if (!($0 ~ /^\//)) { # i.
> +                                                   $0 =3D PWD "/" $0
> +                                  }
> +                                  while (gsub(/\/\//, "/")) { }; # ii.
> +                                  while (sub(/\/[^\/]+\/\.\.\/?/, "/")) =

> { }; # iii.
> +                                  while (sub(/\/\.\//, "/")) { }; # iv.
> +                                  sub(/(\/\.)?\/$/, "");
> +                                  sub(/^\.\//, "/");
> +                                  sub(/\/\.$/, "");
> +                                  if ($0 =3D=3D "") {
> +                                                   print "/"
> +                                  } else {
> +                                                   if ($0 =3D=3D ".") {
> +                                                                   =

>  print PWD
> +                                                   } else {
> +                                                                    print
> +                                                   }
> +                                  }
> +                 }
> +}'
> +}
> +
> +_realpath() {
> +                 readlink -f "$@"
> +}
> Index: scripts/tests/test_abspath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: scripts/tests/test_abspath.sh
> diff -N scripts/tests/test_abspath.sh
> --- /dev/null                 1 Jan 1970 00:00:00 -0000
> +++ scripts/tests/test_abspath.sh                 18 Jan 2010 11:13:32 -0=
000
> @@ -0,0 +1,121 @@
> +#!/bin/sh
> +#
> +# Test the _abspath function, utilized as part of abspath.sh
> +#
> +#    Copyright (C) 2010, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License =

> along
> +#    with this program; if not, write to the Free Software Foundation, =

> Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +SCRIPTS_DIR=3D"$(readlink -f ${0%/*}/..)"
> +TEST_PATH=3D$("$SCRIPTS_DIR/realpath.sh" "$SCRIPTS_DIR/lib")
> +
> +pushd "$TEST_PATH" >/dev/null
> +
> +set --                 \
> +                 :$PWD                                                 =

>                                                                         =

>                \
> +                 .:$PWD                                                 =

>                                                                         =

>                \
> +                 foo/bar:$PWD/foo/bar                                   =

>                                                                    \
> +                 /foo/bar:/foo/bar                                     =

>                                                                  \
> +                 /foo/../bar:/bar                                       =

>                                                                 \
> +                 /foo/bar/../baz:/foo/baz                               =

>                                                        \
> +                 /foo/bar/../baz/:/foo/baz                             =

>                                                          \
> +                 /foo/../bar/:/bar                                     =

>                                                                   \
> +                 /foo/../bar/..:/                                       =

>                                                                 \
> +                 /foo/../bar/../:/                                     =

>                                                                   \
> +                 /foo/bar/../baz:/foo/baz                               =

>                                                        \
> +                 /foo/./bar:/foo/bar                                   =

>                                                                     \
> +                 /./foo/./bar:/foo/bar                                 =

>                                                                      \
> +                 /foo//bar:/foo/bar                                     =

>                                                                  \
> +                 //foo/bar:/foo/bar                                     =

>                                                                  \
> +                 //////foo/bar:/foo/bar                                 =

>                                                                      \
> +                 /foo/////bar:/foo/bar                                 =

>                                                                      \
> +                 /a/b/c/.././:/a/b                                     =

>                                                                  \
> +                 /.foo:/.foo                                           =

>                                                                         =

>     \
> +                 ./.foo:$PWD/.foo                                       =

>                                                                \
> +                 /.foo/.bar:/.foo/.bar                                 =

>                                                                      \
> +                 ./.foo/.bar:$PWD/.foo/.bar                             =

>                                                         \
> +                 /scratch/ltp/testcases/realtime/../..:/scratch/ltp     =

>                              \
> +                 ..:$(dirname "$TEST_PATH")                             =

>                                                         \
> +                 ../..:$(dirname "$(dirname "$TEST_PATH")")             =

>                                       \
> +                 =

> testcases/kernel/controllers/libcontrollers/../../../..:$PWD
> +
> +export TCID=3Dtest_abspath
> +export TST_TOTAL=3D$#
> +export TST_COUNT=3D1
> +
> +. "$SCRIPTS_DIR/lib/file_functions.sh"
> +
> +for i in "$@"; do
> +
> +                 test_string=3D${i%:*}
> +                 expected_string=3D${i#*:}
> +
> +                 result=3D$(_abspath "$test_string")
> +
> +                 if [ "$result" =3D "$expected_string" ] ; then
> +                                  result_s=3D"matches expected string =

> _abspath(${test_string}) =3D>
> $result =3D=3D $expected_string)"
> +                                  result_v=3DTPASS
> +                 else
> +                                  result_s=3D"doesn't match expected =

> string _abspath(${test_string}) =3D>
> $result !=3D $expected_string)"
> +                                  result_v=3DTFAIL
> +                                  FAILED=3D1
> +                 fi
> +
> +                 tst_resm $result_v "Test string $result_s"
> +
> +                 : $(( TST_COUNT +=3D 1 ))
> +
> +done
> +
> +popd >/dev/null
> +
> +expected_string=3D"$PWD"
> +test_string=3D'""'
> +result=3D$("$SCRIPTS_DIR/abspath.sh" "")
> +
> +if [ "$result" =3D "$expected_string" ] ; then
> +                 result_s=3D"matches expected string abspath.sh =

> ${test_string} =3D>
> $result =3D=3D $expected_string)"
> +                 result_v=3DTPASS
> +else
> +                 result_s=3D"doesn't match expected string abspath.sh =

> ${test_string} =3D>
> $result !=3D $expected_string)"
> +                 result_v=3DTFAIL
> +                 FAILED=3D1
> +fi
> +
> +tst_resm $result_v "Test string $result_s"
> +
> +: $(( TST_COUNT +=3D 1 ))
> +
> +expected_string=3D"$PWD $PWD"
> +test_string=3D"\"\" ."
> +result=3D$("$SCRIPTS_DIR/abspath.sh" "" .)
> +
> +if [ "$result" =3D "$expected_string" ] ; then
> +                 result_s=3D"matches expected string abspath.sh =

> ${test_string} =3D>
> $result =3D=3D $expected_string)"
> +                 result_v=3DTPASS
> +else
> +                 result_s=3D"doesn't match expected string abspath.sh =

> ${test_string} =3D>
> $result !=3D $expected_string)"
> +                 result_v=3DTFAIL
> +                 FAILED=3D1
> +fi
> +
> +tst_resm $result_v "Test string $result_s"
> +
> +: $(( TST_COUNT +=3D 1 ))
> +
> +exit ${FAILED:=3D0}
> =

> =

> =

> ------------------------------
> =

> -------------------------------------------------------------------------=
-----
> Throughout its 18-year history, RSA Conference consistently attracts the
> world's best and brightest in the field, creating opportunities for =

> Conference
> attendees to learn about information security's most important issues =

> through
> interactions with peers, luminaries and emerging and established companie=
s.
> http://p.sf.net/sfu/rsaconf-dev2dev
> =

> ------------------------------
> =

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> =

> =

> End of Ltp-list Digest, Vol 44, Issue 44
> ****************************************
> =

> =

> =3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain =

> confidential or privileged information. If you are =

> not the intended recipient, any dissemination, use, =

> review, distribution, printing or copying of the =

> information contained in this e-mail message =

> and/or attachments to it are strictly prohibited. If =

> you have received this communication in error, =

> please notify us by reply e-mail or telephone and =

> immediately and permanently delete the message =

> and any attachments. Thank you
> =

> =

> =


---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
