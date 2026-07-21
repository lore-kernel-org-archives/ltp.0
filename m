Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97931C44532
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784642173; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GF7FC+oBVH/W/yhZ+jjuGugY2cabty8Y9gqqWD2ECDg=;
 b=HaxNiDI6T8HEkbES3p45d7T2vVLKel70CkVhq+RqxXDnrGsjx1kRic5E3z1HVkIR0GMVl
 0r5bILHecoscSj6l9WaPMgFTqG/d/sLIg61r+sIFHnZfvi+Uu1Eiee88Vz50bbdU3qOa/x9
 uAopoMmVEktfj7mdFmDnCH7/B3N1i90=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 943D93CEF3D
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 15:56:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39DD33C2603
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:55:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C34E200260
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784642149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+XPV+ZALx2fslwP4OaWIlwMQTrQeNRSkUgl93BdSHM=;
 b=MjiQHUGAIfa2xDCNQRdxZ20a1/LStiUAY6fwvPe9Fv7o0weSKlfKGrzK2WlHg0183FWsP9
 RGSBPmr4DFEy0vy0wsF/aeH/r7jPn4Kdnws8SLxGuLBiFTkCaAxiA3RP//QrTqYQ5Ryjys
 QY1qOHUwY+l2S0AbEnlK9Vd9IHFHXcg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-TvcXGcVJMK62T1e7PUgwTA-1; Tue, 21 Jul 2026 09:55:46 -0400
X-MC-Unique: TvcXGcVJMK62T1e7PUgwTA-1
X-Mimecast-MFC-AGG-ID: TvcXGcVJMK62T1e7PUgwTA_1784642146
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f08560ea44so170203986d6.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 06:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784642146; x=1785246946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y+XPV+ZALx2fslwP4OaWIlwMQTrQeNRSkUgl93BdSHM=;
 b=Gb1v7KKbsBL9OzYSOMCo41+wdGY3U07env4olFK0xQDsl9e/xWcGbDXkAzt2oXl5vV
 oI5F2HEIBZZQ+irZG8mx71oTjPRprESfu6vTJgIF1lc5mVBfzyB0SGzvmsmrWh37oQKQ
 q0IyysQpO1PIv00wZoffxKCS1nE3wMRFG4/wRFjHlbG06bw0TP0YAbXPAQMUQSvkmmbP
 w6GrLk4qi8texXGDYEwH63LUCOSl66jEjfX2Ligjw+a1PkmADEn0rVbL3drIzXSuwY77
 vDOYj9jdT8Fr0G2xK/qWzA18s/fBR3Ez3h1+ZaHrbI/G/ey0oFGXH+BiVlrGP+HV5prd
 SstQ==
X-Gm-Message-State: AOJu0YwOtqIsNq2Vtv9qETHQPxmLYOoI7RK3Dzusk0x4mrCLS/EFBBef
 QPPp5tYaHT0f8+MRsRVfqWPBIH3Aj0aVvOG8gh1fQScsK0qj5FzmXuNK3lNUp/H4cC1Wke7ERKz
 tZFwq31L8YYG9iqpoxSVRObO4MakhryYyJApmM/WuLdspEPf3cgUeKz17QK0IRTfMQZuA3p8nzh
 F2/CqjtTY1v+WNnHb1U4TdjR0WgJtDbUl2D1rq
X-Gm-Gg: AfdE7cmRu7Xsd+TAWTUi7xHi+07Uxkq8uOALWyMU6UP2h0RmjZm2VtWeK5w4uQIHrsB
 IqEgI2ewkLXnsTU/0X84zXSPnEbg/NqYkYpa3hpyQJQ/IeQbD7cc44TO5h8w8fJSigKOv9lBcCB
 BaGm68DbMH39djS4ihAh7SMIK4U4WkHxUagQl2ZV8R/zrshOyk1+Id9B2B5dbql7Qp82P1yb+Er
 ShW5zSl0Ih7yMHYhbaOdYZEptADGdZv4WvfCvIWqrMnBMKw3FaBzbo6uH72VHdxv2ev/1e9sIty
 PFHN37SJV7XfnKKBD1l+E+OqHJaAPi+a5zo2tRuQjosy6iMCxosJtXFPAqonoJUNcOXTU1htFIk
 u6duYkSPv8DNlnUZS6o6SUFAA1A==
X-Received: by 2002:a05:622a:14d:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-5213b146e19mr178326171cf.25.1784642145379; 
 Tue, 21 Jul 2026 06:55:45 -0700 (PDT)
X-Received: by 2002:a05:622a:14d:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-5213b146e19mr178320011cf.25.1784642134352; 
 Tue, 21 Jul 2026 06:55:34 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5214d09bb08sm94771341cf.12.2026.07.21.06.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:55:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 09:55:28 -0400
