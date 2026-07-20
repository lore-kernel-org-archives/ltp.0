Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED953C44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784587809; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tAN5sNCyUT+BzOCntxxREtGMwfw8caVx6XiPO4JplUg=;
 b=GGdkVK2Yc73+uP0Frimkgd2ra2QvvXcQ73c0zoBYiZy2ZvFvZUgObqHSvhBgslU7I1GCH
 X2WwhggQzhIReF3JSVmJBY17KEUdONcHxUSiX0GkDMBtkGklEpdxs4K9/WPxdwtU1Osok3s
 oBDWrzdXJviSD5supgm01nJlhD6q7IY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24CED3E961F
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 00:50:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C4F43E1C66
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:49:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9ABA91A001D6
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784587785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PR41dhXFax7pUsuk1XpWjIpwlB0dpojZjJ1vfJbXG8=;
 b=afNPR5cH1ID2Xrcyk5sryYbQ5Q+6sUnoUnhcmcD8LhskYAJr/xeD5RDP4SUdeRDZRMoq9I
 VYOGatYMbGFDGt0qI+p0rNnk5pmfN6KcaD02faCyZH3+tG9GnHkEoyv7vu0ahWUbQYylUT
 1K3u3RfqIEswKtmA2N4CCzyVlYnOKhg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-RF_zQ7mAOqGE5AETzJVeoA-1; Mon, 20 Jul 2026 18:49:43 -0400
X-MC-Unique: RF_zQ7mAOqGE5AETzJVeoA-1
X-Mimecast-MFC-AGG-ID: RF_zQ7mAOqGE5AETzJVeoA_1784587783
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f45dde7595so85869846d6.3
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 15:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784587783; x=1785192583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8PR41dhXFax7pUsuk1XpWjIpwlB0dpojZjJ1vfJbXG8=;
 b=fBIQU3BA7Ziu1z6Kd2L8pDWHo682pOHRzvWR5MK9i65CK5RhaYUKTxawnUNlVHSBau
 SHhzBdwO92hF7u1kcTVdN1aBPQ9wDa7NltUrQIOPgCgdCI5wbt35rTYSBBq/pQecxxNo
 oKSJSS33SBgCLoFgzajBGprSpVcwLJVg1G7ZAHWmGN7/erxTxU8IRWsy71RkJsaKKv00
 Wu/bMPQI7LkC9YblBenb2bG1q3W8TgbJcySJLKKGwfdHQ2LZ+Zb/BZ1yxfSxhg5sHyqH
 GV7IG6UEOpdpt/yPqA+BTr62D28VbZhCgvYernRIQ3wdGkmBxZG4Tw07k/L13U1ZN66P
 coEA==
X-Gm-Message-State: AOJu0YwbUDVqF5z5I+i0yUzHbN7TdHf99yryf6yyraOb5EW/oZ+oXrnU
 isSYDn5ejpjfEPqXMoXgHgGfzlLBmdAuGbqXjE7CgciI3K3MLkU/Zr0x5jXFzhabumVHB/kMER1
 OZSUo+C0p10yOShgE4x8obUb3N3x08yySfMtWbMM4EyVaiKsmLdYe93+joMW0J3UscpD7Gh5wJg
 WnC3ZNac4ZCdHokpXmReqCEKJAs1qeEUwXNkIp
X-Gm-Gg: AR+sD13eMWNOtQq3ggH32flvUgkWUVucMe18D8+dyNCv3ENtlJr4UW0cfZ+xup7geM7
 On/Tyj2NtNQHnok/Dq8BddMZS/IG+j4wg/xQWEL4lRNjEChv1r2Tkrg/GAtx23Xy6qhJv0mJtu9
 fZYaWLcdcTtwo0D4eGLuwitnhoH9vsnOT/HxzqvXz/mr6xS9mcIg+R63UWQAdoU4aB4KGB9EXfT
 NEBHrP5f/JMzXQSe+WFtmMtO0kPDJMjFeQidteIHQY4C250o1Z56IV0aXNCnAe+oFCKZfsJjKMT
 ja1vSOk7A8bmxHBVh4QBhjGjI7IAhZY73CdFf2d9f8zdBF9q2lwV5xVsZcAO7ogdUKDxdmOcffO
 RRe29bLMhO8k4CM21ogqxXDjSGQ==
X-Received: by 2002:a05:6214:c2b:b0:8ff:60dc:d41c with SMTP id
 6a1803df08f44-907783cff15mr175038166d6.52.1784587783093; 
 Mon, 20 Jul 2026 15:49:43 -0700 (PDT)
X-Received: by 2002:a05:6214:c2b:b0:8ff:60dc:d41c with SMTP id
 6a1803df08f44-907783cff15mr175037806d6.52.1784587782388; 
 Mon, 20 Jul 2026 15:49:42 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907786f365fsm100355676d6.37.2026.07.20.15.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:49:41 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 20 Jul 2026 18:49:30 -0400
Message-ID: <20260720224936.2753334-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260414164927.843200-1-sbertram@redhat.com>
References: <20260414164927.843200-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WDF7IY2o467Eu1_ZOHsQw-xRZoCVUb55DNWrOUcK6rg_1784587783
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] semctl01: tolerate SEM_STAT races under parallel
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
Cc: Stephen Bertram <sbertram@redhat.com>
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
 testcases/kernel/syscalls/semctl/semctl01.c | 90 ++++++++++++++-------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..e5056e8e3 100644
--- a/testcases/kernel/syscalls/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/semctl/semctl01.c
@@ -236,35 +236,58 @@ static void func_sstat(int semidx)
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
+		idx = semctl(0, 0, IPC_INFO, (union semun)&ipc_buf);
+		if (idx < 0)
+			tst_brk(TBROK | TERRNO, "semctl(0, 0, IPC_INFO)");
+		rval = semctl(idx, 0, SEM_STAT, arg);
+		if (rval >= 0) {
+			sem_index = idx;
+			return rval;
+		}
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
 	int rval;
 
-	if (sem_id == -1)
-		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
@@ -279,25 +302,33 @@ static void verify_semctl(unsigned int n)
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
 
+static void setup(void)
+{
+	sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+}
+
 static void cleanup(void)
 {
 	if (sem_id >= 0)
@@ -305,6 +336,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_semctl,
 	.tcnt = ARRAY_SIZE(tests),
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
