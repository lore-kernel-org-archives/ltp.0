Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DF606A32D
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=lTHSByQx;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YPoE94nu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794520194; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=TStCUgolQJPWUDEUH68jtVB/1cgNTdVFc1Ig6WX8S10=;
 b=lTHSByQxmKHx8/yXhTP9s0r3e9CM5qianvXM6rpTYVDoA3y/2YEfo1/sYUv6CAYb/uk2B
 MYeV/CyarFjYd0Kb1kMea0qIzzZ6PaiwVK6B5HfHyo+RK7G1iYFLUwV+tzS1xEza7ircL/A
 G9VJCAqMX4Q3JeYbFgyhpPzizZQe53k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 892E33EB4F5
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 22:49:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA0153EAC93
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 22:49:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 43DCD1A00661
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 22:49:33 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so1436395e9.1
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 13:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794520173; x=1795124973; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zUytcArwYft42yI5fAGTTaE7PTH2ElBsf7FRxoWCuy8=;
 b=YPoE94nuNiDtLl2AOu9tTI/eKbW8o0TLBIyunv62S5nPqZ54wHoYTeT6HmsjkzFtot
 N+UyBhyQFe7MrbAHBu7uq2HFPrh4sJTiVan4A1G9PMC/6Vuxem3d19wKT8Ijb0Rr0Jd9
 482JO0fRb1BD/rrAqWsEx0UTn+qkwvsD7qlE1sIPcfiCpk0HGR4xi6YrEBUpR+lYa3IL
 3yBHt8Q9pzp3DG3e0orBP1ecROzkR4/zhIXbecrgPsp6BTAFwIem1yrZW2bFR88028x+
 puvW8wVcsvJbaQS4JR++0oEbbR7O0iFmiyiDF0Hn0AVqGmpctUOk5k9zKffQ4dHlj2fV
 ACcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794520173; x=1795124973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zUytcArwYft42yI5fAGTTaE7PTH2ElBsf7FRxoWCuy8=;
 b=uxsUZQxjwAfKEad2wFDJv/Xf8LSnGpE+kNv76b7bRWTs2WidRjrNtl3oMiROn7MjHj
 KWpogrkSWG02Y/IN7hSQQ6/j9Jmrho1UbjKVff7cadYB9VJjEXuJV+CEu9c2CvRdD7JI
 za6pSl7QfbNbmtJqwq8uV7UJKVPpwklAQhbWcQd10cXgyGvUx0R0sQkK+srGCpwiQ003
 mrAkGCZlJxDHJiyLqiJREUh6UUaG+Vb834SGR9MTu0qmGWDdZN/oNgjZKsB9iZHUuicm
 OLqmc7Bxq2KcM/M2kVAv7n0c1YQ2wlqkklk5kyNDIQW0wamDerRZrMibcccJpb6hFNrU
 Z3Tg==
X-Gm-Message-State: APuU4Z/P38SV11c2XScU2DjkH2muieJxSdSgPEgRwyn9zUYCBWJ7XDyO
 t8Xkawn0fmhjpOHJEX8VucpVdsD69/s5qEbssDA4gQxqUght62RckaTm/xYco4LEHW4YA2JnvUJ
 VnAq8e1Q=
X-Gm-Gg: AYBFou2NzRG/sKhFGJ+CeTwW+o2X7ucRCrLUSIt1mQlPIpocj0fsTixR0l4701/c/WA
 6su6I9RA3irI6IBxeVzw7hQYfF37IUyadHjYC0Rc3htxPWbSZRVGeWpLVTMtyr4o/n+Dk1d5NZB
 ZooEYbKSX+jjyukMwZ4m0Kg1naPsyr9DSV2awZZyybeaq39tL29LMwPEIjr3eKOaRlWjERF5RO2
 HR/eeqTWrUsRoCbbmaOx9ht1pbaehdWYOjjGkmy1WCJBFgSsE7oD+yDxTAxVDITjtryQ5yc+dyl
 DHFr34/qacfRCYXC67eRRei0l9LOt93RNtd8SoyRHrg7rwOMsGuBL88mAJG8F9Tzw5W7evgnslI
 nQMvF+qzEG+DvLE9p+3Tz/tKjYTKils6t8T48MbdwFoMV93Je20lUrpB29wX5gwrfabxBifAiAk
 rM2YoJjGa95hH0DVoiF+doHMl34LT8sVr+jJ7RVhqlZU7Kpk2ACzYNpyip7DJDbIwFFp/ucu0uo
 djmA+0jebRiOVvBALrTzfGC7xUL+9VKWAYMyP+1cgpGoDjEhY6FSbRF2J/MVCwzHe2DKxFbhjvy
 UlRLrnUF9Na3RnR2qqwlCj1+wHiP
X-Received: by 2002:a5d:588b:0:b0:48e:202:6718 with SMTP id
 ffacd0b85a97d-49c71b5d3cemr1589660f8f.25.1794520172612; 
 Thu, 12 Nov 2026 13:49:32 -0800 (PST)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm1631992f8f.11.2026.11.12.13.49.32
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:49:32 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 12 Nov 2026 22:49:30 +0100
Message-ID: <20261112214931.442129-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: pthread_join/speculative/6-1: Fix race
 with detached thread exit
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

The test creates a detached thread whose body returns immediately, then
expects pthread_join() on its ID to fail with EINVAL. Once the thread has
exited, its ID is no longer valid and the behavior is undefined. The
outcome depends on scheduling, so the test fails sporadically, mostly
on single CPU machines.

Keep the thread blocked on a semaphore until pthread_join() has returned.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../interfaces/pthread_join/speculative/6-1.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/speculative/6-1.c
index 127b724c69e4..232fd4cc33ac 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/speculative/6-1.c
@@ -25,18 +25,30 @@
  * Steps:
  * 1.  Create a new thread that is non-joinable (i.e. detached state
  *     attribute is PTHREAD_CREATE_DETACHED.
+ *     The thread blocks until released.
  * 2.  Call pthread_join() in main.  It should return EINVAL.
  *     If not, the test fails.
+ * 3.  Release the thread.
+ *
+ * The thread must still be running while pthread_join() is called. Once a
+ * detached thread has exited its ID is no longer valid and the behavior of
+ * pthread_join() is then undefined.
  */
 
 #include <pthread.h>
+#include <semaphore.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
 #include "posixtest.h"
 
+static sem_t gate;
+
 static void *a_thread_func()
 {
+	if (sem_wait(&gate) != 0)
+		perror("sem_wait()");
+
 	pthread_exit(0);
 	return NULL;
 }
@@ -47,6 +59,11 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	pthread_attr_t attr;
 	int ret;
 
+	if (sem_init(&gate, 0, 0) != 0) {
+		perror("sem_init()");
+		return PTS_UNRESOLVED;
+	}
+
 	pthread_attr_init(&attr);
 	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
 
@@ -55,7 +72,17 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 		return PTS_UNRESOLVED;
 	}
 
+	/*
+	 * The thread cannot get past sem_wait() before the post below,
+	 * so it is alive and detached.
+	 */
 	ret = pthread_join(new_th, NULL);
+
+	if (sem_post(&gate) != 0) {
+		perror("sem_post()");
+		return PTS_UNRESOLVED;
+	}
+
 	if (ret != EINVAL) {
 		printf("Test FAILED: Return code should be EINVAL, "
 		       "but is: %d instead.\n", ret);
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
