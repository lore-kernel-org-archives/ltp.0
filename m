Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxurR-0005Az-Pr
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 03:49:13 +0000
Received: from mail-px0-f180.google.com ([209.85.216.180])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxurD-00045P-Hm
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 03:49:05 +0000
Received: by pxi10 with SMTP id 10so994pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 20:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF09CD3626.9C4C3745-ON8525764F.00076525-8525764F.000CA5FF@us.ibm.com>
References: <mailman.29696.1255455058.5878.ltp-list@lists.sourceforge.net>
	<OF09CD3626.9C4C3745-ON8525764F.00076525-8525764F.000CA5FF@us.ibm.com>
Date: Tue, 13 Oct 2009 20:42:55 -0700
Message-ID: <364299f40910132042o1ec2bd0eyf4eff3bb1b28756b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] compile fails for libcpuset.c on SLES-11 s390x with
	ltp-full-20090930
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
To: Mark Ver <markver@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Oct 13, 2009 at 7:18 PM, Mark Ver <markver@us.ibm.com> wrote:
> Trying to build ltp-full-20090930 on SLES-11. The "make all" gets the
> following:
>
> ...
> make[5]: Entering directory
> `/root/ltp-full-20090930/testcases/kernel/controllers/cpuset/cpuset_lib'
> gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o cpuinfo.o cpuinfo=
.c
> gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o libbitmask.o
> libbitmask.c
> gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o libcpuset.o
> libcpuset.c
> libcpuset.c: In function =91get_mempolicy=92:
> libcpuset.c:3092: error: =91__NR_get_mempolicy=92 undeclared (first use i=
n this
> function)
> libcpuset.c:3092: error: (Each undeclared identifier is reported only once
> libcpuset.c:3092: error: for each function it appears in.)
> libcpuset.c: In function =91set_mempolicy=92:
> libcpuset.c:3097: error: =91__NR_set_mempolicy=92 undeclared (first use i=
n this
> function)
> make[5]: *** [libcpuset.o] Error 1
> make[5]: Leaving directory
> `/root/ltp-full-20090930/testcases/kernel/controllers/cpuset/cpuset_lib'
> make[4]: *** [all] Error 2
> make[4]: Leaving directory
> `/root/ltp-full-20090930/testcases/kernel/controllers/cpuset'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/root/ltp-full-20090930/testcases/kernel/controllers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp-full-20090930/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp-full-20090930/testcases'
> make: *** [all] Error 2
>
> As far as I can tell the architecture does not support get_mempolicy and
> set_mem_policy.
>
> Here are the configure logs and stuff from the build attempt:
> (See attached file: ltp-full-20090930-s390x-builderr.tar.gz)

The constant is defined for the platform, but not with the correct name:

/usr/src/linux/arch/s390/kernel/syscalls.S:NI_SYSCALL
                                 /* 269 sys_get_mempolicy */
/usr/src/linux/arch/s390/include/asm/unistd.h:/* Number 269 is
reserved for new sys_get_mempolicy */
/usr/src/linux/arch/s390/include/asm/unistd.h:#define __IGNORE_get_mempolicy

This needs to be added to testcases/kernel/include/generate.sh for
linux_syscall_numbers.h, or an arch specific #ifdef should be added
for that test / to an autoconf test that would automatically determine
whether or not your platform had a usable get_mempolicy syscall.

Hope that helps describe what needs to take place next...
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
