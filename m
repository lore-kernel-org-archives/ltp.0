Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E6BCF58F1
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726822101; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=2urPBc6HniQ8FTHMOjdy5o+UA88Syv1FRtIZnSVzZcQ=;
 b=SCvIwzm60w4Xt6JDSktc6tFdxEW72LAj1Pm2jfs4brNQml5ruTsDkM81txDmQaUdYqjfQ
 Ic+or2mKpOoAgZktUp/eJE7cQqIAhYGki/Shou9jTiKBUMR9hiDO44QDYMLOwKlueV+1CGM
 4JsY3DvQdWlCXQ76gQDjuHWYUur03Kg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7160F3C301D
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 10:48:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14AA23C28AC
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 10:30:44 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8AC85208F8F
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 10:30:43 +0200 (CEST)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7191fb54147so1316076b3a.2
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1726821041; x=1727425841; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BYR4jeI4HaVoZDExVlC3ZW83o29iZco+Lcuti2F/fwU=;
 b=ZPRusIvy9zvkTLRT0sc77JtsodUzYt63vyMdtp8nw0o/PXHsr98Rdm76SYX6KoxDR9
 YLaDMZUH+UBCIoqueLZSraY8wUlfXB1g5xhmG8tkg/LrGKdFZD/sQYLDM6IA8Iu4gIzf
 qBdT85eE2QUt8lEGkkJqt1Krjva19cakjmXFUXLZMHWRnLdzbnJWf/MuVBC2i3Wke90x
 x8xEDopFqe1asDvnz0jowdvpR+N66wOAzZ809hPIKdeDOy24PjhDbq9V9eushdjM/wTc
 MAPHBLyyK6Hz2OY18k+Jkjcw6qF/qo1FvZIqd/lE7wgY6ZUaLOazm0BJTgZ7V+xyRvdk
 RN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726821041; x=1727425841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BYR4jeI4HaVoZDExVlC3ZW83o29iZco+Lcuti2F/fwU=;
 b=UckXSuAr/V/9ks8H8K66HL6qxeRJCAj/NCzzXhzRggGg/PLJM+nwB1D6ouw1QmCcHr
 rZA57x80J46HvLpY1cP145j+H/lBSuG1ubvKwTfPfq4YBkC1/flaW67sO1S9DmO2PAqK
 LLDj8UYers+6Jb1Id7DA/t9/S9ju4Qbf51jZQTu1x6wefieLNPVzIClPnD1BXv6E+C5K
 dPhyoIM6I0cWh566l7P83gmdWJwkVQHJ0jqGINWZIA0us8WT6rCFwT2aPXpN0j5Xt0KS
 k45OhNPZmzTMPbPvTk4GI0rvOHNT+B1E3KCaqPqRVktFe+QuN6hODhjERl31njWJzcBn
 kHAQ==
X-Gm-Message-State: AOJu0YwZm5oEQlOWGA3K9F/2gESJFOiw/c/+bNw9GaAdRN5c9VJLeX0E
 o6b2omdaIVTzOAUt1Jfl0dqs29f/fx7xETTuIdKf1uN7PhQyGnaimsXlfvsjehPVriXtYu9R/xN
 xsHcDzQ==
X-Google-Smtp-Source: AGHT+IGakqZe8n157UYbE6UQg7db++dTA9ooA4+qNVXVpVImKJjo8G6f5AY3osj6eaFCHlBYtc6Otw==
X-Received: by 2002:a05:6a00:92a2:b0:710:da27:f176 with SMTP id
 d2e1a72fcca58-7199cd6bbc4mr3504760b3a.12.1726821041106; 
 Fri, 20 Sep 2024 01:30:41 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944a97e87sm9337537b3a.1.2024.09.20.01.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:30:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 20 Sep 2024 16:30:36 +0800
Message-Id: <20240920083036.87291-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 20 Sep 2024 10:48:00 +0200
Subject: [LTP] [PATCH] ht_affinity.c: fix ht_affinity test failure
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
From: Haifeng Xu via ltp <ltp@lists.linux.it>
Reply-To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Haifeng Xu <haifeng.xu@shopee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Running ht_affinity test fails:

	smt_smp_affinity    0  TINFO  :  Set affinity through system call
	smt_smp_affinity    0  TINFO  :  Set test process affinity.
	mask: 1
	smt_smp_affinity    0  TINFO  :  ...Error

	...

	smt_smp_affinity    0  TINFO  :  Set test process affinity.
	mask: c0000000
	smt_smp_affinity    0  TINFO  :  ...Error
	smt_smp_affinity    3  TFAIL  :  ht_affinity.c:240: System call setaffinity() is error.

The type of cpumask pointer used in set_affinity() is unsigned long, but
ht_affinity used a unsigned int pointer. When kernel copy cpumask from
user-space pointer, the high 32bit of cpumask is a random value. So the
process can't be bind to the cpu specified by users.

After converting the cpumask from unsigned int to unsigned long, ht_affinity
test succeeds:

	smt_smp_affinity    0  TINFO  :  Set affinity through system call
	smt_smp_affinity    0  TINFO  :  Set test process affinity.
	mask: 1
	smt_smp_affinity    0  TINFO  :  ...OK

	...

	smt_smp_affinity    0  TINFO  :  Set test process affinity.
	mask: c0000000
	smt_smp_affinity    0  TINFO  :  ...OK
	smt_smp_affinity    3  TPASS  :  System call setaffinity() is OK.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 .../kernel/sched/hyperthreading/ht_affinity/ht_affinity.c   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
index f6e9f2745..e6829c2d2 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
@@ -48,7 +48,7 @@ len - length in bytes of the bitmask pointed to by user_mask_ptr.
 
 int HT_SetAffinity(void)
 {
-	unsigned int mask;
+	unsigned long mask;
 	pid_t pid;
 	int result = 1;
 	int cpu_count, i, j, k, cpuid;
@@ -65,7 +65,7 @@ int HT_SetAffinity(void)
 
 	for (i = 0, mask = 0x1; i < cpu_count; i++, mask = mask << 1) {
 		tst_resm(TINFO, "Set test process affinity.");
-		printf("mask: %x\n", mask);
+		printf("mask: %lx\n", mask);
 
 		sched_setaffinity(pid, sizeof(unsigned long), &mask);
 
@@ -93,7 +93,7 @@ int HT_SetAffinity(void)
 
 	for (i = 0, mask = 0x3; i < cpu_count - 1; i++, mask = mask << 1) {
 		tst_resm(TINFO, "Set test process affinity.");
-		printf("mask: %x\n", mask);
+		printf("mask: %lx\n", mask);
 
 		sched_setaffinity(pid, sizeof(unsigned long), &mask);
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
