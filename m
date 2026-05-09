Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A418CD343F
	for <ltp@archiver.kernel.org>; Sat,  9 May 2026 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778312388; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=JmLWg7TGwyxFnK1240Na3OcEvcc5PDylEbxQenqmEl0=;
 b=N1uqczT/fKMKYLI/cUSOKqjdU5YaHkiMGuM2mx4rzzEqAsFEPNyKa50119rkwd/NiAWpD
 mOj6/d8lc5BzeNxZZKJ0clZP03RPw7qeAeGOyb7yjkUlj7lAGBcAJ3KOYPJskIvO8Zh5W6T
 oRmrYE0m/bjI3zFztD4ndmImBprKjDs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC7693E2C0F
	for <ltp@archiver.kernel.org>; Sat,  9 May 2026 09:39:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC6FC3C4BEF
 for <ltp@lists.linux.it>; Sat,  9 May 2026 09:39:24 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 359E2600688
 for <ltp@lists.linux.it>; Sat,  9 May 2026 09:39:24 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso25430375e9.2
 for <ltp@lists.linux.it>; Sat, 09 May 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778312363; x=1778917163; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBDhpBQpJue5GhCEeb1U4Bd4Cpj3oDcIaGfVCUVYYpA=;
 b=aLIoRMtLVY/LOUPsdU+SGeZ3EudbK+ucR5VUd5MAaeUD4AjrnIWD8fqiMeL7j60J16
 dZDucG+Zf8AtV0M++9lwOxjTl8Q/Tjj6MO/BWDI5FhSH80B2/BnZSxIjkLYLCE/bRYXV
 XrzHrCvJKHlkW3A7rsHg0PkDOaJUwLZNDwEM0mM+zVP+hEZ84MMRBv0IIgPCMAb51+ZZ
 LJ6buK/nbgPUmQXykgnInlyrxHQkV9/lRjC7eVgfb2e2IT1AtmTpBJtbz4K1finreha9
 /s5ye4A4XUOttedr/6tENg6/RmLfK25JgOVgdctPiogFP+kldA/P7Smwuztl3FxBOrtS
 Mz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778312363; x=1778917163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SBDhpBQpJue5GhCEeb1U4Bd4Cpj3oDcIaGfVCUVYYpA=;
 b=aUTzHvnTm0rHOMwlCtiuIwKKYuCH5l7Yn+htxTsBk1sLZY+YnXnGY/hERvjxp6Xntx
 FCP/KKFc3qo6zaLvTJXqLWOPjV6GcQQRmMvAmZNB7HuZD1dtEZo6Cyrg8x5Gap3yKd2Q
 xHocbDKge87EkbNXksGpWo5FhvlEzfWY0TDIv+veAIBI6DthYINdqhpbMV24AM5M6K/D
 4UBd8CvpOG4IV/zg8wqUtVvyxVs8h9fA4qrU12n0IISuZWP06KPfTetTwmFFxGUCilb8
 ak0w78nFAbraBYUSF0djfqvCQck0yJeNWhp4NyxcgwR2wGhgPjbFdpXDVa1IgHxcx8j7
 24hQ==
X-Gm-Message-State: AOJu0YzpOTA/rEDJqU6Jy5WmahLvZOOZKJt+8lNUrL2iq+9QFRKKBrk7
 jLAF0UtdFjnpa4pcYOGxI97HUfqqwBE3k7AIlsBSOs2VTWb44Q62tQzuXRrsYJUaVZ4UaXJcqJJ
 vdng=
