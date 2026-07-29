Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977B8C53219
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 19:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785353623; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Co+9Echa/nHLDcMKSDsTXQvCiX4Nv4/kwzrxBKtcj3Q=;
 b=ieTNtrgDTKbx+i2zE+Fxi7QRqimyzgFQm/Nz7mh9ExNjrE/agBBylbwr2IxOrk6Wf03FT
 NU4n0Lm7FOTILAMf4VZk6lwLfnvL4g6KAMyw3FWKRVIWhWfCEoEGnsE1+zsNCbUWmr7Rgog
 qum1aKfPwriEyyGqpo7scnk+UhQ8u14=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DFD53E145D
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 21:33:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBDE13D2634
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 21:33:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D482C100075F
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 21:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785353597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rl2QYf/YZDAyGWfo4hjnhMXq9DHPMtuuJwJaPeT+QTA=;
 b=UDGYZVRmEcFJp0OgRS7eQyJ/dL6jIF2f+HSoWIIjuQlGkFdxiEhmzsEM+KxmKYvt76bEqU
 f9bR2TvOyfBtRse/nD1dNUrQyBJkBfSYK1JfpKwGBmVZrSmqd6KkIqZ9HG5PC2dZBg+Lww
 GFmzvvmICEoAqg/RYCWJUh0vjMnVgBw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-3AObn56TN3-EQbZvE4BKQw-1; Wed, 29 Jul 2026 15:33:14 -0400
X-MC-Unique: 3AObn56TN3-EQbZvE4BKQw-1
X-Mimecast-MFC-AGG-ID: 3AObn56TN3-EQbZvE4BKQw_1785353594
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c083f1818so15268221cf.0
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 12:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785353594; x=1785958394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rl2QYf/YZDAyGWfo4hjnhMXq9DHPMtuuJwJaPeT+QTA=;
 b=b2OTIhqHXcijNH+OAm9n2S+NnqN21UMo+aZj6piG/nFifly9fux2UJDr0VL9aRAarv
 QZvfi6o6cZmzbCiGrQy6Twj6EyvvebBdjvcoUYOD8x+019rFfJe/RpgCRfGeZNz3nT8X
 uyoSyhiROrX70b1P3XMRd2onBn4FR5xpn5PKctsySn147AYzsCXqMjN9z6swHpUWqWOV
 RVhwEOG33yv4HmxDYzGh/miyVZRvZbx2m8VWPW5LJ0iSvn8PJa57hA5v8LmfeWLmzdTR
 Bl+rwgOIcW22ycdMz42KQE5JHma70a5ZMGd+PC1JeR2p+fdui7+ap6nF7Ip59ue4UyaB
 7yrg==
X-Gm-Message-State: AOJu0YzEnk11srWIr2cvVG9cLQW9SCybMhgrSMW01zZYIzvcS92QoPQ2
 Ba77BDwo060DCHKHeW5HdyCgpo/YKGdQJehxAGrIS4f52e5b1wx3lG+dwSdia3FHJLWGNwdOJwJ
 AsixWrY3BwlD/CoHtAbTQ8PgJv8/38O/mvnHSONYt3SZsTbJsWewlFg+1PnGU8SjLw4P6t2vQnf
 Pkno24DhWnbda8UHbW64HH0HyP2rsn1/dq/V8f
X-Gm-Gg: AR+sD12GEURbTJzC3YVgcfscfmRm51MZ5fN2196nNbQxN+YlIrNdDmglY6WptgdIKpP
 Ew0qIJkHilyBy6BrvNOPs1gHxXN5t+qmEDWrvbGRPk9jA+mlgnv5b80Ff0vuORiA8gByenA4n7U
 7rjbp2iJYobXQJnUrho+e/X0xYZ544wJ1OSpiIF/3NkgRTZbWKcQiS013BtqTKkGbtxBXE6h3U9
 2IPQT2hWvZQ1wX5rVX0ZEidVO6POS1KCmaT3g2IQ43xCJMv9U/y40AH5yFFX1pwythtm5LQSxUl
 M1BwPB8rJTvsBpEkWMFIaUx3RnswQ29OoAmI7RJt5ax9yyuuOx3ZIMj9leoVbGMQqUtgsSU8vCm
 Hw5HkTWTgYaPnViWi3FwEsX+azg==
