Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C56DC531D0
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 04:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785386889; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WozmVRXZAuTOTHzSjOcMnjxUe0yu5q7JmR7BPm7hgsk=;
 b=HtgRYOIgL1pcKiamvFTJ+2XNO7BPfs6+ThtCFX6TjX5sjOA12MbXgBT7MfHXLQA4knUFb
 EWWyJKHsqJg/wYDD3V6yNXIfODQ2p+4fB4wWvHBjwUohhcGJr2pkQq4kSj5zXFleH3J2ZIi
 64DlOt3IP0CHhc+ayRGnaYlKXm75JzU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9DDA3E2D2A
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 06:48:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 096C13E1B91
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:47:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9622A600879
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785386865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5ugYIKhc62u514f77AW6i115jmDnOcKjPJ3y6JDGjY=;
 b=cuyTUo2F9K8TJvECO4sBJgg4xqVP89cVIu4JEM5aoMdRpJHXlaZZukK+XaeXgtG4ZKFKCB
 g1owTVQna3WA1rJ+5kfFi5psSOAANo6TpZQz4EFsYkqui6kINMhgk91sqo8XDmDZA0irDr
 ZQaMIU/Kw6H4Obmp18l3rbXxrUYRQDY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-WDsSPygQNeiyiI_wzhGgnQ-1; Thu, 30 Jul 2026 00:47:44 -0400
X-MC-Unique: WDsSPygQNeiyiI_wzhGgnQ-1
X-Mimecast-MFC-AGG-ID: WDsSPygQNeiyiI_wzhGgnQ_1785386864
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f27f49bso162411285a.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 21:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785386864; x=1785991664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t5ugYIKhc62u514f77AW6i115jmDnOcKjPJ3y6JDGjY=;
 b=jNgNZlWpSwstH2Q89mOTONY4FF5ZqzbgJ87/XBE4bPFM5uYINH0vx6Gz5eSUBtpsdy
 kd2vVkUhKeqxM8MlMGYOJJumM5NN3TXnrkuGhwYXy6lK9GA2BRSkOy2bim1TwkPEAWKl
 IAuCjehM7cm+jxLP0QGGE4Ou5gyr9gJJ5ZhRUZa1Fuqm/WP0ZDMMXTHrYPZLgEUffOcN
 WJMxQchlXNQ43j+nmxNtZv6KkGO5nD+3CDAFMIqhRbTwO8M+cBzBaQdmjgFubY9KTNP5
 RUC/BG1G89DGhxE3XLDALCpKijtGhBfAIwvtYCb7sLBFSmY1boc9lz1fFVwN3B61/GUy
 gosA==
X-Gm-Message-State: AOJu0YySeCiTxU5yU+/+RcPuwRMv1rT/fvE3ZOEHherDmtNf8rXgEyxO
 BHNQ/PxlXy2OuClOZ4P8zQv3iM1BeQBr8IDJxilyydcGAC61JNAxgvL4TLTMgzORS/CQtx9885e
 4gOEe5goZ6kgw45HfUUJsOK3yo7byCu9kGe2cGotToeZvsTzfCC0UO61e23DnRf04hMMtWi4XlI
 wanO/Uus3VDM+BSSglkmKbxwO3HJeKIGS+bPX6
X-Gm-Gg: AR+sD11e0aQz4rQGJUBlpxd1uMc0mB2Xh5TZi+VAwWeo8l/kDWEtmqIaEjTome1A1KW
 z1zNaZe4dJUx9nBC4G8yCQkkUxMZLJociQvm69MdVyrQOMjvfqsFxlB8H5geCbcTeBSg2bMIdrE
 1nZZ0uFTVs4pJYB8XcXKm0cKyu9kSxthkXbpkb9VZme2wx+KNOyJgFMJgbcRLnOD7e+LlUt77KI
 7KF6lj1456dLQ5rubpyZiqERPPip2xDIrTyfdIe7CCJ5jH1ctVcPpj0GYXqI/pC1tW7V0imMjyR
 qiotfTeOHXoog5c+7eJMEViKOH1DO2uJeDWdQ0ZLiY6qvjdvS8yygnYQQxpCSxfECm524OuRauq
 aByfsWCKnoeiul25DEPyySUuyGA==
X-Received: by 2002:a05:620a:2955:b0:930:c06d:f894 with SMTP id
 af79cd13be357-9348720d651mr92612285a.92.1785386863761; 
 Wed, 29 Jul 2026 21:47:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2955:b0:930:c06d:f894 with SMTP id
 af79cd13be357-9348720d651mr92610585a.92.1785386863072; 
 Wed, 29 Jul 2026 21:47:43 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3264577sm331464385a.17.2026.07.29.21.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 21:47:42 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 00:47:35 -0400
Message-ID: <20260730044737.107415-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730020813.68630-1-sbertram@redhat.com>
References: <20260730020813.68630-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r3zyfw4uR4ilqLhupHYK3LkC_SMqyTDtdVbsJ3B0W3c_1785386864
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13] semctl01: fix SEM_STAT failures under parallel
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
func_sstat() now also verifies the semaphore data SEM_STAT returns
(sem_nsems, sem_perm.mode), not just the id used to locate it.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
Assisted-by: Cursor
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

On sharing get_sem_idx_from_id() with shmctl01's get_shm_idx_from_id():
agreed there's duplication worth consolidating, but I'd like to keep
this patch scoped to the SEM_STAT fix. I can follow up with a
libs/newipc helper shared across semctl01/shmctl01/msgctl12 as a
separate patch on top of this one.

 testcases/kernel/syscalls/semctl/semctl01.c | 73 +++++++++++++++++----
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..05cb31ab6 100644
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
@@ -227,12 +230,52 @@ static void func_sinfo(void)
 		tst_res(TPASS, "number of semaphore sets is correct");
 }
 
-static void func_sstat(int semidx)
+/*
+ * SEM_STAT fills buf the same way IPC_STAT does. sem_nsems and
+ * sem_perm.mode (set via IPC_SET earlier) verify SEM_STAT's own data,
+ * not just the id already used to find sem_index.
+ */
+static void func_sstat(int semid)
 {
-	if (semidx >= 0)
-		tst_res(TPASS, "id of the semaphore set is correct");
+	if (semid != sem_id) {
+		tst_res(TFAIL, "expected sem_id %d, got %d", sem_id, semid);
+		return;
+	}
+
+	if (buf.sem_nsems == PSEMS && buf.sem_perm.mode == (SEM_RA | NEWMODE))
+		tst_res(TPASS, "id and semaphore STAT info are correct (id=%d)", sem_id);
 	else
-		tst_res(TFAIL, "id of the semaphore set is incorrect");
+		tst_res(TFAIL, "nsems=%d (expected %d), mode=%o (expected %o)",
+			(int)buf.sem_nsems, PSEMS,
+			buf.sem_perm.mode, (SEM_RA | NEWMODE));
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
@@ -263,8 +306,14 @@ static void verify_semctl(unsigned int n)
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