X-Gm-Gg: AeBDietxvm1rgBQpRHrxP0R+9WdjzdFpwk0xVFFhM6h03yoH+cDZJkuTgFmr0TdXrtc
 LkQN6xfY2Si4NCQVWMaC4veRhgSfE+oVEV6KASn/hQjLH+9pYmDVNbda+HB6zqmNbecLSi9hI0Y
 +2pViCJAwkQHvxc79UHIJAAHGDmhUjAYHMbZCDZTxZhy6wzSRip2btLN3vlxlhNfJAA2vR2Rz+R
 kc1JU7Qa1NRlXlcuIVE/6tpG9Put27M3wqSaHB59jCeHLKeGMfLaVwcLpsrfpp9CdM7iWG2RN0V
 dD2OhNI1OIraJsAUYgBTeyU0g4PtDXXA3ftBBR+c4gZ7KVpjvvh9OTrBtuRR3pZ+5Agxiu+AmbH
 BBnvJ9eFeM5SdCG0Q+krq1CQ4zd4ZUpJT9eugwvUgKz2pQDYYfFwttN8247py1tTLLBhqJS1+mO
 tvsI8xCwTWnL+bgkjHvZ4l/g==
X-Received: by 2002:a05:600c:150c:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48e70691668mr11868695e9.8.1778312363243; 
 Sat, 09 May 2026 00:39:23 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48e6db0ec25sm17165955e9.24.2026.05.09.00.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 00:39:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  9 May 2026 07:39:13 +0000
Message-ID: <20260509073921.8487-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508100101.7741-1-wegao@suse.com>
References: <20260508100101.7741-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] pthread_detach_1-2: Fix failure on modern glibc
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Latest test in our openqa setup (Linux 7.1-rc2, Glibc 2.43) show following error:
Test FAILED: We were able to join a detached thread.

This is triggered by glibc commit 5da15b15adab661c80e373b6af89be0b5fa5b3ad
("nptl: Do not use pthread set_tid_address as state synchronization (BZ #19951)").

New logic remove the logic of check whether valid thread handle in __pthread_clockjoin_ex().
-  /* Make sure the descriptor is valid.  */
-  if (INVALID_NOT_TERMINATED_TD_P (pd))
-    /* Not a valid thread handle.  */
-    return ESRCH;

So add a second synchronization semaphore to ensure the child thread remains
alive until the main thread has completed its checks. This forces glibc
to see the THREAD_STATE_DETACHED status and correctly return EINVAL.

Signed-off-by: Wei Gao <wegao@suse.com>
---
v1->v2:
- Update commit message for root cause detail

 .../interfaces/pthread_detach/1-2.c           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/1-2.c
index dc5ed39d3..1a9650f49 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/1-2.c
@@ -92,6 +92,7 @@
 /********************************************************************************************/
 
 static unsigned int sc;
+static sem_t sem_exit;
 
 static void *threaded(void *arg)
 {
@@ -113,6 +114,15 @@ static void *threaded(void *arg)
 		UNRESOLVED(errno, "Failed to post the semaphore");
 	}
 
+	/* Wait for the main thread to allow exit */
+	do {
+		ret = sem_wait(&sem_exit);
+	}
+	while ((ret == -1) && (errno == EINTR));
+	if (ret == -1) {
+		UNRESOLVED(errno, "Failed to wait for the exit semaphore");
+	}
+
 	return arg;
 }
 
@@ -125,6 +135,11 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 	scenar_init();
 
+	ret = sem_init(&sem_exit, 0, 0);
+	if (ret != 0) {
+		UNRESOLVED(errno, "Failed to init the exit semaphore");
+	}
+
 	for (sc = 0; sc < NSCENAR; sc++) {
 #if VERBOSE > 0
 		output("-----\n");
@@ -202,11 +217,21 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 				    ("We were able to join a detached thread.");
 			}
 
+			/* Allow the thread to exit */
+			do {
+				ret = sem_post(&sem_exit);
+			}
+			while ((ret == -1) && (errno == EINTR));
+			if (ret == -1) {
+				UNRESOLVED(errno, "Failed to post the exit semaphore");
+			}
+
 			/* Let the thread an additionnal row to cleanup */
 			sched_yield();
 		}
 	}
 
+	sem_destroy(&sem_exit);
 	scenar_fini();
 #if VERBOSE > 0
 	output("-----\n");
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
