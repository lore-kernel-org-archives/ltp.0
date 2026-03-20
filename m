Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4CA1093163
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773972198; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=EEZ8bVaGVPJbJjWpJacac5Y7XyAHYekea5/j4fVGZ+k=;
 b=JlUaz66pOl8MAhO0jdljs3jgX2Z4axLcMiPSM8kkMkXI7aNerme+dDQ1TfEoJ4Wk/O4x7
 pG79utH4hg+Dsg7zoo1rai5wec12VtwKP8BRJe0Cgym75a4enlbq5uVSyaP2WPzo6abqHbq
 dpKQT8ILqmIyNmz+lShvrXX79Prf3Bk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0619E3E4B79
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 03:03:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CDEF3C01E9
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 03:02:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4B9DC1001174
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 03:02:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773972169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=02HUb/FIDsSOoQrX6CkzmcEX3pRwIRBNuYWTloMaIbA=;
 b=DwUajlyxyUjWfafsJb6K9P9JTr4LsC9L2almNFz07w2WKY4TG00zUV35C2D3EOhSn8jBw9
 +JjxC+PcgFMMdv2vSVTglK4tnO155CtxFyu4r4TSe2D0x5GO/DoVcIN+jwxs33LF4G2tiF
 C+QKFXCZdYZQJMQE7KD/azZ7jrFf39M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-RyZn4yj8MmOcV7RyFWQevg-1; Thu, 19 Mar 2026 22:02:47 -0400
X-MC-Unique: RyZn4yj8MmOcV7RyFWQevg-1
X-Mimecast-MFC-AGG-ID: RyZn4yj8MmOcV7RyFWQevg_1773972166
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd849cd562so134726485a.0
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 19:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773972166; x=1774576966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02HUb/FIDsSOoQrX6CkzmcEX3pRwIRBNuYWTloMaIbA=;
 b=ba7FvRRWGdYG96kuE8R6VabpNd8qhM8nEna37Tva7ptOlwHk9vZz9xVi2UW8zYyutI
 qQrvFvs0Yuk3H2PfgT5Iofsh0CRkmhcbN+054qINs2xG6fmsPo3rnQngV1ZuiXEhJe7/
 LWSo4wAwlkPZBAq+kXqMA4wbNcAUJhU8SgzTy3yfMQwwHv0HK+m41ORrND2De9G/Oth6
 /fnV8Le+1LOrDoQJEcqIj5ifWOJ9QGtBmiixddZaD06OYP1mLBfRz2zipv+6iPaV5ND2
 Pl+zP/vAleg7qw1715tNunRK6ORw7BP+zsjEMe/xA/Wtw9/3KhFO0PVKTzIeOWLeQP9w
 i7wQ==
X-Gm-Message-State: AOJu0YxQQNSs8y39AG4WaiTi8BI39yqnZ8kArwWMnagowt2ruxXefbQk
 AZ5OD5gOQ499L0RuFBLQ0JnuKEQH6E2HePunG/S+RBKFDi6a2D5i9GyqmWxXI43tPaMWSOwGrGj
 kfRLul7ns+pKzGQA5kIsLIGT/Iiq6WSoktZyShFY49783Czyh1T6bNbsF5+IxOTxUKLMj8aiRSz
 n4gq5gqyTyOCONEct7vLkJVPbDBVBfRs/ySvFM
X-Gm-Gg: ATEYQzw48mZAAe3zLK2LQ89A/QOk6fCiia+KoCEJZFHlJ44tDdNb2il10TYzD6H9K3D
 GqHh+27GdXtbaiwdczJS91Rw/vzj/oAm7LT8XtKtwLNp9rTnwmNB//ji1R8l2hiW/KR9mRK0EJn
 bY9iSsw6VaqhXZD2dE4R0XAGkTKhzfYtxEG57TPmOBozYaNLBVXljR/KKHJpRdE70BCBhREmOYn
 UQ4CD4MdmLZpTnXol62rHV7PNGmXj6l2Iq6/lFEDhudNOXz733srIBrVxxVvLWEWw+ah/cHfqzn
 HtJlQGrY76CKWa7cYodAsiogvCKuQbd3pbGAGDSYoJYU62Q4dE/52N4EBqcG2tr7L1WbmoAQXYm
 zJlEVattiTLPYS4qIFNnnABe6drCEx9LQIEj2oewQi2qUp1U=
X-Received: by 2002:a05:620a:4594:b0:8cd:8751:2b26 with SMTP id
 af79cd13be357-8cfc7f823famr236420385a.58.1773972166328; 
 Thu, 19 Mar 2026 19:02:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4594:b0:8cd:8751:2b26 with SMTP id
 af79cd13be357-8cfc7f823famr236415885a.58.1773972165695; 
 Thu, 19 Mar 2026 19:02:45 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc90e7587sm59441485a.46.2026.03.19.19.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 19:02:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 19 Mar 2026 22:02:19 -0400
Message-ID: <20260320020233.211264-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ohJCjPVqPy602sERhQVf_nWGHHO13IwYAK_aX2StfR4_1773972166
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] semctl: updates for multi worker testing.
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

Changed semctl03, semctl05 and semctl07 by
replacing the key with IPC_PRIVATE.