Message-ID: <20260721135530.2882066-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720235649.2783420-1-sbertram@redhat.com>
References: <20260720235649.2783420-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QMv_x7UZzgQVvmcRZCp12Gd0-JlfQFa7ETn93bagY5c_1784642146
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] semctl01: tolerate SEM_STAT races under parallel
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
Cc: Stephen Bertram <sbertram@redhat.com>, fdarocha@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When multiple LTP workers run IPC tests concurrently, SEM_STAT can fail
with EIDRM/EINVAL because the index from IPC_INFO can disappear before
SEM_STAT runs. Retry a few times instead of treating that as TBROK.

The test remains single-threaded; shared globals are intentional.

Test: ./kirk -w 4 -f syscalls_32 -p semctl01 -i 1000

Results summary before:
runtime:      997.690s
passed        415980
failed        0
broken        10
skipped       0
warnings      0

Results summary after:
runtime:      998.593s
passed        416000
failed        0
broken        0
skipped       0
warnings      0

Assisted-by: Cursor

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/semctl/semctl01.c | 84 +++++++++++++--------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
index 5bd675ab6..c0e9e8f41 100644
--- a/testcases/kernel/syscalls/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/semctl/semctl01.c
@@ -19,7 +19,6 @@
 #define SEMUN_CAST (union semun)
 
 static int sem_id = -1;
-static int sem_index;
 static struct semid_ds buf;
 static struct seminfo ipc_buf;
 static unsigned short array[PSEMS];
@@ -211,10 +210,8 @@ static void func_rmid(void)
 static void func_iinfo(int hidx)
 {
 	if (hidx >= 0) {
-		sem_index = hidx;
 		tst_res(TPASS, "the highest index is correct");
 	} else {
-		sem_index = 0;
 		tst_res(TFAIL, "the highest index is incorrect");
 	}
 }
@@ -236,28 +233,51 @@ static void func_sstat(int semidx)
 }
 
 static struct tcases {
-	int *semid;
 	int semnum;
 	int cmd;
 	void (*func_test) ();
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
+	{0, IPC_STAT, func_stat, SEMUN_CAST & buf, NULL},
+	{0, IPC_SET, func_set, SEMUN_CAST & buf, set_setup},
+	{0, GETALL, func_gall, SEMUN_CAST array, NULL},
+	{4, GETNCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
+	{2, GETPID, func_pid, SEMUN_CAST & buf, pid_setup},
+	{2, GETVAL, func_gval, SEMUN_CAST & buf, NULL},
+	{4, GETZCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
+	{0, SETALL, func_sall, SEMUN_CAST array, sall_setup},
+	{4, SETVAL, func_sval, SEMUN_CAST INCVAL, NULL},
+	{0, IPC_INFO, func_iinfo, SEMUN_CAST & ipc_buf, NULL},
+	{0, SEM_INFO, func_sinfo, SEMUN_CAST & ipc_buf, NULL},
+	{0, SEM_STAT, func_sstat, SEMUN_CAST & buf, NULL},
+	{0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
 };
 
+/*
+ * SEM_STAT takes an ipc idr index. Under parallel IPC tests that index can
+ * vanish between IPC_INFO and SEM_STAT (EIDRM/EINVAL). Refresh and retry.
+ */
+static int do_sem_stat(union semun arg)
+{
+	int idx;
+	unsigned int retries = 5;
+
+	do {
+		int info_id = 0;
+
+		idx = SAFE_SEMCTL(info_id, 0, IPC_INFO, (union semun)&ipc_buf);
+		TEST(semctl(idx, 0, SEM_STAT, arg));
+		if (TST_RET >= 0)
+			return TST_RET;
+		if (TST_ERR != EIDRM && TST_ERR != EINVAL)
+			tst_brk(TBROK | TERRNO, "semctl(SEM_STAT)");
+	} while (--retries);
+
+	tst_brk(TBROK | TERRNO, "semctl(SEM_STAT) still failing after retries");
+	return -1;
+}
+
 static void verify_semctl(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
@@ -265,6 +285,7 @@ static void verify_semctl(unsigned int n)
 
 	if (sem_id == -1)
 		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+
 	if (tc->func_setup) {
 		switch (tc->cmd) {
 		case GETNCNT:
@@ -279,21 +300,24 @@ static void verify_semctl(unsigned int n)
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
+	if (tc->cmd == SEM_STAT) {
+		rval = do_sem_stat(tc->arg);
 		tc->func_test(rval);
-		break;
-	default:
-		tc->func_test();
-		break;
+	} else {
+		rval = SAFE_SEMCTL(sem_id, tc->semnum, tc->cmd, tc->arg);
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
