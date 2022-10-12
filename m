Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4358C433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 14:49:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CA7B3CAEB2
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 16:49:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DB603CAEC8
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:48:41 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B20116002CE
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:48:40 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 e10-20020a17090301ca00b00183d123e2a5so3066085plh.14
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Svf1RTHGXkUzI2Tdqrp1OahkjDeJrUYWslayTjldAI4=;
 b=rotHseIGrXk63WFzQDIjczCuZycc8i0orpG2CjlJwhUeLpAXv+Rlih6VX5IxATOyH8
 aiKNmwR/DJix71uhyfxMR8pbLCZX5I1zw+A1+l3INbTm2dUMfOYt8rrCl5sGTpEgdjWr
 kViJOw6mmVKB5iFLH+CzRZMDnT0lRMi3EnCJN0uoAXKCsajgEWMv5Z8Tyoqnnm7yZiXX
 my6gpX3YrhIuW2AY3ao3mWJGWNV4vtS/jaOTAmd7G1ddTXNLVdAhhFLAFThG/mJJEI2o
 JdD3eFEVXC6GKMjW8xH5JZcKbRA3IEK4V2sPhl9CGRM1nMklOoGijKVrKDHPjIM7FT98
 hILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Svf1RTHGXkUzI2Tdqrp1OahkjDeJrUYWslayTjldAI4=;
 b=A29YFyAO8icLlcxOQRwL+5Xrdda98NDyfUeRnXE96CZeX9941M4vzlOuYg9M7SVMmI
 oWPboBopHuOywm6HG5isTWPkjOFFlMjSTHjAWpgPaLX0qrgBgQII/RBVQdR9cPO+0sKV
 QuBX/uPGTLKgXzz5XZGQY7BN6gqP59wO+iDxor/Nt0dOuSwPFQyWtlzbAByQp9RHm279
 5UNRECV1X9Jzge7FqfV4C9kzpVlONh0rFq85jiW/cxEhnNv1ITUChImDKsJg1LgvEstw
 73ibBbIyBe7L+0zlLuQRkBOd4oOpYqZKWv8K+AzKJ8pbx37TKW1/m68UhuRoGN+HJHJc
 tWaw==
X-Gm-Message-State: ACrzQf0+yKPwzVpnlAtV7bNivOouWBl76jQyJzjYi60kcBZurfX0a6ml
 ZWKl/iaO4bPFGKUVYv5HQesKJyYqRjTkZbFFm8YzsHm2YyRaTdhAyLs0iSg6oyqzD+LtjsNbciB
 UGSrtsSwrv/LLm4VTC4CDHgIdGZMU62hG8+pE6wkTmV04aPi/H/rkqAfC
X-Google-Smtp-Source: AMsMyM5NkxvBIASbnBC+S0cnvkfAIGeigAhRaPcIgEyUjT9mXiEkFZpPYBI2xG0tnv0iISNwayNrO3Minww=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1ac6:b0:548:962b:4c50 with SMTP id
 f6-20020a056a001ac600b00548962b4c50mr30843300pfv.76.1665586119153; Wed, 12
 Oct 2022 07:48:39 -0700 (PDT)
Date: Wed, 12 Oct 2022 14:48:22 +0000
In-Reply-To: <20221012144823.1595671-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221012144823.1595671-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012144823.1595671-5-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/5] mmapstress01: remove unnecessary pidarray
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/mem/mmapstress/mmapstress01.c      | 25 ++++---------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index ea818ffcd..de7da5b99 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -62,7 +62,7 @@ static char *opt_sparseoffset;
 static char *randloops;
 
 static int fd;
-static int finished;
+static volatile int finished;
 static int nprocs = 20;
 static long long filesize = 4096;
 static long long sparseoffset;
@@ -273,7 +273,6 @@ static void run(void)
 	int wait_stat;
 	off_t bytes_left;
 	pid_t pid;
-	pid_t *pidarray = NULL;
 	sigset_t set_mask;
 	size_t write_cnt;
 	struct sigaction sa;
@@ -289,6 +288,7 @@ static void run(void)
 	 * Plan for death by signal or alarm.
 	 * Also catch and cleanup with SIGINT.
 	 */
+	finished = 0;
 	sa.sa_handler = sighandler;
 	sa.sa_flags = 0;
 	SAFE_SIGEMPTYSET(&sa.sa_mask);
@@ -302,10 +302,6 @@ static void run(void)
 	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664);
 
 	buf = SAFE_MALLOC(pagesize);
-	pidarray = SAFE_MALLOC(nprocs * sizeof(pid_t));
-
-	for (i = 0; i < nprocs; i++)
-		*(pidarray + i) = 0;
 
 	for (i = 0, data = 0; i < (int)pagesize; i++) {
 		*(buf + i) = (data + pattern) & 0xff;
@@ -321,13 +317,11 @@ static void run(void)
 
 	/* Fork off mmap children. */
 	for (procno = 0; procno < nprocs; procno++) {
-		switch (pid = SAFE_FORK()) {
-		case 0:
+		pid = SAFE_FORK();
+
+		if (pid == 0) {
 			child_mapper(TEST_FILE, (unsigned int)procno, (unsigned int)nprocs);
 			exit(0);
-
-		default:
-			pidarray[procno] = pid;
 		}
 	}
 
@@ -353,19 +347,10 @@ static void run(void)
 			    || WEXITSTATUS(wait_stat) != 0)
 				tst_brk(TBROK, "child exit with err <x%x>",
 					wait_stat);
-			for (i = 0; i < nprocs; i++)
-				if (pid == pidarray[i])
-					break;
-			if (i == nprocs)
-				tst_brk(TBROK, "unknown child pid %d, <x%x>",
-					pid, wait_stat);
-
 			pid = SAFE_FORK();
 			if (pid == 0) {	/* child */
 				child_mapper(TEST_FILE, (unsigned int)i, (unsigned int)nprocs);
 				exit(0);
-			} else {
-				pidarray[i] = pid;
 			}
 		} else {
 			/*
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
