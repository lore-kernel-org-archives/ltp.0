Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NkZaV-0002MB-ME
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:00:51 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NkZaS-0007LE-Eb
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:00:50 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1P8sHKZ007935
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 01:54:17 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1P90WxM007996
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 02:00:32 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1P90VVb009154
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 02:00:32 -0700
Date: Thu, 25 Feb 2010 14:30:27 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100225090027.GC3377@linux.vnet.ibm.com>
References: <4B728073.3070209@cn.fujitsu.com>
	<4B7B9EC2.1010004@linux.vnet.ibm.com>
	<364299f41002170914u3a0d0b02o936a81d1ee601ecc@mail.gmail.com>
	<4B823884.4000100@cn.fujitsu.com>
	<364299f41002241922h31f32a1em6f12a2999fd931f8@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002241922h31f32a1em6f12a2999fd931f8@mail.gmail.com>
Subject: Re: [LTP] [PATCH] timers: support clockid of
 CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wed, Feb 24, 2010 at 07:22:09PM -0800, Garrett Cooper wrote:
>     I've added the autoconf-conditionalized variables along with your
> changes, and some other minor cleanups to git just moments ago.
Hi Garret,

Getting the build error on today's tree as:

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/root/temp/testcases/kernel/include -D_GNU_SOURCE
-I/root/temp/testcases/kernel/timers/clock_gettime/../include
-I../../../../include -I../../../../include   -L../../../../lib
clock_gettime02.c   -lltp -lpthread -lrt -o clock_gettime02
In file included from clock_gettime02.c:73:
/root/temp/testcases/kernel/timers/clock_gettime/../include/common_timers.h:22:
error: `CLOCK_MONOTONIC_RAW' undeclared here (not in a function)
/root/temp/testcases/kernel/timers/clock_gettime/../include/common_timers.h:22:
error: initializer element is not constant
/root/temp/testcases/kernel/timers/clock_gettime/../include/common_timers.h:22:
error: (near initialization for `clock_list[4]')
make[4]: *** [clock_gettime02] Error 1
make[4]: Leaving directory
`/root/temp/testcases/kernel/timers/clock_gettime'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/root/temp/testcases/kernel/timers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/temp/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/temp/testcases'
make: *** [testcases-all] Error 2
[root@elm17d44 temp]# vim
/root/temp/testcases/kernel/timers/clock_gettime/../include/common_timers.h


And this patch solves the problem, please Ack it if it is correct
solution, so that i can merge to tree.

    Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

diff --git a/testcases/kernel/timers/include/common_timers.h
b/testcases/kernel/timers/include/common_timers.h
index cae9626..1e103b1 100644
--- a/testcases/kernel/timers/include/common_timers.h
+++ b/testcases/kernel/timers/include/common_timers.h
@@ -19,7 +19,6 @@ clock_t clock_list[] = {
        CLOCK_MONOTONIC,
        CLOCK_PROCESS_CPUTIME_ID,
        CLOCK_THREAD_CPUTIME_ID,
-       CLOCK_MONOTONIC_RAW,
 #if HAVE_CLOCK_REALTIME_COARSE
        CLOCK_REALTIME_COARSE,
 #endif
@@ -40,7 +39,6 @@ const char *get_clock_str(const int clock_id)
        CLOCK_TO_STR(CLOCK_MONOTONIC);
        CLOCK_TO_STR(CLOCK_PROCESS_CPUTIME_ID);
        CLOCK_TO_STR(CLOCK_THREAD_CPUTIME_ID);
-       CLOCK_TO_STR(CLOCK_MONOTONIC_RAW);
 #if HAVE_CLOCK_REALTIME_COARSE
        CLOCK_TO_STR(CLOCK_REALTIME_COARSE);
 #endif

Thanks
Rishi

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
