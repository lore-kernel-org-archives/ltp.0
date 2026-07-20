Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C38C44520
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784591843; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ct9A/N/YD6Gl4yCKIyO5FDqLhNaqAWwHZnohgtaj8YA=;
 b=Naf0ALX6qnHFll4krXs81PLuQpjr6GbKrVPg6V183Cmj8N63l5izuiUnJo3h9WvukwPCw
 XcB2m0Q7WLhFPAAbQsAVV3mzB93KGVNMmJL8d8wyBfsLGVyUbshqBOp1wiAUwUrhRKFrC9v
 3TwtIRa3n7HWl5oybme/8oqUyWQ/xmQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F9A83E961E
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 01:57:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D5963E239D
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 01:57:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 81C41600689
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 01:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784591817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YbdS63UrDxLAGZU4sBU6mdSKHl94RrMMPRTM7xbHos=;
 b=CiMfyO7lm9CVUYQuxKYNWl0ZHAHUxdheDjeymugBmqj3EBGZ3nV9bOgUC6wKTzAnOB4hzq
 U4wYlOJlj+3OCD4G9cP2nDoDg3eTEMI8eekGxAXmy/0XpQzOyavnuQ0WOHbDeVYiWzfUZv
 gDuS3VT1wTlDQad6rgycVs1oVJBbVf0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-va62H_zBOpaW1ZR1YHSfvg-1; Mon, 20 Jul 2026 19:56:56 -0400
X-MC-Unique: va62H_zBOpaW1ZR1YHSfvg-1
X-Mimecast-MFC-AGG-ID: va62H_zBOpaW1ZR1YHSfvg_1784591815
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0408254aso100622811cf.0
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784591815; x=1785196615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3YbdS63UrDxLAGZU4sBU6mdSKHl94RrMMPRTM7xbHos=;
 b=MDqDgDUXDKR7en7N/ZKDCJqxQtHrPxgp1XUwHt4gw3oGfEWgtLkzJBJ51V+AUFHVpW
 q0w4af+ea09FnzBXhIRhXbPEHQhLZ7aFU3r2ELZmCD1Rkzd/jSCJijk06DQRHt9UHJ88
 6UTj58bYXkiisavJ76bj3KF+EolKuKz/ZsQ2Ii6GJLAG3VYMOVkOOBFqRxUdyQZ0vN7S
 j3JvLc6zzP0trmay4WUYccMfOwtKeLeZBJ0ZG0Aj1v8bQZBVgd924UnVc73jtSt8zrya
 y9U0SgzwXsc/MmQN25gA7ie4lXR9AF95SQ6LzS2Upy4LFxwvLGu2Q8RCVCeVJ90WulqY
 nIrg==
X-Gm-Message-State: AOJu0YwH3uYaDmUrpynNzdpy6R+cSTlfYoEdO0+hqr/0TkxFVWyAuhuR
 kVll6iiPq+AM6N1lR76/r5S8eqktXZBJhALNbsEFQk8on396/OKgr2X/tanHpOFpPjWUy1XpSEG
 lKkDe947lFzvmHq2Eapbh/FSLquroZfToVZm7Wlo8yWTQlaJQBswetqiIdtVAIXmaXOH+AP5nSg
 yYTafPbIzmvJejArKK1KSsZN1uTBvpb2xyXfjA
X-Gm-Gg: AfdE7clASSjQzM2R8+9XennY/5T++Ei1+pE/UluX2UCGZfIkFNxVELPHoWevZZiDCZs
 CjVDR89x4/4YizySHNcXuTC+Fq6Efzd6ivBKGOBigyDgW43pjK3eWR/kYsvPYPdaetStkkxaY3i
 sCwmN1jSxebIwIvc9mpVZJ8FJY9q0rHMruvusFHTNwXcA1gQIAOUDbvsjmigNDCbPUmSELPhDBR
 H8Eqs2Y3iO2QOqo/tSLwt+CvNpenVznXV7nkTjNeBL9tzoEbJZX2SgeuIurZFb6oDpwZIHx8crM
 zaxE6xYWUht+XyieIG6oBPKCfczu2n3nIo/xcQBsRqtNARrxQi6k+Qr2THKt2IpHetMM8PlRZI0
 E/T55u3UNKAEAPzA4gwOuAC61lg==
X-Received: by 2002:a05:622a:307:b0:51c:7aa7:e0ef with SMTP id
 d75a77b69052e-5212c9eb5b3mr153624281cf.44.1784591814819; 
 Mon, 20 Jul 2026 16:56:54 -0700 (PDT)
X-Received: by 2002:a05:622a:307:b0:51c:7aa7:e0ef with SMTP id
 d75a77b69052e-5212c9eb5b3mr153624021cf.44.1784591814077; 
 Mon, 20 Jul 2026 16:56:54 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5214d095ed4sm82306741cf.10.2026.07.20.16.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:56:53 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 20 Jul 2026 19:56:47 -0400
Message-ID: <20260720235649.2783420-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720224936.2753334-1-sbertram@redhat.com>
References: <20260720224936.2753334-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YVPKoq6-AK7OKQxeVcgvWpMgLmhehqvZz5B6dw6ZEtI_1784591815
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] semctl01: tolerate SEM_STAT races under parallel
 LTP runs
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

When multiple LTP workers run IPC tests concurrently, SEM_STAT can fail
with EIDRM/EINVAL because the index from IPC_INFO can disappear before
SEM_STAT runs. Retry a few times instead of treating that as TBROK.

The test remains single-threaded; shared globals are intentional.

Test: ./kirk -w 4 -f syscalls_32 -p semctl01 -i 1000

