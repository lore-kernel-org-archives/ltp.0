Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283DCC54F55
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785336885; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4jcVR7XtbUUg2kY4ERC0/N5qvWITyEP1gA4jMTCPzqM=;
 b=qL/GdEl4jw/eM7xdsZKBnveT4M8bNAWWx6AseHj/ohaYbB9n1SpnFkueKTTixLbvpUliz
 RVyWAlCa+PzoJlJ95e4+5iuiVJOcI5QhQHNQcnqrUztCHLKXu6GJZ+lFLPVUEQBgjSikVGU
 brQNubSet2NucKlDh97nET+sSkTfkXs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 797DF3E6201
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 16:54:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 743053E138C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 16:54:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E43251A002D7
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 16:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785336861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0xhu1HZxL6d/jTfBG/S21CDxJ8mefhr3/WR163hBbo=;
 b=WCD4TdDWis7MxtGgap2c+XQMbPi2SR1fqLzN8FfRHxMk/qBnkGX+MlF+D2ve77+tXyDTv5
 kx8XCQa3WjSy7CYX43mgfZeYpF+rZMr9zchzMLVv9ayVwt9lpXobWHkgG7/Bw6YHPXHCoi
 Qh2X9Bk1HPxXTKLUMJkGLSY9l2DKRLw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-rnIUssjoMRKOSXsvjh0rlw-1; Wed, 29 Jul 2026 10:54:20 -0400
X-MC-Unique: rnIUssjoMRKOSXsvjh0rlw-1
X-Mimecast-MFC-AGG-ID: rnIUssjoMRKOSXsvjh0rlw_1785336859
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so8764361cf.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336859; x=1785941659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y0xhu1HZxL6d/jTfBG/S21CDxJ8mefhr3/WR163hBbo=;
 b=gVjY3qLBOwZiBIgxRQA1kX4+tiC3rfatgxi07IHDnVWVDQKGO7Hgb3XiXBxSYOYSb8
 pahcnpG8E4W4w3iolY29mb43a/iMo48biHlGNpJ3Ir/v3wEg6F5JAS49MLSNjG5tHkyi
 /zsnhytX3Ql+pqTNBGTCd4rMmdHRea+/TKWUZc1Ihme3SWxDo5ANzbsBO9EcpNguIuEy
 F5ObBIK9gW3TAPcKvci+8pUDW42c6Yw29EdywrlqByiGgxa7JTkDqkf1jReftMEZNhnj
 ZkVyT0L9pWHgo2iJkKFVd/CSJiBc5RY+whTNrfuymbeFElHLgqJ3KB+IsAL3TskrzWmQ
 LpDg==
X-Gm-Message-State: AOJu0Yz+cDKEEtNUCW7lZr58/p4M7VUg5Xs8GGC8g6Y0DvLZRfJKoVJs
 7H2GHlO/ErCUO3qNumzZCdm056IN7DCA8k1HvFGoZV1JGLZzyokUvYsHHH4F9haW6oqmwzgJRBV
 j5114V51YC2jNx5yBFCnrUyrHe//uvYXy11f2Op5IP70c7mAtINoqp07KQW9/re18LXHaszGDvQ
 jnVNdzJUEEK5CsrgOn5B1rruudoBSJacPClDqm
X-Gm-Gg: AR+sD11RkIuh4WUzJmKJO/YnrvcI8XGZkkt/52pN+t3so7Nx/4j5zOCRXNcQHl+OETd
 12qNy13AfsCfUtgd/w+qYSTG9RT4gwVqnG4m4LMMKJqybO1V7LO+2oqrCEMmoxt4Ca9L9yk8v0B
 scFTuTzbFbpxMFvwa9ojImMfikwZn6diR8zZQ/lFhuj45rQtWA+0sRyyZC8/+FButzkQTbEJ3Pa
 hNy2ahOp1wB3prqmNpiQDB31P9faLiCWBk7/1yaXYoF61QAakR0jSATkpPlpxlWdB91gWW6Vxjr
 pl24csPd4/mXs9CexD8d4iOUuTtQ7b5doTNDjZiFJF1biMPZYR36hTmJ3gy1UlS5Ozv5sYrd0Cd
 9A9xiOoL5xHZB6M8EDThSweTgHA==
