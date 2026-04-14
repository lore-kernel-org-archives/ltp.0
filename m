Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D814EF9D0E8
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776185420; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=tOKiT2N8zmNvc047K+WiWRmY8WJ3J6/5IpVSbHOjt20=;
 b=jx6Uw5m9ER96X80JbzcfLw2l1O4J7Ojo/SSFcSGOJffrsHLXRRLN0pneWQbLEfCqOBST4
 rbCjzbg9qZYFRuf+DbgLA8HvnZc1i7xXlSFyFLArnYF7CjzriDnSM76VILQ7wRy2BgCHEaN
 A2C7v/jpTKEkm4cDAabmrgjPwUzPTcQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBCF63E5E14
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 18:50:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19C923E5DCA
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 18:49:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 49A2E1A0088E
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 18:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776185388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BgaNqldyV5xs2RW8AX0dXn+cYg0/S/Y7yavOjSI7S6Q=;
 b=WB7YhP9xrqWr59gZ3zVjwmuC+sRpvMr5LWK3j3CXw1MRdnf21risuZtF52u5QMRlkD/wpZ
 srtIMiPvIMeiQJwjEoVRgAH+2RhIX0qy2rhPzlffPWDVXE5EB+lWvepLinzc+qR64JmCwr
 Nj9pQ1dCVoYlKfcPK7U22sjtYA7UJBM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-LG5J0y6mOqCzgbqojsHpeg-1; Tue, 14 Apr 2026 12:49:46 -0400
X-MC-Unique: LG5J0y6mOqCzgbqojsHpeg-1
X-Mimecast-MFC-AGG-ID: LG5J0y6mOqCzgbqojsHpeg_1776185386
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cfbfac0e05so1412291985a.1
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 09:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776185386; x=1776790186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgaNqldyV5xs2RW8AX0dXn+cYg0/S/Y7yavOjSI7S6Q=;
 b=qs087JIsS4gXw/k6+pRwQ+qrv0qTxEI7uxN9BipN8EakhhI5ll3arwuOvspaH4121w
 k/TSh4AburIG9S1a9H6AnGRqN3wFbHQ/RsqspGYnawXOyRXpfymcW8Uj5rzCujLkb6f9
 dDiMHAlhlrY1HAyIzGEFi1oC/rK0IhHPdJSPRqhteo45qqB8DcGNjZtMXxsaSlHENa2d
 Wiyp2RBAuECCA0tarrk2fXxaXmwOrzoznQLAVL/7scewElWsymfvAaj1BVVrdxNiot+I
 gLl4cPGWkDbTNpVtmI9JtB77jKmKmXC/12RAuLjv3amQAIfVRIAhBAe4xmkbq88uXSbT
 Vjuw==
X-Gm-Message-State: AOJu0YyiHjue1Zj4Tjlv2kMV5WbA5I72YGyqFxNWjlthrclRuuBjUg/+
 EIy+ixo87thu+/OeBU/2Z+MWCNZjrEOlHjRgxCU4v9cQalu95ThZJ9nKje/eSdSm3UBKhxh258H
 q0fIgm4KkqPuAfME+DxI2B7TTYVRzYMvMYYUCQZ6kY1RqhOpwvey1/NylMiIeMULuE0Khx5jabv
 VFxzA/2G8q5zUy9L0PGGRENzhbixeHm6NxTZDP
X-Gm-Gg: AeBDieuWIME62HrNUwXhO0s5dryrXQReL3NKpBse3hQsSJSZe4uGduu5cvQazsuwGE5
 aoA4HKmKO/7b4Irs/oAnUTKzSHywlpx5nB4YHOmwr9T45CXsK0qhqvfeep7MvYZaz0+VPg4gOmc
 MiuxAO45v1aQgkDIo/9zDctr7N+AXx3G3NclONJVRPbe7B6jWLCDlF369tUZ7cZ784xkAfriWkv
 vuoJfI+hIJ53X8GZwecS7JE6THytOfl7u/hzfsnjy8xWqCcm/QMWcde850YeN5OlCWOlmcHkvuF
 qXzvakLD6uP/SRu2yY5j5Q9kt/G7vGltmy46O2XrYqlwR/zp2euEgA4k5AhCD3xQbWHLhP0pVEC
 /jhkr5alA3ZRicxfTkcNN6Cb6niwFfpgbQBXokTfTtB8RfGw=
X-Received: by 2002:a05:620a:2a0d:b0:8cd:918e:e824 with SMTP id
 af79cd13be357-8dc46ec803fmr2797648785a.42.1776185385842; 
 Tue, 14 Apr 2026 09:49:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0d:b0:8cd:918e:e824 with SMTP id
 af79cd13be357-8dc46ec803fmr2797643185a.42.1776185385203; 
 Tue, 14 Apr 2026 09:49:45 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb8d6b859sm1115647985a.22.2026.04.14.09.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:49:44 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 14 Apr 2026 12:49:21 -0400
Message-ID: <20260414164927.843200-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eFeLPzP9R0-eMAkE3jSCBzpZhSd3SDiSFg7l0NHyhXI_1776185386
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] semctl: updates for multi worker testing.
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

Changed semctl01, which required updates to
reduce interference and provide an allowance
for EINVAL and EIDRM failures.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 .../kernel/syscalls/ipc/semctl/semctl01.c     | 91 +++++++++++++------
 1 file changed, 61 insertions(+), 30 deletions(-)

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
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