X-Received: by 2002:a05:622a:2515:b0:528:1dd:628 with SMTP id
 d75a77b69052e-529d7197335mr74682141cf.72.1785353594203; 
 Wed, 29 Jul 2026 12:33:14 -0700 (PDT)
X-Received: by 2002:a05:622a:2515:b0:528:1dd:628 with SMTP id
 d75a77b69052e-529d7197335mr74681761cf.72.1785353593516; 
 Wed, 29 Jul 2026 12:33:13 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e30fc51fsm25456831cf.30.2026.07.29.12.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 12:33:12 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 15:33:05 -0400
Message-ID: <20260729193307.4187107-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145321.4115712-1-sbertram@redhat.com>
References: <20260729145321.4115712-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7tw7GWemj93SLG_iN5WASsxwihAADpsqOkeP2grl0DM_1785353594
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10] semctl01: fix SEM_STAT failures under parallel
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
Runtime:    16m 36s
Passed:     416000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

Assisted-by: Cursor

 testcases/kernel/syscalls/semctl/semctl01.c | 67 ++++++++++++++++++---
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..c2aee0eb0 100644
--- a/testcases/kernel/syscalls/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/semctl/semctl01.c
@@ -210,12 +210,27 @@ static void func_rmid(void)
 
 static void func_iinfo(int hidx)
 {
-	if (hidx >= 0) {
-		sem_index = hidx;
-		tst_res(TPASS, "the highest index is correct");
+	int semmsl, semmns, semopm, semmni;
+
+	/*
+	 * Return value is the highest used index; SAFE_SEMCTL already
+	 * rejects negatives. Limits are what IPC_INFO actually fills.
+	 */
+	tst_res(TINFO, "IPC_INFO highest index %d (our index %d)",
+		hidx, sem_index);
+
+	SAFE_FILE_SCANF(PATH_KERN_SEM, "%d %d %d %d",
+			&semmsl, &semmns, &semopm, &semmni);
+
+	if (ipc_buf.semmsl == semmsl && ipc_buf.semmns == semmns &&
+		ipc_buf.semopm == semopm && ipc_buf.semmni == semmni) {
+		tst_res(TPASS, "IPC_INFO seminfo matches %s", PATH_KERN_SEM);
 	} else {
-		sem_index = 0;
-		tst_res(TFAIL, "the highest index is incorrect");
+		tst_res(TFAIL,
+			"IPC_INFO seminfo %d %d %d %d, expected %d %d %d %d from %s",
+			ipc_buf.semmsl, ipc_buf.semmns, ipc_buf.semopm,
+			ipc_buf.semmni, semmsl, semmns, semopm, semmni,
+			PATH_KERN_SEM);
 	}
 }
 
@@ -227,12 +242,40 @@ static void func_sinfo(void)
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
+static int get_sem_idx_from_id(int sem_id)
+{
+	struct seminfo info;
+	struct semid_ds dummy_ds;
+	union semun arg;
+	int max_idx, i;
+
+	arg.__buf = &info;
+	/* SEM_INFO ignores semid; but SAFE_SEMCTL requires an lvalue */
+	max_idx = SAFE_SEMCTL(sem_id, 0, SEM_INFO, arg);
+
+	arg.buf = &dummy_ds;
+	for (i = 0; i <= max_idx; i++) {
+		/*
+		 * Bare semctl: unused/unreadable indices fail with
+		 * EINVAL/EACCES; SAFE_SEMCTL would abort the test.
+		 */
+		if (semctl(i, 0, SEM_STAT, arg) == sem_id)
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
+		tst_res(TINFO, "sem_id=%i maps to kernel index=%i", sem_id, sem_index);
+	}
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
