Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29415C55164
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785432025; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zz6I0AgYxKPD8blrcuRjItFX6bRaBr8wdLcOQ2f/mPQ=;
 b=kkppxOPIsQeaCC55PZr9m4LJvq+Ior+IyTke2JQIoY+lCP7CrwrugwI/9SuVPXl5SOLrW
 JLGmrw7lWT8BHT9vHV2mc2eiej/NnqGdHHDXTWVwSVah9vY2e6GDS2mND1yIqxnzz9os1WK
 /TmXq5CcpiFw7yKBST+428DtkqM0FcY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F021D3E7257
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 19:20:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0C853E2D2D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 19:20:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 02C971400B89
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 19:20:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785432003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FE158BI/AzVkWC33NTgquaVhrSIIq2bWIKae/IF7sbI=;
 b=Lt8Y/N9YVy8NwxTugOElAn7gVC2UgMzmD1ZStWPBAO3srXqcT6B3fF+QzyV/uwNSivaLYu
 4K6BNe6yJiMBJuekcNM+kpWJfgWV/CZznBwIH2rbXx3DRKDgqMz/ybTwJpkHmO3QzX3bdk
 +nX+jdTWWWCbDZgRgb6Uekzv7h9xF3U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-Xwv0JlurPESgMosKtYefgw-1; Thu, 30 Jul 2026 13:20:01 -0400
X-MC-Unique: Xwv0JlurPESgMosKtYefgw-1
X-Mimecast-MFC-AGG-ID: Xwv0JlurPESgMosKtYefgw_1785432001
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ee593a5a2fso11786476d6.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785432001; x=1786036801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FE158BI/AzVkWC33NTgquaVhrSIIq2bWIKae/IF7sbI=;
 b=SMQeMGYBLny2fXt+MKaKB/gRK4Q5oBfeH/qy5aSLiO+puf6z1Ppax24KcnINOuOSOh
 sycF2iebiP0J+mYCDFgbKqkcS9FjQhMTCufj0f6wyaCLUGw+rDEmWvQ4yOc1zEJPIzmM
 /v8pyaZo4zpmaevvrcMujLzufZ9PmQYt1hMED9edfpNvpCtKj4NNkhoFbpXqXVg+lthc
 vJbdZM9HuT1SV6BbUeHZOqvFE0Al+AQCJZpseKu8rKs63gfA0biM8LbuiwL+V1Lx88HT
 9ZiIx7LBPaxFhhQ2dHHlC7nZv7S6P1FLe8WXq8KtuHkIyShV2J2rUVIi6B0nYTa1CtVs
 19Gg==
X-Gm-Message-State: AOJu0YzRWGz9TEbbqqjW24aq3vbMxORZJP9cCHd+ZCUk28gp6blV0M6P
 RiCcnbwqBmWSSSg80GK5VhNFvAYI6h0jiENhZq8SCBnqYyNYQQ+ObFY4e0wOiM8fdLSmII+k8Pz
 J8kcRawR6hT/NVYeCHNzVse4cjh/4UW9dwkO4wKkrm9RJl6BUU0x+T4YqoXoZQtxPc2Z9ziN+R5
 1fYbu8gupd+ng92bXbsr+W3upb/fJ6UkZ2HwoY
X-Gm-Gg: AR+sD12WoCZ+VNFHO30o3gJIgiDb7K90JOZQ3waQARYY3IeVudqte40vdVlWzOwihu7
 oPdeIukraBQFF2M0WEBW6qbQZ0o+7FeiafjWhk3vADbEdk7W94PdbTgvknDe/dImIvHhX46Fxhf
 qQF0M54CcHJaiOW2UrtrezlZgQJsgWzbzI3ZVvuDfd+OCIBrWbGV6vfbh77rzMw6lJ6eUTjAmct
 Q/uRljq2VnkUN2yT67T8aqM/lPNCYvD/nMHJgCXD4UDyT7gAtpu0F6q6fiHhPdAdZBjVCfUHrpT
 SDujy5HAScEG9AzBfhjHrGzzS29JQKvBbQoqOdIdJ+F0w9TfQizOTI1bYy7BeT69K048TpmdNz1
 5B/cDA8F60fmpulBC20iifHFdVA==
