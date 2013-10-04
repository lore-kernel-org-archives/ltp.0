Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maxim.uvarov@linaro.org>) id 1VS2Rw-0001lj-Fo
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:17:32 +0000
Received: from mail-lb0-f180.google.com ([209.85.217.180])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VS2Ru-00047H-1s
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:17:30 +0000
Received: by mail-lb0-f180.google.com with SMTP id q8so2983119lbi.25
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Oct 2013 03:17:23 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Fri,  4 Oct 2013 14:17:12 +0400
Message-Id: <1380881832-7418-2-git-send-email-maxim.uvarov@linaro.com>
In-Reply-To: <1380881832-7418-1-git-send-email-maxim.uvarov@linaro.com>
References: <1380881832-7418-1-git-send-email-maxim.uvarov@linaro.com>
Subject: [LTP] [PATCH] LTP cacheflush01 add arm variant
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
Cc: linaro-networking@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.com>

Cache flush on arm provided via
__ARM_NR_cacheflush(unsigned long start, unsigned long end, int flags)
defined in ./arch/arm/kernel/traps.c.
Flags are not used, providing 0 there.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.com>
---
 .../kernel/syscalls/cacheflush/cacheflush01.c      |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/cacheflush/cacheflush01.c b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
index 9c02f0a..fae51b4 100644
--- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
+++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
@@ -137,6 +137,14 @@ int main(int ac, char **av)
 	}
 
 	/* Invokes cacheflush() with proper parameters */
+#if defined(__arm__)
+	TEST(ltp_syscall(__ARM_NR_cacheflush, addr, addr + getpagesize(), 0));
+	if (TEST_RETURN == 0) {
+		tst_resm(TPASS, "passed with no errno");
+	} else {
+		tst_resm(TFAIL, "failed with unexpected errno");
+	}
+#else	
 	TEST(ltp_syscall(__NR_cacheflush, addr, getpagesize(), ICACHE));
 	if (TEST_RETURN == 0) {
 		tst_resm(TPASS, "passed with no errno");
@@ -157,6 +165,7 @@ int main(int ac, char **av)
 	} else {
 		tst_resm(TFAIL, "failed with unexpected errno");
 	}
+#endif
 
 	cleanup();
 	tst_exit();
-- 
1.7.9.5


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