Changed semctl01, which required updates to
reduce interference and provide an allowance
for EINVAL and EIDRM.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 .../kernel/syscalls/ipc/semctl/semctl01.c     | 91 +++++++++++++------
 .../kernel/syscalls/ipc/semctl/semctl03.c     |  5 +-
 .../kernel/syscalls/ipc/semctl/semctl05.c     |  6 +-
 .../kernel/syscalls/ipc/semctl/semctl07.c     |  3 +-
 4 files changed, 64 insertions(+), 41 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index 5bd675ab6..25c7ebc65 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -8,6 +8,7 @@
 
 #define _GNU_SOURCE
 #include <stdlib.h>
+#include <pthread.h>
 #include "tst_safe_sysv_ipc.h"
 #include "tst_test.h"
 #include "lapi/sem.h"
@@ -18,14 +19,16 @@
 #define NCHILD  5
 #define SEMUN_CAST (union semun)
 
-static int sem_id = -1;
-static int sem_index;
+static __thread int sem_id = -1;
+static __thread int sem_index;
 static struct semid_ds buf;
 static struct seminfo ipc_buf;
 static unsigned short array[PSEMS];
 static struct sembuf sops;
 static int pid_arr[NCHILD];
 
+static pthread_mutex_t sem_stat_lock = PTHREAD_MUTEX_INITIALIZER;
+
 static void kill_all_children(void)
 {
 	int j;
@@ -243,28 +246,36 @@ static struct tcases {
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
+	{NULL, 0, IPC_STAT, func_stat, SEMUN_CAST & buf, NULL},
+	{NULL, 0, IPC_SET, func_set, SEMUN_CAST & buf, set_setup},
+	{NULL, 0, GETALL, func_gall, SEMUN_CAST array, NULL},
+	{NULL, 4, GETNCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
+	{NULL, 2, GETPID, func_pid, SEMUN_CAST & buf, pid_setup},
+	{NULL, 2, GETVAL, func_gval, SEMUN_CAST & buf, NULL},
+	{NULL, 4, GETZCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
+	{NULL, 0, SETALL, func_sall, SEMUN_CAST array, sall_setup},
+	{NULL, 4, SETVAL, func_sval, SEMUN_CAST INCVAL, NULL},
+	{NULL, 0, IPC_INFO, func_iinfo, SEMUN_CAST & ipc_buf, NULL},
+	{NULL, 0, SEM_INFO, func_sinfo, SEMUN_CAST & ipc_buf, NULL},
+	{NULL, 0, SEM_STAT, func_sstat, SEMUN_CAST & buf, NULL},
+	{NULL, 0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
 };
 
 static void verify_semctl(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
-	int rval;
+	int rval, sid;
+	int retries = 5;
+
+	/* Resolve sem id: SEM_STAT uses sem_index, others use sem_id */
+	if (tc->cmd == SEM_STAT)
+		sid = sem_index;
+	else {
+		sid = sem_id;
+		if (sid == -1)
+			sem_id = sid = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	}
 
-	if (sem_id == -1)
-		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
@@ -279,21 +290,41 @@ static void verify_semctl(unsigned int n)
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
+	/* SEM_STAT: get index under lock, call SEM_STAT without lock, retry on EIDRM and EINVAL */
+	if (tc->cmd == SEM_STAT) {
+		do {
+			pthread_mutex_lock(&sem_stat_lock);
+			sem_index = semctl(0, 0, IPC_INFO, (union semun)&ipc_buf);
+			pthread_mutex_unlock(&sem_stat_lock);
+			if (sem_index < 0)
+				tst_brk(TBROK | TERRNO, "semctl(0, 0, IPC_INFO)");
+			rval = semctl(sem_index, 0, tc->cmd, tc->arg);
+			if (rval >= 0)
+				break;
+			if ((errno != EIDRM && errno != EINVAL) || --retries <= 0)
+				tst_brk(TBROK | TERRNO, "semctl(SEM_STAT)");
+		} while (1);
 		tc->func_test(rval);
-		break;
-	default:
+	} else if (tc->cmd == IPC_RMID) {
+		pthread_mutex_lock(&sem_stat_lock);
+		SAFE_SEMCTL(sid, tc->semnum, tc->cmd, tc->arg);
+		pthread_mutex_unlock(&sem_stat_lock);
 		tc->func_test();
-		break;
+	} else {
+		rval = SAFE_SEMCTL(sid, tc->semnum, tc->cmd, tc->arg);
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
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index 5a11b95ef..dc11d0823 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -84,14 +84,11 @@ static void verify_semctl(unsigned int n)
 
 static void setup(void)
 {
-	static key_t semkey;
 	struct test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
-	semkey = GETIPCKEY();
-
-	sem_id = SAFE_SEMGET(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
 
 	bad_ptr = tst_get_bad_addr(NULL);
 }
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
index 985c1f039..f1ab69f59 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
@@ -45,11 +45,7 @@ static void verify_semctl(unsigned int n)
 
 static void setup(void)
 {
-	static key_t semkey;
-
-	semkey = GETIPCKEY();
-
-	sem_id = SAFE_SEMGET(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index 1b03f0ab2..a0b5f4928 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -130,10 +130,9 @@ static void verify_semctl(void)
 
 static void setup(void)
 {
-	key_t key = GETIPCKEY();
 	nsems = 1;
 
-	semid = SAFE_SEMGET(key, nsems, SEM_RA | IPC_CREAT);
+	semid = SAFE_SEMGET(IPC_PRIVATE, nsems, SEM_RA | IPC_CREAT);
 }
 
 static void cleanup(void)
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