Results summary before:
runtime:      997.690s
passed        415980
failed        0
broken        10
skipped       0
warnings      0

Results summary after:
runtime:      998.593s
passed        416000
failed        0
broken        0
skipped       0
warnings      0

Assisted-by: Cursor

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/semctl/semctl01.c | 84 +++++++++++++--------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..78b100455 100644
--- a/testcases/kernel/syscalls/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/semctl/semctl01.c
@@ -19,7 +19,6 @@
 #define SEMUN_CAST (union semun)
 
 static int sem_id = -1;
-static int sem_index;
 static struct semid_ds buf;
 static struct seminfo ipc_buf;
 static unsigned short array[PSEMS];
@@ -211,10 +210,8 @@ static void func_rmid(void)
 static void func_iinfo(int hidx)
 {
 	if (hidx >= 0) {
-		sem_index = hidx;
 		tst_res(TPASS, "the highest index is correct");
 	} else {
-		sem_index = 0;
 		tst_res(TFAIL, "the highest index is incorrect");
 	}
 }
@@ -236,28 +233,51 @@ static void func_sstat(int semidx)
 }
 
 static struct tcases {
-	int *semid;
 	int semnum;
 	int cmd;
 	void (*func_test) ();
 	union semun arg;
 	void (*func_setup) ();
 } tests[] = {
-	{&sem_id, 0, IPC_STAT, func_stat, SEMUN_CAST & buf, NULL},
-	{&sem_id, 0, IPC_SET, func_set, SEMUN_CAST & buf, set_setup},
-	{&sem_id, 0, GETALL, func_gall, SEMUN_CAST array, NULL},
-	{&sem_id, 4, GETNCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
-	{&sem_id, 2, GETPID, func_pid, SEMUN_CAST & buf, pid_setup},
-	{&sem_id, 2, GETVAL, func_gval, SEMUN_CAST & buf, NULL},
-	{&sem_id, 4, GETZCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
-	{&sem_id, 0, SETALL, func_sall, SEMUN_CAST array, sall_setup},
-	{&sem_id, 4, SETVAL, func_sval, SEMUN_CAST INCVAL, NULL},
-	{&sem_id, 0, IPC_INFO, func_iinfo, SEMUN_CAST & ipc_buf, NULL},
-	{&sem_id, 0, SEM_INFO, func_sinfo, SEMUN_CAST & ipc_buf, NULL},
-	{&sem_index, 0, SEM_STAT, func_sstat, SEMUN_CAST & buf, NULL},
-	{&sem_id, 0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
+	{0, IPC_STAT, func_stat, SEMUN_CAST & buf, NULL},
+	{0, IPC_SET, func_set, SEMUN_CAST & buf, set_setup},
+	{0, GETALL, func_gall, SEMUN_CAST array, NULL},
+	{4, GETNCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
+	{2, GETPID, func_pid, SEMUN_CAST & buf, pid_setup},
+	{2, GETVAL, func_gval, SEMUN_CAST & buf, NULL},
+	{4, GETZCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
+	{0, SETALL, func_sall, SEMUN_CAST array, sall_setup},
+	{4, SETVAL, func_sval, SEMUN_CAST INCVAL, NULL},
+	{0, IPC_INFO, func_iinfo, SEMUN_CAST & ipc_buf, NULL},
+	{0, SEM_INFO, func_sinfo, SEMUN_CAST & ipc_buf, NULL},
+	{0, SEM_STAT, func_sstat, SEMUN_CAST & buf, NULL},
+	{0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
 };
 
+/*
+ * SEM_STAT takes an ipc idr index. Under parallel IPC tests that index can
+ * vanish between IPC_INFO and SEM_STAT (EIDRM/EINVAL). Refresh and retry.
+ */
+static int do_sem_stat(union semun arg)
+{
+	int idx, rval;
+	unsigned int retries = 5;
+
+	do {
+		int info_id = 0;
+
+		idx = SAFE_SEMCTL(info_id, 0, IPC_INFO, (union semun)&ipc_buf);
+		rval = semctl(idx, 0, SEM_STAT, arg);
+		if (rval >= 0)
+			return rval;
+		if (errno != EIDRM && errno != EINVAL)
+			tst_brk(TBROK | TERRNO, "semctl(SEM_STAT)");
+	} while (--retries);
+
+	tst_brk(TBROK | TERRNO, "semctl(SEM_STAT) still failing after retries");
+	return -1;
+}
+
 static void verify_semctl(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
@@ -265,6 +285,7 @@ static void verify_semctl(unsigned int n)
 
 	if (sem_id == -1)
 		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
@@ -279,21 +300,24 @@ static void verify_semctl(unsigned int n)
 		}
 	}
 
-	rval = SAFE_SEMCTL(*(tc->semid), tc->semnum, tc->cmd, tc->arg);
-	switch (tc->cmd) {
-	case GETNCNT:
-	case GETZCNT:
-	case GETPID:
-	case GETVAL:
-	case IPC_INFO:
-	case SEM_STAT:
+	if (tc->cmd == SEM_STAT) {
+		rval = do_sem_stat(tc->arg);
 		tc->func_test(rval);
-		break;
-	default:
-		tc->func_test();
-		break;
+	} else {
+		rval = SAFE_SEMCTL(sem_id, tc->semnum, tc->cmd, tc->arg);
+		switch (tc->cmd) {
+		case GETNCNT:
+		case GETZCNT:
+		case GETPID:
+		case GETVAL:
+		case IPC_INFO:
+			tc->func_test(rval);
+			break;
+		default:
+			tc->func_test();
+			break;
+		}
 	}
-
 	if (tc->cmd == GETNCNT || tc->cmd == GETZCNT)
 		kill_all_children();
 }
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
