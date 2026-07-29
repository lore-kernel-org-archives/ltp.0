Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7097DC54FD4
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785358849; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/cn6wsekVlhmztd0kAbTuN5PVjMoqnI7G0s5MwB2U1U=;
 b=KePxF20sOR2B44jCEmJ4bFvKEZhoUV+1LA0L/skRidqG1r6P2vC9a6axKn4yh8HaIscNh
 LfN23H7q+YnUYcFL6YnP2RMzeyjmm6tFl6bJmKr+l6PbVFGNLyMGoMk5HrUkOOkHOe2Iyw2
 XgsnmFcRUpfBHnusEmPN748Dtg6SBmE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BED453E62BA
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 23:00:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BBC13E293C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 23:00:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C1C96003BA
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 23:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785358826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHF8kLoYVm1k66u9YI/lJujqf+4bmc2OauGUxt6znWE=;
 b=DVH+LnbXxrO7Bb/QjcO/YXJxz73UmmM2eS9laUSwkEaQu61mkLyFY7iqsL3863qc77SZvT
 cN11fOESb+HLrmdciQQZKB+D0v/tM0q5vBYDW7gM53y0ceCBBK6ux9T+IEbwgyrChQdQkc
 oVY9MFudFbIrg6URCj+ic6QHylkVGuI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-2vpgfxK_PTiuHsKzRZ79iw-1; Wed, 29 Jul 2026 17:00:24 -0400
X-MC-Unique: 2vpgfxK_PTiuHsKzRZ79iw-1
X-Mimecast-MFC-AGG-ID: 2vpgfxK_PTiuHsKzRZ79iw_1785358824
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c07f25de2so12345171cf.3
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 14:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785358824; x=1785963624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SHF8kLoYVm1k66u9YI/lJujqf+4bmc2OauGUxt6znWE=;
 b=fLTIs2lW9GOpcUmB3rlCsW5zp/mcaWR0r00K9Gtfd5MqLLqRZ7pN/K6pz/ISGYUYgy
 1UtA6wCALXvEPFUSG21FpTMf7d7MAIafrbzf5HmjNZk/gy/5EGch0j6zUNXoWQmcdXpc
 YZyEnchyJeGMfyitCGNmJJuXB+feV2c2E+59CVcjtlTpaTn7wRklEbYIg2spIa9gP/d5
 dytIseW6o12nKRb+tyNwCg6r21ViOr88FVBPdEMVufkpkl9VPKKt5X9abvhM8BO77t3W
 8Gs0x4DbCjMdKx0TlmIH7tcUNyGfvHj+xzxso3iXteDZjv4664IS6wXbs+njbpLRcF5R
 oQgQ==
X-Gm-Message-State: AOJu0YzhIl/EGxdUV0kGx/IrDWhG7Cf0BXhXliJlptIc183TdAVneQ3w
 hHUumIGlmaT/R7G0PgQxKLmwFINIkKLw8iBtrHeqfOoeBIw7W5rzxbOuadUPXhMW01Ac/2z9PoU
 pOf6scmEH3OR/2sDgn+vWP/ZnP0UOcIVNAmGOrVAeTRW1hJClEFAhQA+2jqFsXvux0vuafs+u/p
 QsRYDiFNIKlM9hpoGx8UF4ritlNw3FtuSW+Zop
X-Gm-Gg: AR+sD10/IhkT9eZyY+ZH9V0cFY4TIUCFW4Bq/SGn4HBDIG7ybXEu54v0l5KCq0YtFwl
 rudwjLCJDhVoNyYYcAlOdDhR7OHHuj74vmThI/itWm860vOrQF+a7UNLbqnNBsw1b9ZfDPwlxrr
 pmyVo8Xa12hAXOWls71TBXcEerydXrcy/LUjL9F/jnfUINXoObElbU2GgcBWszF3fgWwXYQ+IMZ
 J3wvl8kFwsI9rFOoXDhJL5L1BfelyhXkoRBslCCVBCFcoAk3VXsGluKYIlrh9LCZWcEnUazorPQ
 4OhlyLUSsfFzO52X90TujQQWW+Zz4uhVpzzylxYklTxXMT+o1pBhvk6hqNh+yNaoJWVIngbR5AJ
 RB39ORRftvtpYR4ujqGwWoE330A==