X-Received: by 2002:a05:6214:410b:b0:906:7a36:9a38 with SMTP id
 6a1803df08f44-9083af623fbmr13521876d6.28.1785432000697; 
 Thu, 30 Jul 2026 10:20:00 -0700 (PDT)
X-Received: by 2002:a05:6214:410b:b0:906:7a36:9a38 with SMTP id
 6a1803df08f44-9083af623fbmr13521306d6.28.1785432000047; 
 Thu, 30 Jul 2026 10:20:00 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908324f8805sm22199716d6.35.2026.07.30.10.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:19:59 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 13:19:42 -0400
Message-ID: <20260730171956.237584-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730150149.211449-1-sbertram@redhat.com>
References: <20260730150149.211449-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6EQqaHM4Q_tknvHtWf4vAwSlRXIJFmU5sjwesMOTYvo_1785432001
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15] semctl01: fix SEM_STAT failures under parallel
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

From: Stephen Bertram <sbertram@redhat.com>

SEM_STAT relied on the global high index from IPC_INFO to find this
test's semaphore set. That index is not stable when other IPC tests run
concurrently, and could trigger TBROK aborts under parallel LTP runs.
Look up the index for this test's own semaphore set instead.

This also updates func_iinfo(), which no longer derives sem_index, and
func_sstat() now also verifies the semaphore data SEM_STAT returns
(sem_nsems, sem_perm.mode), not just the id used to locate it.

The per-index lookup duplicated shmctl01's get_shm_idx_from_id(). Move
the common loop into a new get_ipc_idx_from_id() helper in libs/newipc,
shared by semctl01.c and shmctl01.c behind a small per-family stat()
wrapper on each side.

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
Runtime:    16m 37s
Passed:     416000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

Test: ./kirk -w 4 -f syscalls_32 -p shmctl01 -i 1000
After changes:
Total runs:  32000
Runtime:    24m 57s
Passed:     384000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

 include/tse_newipc.h                        | 20 ++++++
 libs/newipc/tse_newipc.c                    | 13 ++++
 testcases/kernel/syscalls/semctl/Makefile   |  2 +-
 testcases/kernel/syscalls/semctl/semctl01.c | 76 +++++++++++++++++----
 testcases/kernel/syscalls/shmctl/shmctl01.c | 14 ++--
 5 files changed, 105 insertions(+), 20 deletions(-)

diff --git a/include/tse_newipc.h b/include/tse_newipc.h
index 1d3bbd129..175a60234 100644
--- a/include/tse_newipc.h
+++ b/include/tse_newipc.h
@@ -49,4 +49,24 @@ void *probe_free_addr(const char *file, const int lineno);
 #define PROBE_FREE_ADDR() \
 	probe_free_addr(__FILE__, __LINE__)
 
+/**
+ * get_ipc_idx_from_id() - Find the kernel index of an IPC resource by id.
+ *
+ * @id: The msqid/semid/shmid to look for.
+ * @max_idx: Highest kernel index to search, from IPC_INFO/SEM_INFO/SHM_INFO.
+ * @stat_fn: Per-family *_STAT wrapper called as stat_fn(idx, buf) for
+ *           each idx in [0, max_idx]; must return the id at idx, or -1
+ *           on error, without aborting the test.
+ * @buf: Buffer passed through to @stat_fn.
+ *
+ * SysV *_STAT commands (MSG_STAT/SEM_STAT/SHM_STAT) take a kernel array
+ * index rather than the id returned by *get(), and that index is not
+ * guaranteed to match the id when other IPC users are active. This walks
+ * the live indices to find the one that currently maps to @id.
+ *
+ * Return: The kernel index mapping to @id, or -1 if none was found.
+ */
+int get_ipc_idx_from_id(int id, int max_idx,
+			int (*stat_fn)(int idx, void *buf), void *buf);
+
 #endif /* tse_newipc.h */