X-Received: by 2002:ac8:7c42:0:b0:51c:7b13:6300 with SMTP id
 d75a77b69052e-529d719d02bmr57750391cf.86.1785336859382; 
 Wed, 29 Jul 2026 07:54:19 -0700 (PDT)
X-Received: by 2002:ac8:7c42:0:b0:51c:7b13:6300 with SMTP id
 d75a77b69052e-529d719d02bmr57750101cf.86.1785336858834; 
 Wed, 29 Jul 2026 07:54:18 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2b1a203sm20570591cf.1.2026.07.29.07.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:54:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 10:53:17 -0400
Message-ID: <20260729145321.4115712-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728203333.3949671-1-sbertram@redhat.com>
References: <20260728203333.3949671-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pRaK8QXZRdpUQj896vnJk_LKgqJasaUPn72yqTBW9Ks_1785336859
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] semctl01: fix SEM_STAT failures under parallel LTP
 runs
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>, fdarocha@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SEM_STAT was using the global high index from IPC_INFO, which is not
stable when other IPC tests run in parallel and can abort the test with
TBROK.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
Test: ./kirk -w 4 -f syscalls_32 -p semctl01 -i 1000

Before changes:
Total runs:  32000
Runtime:    16m 32s
Passed:     415968
Failed:     0
Skipped:    0
Broken:     16
Warnings:   0

After changes:
Total runs:  32000
Runtime:    16m 34s
Passed:     416000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

Assisted-by: Cursor

 testcases/kernel/syscalls/semctl/semctl01.c | 40 ++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..151061995 100644
--- a/testcases/kernel/syscalls/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/semctl/semctl01.c
@@ -210,13 +210,10 @@ static void func_rmid(void)
 
 static void func_iinfo(int hidx)
 {
-	if (hidx >= 0) {
-		sem_index = hidx;
+	if (hidx >= 0)
 		tst_res(TPASS, "the highest index is correct");
-	} else {
-		sem_index = 0;
+	else
 		tst_res(TFAIL, "the highest index is incorrect");
-	}
 }
 
 static void func_sinfo(void)
@@ -229,10 +226,10 @@ static void func_sinfo(void)
 
 static void func_sstat(int semidx)
 {
-	if (semidx >= 0)
+	if (semidx == sem_id)
 		tst_res(TPASS, "id of the semaphore set is correct");
 	else
-		tst_res(TFAIL, "id of the semaphore set is incorrect");
+		tst_res(TFAIL, "expected sem_id %d, got %d", sem_id, semidx);
 }
 
 static struct tcases {
@@ -258,13 +255,40 @@ static struct tcases {
 	{&sem_id, 0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
 };
 
+/*
+ * SEM_STAT takes an index into the kernel's internal array, not a semid.
+ * Return the index that maps to this test's set.
+ */
+static int get_sem_idx_from_id(int id)
+{
+	struct seminfo info;
+	struct semid_ds dummy_ds;
+	union semun arg;
+	int max_idx, i;
+
+	arg.__buf = &info;
+	max_idx = SAFE_SEMCTL(id, 0, SEM_INFO, arg);
+
+	arg.buf = &dummy_ds;
+	for (i = 0; i <= max_idx; i++) {
+		if (semctl(i, 0, SEM_STAT, arg) == id)
+			return i;
+	}
+
+	return -1;
+}
+
 static void verify_semctl(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
 	int rval;
 
-	if (sem_id == -1)
+	if (sem_id == -1) {
 		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+		sem_index = get_sem_idx_from_id(sem_id);
+		if (sem_index < 0)
+			tst_brk(TBROK, "Failed to get sem_id to idx mapping");
+	}
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
