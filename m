Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192C4C55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785424087; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RGgtlC7XukKAr8GQf5+tlQq1qRiXhB0tg+74bImXGj4=;
 b=PRYLojhV5jxrN6H9FODOVfBmq+AxS8BSzkbUEQz7bccIiP3oScSCbwVSJxlSOZ7/zkwiM
 owN9lFBJGVYouEM+Qja4fT8bXgpFtoJMqFNrWZG9ySidJjXFNvNAosMjQ+QMUmnbfhhb7IG
 N2atOvOlZvgDA+uMOHItVGhIqY+fMMU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ADD63E7242
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 17:08:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DC303E1B4F
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 17:07:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2020A10001E0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 17:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785424063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnL/cjYUflUUmiLDgXiptAdD2jqNJUdZwfltOZXACyU=;
 b=Uh8VxbwAQo8Jf/YbvC7WRmFfInW4L0S5x+M2XjW+G8FU7eUk/HP+WVud/HbPm1o+HFrPVM
 /A3j48FLc6q9FftOQ2myLwHh0wYFAwNK86LBJ2+dQHNS4e5Fmkmqu2JOFECqgHLBxVXrWa
 yCMLLNWWpdoCFmcJ6n04uTGoYW3bd/Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-u_DweiEeNHiY08QBOICFSg-1; Thu, 30 Jul 2026 11:07:39 -0400
X-MC-Unique: u_DweiEeNHiY08QBOICFSg-1
X-Mimecast-MFC-AGG-ID: u_DweiEeNHiY08QBOICFSg_1785424058
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso40470111cf.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 08:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785424058; x=1786028858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VnL/cjYUflUUmiLDgXiptAdD2jqNJUdZwfltOZXACyU=;
 b=n9HOsIaiAnGN/ICsRRFJlrcJKyJpaOdlhjYhCNobeo4bu6W6lNpBNHkGIQjgwu5msG
 3hU6lUzK+4NF8K6EnX+sz5apw5mzjooxkfw0HU4OnPoFWkz6f2XjU23uEt38slUUkOcj
 yCTdj0aXqF1HBu9h4KDwnMysjllqiCEzzznyY+EgcxWWppt71gkyLV+7M4TlSp9EYyCQ
 4w1gw9R2913KLEtVGC/FqIa4W8nFD3TH50ewtJCE2G69vyrSLGVsWSlJlcr6qn8VAXsB
 KG/d79EQG7hrd0SaAsxWCAS5rmpH6lhWygPUuuL3/Z9x4Hrc1BeAc51EVxhX3QmI9GjS
 HeXg==
X-Gm-Message-State: AOJu0YwDqH0d/7t4ZFF1HyCS+1C8kg6AQ3CkcjHMqSiBv6/L49zs5Hqr
 d9dVSNJ7GOm/k84pl5rjpq8uLRiN4QLBkpz5veKE5XsFEmfhgw5p/IRqN9uYHd6cNhdcB/xzxil
 m3nJSR7SVqTM3ktSyVfxiJLrPsj+ztG9liuNv7HEjfS6ing8q1tciG5qk3ReXwEgMqhh2NGJwWf
 GIiEag+5AG24suy3NgoE+W/P7umQmxJfhabgFc
X-Gm-Gg: AR+sD123Cw2W80RI7uadRTfsZ2qS3cVX59opzphSBGOpOYt1TLPU3MVjlRb54Y2ICUT
 ClvgOoSXO7+HA/PCPJw4FpGWzupe8bzkljRz09E1fFs1pikTABw9mxJ/nZn8lL3xYMBtcWQ0f8Q
 H8vp8q9Sc0X9sKni7iSkLI09XkSpKTYIqA6O4dHCxqszVudQLkZjzOqOjFndiMWZ8F81W+JfspJ
 4XiicTK583qcsbNCN/Q6i3d1188uWvZKUMwJGocsiyEWZmCHcD6ZCDQqKOqr7MG6oRFwU01lEz+
 418FRrCvLLd0FAp0drqCssNfsAKAG4qqtrt/gpn4dhTbzQNTisg/qs1Lz7Lwvw95s6TauVUiTSI
 fZcdqAu8Q+MIhylpFeEhk/U8VQQ==
X-Received: by 2002:ac8:6543:0:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52b384f502dmr33667801cf.39.1785424058360; 
 Thu, 30 Jul 2026 08:07:38 -0700 (PDT)
X-Received: by 2002:a05:6102:6895:b0:739:5cfb:50f6 with SMTP id
 ada2fe7eead31-7574e7d6e55mr1107700137.11.1785423713726; 
 Thu, 30 Jul 2026 08:01:53 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908323e8bc0sm19831986d6.26.2026.07.30.08.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:01:53 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 11:01:47 -0400
Message-ID: <20260730150149.211449-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730044737.107415-1-sbertram@redhat.com>
References: <20260730044737.107415-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2ILbcqm5rsYJA6ObKdmY5bWgZWxYElz1i5kC4LVterg_1785424058
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14] semctl01: fix SEM_STAT failures under parallel
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

The per-index lookup duplicated shmctl01's get_shm_idx_from_id(). Move
the common loop into a new get_ipc_idx_from_id() helper in libs/newipc,
shared by semctl01.c and shmctl01.c behind a small per-family stat()
wrapper on each side.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
Assisted-by: Cursor
---
Changes since v13:
- Added a shared get_ipc_idx_from_id() helper in libs/newipc
  (include/tse_newipc.h, libs/newipc/tse_newipc.c) and converted
  get_sem_idx_from_id() to use it, per review feedback.
- Converted shmctl01's get_shm_idx_from_id() to use the same shared
  helper.
- Added semctl01 to LTPLDLIBS = -lltpnewipc in
  testcases/kernel/syscalls/semctl/Makefile (semctl01 now links
  against libltpnewipc.a).
- Wrapped two tst_res()/TINFO lines in semctl01.c that exceeded 80
  columns.

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

 include/tse_newipc.h                        |  3 +
 libs/newipc/tse_newipc.c                    | 13 ++++
 testcases/kernel/syscalls/semctl/Makefile   |  2 +-
 testcases/kernel/syscalls/semctl/semctl01.c | 76 +++++++++++++++++----
 testcases/kernel/syscalls/shmctl/shmctl01.c | 14 ++--
 5 files changed, 88 insertions(+), 20 deletions(-)

diff --git a/include/tse_newipc.h b/include/tse_newipc.h
index 1d3bbd129..2c78f22ef 100644
--- a/include/tse_newipc.h
+++ b/include/tse_newipc.h
@@ -49,4 +49,7 @@ void *probe_free_addr(const char *file, const int lineno);
 #define PROBE_FREE_ADDR() \
 	probe_free_addr(__FILE__, __LINE__)
 
+int get_ipc_idx_from_id(int id, int max_idx,
+			 int (*stat_fn)(int idx, void *buf), void *buf);
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
