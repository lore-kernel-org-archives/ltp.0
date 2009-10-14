Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1My2T6-0003mW-3Y
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 11:56:36 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1My2Sy-0007Yl-VM
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 11:56:36 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9EBmlLJ013952
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 07:48:47 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9EBuNE6252346
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 07:56:23 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9EBquI1020323
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 07:52:56 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Wed, 14 Oct 2009 17:26:18 +0530
Message-Id: <20091014115618.7801.69877.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Re: compile fails for libcpuset.c on SLES-11 s390x
	with ltp-full-20090930
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7655599578203598415=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mark Ver <markver@us.ibm.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>, Sachin P Sant <sachinp@in.ibm.com>

--===============7655599578203598415==

Hi Mark,

>On Tue, 2009-10-13 at 20:42 -0700, Garrett Cooper wrote:
>On Tue, Oct 13, 2009 at 7:18 PM, Mark Ver <markver@us.ibm.com> wrote:
> > Trying to build ltp-full-20090930 on SLES-11. The "make all" gets the
> > following:
> >
> > ...
> > make[5]: Entering directory
> > `/root/ltp-full-20090930/testcases/kernel/controllers/cpuset/cpuset_lib'
> > gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o cpuinfo.o cpuinfo.c
> > gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o libbitmask.o
> > libbitmask.c
> > gcc -g -O2 -Wall -g -Wextra -I../../../../include -c -o libcpuset.o
> > libcpuset.c
> > libcpuset.c: In function ���get_mempolicy���:
> > libcpuset.c:3092: error: ���__NR_get_mempolicy��� undeclared (first use in this
> > function)
> > libcpuset.c:3092: error: (Each undeclared identifier is reported only once
> > libcpuset.c:3092: error: for each function it appears in.)
> > libcpuset.c: In function ���set_mempolicy���:
> > libcpuset.c:3097: error: ���__NR_set_mempolicy��� undeclared (first use in this
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

As Garret proposed, can you please apply the following Patch and see if it
solves your build problem. I get the following instructions from 2.6.31
kernel sources:

linux-2.6.31/arch/s390/include/asm/unistd.h:
208 #define __NR_remap_file_pages   267
209 /* Number 268 is reserved for new sys_mbind */
210 /* Number 269 is reserved for new sys_get_mempolicy */
211 /* Number 270 is reserved for new sys_set_mempolicy */
212 #define __NR_mq_open            271

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>,
---

--- ltp-intermediate-20091013/testcases/kernel/include/s390x.in.orig	2009-10-14 17:14:39.000000000 +0530
+++ ltp-intermediate-20091013/testcases/kernel/include/s390x.in	2009-10-14 17:15:26.000000000 +0530
@@ -14,3 +14,6 @@ fchmodat (__NR_openat + 11)
 faccessat (__NR_openat + 12)
 eventfd 318
 fallocate 314
+get_mempolicy 269
+set_mempolicy 270
+

---
Regards--
Subrata

-Garrett
> 
> 


--===============7655599578203598415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============7655599578203598415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7655599578203598415==--
