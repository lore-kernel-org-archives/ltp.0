Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63ADC54F4D
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785255881; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZAwwEJY+gyVQkRPe7BWWXyxezY20V64YCgUb14eNC58=;
 b=gyzFe1EwWkoK19NCBpgS8UPm1BVGy3y8MJYfa/UXY8Xafgc1S9aV/KyN5ctovO6kFvkif
 e3KC9Y4ifF7iBkHtVv/Zolie1Hgd/DbNRCIq5PeNA/f8hetMBq8b+n5CMd5l7/TptMAzSF0
 T9Gke7wkL+z2+DdtnwUMU+hjUm6l7ps=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17ECE3E7484
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 18:24:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A834C3E2AC7
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 18:24:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D97C5140024B
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 18:24:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785255857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u72MoEVhyfu/7nftJ/T8L3Vm8NMgMFkg1aadmCNMKds=;
 b=YqkHARSrU7vKLpwCiIdGe+jIe91q4A9TyoPKjV6cfP+P+a+WLTqrkmPzwCvolC6DExeKSo
 z9JnvRB6Vc+rIaG+kW0E7esAFw5oPQ2s9NbHepv7QsJ5bgQmywDlQCaqVsXeQ+9exAO1ho
 7zi/7J92oeYH7WXSthw5cqFDi31QnDQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-8LTG-3NAPQOkqtQ7hfy27g-1; Tue, 28 Jul 2026 12:24:16 -0400
X-MC-Unique: 8LTG-3NAPQOkqtQ7hfy27g-1
X-Mimecast-MFC-AGG-ID: 8LTG-3NAPQOkqtQ7hfy27g_1785255855
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e695a3b28so133019385a.1
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 09:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255855; x=1785860655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u72MoEVhyfu/7nftJ/T8L3Vm8NMgMFkg1aadmCNMKds=;
 b=Dk/c/iOpVrIQSRBq5MuBWHuysh/gmORzRnci9bSyN4gBrxGpaRnWbzun8r2JTPV0W9
 aKCHlXdCrMrDUMcoaayP/KXikhaGOszucD3BiafvwNlYPj2WdoMRCb6rlrCe/fNi40MN
 lB6XxL7e8W32s+W3ZfExPJGlHg68Pp1n0oFvSzR8j/MwUJvOh5jIPTlvLxl/a74hGSQj
 CfIjFAyMNliKwkurNhRlkyJIVpO4c+x9EpO7yH5K1bfhNRJHIbyBuFW+68ccypS17UCD
 2ikvDiUFirYB2OHgy9FxvNhTmMSHr1lOI9VIG6K/wRVuKjiGF0avEJCl6DpMnr3wadRH
 iVxg==
X-Gm-Message-State: AOJu0YxBDQldaiKVrZTiIc65Y60gyQt4yySGkmm7a4QtwcZia2AhUZH5
 MbEjrktcXqsITCAM1dZjRblUYsBHjE1dNch4N91OJCa+UXWWFgG9wDj73D4iFfrKeJnRv+CtBk8
 K4E+2kErPNQw8XN7E+lm8Z/dOus7lWULq2cK+yGrrqxPa1Vi4nkJ4EMa6q5OZEiOuLOQnsDO7cr
 NbWI33wiiQ2UxGs5yQRVmdhYRsRu5kLCQXMuDO
X-Gm-Gg: AR+sD10V7plruABtetd7g0EWVLVQDI8Mi7xsR6R8JnxAR5Q/WnX5d7JFt0vRddrsOSw
 ZWdDSRERBLFZJaX2MvmHbMrgwvTcER3Eiz18Nd1hGs2TVVgMMH1AXkFUlxgHIZvdTQgvsq+UvIi
 fSLeBHP3D9m/uyDII069ao0uiGy9DPmIBmIKMOs96am0Q+SYDiz9Jr4bVwGyrKhTR/8tziV4vGS
 7eprkmMmfW5i+jvyRmctcpraEBHuHZoEVJj/D61OQ5FqrgQiCuGkwZGL5uhnXWOXst8BSsIODR3
 oYlTh0luqu3GVjE6l1SAKok6Xflm0Lv5YE+K4JDiE2e5eWyMKKrh/8MS0tXTUol+xPCW6vwuEdY
 5nT0FpnMeIW31MNJ0NW6zR4dHVQ==
X-Received: by 2002:a05:620a:2785:b0:92e:5949:3567 with SMTP id
 af79cd13be357-93302636822mr294728385a.14.1785255855177; 
 Tue, 28 Jul 2026 09:24:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2785:b0:92e:5949:3567 with SMTP id
 af79cd13be357-93302636822mr294724285a.14.1785255854611; 
 Tue, 28 Jul 2026 09:24:14 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de635f6csm866784885a.26.2026.07.28.09.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 09:24:13 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 28 Jul 2026 12:23:50 -0400
Message-ID: <20260728162351.3845090-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721135530.2882066-1-sbertram@redhat.com>
References: <20260721135530.2882066-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EKCPWS0ItH-49ICUG6xQv4yKT84f9S2E8Sq66cg9BzQ_1785255855
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] semctl01: tolerate SEM_STAT races under parallel
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

Test: ./kirk -w 4 -f syscalls_8 -p semctl01 -i 1000

Results summary before:
Total runs:  8000
Runtime:    4m 8s
Passed:     103994
Failed:     0
Skipped:    0
Broken:     3
Warnings:   0

Results summary after:
Total runs:  8000
Runtime:    4m 8s
Passed:     104000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

Assisted-by: Cursor

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/semctl/semctl01.c | 96 ++++++++++++++-------
 1 file changed, 66 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..1aa1e0a58 100644
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
@@ -236,28 +233,63 @@ static void func_sstat(int semidx)
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
 
+static int try_sem_stat(union semun *arg)
+{
+	int info_id = 0;
+	int idx;
+
+	idx = SAFE_SEMCTL(info_id, 0, IPC_INFO, (union semun)&ipc_buf);
+	return semctl(idx, 0, SEM_STAT, *arg);
+}
+
+static int sem_stat_succeeded(int ret)
+{
+	if (ret >= 0)
+		return 1;
+
+	if (errno != EIDRM && errno != EINVAL)
+		tst_brk(TBROK | TERRNO, "semctl(SEM_STAT)");
+
+	return 0;
+}
+
+/*
+ * SEM_STAT takes an ipc idr index. Under parallel IPC tests that index can
+ * vanish between IPC_INFO and SEM_STAT (EIDRM/EINVAL). Refresh and retry.
+ */
+static int do_sem_stat(union semun arg)
+{
+	int ret;
+
+	ret = TST_RETRY_FUNC(try_sem_stat(&arg), sem_stat_succeeded);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO,
+			"semctl(SEM_STAT) still failing after retries");
+
+	return ret;
+}
+
 static void verify_semctl(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
@@ -265,6 +297,7 @@ static void verify_semctl(unsigned int n)
 
 	if (sem_id == -1)
 		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
@@ -279,21 +312,24 @@ static void verify_semctl(unsigned int n)
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