X-Received: by 2002:a05:622a:11d0:b0:51c:f8f:13d with SMTP id
 d75a77b69052e-52b3869404fmr595491cf.37.1785358823293; 
 Wed, 29 Jul 2026 14:00:23 -0700 (PDT)
X-Received: by 2002:a05:622a:11d0:b0:51c:f8f:13d with SMTP id
 d75a77b69052e-52b3869404fmr594531cf.37.1785358822405; 
 Wed, 29 Jul 2026 14:00:22 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2d822dbsm26474561cf.16.2026.07.29.14.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 14:00:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 17:00:17 -0400
Message-ID: <20260729210019.7647-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729193307.4187107-1-sbertram@redhat.com>
References: <20260729193307.4187107-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E3B-_wq5J0QKDGM0auzH8DKVpjYwHiI7ORsUY6hGxqg_1785358824
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11] semctl01: fix SEM_STAT failures under parallel
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
Runtime:    16m 35s
Passed:     416000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

Assisted-by: Cursor

 testcases/kernel/syscalls/semctl/semctl01.c | 59 +++++++++++++++++----
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..1627a07a7 100644
--- a/testcases/kernel/syscalls/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/semctl/semctl01.c
@@ -210,13 +210,16 @@ static void func_rmid(void)
 
 static void func_iinfo(int hidx)
 {
-	if (hidx >= 0) {
-		sem_index = hidx;
-		tst_res(TPASS, "the highest index is correct");
-	} else {
-		sem_index = 0;
-		tst_res(TFAIL, "the highest index is incorrect");
-	}
+	/*
+	 * Return value is the highest used index. Our set is alive, so the
+	 * highest used index must be at least our index.
+	 */
+	if (hidx >= sem_index)
+		tst_res(TPASS, "IPC_INFO highest index %d >= our index %d",
+			hidx, sem_index);
+	else
+		tst_res(TFAIL, "IPC_INFO highest index %d < our index %d",
+			hidx, sem_index);
 }
 
 static void func_sinfo(void)
@@ -227,12 +230,40 @@ static void func_sinfo(void)
 		tst_res(TPASS, "number of semaphore sets is correct");
 }
 
-static void func_sstat(int semidx)
+static void func_sstat(int semid)
 {
-	if (semidx >= 0)
+	if (semid == sem_id)
 		tst_res(TPASS, "id of the semaphore set is correct");
 	else
-		tst_res(TFAIL, "id of the semaphore set is incorrect");
+		tst_res(TFAIL, "expected sem_id %d, got %d", sem_id, semid);
+}
+
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
+	/* SEM_INFO ignores semid; but SAFE_SEMCTL requires an lvalue */
+	max_idx = SAFE_SEMCTL(id, 0, SEM_INFO, arg);
+
+	arg.buf = &dummy_ds;
+	for (i = 0; i <= max_idx; i++) {
+		/*
+		 * Bare semctl: unused/unreadable indices fail with
+		 * EINVAL/EACCES; SAFE_SEMCTL would abort the test.
+		 */
+		if (semctl(i, 0, SEM_STAT, arg) == id)
+			return i;
+	}
+
+	return -1;
 }
 
 static struct tcases {
@@ -263,8 +294,14 @@ static void verify_semctl(unsigned int n)
 	struct tcases *tc = &tests[n];
 	int rval;
 
-	if (sem_id == -1)
+	if (sem_id == -1) {
 		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+		sem_index = get_sem_idx_from_id(sem_id);
+		if (sem_index < 0)
+			tst_brk(TBROK,
+				"Failed to get sem_id %d to idx mapping", sem_id);
+		tst_res(TINFO, "sem_id=%d maps to kernel index=%d", sem_id, sem_index);
+	}
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
