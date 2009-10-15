Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MyT4a-0006RJ-OJ
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 16:21:04 +0000
Date: Thu, 15 Oct 2009 18:20:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091015162044.GA4152@schrodinger.suse.cz>
References: <mailman.29696.1255455058.5878.ltp-list@lists.sourceforge.net>
	<OF09CD3626.9C4C3745-ON8525764F.00076525-8525764F.000CA5FF@us.ibm.com>
	<364299f40910132042o1ec2bd0eyf4eff3bb1b28756b@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40910132042o1ec2bd0eyf4eff3bb1b28756b@mail.gmail.com>
Subject: Re: [LTP] compile fails for libcpuset.c on SLES-11 s390x
	with	ltp-full-20090930
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mark Ver <markver@us.ibm.com>

Hi!
> > make[5]: Entering directory
> > `/root/ltp-full-20090930/testcases/kernel/controllers/cpuset/cpuset_lib'
> > gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o cpuinfo.o cpuinfo.c
> > gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o libbitmask.o
> > libbitmask.c
> > gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o libcpuset.o
> > libcpuset.c
> > libcpuset.c: In function ?get_mempolicy?:
> > libcpuset.c:3092: error: ?__NR_get_mempolicy? undeclared (first use in this
> > function)
> > libcpuset.c:3092: error: (Each undeclared identifier is reported only once
> > libcpuset.c:3092: error: for each function it appears in.)
> > libcpuset.c: In function ?set_mempolicy?:
> > libcpuset.c:3097: error: ?__NR_set_mempolicy? undeclared (first use in this
> > function)
> > make[5]: *** [libcpuset.o] Error 1
> > make[5]: Leaving directory
> > `/root/ltp-full-20090930/testcases/kernel/controllers/cpuset/cpuset_lib'
> > make[4]: *** [all] Error 2
> > make[4]: Leaving directory
> > `/root/ltp-full-20090930/testcases/kernel/controllers/cpuset'
> > make[3]: *** [all] Error 2
> > make[3]: Leaving directory
> > `/root/ltp-full-20090930/testcases/kernel/controllers'
> > make[2]: *** [all] Error 2
> > make[2]: Leaving directory `/root/ltp-full-20090930/testcases/kernel'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory `/root/ltp-full-20090930/testcases'
> > make: *** [all] Error 2
> >
> > As far as I can tell the architecture does not support get_mempolicy and
> > set_mem_policy.
> >
> > Here are the configure logs and stuff from the build attempt:
> > (See attached file: ltp-full-20090930-s390x-builderr.tar.gz)
> 
> The constant is defined for the platform, but not with the correct name:
> 
> /usr/src/linux/arch/s390/kernel/syscalls.S:NI_SYSCALL
>                                  /* 269 sys_get_mempolicy */
> /usr/src/linux/arch/s390/include/asm/unistd.h:/* Number 269 is
> reserved for new sys_get_mempolicy */
> /usr/src/linux/arch/s390/include/asm/unistd.h:#define __IGNORE_get_mempolicy
> 
> This needs to be added to testcases/kernel/include/generate.sh for
> linux_syscall_numbers.h, or an arch specific #ifdef should be added
> for that test / to an autoconf test that would automatically determine
> whether or not your platform had a usable get_mempolicy syscall.
> 
> Hope that helps describe what needs to take place next...

This is even simplier. Just look into testcases/kernel/include/ directory and
add "get_mempolicy xxx" and "set_mempolicy yyy" into corresponding file (for
you it's s390.in). The build porcess should generate file
linux_syscall_numbers.h for you. Anyway I'm preparing patch fixing this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
