Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D89C5516E
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785441282; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Mi2BA6KfZ6pkrcGSTgd4+432FFRqblovI+XL1OsUN2A=;
 b=cMsM0vcERNIiS1cdAH+4/l64dpdZ0Ewtg50mRVkC6/3kIWL5HDyESoapj+rbRCCvfw//y
 dFyDwhijKhanYAr1AmyuetQ+dJCZHdMsdJpGL84Unt4so1CgGN4potuz35o06dG6In1WO7H
 wZuCAeZMZrTWjbtMwOaNG6eODb18gEs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2C4A3E7281
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 21:54:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E6953E7636
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 21:54:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 90AE81A0037F
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 21:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785441244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w96pf3mWppwoLq2pRTB+nyAoSXU6TgB4D0zAO8E3PJU=;
 b=beOLK8j2ZpYRgs3WkYflGZ1FzJfSTDPmBFJPsXRuDx/2Vph2BREDZk0WkE28Q4XOhQnawx
 gJ+PC1z0C1Wr4yiI+29mm8hsbhPtqjJf4aXPi2unT9GVZchTaqa+M/l+YlH0izso0SF/06
 ULjAP6kP7wPXZvACJKOYLZ4Mh7X8xTc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-J07z9W-OPpGwKXPwbM_KPg-1; Thu, 30 Jul 2026 15:54:01 -0400
X-MC-Unique: J07z9W-OPpGwKXPwbM_KPg-1
X-Mimecast-MFC-AGG-ID: J07z9W-OPpGwKXPwbM_KPg_1785441241
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e53b8a302so24890585a.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785441241; x=1786046041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w96pf3mWppwoLq2pRTB+nyAoSXU6TgB4D0zAO8E3PJU=;
 b=gARP43QisMqVbdm7rCVNUZFxtZAsPDaOD4B7hYIJmTIPb0q5gQLYygaIhvQ6zH7Htm
 f5XAGntRpaOcW3CFyE1YEhIaci6N6slgzbczGZc6TQtAeVtzKXYkbez4vWjZ73cExx07
 DTOGSFyHx9vVfQ6TvE+zk2LHhFOxkz9cIxrgchA+xuzsUP3BgHy36lyNA9AROwlqQdCc
 uPy4TEdPgLgT1jtfHvyBeBvoFpjkWgdP87bIWkXjqEuQ5qVWDYi+HZGBkJEj1A66fo4H
 qJ6XZqNwQg4Xe8F9xvjdNID3IOsK9Zq03eKdvzRVVA0OFcuxnA8z70tKf5Zj1YN8EcaX
 kWqw==
X-Gm-Message-State: AOJu0Yz6XvG633CT/qA4e+/8zOL/QO/ivWXOhigVIPtNnLuGHKNWAzU4
 GcBTEgsPRc5jYnWWM/m6+odadsRkO/iEUARmEscOIHtqhBMBualm0/0NBuhPyaHcSnCPdFTI1Y/
 qaVuDYoeT+vWJy3GfPN32r6RTeRNsSrDPzQLh2Di+xUqJKwO9iEUeDhhasff8u4y3Yw/mnnniqS
 qEeoeqyb+f5G98LOgHtzkEnKtK9F2PL4nCRMCh
X-Gm-Gg: AR+sD10G3PFdo2IgJ4UUCHLx3mfnljLUibEa7E1naaphPhjnViSNjNPZpSwBS3010pG
 miolErbGUMd40GOWRhEmwFxRM8/wVMN+VbzLc/Rh3+YKDy8H2gE7XgCIcXbMpqgbyz8V2MxJ4/X
 kgs+h0bN6PQH6GTFmvixPC4ZKH11x0y/XdBUUKe4R862dIc2PxCSsqctwfEdP0Rsw+DU5MHMHlq
 NwZgsjgxLwKsafMLxrnjUqGBMKLBYXy0mqJHbt6RHGu1W/hmm9swi5JyXkNCMQDTg/HPzl0A9dJ
 5B4F/P3EO9X/ODbR/1atNMhSZOgsFyZf8yH2o4YMPJu/PBl9OxxnMIn7kesYVIyovy++GCfdz6c
 6RpYflbm/OBKmY3fdFumKXQOjvw==
X-Received: by 2002:a05:620a:a0cc:20b0:92e:8037:c871 with SMTP id
 af79cd13be357-93486ee45fcmr345853185a.74.1785441240786; 
 Thu, 30 Jul 2026 12:54:00 -0700 (PDT)
X-Received: by 2002:a05:620a:a0cc:20b0:92e:8037:c871 with SMTP id
 af79cd13be357-93486ee45fcmr345850585a.74.1785441240248; 
 Thu, 30 Jul 2026 12:54:00 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e73181e1sm479185485a.25.2026.07.30.12.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 12:53:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 15:49:51 -0400
Message-ID: <20260730194953.274721-3-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730194953.274721-1-sbertram@redhat.com>
References: <20260730171956.237584-1-sbertram@redhat.com>
 <20260730194953.274721-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N_A7FbUVt6taByVQJC19uW56FBveBJ8c_qJACd47gwM_1785441241
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] semctl01: fix SEM_STAT failures under parallel
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
Look up the index for this test's own semaphore set instead, using the
get_ipc_idx_from_id() helper shmctl01 already shares.

This also updates func_iinfo(), which no longer derives sem_index, and
func_sstat() now also verifies the semaphore data SEM_STAT returns
(sem_nsems, sem_perm.mode), not just the id used to locate it.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
Assisted-by: Cursor:Sonnet-5
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

 testcases/kernel/syscalls/semctl/Makefile   |  2 +-
 testcases/kernel/syscalls/semctl/semctl01.c | 76 +++++++++++++++++----
 2 files changed, 65 insertions(+), 13 deletions(-)

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
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
