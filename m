Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <voipio@kos.to>) id 1VUYzm-0000gJ-IS
	for ltp-list@lists.sourceforge.net; Fri, 11 Oct 2013 09:26:54 +0000
Received: from afflict.kos.to ([92.243.29.197])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VUYzk-0002m0-QQ
	for ltp-list@lists.sourceforge.net; Fri, 11 Oct 2013 09:26:54 +0000
Received: from kos.to (91-157-208-114.elisa-laajakaista.fi [91.157.208.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by afflict.kos.to (Postfix) with ESMTPSA id F015426552
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Oct 2013 11:09:11 +0200 (CEST)
From: Riku Voipio <riku.voipio@linaro.org>
Date: Fri, 11 Oct 2013 12:09:08 +0300
Message-Id: <1381482548-29543-1-git-send-email-riku.voipio@linaro.org>
Subject: [LTP] [PATCH] Remove bogus Aarch64 system call numbers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

Aarch64 build fails with:

cacheflush01.c:52:26: fatal error: asm/cachectl.h: No such file or directory
 #include <asm/cachectl.h>

This is caused by bogus definitions of cacheflush and set_tls, which are
private 32bit ARM system calls. These should not be used on native
Aarch64 binaries. If they need to be tested, it is better done using ltp
compiled for 32bit ARM.

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 testcases/kernel/include/aarch64.in              | 2 --
 testcases/kernel/include/linux_syscall_numbers.h | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/testcases/kernel/include/aarch64.in b/testcases/kernel/include/aarch64.in
index a845be0..ceb67c6 100644
--- a/testcases/kernel/include/aarch64.in
+++ b/testcases/kernel/include/aarch64.in
@@ -253,5 +253,3 @@ clock_adjtime 266
 syncfs 267
 setns 268
 sendmmsg 269
-cacheflush 0x1002
-set_tls 0x1005
diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
index 38931cf..03664ce 100644
--- a/testcases/kernel/include/linux_syscall_numbers.h
+++ b/testcases/kernel/include/linux_syscall_numbers.h
@@ -801,12 +801,6 @@
 # ifndef __NR_sendmmsg
 #  define __NR_sendmmsg 269
 # endif
-# ifndef __NR_cacheflush
-#  define __NR_cacheflush 0x1002
-# endif
-# ifndef __NR_set_tls
-#  define __NR_set_tls 0x1005
-# endif
 #endif
 
 
@@ -12754,9 +12748,6 @@
 # ifndef __NR_settimeofday
 #  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
 # endif
-# ifndef __NR_set_tls
-#  define __NR_set_tls __LTP__NR_INVALID_SYSCALL
-# endif
 # ifndef __NR_setuid
 #  define __NR_setuid __LTP__NR_INVALID_SYSCALL
 # endif
-- 
1.8.1.2


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
