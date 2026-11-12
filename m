Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE6606A323
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ddHrvMyx;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=R2BkCH4Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794462513; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=RCcWxPFz8NEIw3mpr09MkB9c4o+fPfAlgKWtD6PHs5o=;
 b=ddHrvMyxoj94HgsrzP/LpwIyoDBe0pkAa/PhGJeLWS/jZm5v2a7WdylqtT561vx2p+kOY
 ogDoaPUKiPVcjw6DwSTwScTyWgT7iHH9QvYiCs1jevfAZkhNdwrtZ3flsbuYHccP+2lwE/g
 LcccSwsENzQ4a506tdOdIRCvY6eptZ0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C700B3E5E39
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 06:48:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C2423CD421
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 06:48:14 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C136F10009F6
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 06:48:13 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso33994565e9.3
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 21:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794462493; x=1795067293; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WoWnJP90wEH3lTClsqZjhQDL6gm3mfz1Iiu/3CrVXxE=;
 b=R2BkCH4ZUXD48xuXPzpWZUPVpQMuxlgJzNYMJ2qnRtUriX3Wlf9snr9QYJxy1YhGGX
 UOSE6MNTerCRelwUWYmTkAD/VgfYU8kC4X/oMmwWoR2MDk2Un+TGFGxkYAx8DrbebD7+
 R4JaxBZkB4GgWoJIB7R0kHYXHhZtTgxNKE1LISBFvgtimliCnKygemKiZO9/4nEd+x63
 yAW62JkyPa2VlFk+PinWcifjVaHwnGF36g4xy2usMNkKoiWshm/A8jcZ/yefQW4gkc+B
 zAf9izKMJNGKcimlHCk1UjwPCoFoxOWGh0FeNm+t3/zZh/Rgtr6devr9kr0mlctFQBaI
 CWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794462493; x=1795067293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WoWnJP90wEH3lTClsqZjhQDL6gm3mfz1Iiu/3CrVXxE=;
 b=oJbwqbPwK48LU0IiYQ9xsRqSoDy0OU7tAdCOSGQrI5HFgp8xHSk27+BHpBC6i2HyPt
 rieCmAU8D3lX1MhhMh+VR9ob1WP0+WCT2en0YgyM4CEQRKZfGCaZLWQz/I61hJnUyGST
 Rdu2C2lgctZULQbErnZn89aFXD9UiMACfmGW6GA/13tg/sxHKFvs5K6W9w83SUEJ1tpa
 4V0kTTVX4GG9KM/cwfHG3UiB++ISOUo91gPjIOgaNksmvMDzPiJTDWxPmwHPZbxTRu1x
 gOFeZZrwLQOFlbo2HQBlv6Gt7AwwMVDuLj6LiHhAqJ54G4a0lKlgw1Yxd3W61KgPKSQ0
 6j2A==
X-Gm-Message-State: APuU4Z9WrSt4hzsi8BGEI5bE4f532M+1D5+1sXjVtj4d3ltcfz8kLoyt
 k3wOjh9Y7iZ9FUaCkIxJnDrnGXInWfelDu8F36lXSD2sSXx4QSxx335dxxLDIz7Z9KSjt5dXRTp
 Obk+TFO2C+g==
X-Gm-Gg: AYBFou2G5m+IHPeYgiZf8+O8YaEllgskB3qEEgw/TYnyz67N/NKScXmvYKyao9D/9iA
 lsyDQ+DjaJokyyiY5mHA2xEur+0U/d6/hm3B3M93UUIz9Px3xK44hM6ZCAH6ibhI7oSjbGZkyUf
 KySVfe4SNGNqtOkuwaZy1/tQnaWPhr6h339NGA7b1oOLbqTU81VyMX21wdOTFAyCq/M7/dWewxT
 JxpGQPGkZBMK+500LeIHAZQSdzZLDk5eRJ5dHiUAILyLK6zEwCIWM9DxUsCrW6dPHsXgv8dHJXP
 tY4/j/b8NxxbEJruVckZd3x8AEEsmeQ0dsLs4WeEhOE/VCywCM30dKia0biZiaz/O4YVJnGx+AG
 s64lJvvxfPoH4eA5BY6HuVnqZumF059DbObKxLXFUjJa3Wzt3I1Gs+FggvwcTOZNX3lY0bkbSgc
 hrGyD3VZy1uTXfM6RhSqLPWDEoBXuviKRhyKIUarAh64aHPEuM97J+1+Ces44K9JCWnL4uDirpz
 0KwdOSmrZ/kcoVQbtS/HTxv5/iRMr3UFhJ9vpx2EfTGCW3YGSmHdQEXGddqbJ3CJt6vavkxFD7T
 y6t2RsTI+mWgZrHkCQQTtHh1boXduXLuDBnkhhnUhXXVKBqXPA==
