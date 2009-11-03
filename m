Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N5J5f-00027G-54
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 13:06:27 +0000
Received: from mail-pz0-f191.google.com ([209.85.222.191])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5J5X-0000Jh-9X
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 13:06:27 +0000
MIME-Version: 1.0
In-Reply-To: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
References: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
Date: Tue, 3 Nov 2009 05:06:12 -0800
Message-ID: <364299f40911030506y4411e17g3d644d90e9bdfe32@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Build Fails on some archs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, Nov 2, 2009 at 5:33 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Garret,
>
> There are some build failures of LTP on some archs. Probably, autoconf
> files needs to be written for them:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> # uname -a
> Linux 2.6.27.19-5-default #1 SMP 2009-02-28 04:40:21 +0100 s390x s390x
> s390x GNU/Linux
> # cat /etc/issue
> Welcome to SUSE Linux Enterprise Server 11 (s390x) - Kernel \r (\l).
>
> and
>
> # uname -a
> Linux 2.6.18-164.el5 #1 SMP Tue Aug 18 15:53:50 EDT 2009 s390x s390x
> s390x GNU/Linux
> # cat /etc/issue
> Red Hat Enterprise Linux Server release 5.4 (Tikanga)
> Kernel \r on an \m
>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> -I../../../../include -I../../../../include =A0 -L../../../../lib
> ptrace04.c =A0 -lltp -o ptrace04
> ptrace03.c: In function 'main':
> ptrace03.c:182: warning: format '%d' expects type 'int', but argument 3
> has type 'long int'
> ptrace04.c: In function 'compare_registers':
> ptrace04.c:50: error: storage size of 'pt_regs' isn't known
> ptrace04.c:50: warning: unused variable 'pt_regs'
> make[4]: *** [ptrace04] Error 1

Like Mike said some ptrace(2) hackery needs to occur in m4 to make the
ptrace(2) stuff work...

> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> -I../../../../../include -I../../../../../include
> -L/root/subrata/ltp/ltp-full-20091031/testcases/kernel/controllers/cpuset=
/cpuset_syscall_test/../cpuset_lib -L../../../../../lib =A0cpuset_syscall_t=
est.c =A0 -lltp -lcpu_set -o cpuset_syscall_test
> cpuset_syscall_test.c: In function 'get_mempolicy':
> cpuset_syscall_test.c:67: error: '__NR_get_mempolicy' undeclared (first
> use in this function)
> cpuset_syscall_test.c:67: error: (Each undeclared identifier is reported
> only once
> cpuset_syscall_test.c:67: error: for each function it appears in.)
> cpuset_syscall_test.c: In function 'mbind':
> cpuset_syscall_test.c:73: error: '__NR_mbind' undeclared (first use in
> this function)
> cpuset_syscall_test.c: In function 'set_mempolicy':
> cpuset_syscall_test.c:78: error: '__NR_set_mempolicy' undeclared (first
> use in this function)
> cpuset_syscall_test.c: In function 'process_options':
> cpuset_syscall_test.c:100: warning: unused variable 'file'
> cpuset_syscall_test.c: In function 'test_mbind':
> cpuset_syscall_test.c:177: warning: format '%lx' expects type 'long
> unsigned int', but argument 2 has type 'void *'
> make[5]: *** [cpuset_syscall_test] Error 1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> # uname -a
> Linux 2.6.18-164.el5 #1 SMP Tue Aug 18 15:58:09 EDT 2009 ppc64 ppc64
> ppc64 GNU/Linux
> # cat /etc/issue
> Red Hat Enterprise Linux Server release 5.4 (Tikanga)
> Kernel \r on an \m

Memory served me correctly ppc64 didn't support numa-related syscalls
like numa, set_mempolicy, etc. If that's not the case then the
syscalls need to be added to ppc64.in...

> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> -I../../../../include -I../../../../include =A0 -L../../../../lib
> ptrace04.c =A0 -lltp -o ptrace04
> ptrace03.c: In function =91main=92:
> ptrace03.c:182: warning: format =91%d=92 expects type =91int=92, but argu=
ment 3
> has type =91long int=92
> ptrace04.c: In function =91compare_registers=92:
> ptrace04.c:57: error: =91PTRACE_GETREGS=92 undeclared (first use in this
> function)
> ptrace04.c:57: error: (Each undeclared identifier is reported only once
> ptrace04.c:57: error: for each function it appears in.)
> make[4]: *** [ptrace04] Error 1
> make[4]: *** Waiting for unfinished jobs....
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/controllers/cgroup=
/../libcontrollers -I../../../../include -I../../../../include =A0 -L/root/=
subrata/ltp/ltp-full-20091031/testcases/kernel/controllers/cgroup/../libcon=
trollers -L../../../../lib =A0getdelays.c =A0 -lltp -lcontrollers -o getdel=
ays
> make[5]: Entering directory `/root/subrata/ltp/ltp-full-20091031/lib'
> make[5]: Nothing to be done for `all'.
> make[5]: Leaving directory `/root/subrata/ltp/ltp-full-20091031/lib'
> getdelays.c: In function 'send_cmd':
> getdelays.c:147: error: dereferencing pointer to incomplete type
> getdelays.c:148: error: dereferencing pointer to incomplete type
> getdelays.c:148: error: 'NLA_HDRLEN' undeclared (first use in this
> function)
> getdelays.c:148: error: (Each undeclared identifier is reported only
> once
> getdelays.c:148: error: for each function it appears in.)
> getdelays.c:150: error: dereferencing pointer to incomplete type
> getdelays.c: In function 'get_family_id':
> getdelays.c:194: warning: implicit declaration of function 'NLA_ALIGN'
> getdelays.c:194: error: dereferencing pointer to incomplete type
> getdelays.c:195: error: dereferencing pointer to incomplete type
> getdelays.c:196: error: 'NLA_HDRLEN' undeclared (first use in this
> function)
> getdelays.c: In function 'main':
> getdelays.c:452: error: dereferencing pointer to incomplete type
> getdelays.c:453: error: dereferencing pointer to incomplete type
> getdelays.c:457: error: dereferencing pointer to incomplete type
> getdelays.c:457: error: 'NLA_HDRLEN' undeclared (first use in this
> function)
> getdelays.c:463: error: dereferencing pointer to incomplete type
> getdelays.c:483: error: dereferencing pointer to incomplete type
> getdelays.c:493: error: dereferencing pointer to incomplete type
> getdelays.c:496: error: dereferencing pointer to incomplete type
> getdelays.c:507: error: dereferencing pointer to incomplete type
> make[4]: *** [getdelays] Error 1

Again with the ptrace hackery.

> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I../../../../include -I../../../../include =A0 -L../../../../lib
> tomoyo_file_test.c =A0 -o tomoyo_file_test
> /tmp/ccvzdsNd.o: In function `main':
> /root/subrata/ltp/ltp-full-20091031/testcases/kernel/security/tomoyo/newn=
s.c:43: undefined reference to `clone'
> collect2: ld returned 1 exit status
> make[4]: *** [newns] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[4]: Leaving directory
> `/root/subrata/ltp/ltp-full-20091031/testcases/kernel/security/tomoyo'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/root/subrata/ltp/ltp-full-20091031/testcases/kernel/security'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory
> `/root/subrata/ltp/ltp-full-20091031/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory
> `/root/subrata/ltp/ltp-full-20091031/testcases'
> make: *** [testcases-all] Error 2
>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I../../../../include -I../../../../include =A0 -L../../../../lib =A0newn=
s.c
> -o newns
> /tmp/ccC18mKb.o: In function `main':
> /root/subrata/ltp/ltp-full-20091031/testcases/kernel/security/tomoyo/newn=
s.c:43: undefined reference to `clone'
> collect2: ld returned 1 exit status
> make[4]: *** [newns] Error 1
> make[4]: Leaving directory
> `/root/subrata/ltp/ltp-full-20091031/testcases/kernel/security/tomoyo'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/root/subrata/ltp/ltp-full-20091031/testcases/kernel/security'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory
> `/root/subrata/ltp/ltp-full-20091031/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory
> `/root/subrata/ltp/ltp-full-20091031/testcases'
> make: *** [testcases-all] Error 2

I'll defer to Mike's recommendation on this item :)...

> ptrace03.c: In function 'main':
> ptrace03.c:182: warning: format '%d' expects type 'int', but argument 3
> has type 'long int'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> -I../../../../include -I../../../../include =A0 -L../../../../lib
> ptrace04.c =A0 -lltp -o ptrace04
> In file included from /usr/include/asm/ptrace.h:58,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from ptrace04.c:17:
> /usr/include/asm/fpu.h:57: error: redefinition of 'struct ia64_fpreg'
> In file included from ptrace04.c:17:
> /usr/include/asm/ptrace.h:306: error: redefinition of 'struct
> pt_all_user_regs'
> make[4]: *** [ptrace04] Error 1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have no clue what's going on here, but it looks like the system
headers are fubared on this machine, and/or the way things are being
done for ptrace04.c.

A lot of issues (I feel) are the fact that we're including the wrong
headers for basic functionality, and thus we're running into space
that we shouldn't be with kernel defines and what-not... I know that
it's not smart to use linux/...*.h at least.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
