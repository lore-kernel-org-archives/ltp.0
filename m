Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0AFC55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 02:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785377338; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WmGD0Mz3OFx/4tKtQAM97fRBZK0yjTL+VNAN25PRBNg=;
 b=GBvPRFvgc6x++lTiy/0WThpUtsoj1TXO0E/4H5RDWxzit50Xw5fhYJmD7SVeCaasj+dcn
 CQJZKzGCUGpVkq/DwE9eXIuHzT4KvMH9ARWjvh0nM+/rd8RtqhI0Oq50fSk7rkTT+QxHIGr
 s3tUMzboecXk3VcmMzYzOJxwRbsPrXQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B56D03E729B
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 04:08:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A574B3E2156
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:08:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AEBD51A003C1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785377316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqK7q2lqol/0uwz7478l3pDGFLDm0+Txoa0M5tfLTAU=;
 b=aCmAhZZR0cIJY9ufGeY//lA56A/uIjsN1Ewh9Kj7a1DmThycjRDfYF5AZj3A4SUObQcRQ/
 6QLLLuKJV9LYKHpb675SqDzgG7m593lDNTZ093ievv32QaNQ6nOfJqd+608cCaq7L5ZOVz
 N+/OOmFkN+aKZ8YRdRH9v9jiRLqehuE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-U-AfNp_uNc2jB719xIcYuw-1; Wed, 29 Jul 2026 22:08:27 -0400
X-MC-Unique: U-AfNp_uNc2jB719xIcYuw-1
X-Mimecast-MFC-AGG-ID: U-AfNp_uNc2jB719xIcYuw_1785377297
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c07f25de2so14133331cf.3
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 19:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785377297; x=1785982097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uqK7q2lqol/0uwz7478l3pDGFLDm0+Txoa0M5tfLTAU=;
 b=j/mWRTw3h77qLy85XaY1AuH/3Pn2JZNOVqVi+8q2UsX7KNyrgN17ih+qHnsAT6cjqG
 CsZk7o0Pl0h7A9SP+VvwB9YUnoc9BBnUo1yDTRTJxQXh0NMjMHbEzH0qBM6Pg0doE0uV
 ctuCJMQHCDuD520D4K6fBPDOo4amrdc1bET3J0Wt/AjYfAV+Hpx3IWaKwAh4SL0cAEm4
 4+lSGGJn2BYdoqAfCWTDO9xcdD4r61Iy7hkqWhufY+Vxdg/WWbgl+NRmbkNJ6yuAH3za
 bmRAyKeNoUF9rzaTZs2iOM8DFQI5KayeffTkevww00Hj4tfi3t9lKgb0DvbIxnG+rq/O
 aNEQ==
X-Gm-Message-State: AOJu0Yy0DQMCpDRbJSnyDUdVfFW3bs5EuwqBX50YmwK2AzVYpQAAReks
 JGC1B6mNt9fSRQ+hHkDF0K3jT0f6eaECC940AKnN1mANvtmFbe3r6AfAzD3oLDLY2ju3ekyAOB4
 1q01N05yDWl1O9zjC79teLLsLrCaL/un3QCJIobz/3Grjle8MLL24ZPAnt//Qno1SwFyTatAlXD
 DOy3BcHICfGCJvIjkwJ+lt556P7+csoPg2nfpB
X-Gm-Gg: AR+sD10gmwLKfnm4ZgMhWzNrNLX9o6HdS8qwTrN077jP/0YHnNxrBBbEJCcrd8Mm21p
 Y8VfrQ3AkzgjtjqrCZ8eHBDudPAJ3thPHX08wjpVzHXruXJoA3AVD+Hh/23tlvQGZy6afztrJR0
 bV+OnmZLPI9CXjv6RZeCNROfcITzL++RPEUEJnlz9WZhuqEOdwtghT8+MHOZB0ZGb2WMS/XIxaY
 i6XxaY/KEskZNWWKwn4UOpIJR1xryqO2km5We7sORjUHGWMm+fdpcQt1+M7qEoU4I7MYkg7Xt78
 00tZdtWh3oCytGizPO1gxj4mL41yGKC647xGJs/mqeL+GtPm6ddzQy37a6f1iVvZjIq+CvYewno
 Kx0sYaGU5Uswi5zgc9Yc7aw18lw==
X-Received: by 2002:a05:620a:40d1:b0:92e:74f6:ddd6 with SMTP id
 af79cd13be357-93485fc07f9mr84945285a.25.1785377297509; 
 Wed, 29 Jul 2026 19:08:17 -0700 (PDT)
X-Received: by 2002:a05:620a:40d1:b0:92e:74f6:ddd6 with SMTP id
 af79cd13be357-93485fc07f9mr84943785a.25.1785377296913; 
 Wed, 29 Jul 2026 19:08:16 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e733e41bsm305673585a.39.2026.07.29.19.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 19:08:16 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 22:08:11 -0400
Message-ID: <20260730020813.68630-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729210019.7647-1-sbertram@redhat.com>
References: <20260729210019.7647-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MmeSBjvwcAjnaqamNced91Pmvc2F6K-94Eer6v59JaA_1785377297
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12] semctl01: fix SEM_STAT failures under parallel
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

SEM_STAT relied on the global high index from IPC_INFO to find this
test's semaphore set. That index is not stable when other IPC tests run
concurrently, and could trigger TBROK aborts under parallel LTP runs.
Look up the index for this test's own semaphore set instead.

This also updates func_iinfo(), which no longer derives sem_index, and
tightens func_sstat() to compare the returned id against sem_id.

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

 testcases/kernel/syscalls/semctl/semctl01.c | 66 +++++++++++++++++----
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..717d005a8 100644
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
@@ -227,12 +230,47 @@ static void func_sinfo(void)
 		tst_res(TPASS, "number of semaphore sets is correct");
 }
 
-static void func_sstat(int semidx)
+/*
+ * get_sem_idx_from_id() relies on this same identity (SEM_STAT(i) == id)
+ * to find sem_index during setup. Re-checking it here still has
+ * meaning: it verifies that SEM_STAT still resolves to our set at
+ * test-execution time, catching the case where a parallel IPC test
+ * reused sem_index in between - the exact race this patch fixes.
+ */
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
@@ -263,8 +301,14 @@ static void verify_semctl(unsigned int n)
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
