Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NpJTm-0005z3-Gv
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 10:49:30 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpJTl-0002fP-E9
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 10:49:30 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2AAjCHm015668
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 03:45:12 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2AAnNTQ109320
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 03:49:23 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2AAnNti012060
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 03:49:23 -0700
Date: Wed, 10 Mar 2010 16:19:19 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100310104919.GA11404@linux.vnet.ibm.com>
References: <000a01cac032$c4126c80$4c374580$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000a01cac032$c4126c80$4c374580$@co.jp>
Subject: Re: [LTP] "check_for_unshare.c" build failed
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

Hi Mitani,

I am able to compile with changing LDLIBS as done by commit
: 1a5506c97dcfda0bd16f83ca855bb633c47eea4c

on RHEL5.4 .

Can you try configuring once again ?

Let me know when you face again some prob.

-Rishi

On Wed, Mar 10, 2010 at 06:19:20PM +0900, Mitani wrote:
> Hi,
> 
> 
> I tried to build LTP modules from following git:
> 
>    "Fix make filed,, reported by Shi Weihua <shiwh@cn.fujitsu.com>"
>    (ltp-dev-c962f51674b971496e14ac4be0cc75da98b75fca.tar.gz)
> 
> But I failed to build "check_for_unshare.c" in RHEL5.4 system 
> (2.6.18-164.el5).
> 
> ------------
> <...>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../include
> -I../../../include   -L../../../lib  check_for_unshare.c   -o
> check_for_unshare
> /tmp/ccWzyOQO.o: In function `main':
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
> are.c:40: undefined reference to `dlopen'
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
> are.c:46: undefined reference to `dlerror'
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
> are.c:47: undefined reference to `dlsym'
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
> are.c:48: undefined reference to `dlerror'
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
> are.c:53: undefined reference to `dlclose'
> /home/mitani/LTP/ltp-dev-20100310/testcases/kernel/containers/check_for_unsh
> are.c:42: undefined reference to `dlerror'
> collect2: ld returned 1 exit status
> make[3]: *** [check_for_unshare] Error 1
> <...>
> ------------
> 
> 
> I think that "-ldl" is needed in options.
> I tried to build using "-ldl" option and succeeded.
> 
> ------------
> [root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# gcc -g -O2 -g -O2 -ldl
> -fno-strict-aliasi
> ng -pipe -Wall  -I../../../include -I../../../include   -L../../../lib
> check_for_unshare.
> c   -o check_for_unshare
> [root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# echo $?
> 0
> [root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]# ll
> total 60
> -rw-rw-r-- 1 root root  1396 Mar 10 01:23 Makefile
> -rw-rw-r-- 1 root root  1386 Mar 10 01:23 Makefile.inc
> -rw-rw-r-- 1 root root  3286 Mar 10 01:23 README
> -rw-rw-r-- 1 root root  1451 Mar 10 01:23 TEST_PLAN.txt
> -rwxr-xr-x 1 root root 10805 Mar 10 15:18 check_for_unshare
> -rw-rw-r-- 1 root root  1634 Mar 10 01:23 check_for_unshare.c
> -rwxrwxr-x 1 root root  1712 Mar 10 01:23 container_test.sh
> drwxrwxr-x 2 root root  4096 Mar 10 10:42 libclone
> drwxrwxr-x 2 root root  4096 Mar 10 01:23 mqns
> drwxrwxr-x 2 root root  4096 Mar 10 01:23 netns
> drwxrwxr-x 2 root root  4096 Mar 10 01:23 pidns
> drwxrwxr-x 2 root root  4096 Mar 10 01:23 sysvipc
> drwxrwxr-x 2 root root  4096 Mar 10 01:23 utsname
> [root@RHEL54-INTEL64-GUIDE-APDB2-AP containers]#
> ------------
> 
> 
> How about changing Makefile as follows?
> 
> ============
> --- ./testcases/kernel/containers/Makefile      2010-03-10
> 01:23:25.000000000 +0900
> +++ ./testcases/kernel/containers/Makefile.new  2010-03-10
> 15:27:20.000000000 +0900
> @@ -28,6 +28,8 @@
> 
>  LIB                    := -ld
> 
> +CFLAGS                  += -ldl
> +
>  INSTALL_TARGETS                := *.sh
> 
>  $(LIBDIR):
> ============
> 
> 
> Regards--
> 
> 
> -Tomonori Mitani
> 
> 
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
