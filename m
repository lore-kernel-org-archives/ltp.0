Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gary.robertson@linaro.org>) id 1XZ4s3-0003id-7M
	for ltp-list@lists.sourceforge.net; Tue, 30 Sep 2014 21:22:07 +0000
Received: from mail-oi0-f52.google.com ([209.85.218.52])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XZ4s2-0006Kk-6i
	for ltp-list@lists.sourceforge.net; Tue, 30 Sep 2014 21:22:07 +0000
Received: by mail-oi0-f52.google.com with SMTP id a3so2809155oib.25
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Sep 2014 14:22:00 -0700 (PDT)
From: "Gary S. Robertson" <gary.robertson@linaro.org>
Date: Tue, 30 Sep 2014 16:15:59 -0500
Message-Id: <1412111759-22198-1-git-send-email-gary.robertson@linaro.org>
Subject: [LTP] [PATCH] Realtime tests: Fix bad priority inheritance
	conditionals
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
Cc: mike.holmes@linaro.org

From: "Gary S. Robertson" <gary.robertson@linaro.org>

testcases/realtime/lib/librttest.c and
testcases/realtime/stress/pi-tests/testpi-3.c
both referenced a non-existent autoconf configuration setting variable.
Replaced the invalid variable name with the variable actually created
by autoconf.

Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
---
 testcases/realtime/lib/librttest.c            |    2 +-
 testcases/realtime/stress/pi-tests/testpi-3.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index c175148..3679058 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -586,7 +586,7 @@ void *busy_work_us(int us)
 
 void init_pi_mutex(pthread_mutex_t * m)
 {
-#if HAVE_DECL_PTHREAD_PRIO_INHERIT
+#if HAS_PRIORITY_INHERIT
 	pthread_mutexattr_t attr;
 	int ret;
 	int protocol;
diff --git a/testcases/realtime/stress/pi-tests/testpi-3.c b/testcases/realtime/stress/pi-tests/testpi-3.c
index 30f38f6..e483945 100644
--- a/testcases/realtime/stress/pi-tests/testpi-3.c
+++ b/testcases/realtime/stress/pi-tests/testpi-3.c
@@ -365,7 +365,7 @@ int main(int argc, char *argv[])
 
 	printf("Start %s\n", argv[0]);
 
-#if HAVE_DECL_PTHREAD_PRIO_INHERIT
+#if HAS_PRIORITY_INHERIT
 	if (!nopi) {
 		pthread_mutexattr_t mutexattr;
 		int protocol;
-- 
1.7.9.5


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
