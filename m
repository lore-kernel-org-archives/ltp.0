Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A7AC53219
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785347802; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=U50k2MiDTqLwRBt4IYbH3glcwmxzFS4sbs1IhTzoHDI=;
 b=Yn0ppaiWGEOgTI4DuWHpr6Pem+vzpXTcFET0+o+amMZcAcc9RCXGrrJ3Ho/qT1Jvx4Z5j
 /nqRgJ49KBySEJFefgSSm57SDG0+4r0SkMvb7EkM+9flZyZjJX38ONR2xD2VgRw4PGY9XXC
 tZ/DHzYPlac86Nd6jnM3HwEtzDKXCqw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D28093E7280
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 19:56:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 901C53E29BF
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 19:56:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C67FF140005D
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 19:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785347779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96wmYM75ELiJ0rK9qqCFrv7e30qOH+Z49asT6Kb2v2o=;
 b=FV+mk7n6mVvvxWbJaR1D5q36kR8SvHLAI7/5p6UG4unQpuUN97Y9ZP1aKyrVBaJ+7Bee+P
 MuxTh2h27M4gz+IHD4OJJXAPotSPQVsjUySXJ3O6NlaZBk4iIhj2XyGc1PLAfOPHcReNrG
 njcXFidDVpifZNd/Vv2riWuXX2hnysM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-GSIbroGdMLS_j5SPdL9ypQ-1; Wed, 29 Jul 2026 13:56:17 -0400
X-MC-Unique: GSIbroGdMLS_j5SPdL9ypQ-1
X-Mimecast-MFC-AGG-ID: GSIbroGdMLS_j5SPdL9ypQ_1785347776
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92efd2ca21aso266720585a.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 10:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347776; x=1785952576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=96wmYM75ELiJ0rK9qqCFrv7e30qOH+Z49asT6Kb2v2o=;
 b=HT8syrmULAzny/1txBv1z0QZpSzEPmifyqxByMx4fWoV0gHlFG7+ljmW/EZKWD6IPU
 hNgEGwkDRuVe4/ZCSM8sC9F5vXHHnZBhvw8OFnbXq2lyAKWSlvyGgr1j4E2b+MWkELAh
 j0b0XbhBWfNjqkMAe615GMuoICEjIRHVzJAT8WSZVSpd97dQBsfSumJsTkM9cSmCXaQZ
 eE+j3TUcmMzo3fIEiwf3xYXrex6/1LH3Lmz5bFw04l6quLfbhMeTOfXVHIYk/18hNqmw
 biptcJmNeNU9nvp/Ic7XcfRN0zjmbr8kYhv5d8hNKXM1AiJSkHbVYtqqX1jAlTrH/o+F
 NR8Q==
X-Gm-Message-State: AOJu0YwRIT6vVTX4geDbeKErav05kxizPBfmX8xVih0M9ZaDCPm4OqJS
 S/GgFkOIer+9H+3CUga2RMwF8dZAA/XGbzw2irh6tMz+M1rTgm4Gu+QDYIBHwEsnk9yVhpw1efv
 v4tdMPjmzFBC6FA8unqkmVOoYS6OvNWnCof35Tvr1A06zt09G3nF5y8lyT5tw3T8jJiEeaTSP6f
 JszqU1DveS7aUxG/ilauPbEvEgEcvfwgkOK1Qm
X-Gm-Gg: AR+sD1302LMUT08YOq2sJDDRpmYWxmd9RZIPI2X0ia1tWiMOEz9rez5SOr4eUzb7H+O
 8bk2J0UiQefETNIkf4+LgMzyCQb/CZIM4fuJbqywKbWot5vzaw9YWmIp/11r41lkNonIwz+XM6l
 OwkLASKuhBzhjY326OyNJy5kckp+us9HbPeuJyX2skipCO+l5wz0v/jQd8LiHlG0sIEn7gJoOXS
 tl3EadP7AxnHj5po7W53v5HjAn43Erq38tO8mu7O5nqF69SCuo3k79PGu0Uoc9ZPkq/stwN+hTy
 5/ON5pGlOriBWUvdfeYCycV0IYPgB9oiOKHeOiYYpF2V+YtBV6VS1nrlx23LHTBbl02PmGYUF42
 6hLbO9OOe1VMPxxHaZ58vIVUqbQ==
X-Received: by 2002:a05:620a:4107:b0:91c:d0b6:13f5 with SMTP id
 af79cd13be357-9330267b746mr747805585a.19.1785347776256; 
 Wed, 29 Jul 2026 10:56:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4107:b0:91c:d0b6:13f5 with SMTP id
 af79cd13be357-9330267b746mr747801585a.19.1785347775553; 
 Wed, 29 Jul 2026 10:56:15 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d32214e1sm220345485a.5.2026.07.29.10.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:56:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 13:56:10 -0400
Message-ID: <20260729175611.4161450-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145321.4115712-1-sbertram@redhat.com>
References: <20260729145321.4115712-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xeqGVKNnijuHAxcLV-TNbC6LLHsuHiR7rUrDEN9gOS8_1785347776
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9] semctl01: fix SEM_STAT failures under parallel LTP
 runs
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
Runtime:    16m 33s
Passed:     416000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

Assisted-by: Cursor

 testcases/kernel/syscalls/semctl/semctl01.c | 49 ++++++++++++++++-----
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..3d1671e33 100644
--- a/testcases/kernel/syscalls/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/semctl/semctl01.c
@@ -210,13 +210,12 @@ static void func_rmid(void)
 
 static void func_iinfo(int hidx)
 {
-	if (hidx >= 0) {
-		sem_index = hidx;
-		tst_res(TPASS, "the highest index is correct");
-	} else {
-		sem_index = 0;
-		tst_res(TFAIL, "the highest index is incorrect");
-	}
+	if (hidx >= sem_index)
+		tst_res(TPASS, "IPC_INFO highest index %d >= our index %d",
+			hidx, sem_index);
+	else
+		tst_res(TFAIL, "IPC_INFO highest index %d < our index %d",
+			hidx, sem_index);
 }
 
 static void func_sinfo(void)
@@ -227,12 +226,35 @@ static void func_sinfo(void)
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
+	max_idx = SAFE_SEMCTL(id, 0, SEM_INFO, arg);
+
+	arg.buf = &dummy_ds;
+	for (i = 0; i <= max_idx; i++) {
+		if (semctl(i, 0, SEM_STAT, arg) == id)
+			return i;
+	}
+
+	return -1;
 }
 
 static struct tcases {
@@ -263,8 +285,13 @@ static void verify_semctl(unsigned int n)
 	struct tcases *tc = &tests[n];
 	int rval;
 
-	if (sem_id == -1)
+	if (sem_id == -1) {
 		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+		sem_index = get_sem_idx_from_id(sem_id);
+		if (sem_index < 0)
+			tst_brk(TBROK, "Failed to get sem_id to idx mapping");
+		tst_res(TINFO, "sem_id=%i maps to kernel index=%i", sem_id, sem_index);
+	}
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
