Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D020CA5FED
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 06:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791528589; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=C2v44TMPb/AWsfh3adHmlZXHxypfPT3EXGhhJsyh2pE=;
 b=pFZNyOJ/+6lgK/7o/g04WsOIMGIMz5srCuoD/sg2xXID4dmPtipgLiAUJLj9ByYoBoYzc
 s44C+fEjwHBr/qZ1YRHs0J/Mhzs4fbohLMhvmTUx2/JAgWpNod/rVl9paiPxSw4N2PFMxaH
 hvwcPBp3eZ4BwHLaZaU6fRfycshdlbI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE3963E2AEF
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 08:49:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 163683E2455
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 08:49:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9718D1400E43
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 08:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791528566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b7N+QXQjBpycwakRnT6B4nzOnk1rHgDUwOrPBh1vQZ0=;
 b=ePtFSrReFmqvF+Ba85ygX0T2NoORSZwXvQqlcGPiBXP/zsYqTjeM9uW667H/ltN6qsOFSq
 FkJZXhWOQ/5RU/bWrsIS8eqOxz8zNLAEFno1jOs3xlNW3uO0NNVtnNezxG/juoyDlGob4s
 1jqXk2DEZ2K7U+HJAuyz3g/+xWygmx0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-J_I8ZNA2MoCiMtL6A_oQbw-1; Fri,
 09 Oct 2026 02:49:24 -0400
X-MC-Unique: J_I8ZNA2MoCiMtL6A_oQbw-1
X-Mimecast-MFC-AGG-ID: J_I8ZNA2MoCiMtL6A_oQbw_1791528563
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 811EC1955E7E
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 06:49:23 +0000 (UTC)
Received: from jstancek-thinkpadt14gen5.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5A9A1800473
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 06:49:22 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri,  9 Oct 2026 08:49:19 +0200
Message-ID: <4e46078e97ec7c6678cabd9f2b32cba8be3ee3cf.1791528355.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Me0Rh7-bTPpB1K4d__LxYyU7eF9UL710vHR_--yGNW0_1791528563
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: timers/twoevtimers: Wait for both timer
 signals
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test arms two timers with the same absolute expiration time and
then does a single sleep() before checking that both signals arrived.
sleep() returns as soon as the first signal interrupts it, and the
kernel delivers the two signals one at a time. This sporadically
leads to failure:

  Caught abort signal
  Test FAILED

even though the second timer fires microseconds later.

Keep sleeping on the remaining time until both signals have been
caught or the LONGTIME budget, which was defined but never used, runs
out. Make the counters volatile sig_atomic_t and print from the handlers
with the async-signal-safe PTS_WRITE_MSG() instead of printf().

Lower the sleep time, and also correct the header comment: the timers
live in the same process, not in different processes, and the test only
checks that both of them expire, not that they expire at the same time.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../functional/timers/timers/twoevtimers.c    | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c b/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
index 0e46229777fe..b581678d2b12 100644
--- a/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
+++ b/testcases/open_posix_testsuite/functional/timers/timers/twoevtimers.c
@@ -5,8 +5,14 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
  *
- * Test having two timers in different processes set to expire at the
- * same time, and ensure they both expire at the same time.
+ * Test having two timers in the same process, armed with the same
+ * absolute expiration time but delivering different signals, and ensure
+ * that both of them expire.
+ *
+ * Note that the test does not (and cannot) verify that the two signals
+ * are delivered simultaneously.  Signals are delivered one at a time, so
+ * the first one interrupts sleep() while the second one may still be
+ * on its way.  Keep waiting until both have arrived or LONGTIME elapses.
  */
 #include <stdio.h>
 #include <time.h>
@@ -17,23 +23,23 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-#define EXPIREDELTA 3
-#define LONGTIME 5
+#define EXPIREDELTA 1
+#define LONGTIME 3
 
 #define CHILDPASS 1
 
-static int caughtabort = 0;
-static int caughtalarm = 0;
+static volatile sig_atomic_t caughtabort = 0;
+static volatile sig_atomic_t caughtalarm = 0;
 
-static void handler_abrt(int signo)
+static void handler_abrt(int signo PTS_ATTRIBUTE_UNUSED)
 {
-	printf("Caught abort signal\n");
+	PTS_WRITE_MSG("Caught abort signal\n");
 	caughtabort++;
 }
 
-static void handler_alrm(int signo)
+static void handler_alrm(int signo PTS_ATTRIBUTE_UNUSED)
 {
-	printf("Caught alarm signal\n");
+	PTS_WRITE_MSG("Caught alarm signal\n");
 	caughtalarm++;
 }
 
@@ -45,6 +51,7 @@ int test_main(int argc, char **argv)
 	struct timespec ts;
 	struct itimerspec its;
 	int flags = 0;
+	unsigned int left = LONGTIME;
 
 	act1.sa_handler = handler_abrt;
 	act1.sa_flags = 0;
@@ -93,7 +100,12 @@ int test_main(int argc, char **argv)
 		return PTS_UNRESOLVED;
 	}
 
-	sleep(EXPIREDELTA + 1);
+	/*
+	 * sleep() returns early when the first signal arrives; keep waiting
+	 * until the second one has been delivered as well or we time out.
+	 */
+	while (left > 0 && !(caughtalarm && caughtabort))
+		left = sleep(left);
 
 	if ((caughtalarm == 1) && (caughtabort == 1)) {
 		printf("Test PASSED\n");
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
