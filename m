Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20578C53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 20:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785270843; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IsU5n7jNJc6r5Lb+KclXozUFPHd3BSTMzjeUXb62iX4=;
 b=Dtas2iQhpiauEmWYpLRLMTImhEOTehEvsgYFxmJADmu9HesmY+Lt3KZhiejiK7cdESLcK
 5/WSpxSPshPcWKxq3boRfOsgO/qrMNSYnRph0CZj3XFv9UN/fflgrQDRYFHvE4TgkClDrxi
 hUAqkAw72h2r1NqM5r9awHaiSWJx/m8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6E003E91F7
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 22:34:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A98A3E525F
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 22:33:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC0DA20032C
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 22:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785270820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DG0bLYyxZrSigLB9OXRvqeSy7fdtlKYyVwQ89sF78sU=;
 b=GQE72Sq8/gHABDgNu+o8x+tDPJWvjzzcZI6l8IdV/vktseuhhd8KiEIFOmEjkMwCRhcXoi
 GeIylOIxQXHUuFRt20049U4OuF6zgZ0cQvnMvIDkpdsAgTI2sdM4Or73F6ZRLFXWMQY2N7
 mYTgsOf7RcLOn7SrST4rcdh4nCI2hIY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Ef1--s-qOESePwse4N6WFw-1; Tue, 28 Jul 2026 16:33:38 -0400
X-MC-Unique: Ef1--s-qOESePwse4N6WFw-1
X-Mimecast-MFC-AGG-ID: Ef1--s-qOESePwse4N6WFw_1785270818
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f000e221d7so3141346d6.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 13:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785270818; x=1785875618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DG0bLYyxZrSigLB9OXRvqeSy7fdtlKYyVwQ89sF78sU=;
 b=mzvAkr66GdTjWuldI5Xauos9nSbJjUwoiEf1VUV6KSus4dX2dst1InW1ZnyQpb0lwD
 c125LuqzpXnfXRfwmcN7z2dJXpaQm0e9blX5T1TE1zee01oijq4O6RwuBWQCktpsLcMl
 u7A5KNtQQFQSJWLz15++K5YR9LlbskuTAOd+FwOpnIkTUTEVna21KfTcLbZsP/FDtsOQ
 sfX+Ru17eGkm/mxkOhVJSuZ7pjzktBnz3lc0wtsX47GlY+0WXFIto/EuAhHMUdQWT2Rk
 DgmxN5RlGhSwclSyeZgHb01WLEyYlZl9e1jAocPddqaPfTMvPsS7bbOzxbJHp67UYoa2
 mNKQ==
X-Gm-Message-State: AOJu0YzTdD7rMv3RR4248uj/93EeO4NheUZIZ8FwAuCyQ6PidOiM/SzQ
 E8iSq/pV8MtvmUEObPu85YYE3344kw1zFyc5qZP53cPtuyvFbIwLHuDR9Wexr1ywiviLlNgX0Ra
 NlMmjrqtl13deq0qQzFo4SrHJ3euL2HvLghYrlMWnMIW5iwNUkPAzJ/JWUe44eGFtVvx+06nOP8
 67EV3J+cmDZJsQrttm1zsJP9NZRIEwmMHRfQla
X-Gm-Gg: AR+sD12VKcfQI7FfNyucu2hJMZiG/FsxV4i1n+ZMSxrnVGPn2D62cii/0Eh5PcCkniC
 ysouIGaryTMaytkPDB/cANJvpZxkTntXMlX5ooBoIjf1ZEz3qpT2KCqqLtB9AZZcvovR7AGrlmH
 +9Suih/N3WlqSiqzhr0sBTCyp1SpugC0gTqsqP++sJV7Jx3ZHh0xNMnrLJ+hLPsr0UvIEkSdf+2
 WlVAg/kdFAvN5CVc2+th/vKQKla+seuC3if2pC4x8NnBvzY6GIs/7KwksQPeQ8rwL+wMxqW8lW+
 B5EK0SbBXJrOmwET4eOb/JAI5bs904JPrAsBd1QRHXBIdyl8NfupiVx8M36n1xlxvBNbi28vUVn
 rGvL64y6xFAnB7amGmHGemUVheA==
