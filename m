Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ljhc@br.ibm.com>) id 1MYl3S-0007P5-Tx
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 18:17:38 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYl3R-00086K-PK
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 18:17:38 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n75HmujR010085
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:48:56 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75HrCJc215252
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:53:14 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n75Hr15x016434
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 11:53:04 -0600
From: Lucio Correia <ljhc@br.ibm.com>
In-Reply-To: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="=-gYWGJSRkVkRwJDeybhZ+"
Date: Wed, 05 Aug 2009 14:52:55 -0300
Message-Id: <1249494775.13131.18.camel@lucio-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
Reply-To: ljhc@br.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Kumar Gala <galak@kernel.crashing.org>
Cc: LTP <ltp-list@lists.sourceforge.net>


--=-gYWGJSRkVkRwJDeybhZ+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Kumar,

On Wed, 2009-07-29 at 13:33 -0500, Kumar Gala wrote:
> I get the following compile error:
> 
> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/fstat'
> make[4]: Entering directory `/root/ltp/testcases/kernel/syscalls/ 
> fstatat'
> cc -Wall  -I../../include -g -Wall -I../../../../include -Wall - 
> DTST_USE_NEWER64_SYSCALL=1 -D_FILE_OFFSET_BITS=64   -c -o  
> fstatat01_64.o fstatat01.c
> fstatat01.c:95:37: error: missing binary operator before token "5"
> fstatat01.c: In function 'main':
> fstatat01.c:126: error: expected ')' before numeric constant
> make[4]: *** [fstatat01_64.o] Error 1
> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/fstatat'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/root/ltp/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp/testcases'
> make: *** [all] Error 2

This failure is being caused because .in files in kernel/includes are 
wrong. The prefixes for the names (__NR_) and the plus signs were 
removed. I've noticed it in .in files for several architectures in the
latest LTP release (July 2009). 



This patch fixes bad updates to syscalls declarations for powerpc, that
are causing build failures. This should be fixed for other archs 
accordingly.

Signed-off-by Lucio Correia <luciojhc@br.ibm.com>

--=-gYWGJSRkVkRwJDeybhZ+
Content-Disposition: attachment; filename="july2009-ppc-build-fix.patch"
Content-Type: text/x-patch; name="july2009-ppc-build-fix.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -Nurp ltp-full-20090731.orig/testcases/kernel/include/powerpc64.in ltp-full-20090731.new/testcases/kernel/include/powerpc64.in
--- ltp-full-20090731.orig/testcases/kernel/include/powerpc64.in	2009-07-20 00:41:12.000000000 -0400
+++ ltp-full-20090731.new/testcases/kernel/include/powerpc64.in	2009-08-05 17:00:31.000000000 -0400
@@ -1,26 +1,26 @@
-timer_create 240
-timer_settime 241
-timer_delete 244
-clock_settime 245
-clock_gettime 246
-splice 283
-tee 284
-vmsplice 285
-openat 286
-mkdirat (__NR_openat  1)
-mknodat (__NR_openat  2)
-fchownat (__NR_openat  3)
-futimesat (__NR_openat  4)
-newfstatat (__NR_openat  5)
-fstatat64 (__NR_openat  5)
-unlinkat (__NR_openat  6)
-renameat (__NR_openat  7)
-linkat (__NR_openat  8)
-symlinkat (__NR_openat  9)
-readlinkat (__NR_openat  10)
-fchmodat (__NR_openat  11)
-faccessat (__NR_openat  12)
-utimensat 304
-eventfd 307
-fallocate 309
-eventfd2 314
+__NR_timer_create 240
+__NR_timer_settime 241
+__NR_timer_delete 244
+__NR_clock_settime 245
+__NR_clock_gettime 246
+__NR_splice 283
+__NR_tee 284
+__NR_vmsplice 285
+__NR_openat 286
+__NR_mkdirat (__NR_openat + 1)
+__NR_mknodat (__NR_openat + 2)
+__NR_fchownat (__NR_openat + 3)
+__NR_futimesat (__NR_openat + 4)
+__NR_newfstatat (__NR_openat + 5)
+__NR_fstatat64 (__NR_openat + 5)
+__NR_unlinkat (__NR_openat + 6)
+__NR_renameat (__NR_openat + 7)
+__NR_linkat (__NR_openat + 8)
+__NR_symlinkat (__NR_openat + 9)
+__NR_readlinkat (__NR_openat + 10)
+__NR_fchmodat (__NR_openat + 11)
+__NR_faccessat (__NR_openat + 12)
+__NR_utimensat 304
+__NR_eventfd 307
+__NR_fallocate 309
+__NR_eventfd2 314
diff -Nurp ltp-full-20090731.orig/testcases/kernel/include/powerpc.in ltp-full-20090731.new/testcases/kernel/include/powerpc.in
--- ltp-full-20090731.orig/testcases/kernel/include/powerpc.in	2009-07-20 00:41:11.000000000 -0400
+++ ltp-full-20090731.new/testcases/kernel/include/powerpc.in	2009-08-05 16:57:47.000000000 -0400
@@ -1,27 +1,27 @@
-timer_create 240
-timer_settime 241
-timer_delete 244
-clock_settime 245
-clock_gettime 246
-splice 283
-tee 284
-vmsplice 285
-openat 286
-mkdirat (__NR_openat  1)
-mknodat (__NR_openat  2)
-fchownat (__NR_openat  3)
-futimesat (__NR_openat  4)
-newfstatat (__NR_openat  5)
-fstatat64 (__NR_openat  5)
-unlinkat (__NR_openat  6)
-renameat (__NR_openat  7)
-linkat (__NR_openat  8)
-symlinkat (__NR_openat  9)
-readlinkat (__NR_openat  10)
-fchmodat (__NR_openat  11)
-faccessat (__NR_openat  12)
-utimensat 304
-eventfd 307
-fallocate 309
-eventfd2 314
-perf_counter_open 319
+__NR_timer_create 240
+__NR_timer_settime 241
+__NR_timer_delete 244
+__NR_clock_settime 245
+__NR_clock_gettime 246
+__NR_splice 283
+__NR_tee 284
+__NR_vmsplice 285
+__NR_openat 286
+__NR_mkdirat (__NR_openat + 1)
+__NR_mknodat (__NR_openat + 2)
+__NR_fchownat (__NR_openat + 3)
+__NR_futimesat (__NR_openat + 4)
+__NR_newfstatat (__NR_openat + 5)
+__NR_fstatat64 (__NR_openat + 5)
+__NR_unlinkat (__NR_openat + 6)
+__NR_renameat (__NR_openat + 7)
+__NR_linkat (__NR_openat + 8)
+__NR_symlinkat (__NR_openat + 9)
+__NR_readlinkat (__NR_openat + 10)
+__NR_fchmodat (__NR_openat + 11)
+__NR_faccessat (__NR_openat + 12)
+__NR_utimensat 304
+__NR_eventfd 307
+__NR_fallocate 309
+__NR_eventfd2 314
+__NR_perf_counter_open 319

--=-gYWGJSRkVkRwJDeybhZ+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--=-gYWGJSRkVkRwJDeybhZ+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-gYWGJSRkVkRwJDeybhZ+--


