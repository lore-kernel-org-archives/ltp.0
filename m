Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67894CD3436
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778234490; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=q5JnMNnFQznBZ/6pZzgGSkWHigR5ew8YovWWq1jFE60=;
 b=hYOCLANPBIyDVIiNrpI8Ta7ScUzj7giP9TPH09ifwHfa1r7ammYH8JBm1KNycz8qfwMau
 iRKf1d00QrqLC6mbYqzHFEJ7O56632cwIqvePZrNOKAeYvk1334EsTYnOs8HrrojRzIehIe
 m6CZwd9wdwGEYsYPjh4tR8vo5c2XZKQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF6623C988E
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 12:01:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52D9A3C988E
 for <ltp@lists.linux.it>; Fri,  8 May 2026 12:01:06 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6753114001F4
 for <ltp@lists.linux.it>; Fri,  8 May 2026 12:01:05 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488d2079582so19979425e9.2
 for <ltp@lists.linux.it>; Fri, 08 May 2026 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778234464; x=1778839264; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/sV5w8DzIX5fEXvfEEKvIEUq5qAGKn3xwE7rbiSbs8Q=;
 b=L9ArVhfhVskFjZjv/ee/tuhdfQkOkiklJT1+Lp/oisDZDXTew1QOwUB/zXYnRt0a0g
 98PHWcRtGBEv933+E6MKdn6TFnQC2YSKdnNlq2APfw2Vcxm+biMONklU/HIEgHFX+g1m
 dXKgWytNAy1VhY2/wd4697wrKhKWN32QfAOb2fkWcV2P+6a1PHjiwzHJiJsmH3bMLXgm
 8OxVBcyKik9KbmRI3JexSzSWDh7oQwZSOhE94IdJQkeldnJi8Sb6AeADHyuj6OBNoQrs
 5DM5id2Xq3a1EtYNFctK6emoRxK/xfnJAjdFNKzb4lqwG4+iuLLHCtuGALlSE3bMm+mN
 8oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778234464; x=1778839264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sV5w8DzIX5fEXvfEEKvIEUq5qAGKn3xwE7rbiSbs8Q=;
 b=DWsQA27sSJiN0rqT/7QhvldL1p0mQZ7U7700jW+oDVszXO7wiLTbVRNciSpivt4p1Z
 JkwpkwbQfVtthwpdRnhy2Hrusr25vi7WAZIanfaesZTYgTb+kNA8iw0NMui1hiEhLFo6
 YFoTUDHNkgkyOQQh60klx2ntfUAJrSRafnWeaLQauzL85Cxn5UcB41WrDiytbcQQWoj1
 DAcAjdH1WzIfUn1Cd9JjBFiUZd8VB2C4lZQyWxLGkSdlBScxXvlZOx7I3ebisj9DgRXa
 v1Spgpqd2iALfkbmIVsuDrQ31CWF5dFQS3CjPYmltQ8TK7wBqNzpmrjN7Su59rrbhgrG
 hOfQ==
X-Gm-Message-State: AOJu0Yx1xSKW9W8mpzUuglBTYWSXJ3Plpx9jE2YSYO54Q9xMVvwH8pOJ
 6z05tro/HS012Z+h9wF1/kU54I/n2xY6PTjDkwS1EfNZiQ9CtveWfNn3ZaUvMm+nrHwhSlFQz9J
 jQ/k=
X-Gm-Gg: AeBDiesCMVnRsG7QTL3rrvL3JdZf4Hm7k+5uia2DJK/qV44l8Z6weZLb1rEaIAVISfL
 O3P1pcMgxlV2QtxOb2Bs6ngbogrjZkFmmEct+iNZ+T4STrPksaX0+WxcX7s5ruerQPXyommD70D
 uwIIdCk4ZxNpmZo5QXsIaKi848Uw8yriHGrZaxQREzYC51ho52I9Ez8niViSD4jjV44BEeO3y8g
 uolkSZMg/EIZ/WbGPGd8WeCxVMAX6FoozJSBWj2D9yHxu/nXLV2k0goHVRxEK7AoQiLvkxbLgu6
 olkpZml5os32K7dlP16sEVK9I5W8T7OehyTvyPIz+FP4TUQ9VGdVHbuFrFJVnS/seDBzu8uJVzN
 MuPOrO0hBzAfqPa50gCV3Wck5bEzUaYg+d+SOlrlZxka5ubV4eGqkGCFoIPNi3storO3DrTPw2s
 5pZtP37SU7uRo=
X-Received: by 2002:a05:600c:8011:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-48e51f3b589mr177683105e9.24.1778234464344; 
 Fri, 08 May 2026 03:01:04 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48e68ef0024sm29392585e9.14.2026.05.08.03.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 03:01:04 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri,  8 May 2026 10:00:58 +0000
Message-ID: <20260508100101.7741-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] pthread_detach/1-2: Fix race condition between
 thread exit and join
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

Latest test in our openqa setup(kernel 7.0.3) show following error:

FAILED: We were able to join a detached thread.

Add a second synchronization semaphore to ensure the child thread remains alive until
the main thread has completed its checks can make test case pass.

Signed-off-by: Wei Gao <wegao@suse.com>
---
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
