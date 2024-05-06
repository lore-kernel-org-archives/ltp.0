Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48608C25B4F
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 19:04:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3DCB3CD970
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 21:04:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307053CB7BC
 for <ltp@lists.linux.it>; Mon,  6 May 2024 21:03:53 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7AA67140FB35
 for <ltp@lists.linux.it>; Mon,  6 May 2024 21:03:53 +0200 (CEST)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f44bcbaae7so1760571b3a.2
 for <ltp@lists.linux.it>; Mon, 06 May 2024 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715022231; x=1715627031; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jLuzzTsCnvYiZrslxaSVNQq/auaMXvnphd6qse1U8Yg=;
 b=Gg1ZaEuFkM7yaOQPkALLEydmXErcg8Ryr6k3VrIgQuuojrhmNymqCBXB6zvEMv5OAq
 f1JHuScQXOx4Eu38VD17NkVT2eS5T7j3jrwH2CIfKTuBSNOIVRDdVnUFe3l+MSyJtlqi
 5CEuCZXkjhp3sr5BrdlGXXd7orggtLXvELRk4xOvoxXzvOOKn/WL/X6mEE8apq86w7Oa
 PY1DN1UMxgWaYvwXvq+EByDJ4c4Q8evn9yd5KIYWwlElhR2KcM2h7XRMq8Y03fs5tejt
 Nj9PuXaS1twIX1eX7B7S1Hw7cNVZEiqZd5oCK9IOLqg9cfafV9j9x/mHkGn8HkFHyvzl
 57Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715022231; x=1715627031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLuzzTsCnvYiZrslxaSVNQq/auaMXvnphd6qse1U8Yg=;
 b=lnHHHQH8immy5GAtScOHKp2OPRjgga9BqgScGbSMxUAtAj/ZHjiz72/VaYyxmZIZbs
 dskoSja9hBpyegxY9MQs2/ixyDeB5PcK4xLMXfrplC0G/IkSdhY96f5aRcM1CR9EduGV
 voBzt99wHekjKghovea9pSXtzn8W54fWOb1x/j3I9KbneLQp5BfWvydF0cB64CGf1qjj
 TToqkOrGJep8sXliCMfJ6Gf/m2hFfUiOkSFkjoyJuoZeEXI2ta9DG5uMn1lIyD2dujW9
 OwZND4CmSeqeWYomNKHaUCgG8/QKTSrOZXj9jBykgyk8ynb2kvdeaWrXbypcJycX9zMP
 BT1w==
X-Gm-Message-State: AOJu0Yx78CQEg8DMNNzhsJ2d6YJ7VFtNaHK1L53buAVCjusjo2/q2pVj
 UDk7TXl0cEc81m5MWZyhMYs0Ey31y22ndPrvK++deJo7IQ4SZBJRP+oU7SQG
X-Google-Smtp-Source: AGHT+IG1usVmLsMmz67aHZUepeaSfM+JdAxQTMtnwWYVyXjvrd/u9vjRG1Zttl7bnkL1hhOuHNv9cg==
X-Received: by 2002:a05:6a00:1a8d:b0:6f3:f30a:19b with SMTP id
 e13-20020a056a001a8d00b006f3f30a019bmr10519893pfv.18.1715022231284; 
 Mon, 06 May 2024 12:03:51 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::cf93])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a63df4b000000b005f807af5156sm8457010pgj.41.2024.05.06.12.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 12:03:51 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  6 May 2024 12:03:48 -0700
Message-ID: <20240506190348.1448707-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched_stress: Use time_t instead of long for type
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
Cc: Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This ensures it works across different architectures
Fixes

| sched_driver.c:744:43: error: passing argument 1 of 'ctime' from incompatible pointer type [-Wincompatible-pointer-types]
|   744 |         printf("\nend time = %s\n", ctime(&end_time));
|       |                                           ^~~~~~~~~

With gcc-14

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/sched/sched_stress/sched_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/sched/sched_stress/sched_driver.c b/testcases/kernel/sched/sched_stress/sched_driver.c
index 61573d788..5b8c187fe 100644
--- a/testcases/kernel/sched/sched_stress/sched_driver.c
+++ b/testcases/kernel/sched/sched_stress/sched_driver.c
@@ -136,7 +136,7 @@ int debug = 0;
 /*
  * Function prototypes
  */
-void startup(long);
+void startup(time_t);
 int start_testcase(char *, char *, char *, char *, char *, char *);
 int process_slots_in_use();
 int available_user_process_slots();
@@ -251,7 +251,7 @@ int main(int argc, char **argv)
  * information to the screen and .  It also initializes the	 *
  * process id list and other global variables.	 			 *
  *-----------------------------------------------------------------------*/
-void startup(long start_time)
+void startup(time_t start_time)
 {
 	char tempbuffer[50];	/* temporary buffer to hold names */
 
@@ -734,7 +734,7 @@ void kill_short_term_testcases()
 void finishup(start_time)
 long start_time;		/* starting time to calculate elapsed time */
 {
-	long end_time;		/* time when program finished */
+	time_t end_time;		/* time when program finished */
 
 	/*
 	 * Get the end time and calculate elapsed time; write all this out
-- 
2.45.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