X-Received: by 2002:a05:6214:3211:b0:8ee:f531:4de8 with SMTP id
 6a1803df08f44-908173a77d8mr50330576d6.40.1785270817961; 
 Tue, 28 Jul 2026 13:33:37 -0700 (PDT)
X-Received: by 2002:a05:6214:3211:b0:8ee:f531:4de8 with SMTP id
 6a1803df08f44-908173a77d8mr50330196d6.40.1785270817262; 
 Tue, 28 Jul 2026 13:33:37 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dc4286dsm7617276d6.7.2026.07.28.13.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 13:33:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 28 Jul 2026 16:33:33 -0400
Message-ID: <20260728203333.3949671-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728162351.3845090-1-sbertram@redhat.com>
References: <20260728162351.3845090-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ytVQaq9OAizxr08oSLNCbD_4E-Rtojxz-KXIEa5ALHE_1785270818
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] semctl01: look up SEM_STAT index for this test's
 sem_id
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

Walk 0..max_idx with SEM_STAT until the returned id equals this test's
sem_id.

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
Runtime:    4m 9s
Passed:     104000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

Assisted-by: Cursor

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/semctl/semctl01.c | 85 +++++++++++++++------
 1 file changed, 62 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..7b60d5739 100644
--- a/testcases/kernel/syscalls/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/semctl/semctl01.c
@@ -19,7 +19,6 @@
 #define SEMUN_CAST (union semun)
 
 static int sem_id = -1;
-static int sem_index;
 static struct semid_ds buf;
 static struct seminfo ipc_buf;
 static unsigned short array[PSEMS];
@@ -210,13 +209,10 @@ static void func_rmid(void)
 
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
@@ -229,35 +225,73 @@ static void func_sinfo(void)
 
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
+ * SEM_STAT takes an idr index. Walk 0..max_idx until SEM_STAT
+ * returns this test's sem_id so parallel IPC tests cannot make us exercise
+ * some other process's set (EIDRM/EINVAL/EACCES on a moving max_idx).
+ * Returns that semid.
+ */
+static int sem_stat_for_id(int id, union semun arg)
+{
+	struct seminfo info;
+	union semun info_arg;
+	int max_idx, i, ret;
+
+	info_arg.__buf = &info;
+	max_idx = SAFE_SEMCTL(id, 0, IPC_INFO, info_arg);
+
+	for (i = 0; i <= max_idx; i++) {
+		ret = semctl(i, 0, SEM_STAT, arg);
+		if (ret == id)
+			return ret;
+		if (ret == -1 && errno != EIDRM && errno != EINVAL &&
+			errno != EACCES)
+			tst_brk(TBROK | TERRNO, "semctl(%d, SEM_STAT)", i);
+	}
+
+	return -1;
+}
+
+static int do_sem_stat(union semun arg)
+{
+	int ret;
+
+	ret = sem_stat_for_id(sem_id, arg);
+	if (ret < 0)
+		tst_brk(TBROK, "Failed to find SEM_STAT for sem_id %d",
+			sem_id);
+
+	return ret;
+}
+
 static void verify_semctl(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
@@ -265,6 +299,7 @@ static void verify_semctl(unsigned int n)
 
 	if (sem_id == -1)
 		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
@@ -279,7 +314,11 @@ static void verify_semctl(unsigned int n)
 		}
 	}
 
-	rval = SAFE_SEMCTL(*(tc->semid), tc->semnum, tc->cmd, tc->arg);
+	if (tc->cmd == SEM_STAT)
+		rval = do_sem_stat(tc->arg);
+	else
+		rval = SAFE_SEMCTL(sem_id, tc->semnum, tc->cmd, tc->arg);
+
 	switch (tc->cmd) {
 	case GETNCNT:
 	case GETZCNT:
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