diff --git a/libs/newipc/tse_newipc.c b/libs/newipc/tse_newipc.c
index f7edda6b5..aee286a31 100644
--- a/libs/newipc/tse_newipc.c
+++ b/libs/newipc/tse_newipc.c
@@ -86,3 +86,16 @@ void *probe_free_addr(const char *file, const int lineno)
 
 	return addr;
 }
+
+int get_ipc_idx_from_id(int id, int max_idx,
+			int (*stat_fn)(int idx, void *buf), void *buf)
+{
+	int i;
+
+	for (i = 0; i <= max_idx; i++) {
+		if (stat_fn(i, buf) == id)
+			return i;
+	}
+
+	return -1;
+}
diff --git a/testcases/kernel/syscalls/semctl/Makefile b/testcases/kernel/syscalls/semctl/Makefile
index 0e7223998..1f1ec9c81 100644
--- a/testcases/kernel/syscalls/semctl/Makefile
+++ b/testcases/kernel/syscalls/semctl/Makefile
@@ -8,6 +8,6 @@ LTPLIBS = ipc newipc
 include $(top_srcdir)/include/mk/testcases.mk
 
 semctl06: LTPLDLIBS = -lltpipc
-semctl02 semctl03 semctl04 semctl05 semctl07 semctl08 semctl09: LTPLDLIBS = -lltpnewipc
+semctl01 semctl02 semctl03 semctl04 semctl05 semctl07 semctl08 semctl09: LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..398cb3028 100644
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
@@ -227,12 +230,54 @@ static void func_sinfo(void)
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
+		tst_res(TPASS, "id and semaphore STAT info are correct (id=%d)",
+			sem_id);
 	else
-		tst_res(TFAIL, "id of the semaphore set is incorrect");
+		tst_res(TFAIL, "nsems=%d (expected %d), mode=%o (expected %o)",
+			(int)buf.sem_nsems, PSEMS,
+			buf.sem_perm.mode, (SEM_RA | NEWMODE));
+}
+
+/*
+ * SAFE_SEMCTL() would abort the test on per-index failures.
+ */
+static int sem_stat(int idx, void *buf)
+{
+	union semun arg;
+
+	arg.buf = buf;
+	return semctl(idx, 0, SEM_STAT, arg);
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
+	int max_idx;
+
+	arg.__buf = &info;
+	/* SEM_INFO ignores semid; but SAFE_SEMCTL requires an lvalue */
+	max_idx = SAFE_SEMCTL(id, 0, SEM_INFO, arg);
+
+	return get_ipc_idx_from_id(id, max_idx, sem_stat, &dummy_ds);
 }
 
 static struct tcases {
@@ -263,8 +308,15 @@ static void verify_semctl(unsigned int n)
 	struct tcases *tc = &tests[n];
 	int rval;
 
-	if (sem_id == -1)
+	if (sem_id == -1) {
 		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+		sem_index = get_sem_idx_from_id(sem_id);
+		if (sem_index < 0)
+			tst_brk(TBROK,
+				"Failed to get sem_id %d to idx mapping", sem_id);
+		tst_res(TINFO, "sem_id=%d maps to kernel index=%d",
+			sem_id, sem_index);
+	}
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
diff --git a/testcases/kernel/syscalls/shmctl/shmctl01.c b/testcases/kernel/syscalls/shmctl/shmctl01.c
index 05aea58cc..bfc11fa39 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl01.c
@@ -224,20 +224,20 @@ static void dummy_sighandler(int sig)
 	(void)sig;
 }
 
+static int shm_stat(int idx, void *buf)
+{
+	return shmctl(idx, SHM_STAT, buf);
+}
+
 static int get_shm_idx_from_id(int shm_id)
 {
 	struct shm_info dummy;
 	struct shmid_ds dummy_ds;
-	int max_idx, i;
+	int max_idx;
 
 	max_idx = SAFE_SHMCTL(shm_id, SHM_INFO, (void *)&dummy);
 
-	for (i = 0; i <= max_idx; i++) {
-		if (shmctl(i, SHM_STAT, &dummy_ds) == shm_id)
-			return i;
-	}
-
-	return -1;
+	return get_ipc_idx_from_id(shm_id, max_idx, shm_stat, &dummy_ds);
 }
 
 static void setup(void)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