X-Received: by 2002:a05:600c:1c0c:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4ba091a5bcbmr90161395e9.0.1794462492950; 
 Wed, 11 Nov 2026 21:48:12 -0800 (PST)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e25eb86sm36633385e9.8.2026.11.11.21.48.12
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 21:48:12 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 12 Nov 2026 06:48:10 +0100
Message-ID: <20261112054811.253749-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: pthread_attr_setdetachstate/2-1: Fix race
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

The test expects pthread_join() and pthread_detach() on a detached
thread to fail with EINVAL, but the thread exits immediately. Once it
has exited its ID is no longer valid, the behavior of both calls is
undefined. The outcome depends on scheduling, so the test fails
sporadically, mostly on single CPU machines.

Keep the thread blocked on a semaphore until both calls have returned.
Also print which call returned what on failure instead of a bare
"Test FAILED".

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../pthread_attr_setdetachstate/2-1.c         | 46 ++++++++++++++-----
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/2-1.c
index bff117f542f0..c09a2d3b2b79 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setdetachstate/2-1.c
@@ -14,19 +14,29 @@
  * 1.  Initialize a pthread_attr_t object using pthread_attr_init().
  * 2.  Using pthread_attr_setdetachstate(), set the detachstate to
  *     PTHREAD_CREATE_DETACHED.
- * 3.  Create a thread with this attribute.
+ * 3.  Create a thread with this attribute. The thread blocks until released.
  * 4.  Call pthread_detach() and pthread_join() on this thread, it should give
  *     an error.
+ * 5.  Release the thread.
  *
+ * The thread must still be running while pthread_join() and pthread_detach()
+ * are called. Once a detached thread has exited its ID is no longer valid, the
+ * behavior of both calls is then undefined.
  */
 
 #include <pthread.h>
+#include <semaphore.h>
 #include <stdio.h>
+#include <string.h>
 #include <errno.h>
 #include "posixtest.h"
 
+static sem_t gate;
+
 static void *a_thread_func()
 {
+	if (sem_wait(&gate) != 0)
+		perror("sem_wait()");
 
 	pthread_exit(0);
 	return NULL;
@@ -36,7 +46,12 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	pthread_t new_th;
 	pthread_attr_t new_attr;
-	int ret_val;
+	int join_ret, detach_ret;
+
+	if (sem_init(&gate, 0, 0) != 0) {
+		perror("sem_init()");
+		return PTS_UNRESOLVED;
+	}
 
 	/* Initialize attribute */
 	if (pthread_attr_init(&new_attr) != 0) {
@@ -57,19 +72,28 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 		return PTS_UNRESOLVED;
 	}
 
-	/* If pthread_join() or pthread_detach fail, that means that the
-	 * test fails as well. */
-	ret_val = pthread_join(new_th, NULL);
+	/*
+	 * The thread cannot get past sem_wait() before the post below,
+	 * so it is alive and detached.
+	 */
+	join_ret = pthread_join(new_th, NULL);
+	detach_ret = pthread_detach(new_th);
 
-	if (ret_val != EINVAL) {
-		printf("Test FAILED\n");
-		return PTS_FAIL;
+	if (sem_post(&gate) != 0) {
+		perror("sem_post()");
+		return PTS_UNRESOLVED;
 	}
 
-	ret_val = pthread_detach(new_th);
+	/* Both calls must fail with EINVAL. */
+	if (join_ret != EINVAL) {
+		printf("Test FAILED: pthread_join() returned '%s', expected EINVAL\n",
+		       strerror(join_ret));
+		return PTS_FAIL;
+	}
 
-	if (ret_val != EINVAL) {
-		printf("Test FAILED\n");
+	if (detach_ret != EINVAL) {
+		printf("Test FAILED: pthread_detach() returned '%s', expected EINVAL\n",
+		       strerror(detach_ret));
 		return PTS_FAIL;
 	}
 
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
