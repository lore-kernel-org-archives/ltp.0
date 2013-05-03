Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <riku.voipio@linaro.org>) id 1UYGXR-000679-Vh
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 14:00:42 +0000
Received: from afflict.kos.to ([92.243.29.197])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UYGXQ-0007K3-CO
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 14:00:41 +0000
From: riku.voipio@linaro.org
Date: Fri,  3 May 2013 16:45:17 +0300
Message-Id: <1367588717-18162-4-git-send-email-riku.voipio@linaro.org>
Subject: [LTP] [PATCH 3/3] set 16kb incrediment for Aarch64
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

From: Riku Voipio <riku.voipio@linaro.org>


Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 testcases/kernel/mem/shmt/shmt09.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/shmt/shmt09.c b/testcases/kernel/mem/shmt/shmt09.c
index 5e7e52e..8f8c3c7 100644
--- a/testcases/kernel/mem/shmt/shmt09.c
+++ b/testcases/kernel/mem/shmt/shmt09.c
@@ -61,7 +61,7 @@ int TST_TOTAL = 4;		/* Total number of test cases. */
 #define INCREMENT 		8388608	/* 8Mb */
 #elif defined (__mips__)  ||  defined (__hppa__) || defined (__sparc__)
 #define INCREMENT		262144	/* 256Kb */
-#elif defined __sh__ || defined (__arm__)
+#elif defined __sh__ || defined (__arm__) || defined(__aarch64__)
 #define INCREMENT 		16384	/* 16kb */
 #else
 #define INCREMENT 		SHMLBA
@@ -162,7 +162,7 @@ int main()
 	tst_resm(TPASS, "sbrk, shmat");
 
 /*--------------------------------------------------------*/
-#if defined (__ia64__) || defined(__mips__) || defined(__hppa__) || defined(__arm__)
+#if defined (__ia64__) || defined(__mips__) || defined(__hppa__) || defined(__arm__) || defined(__aarch64__)
 	while ((vp = sbrk(INCREMENT)) != (void *)-1) ;
 	if (errno != ENOMEM) {
 		tst_resm(TFAIL, "Error: sbrk failed, errno = %d\n", errno);
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
