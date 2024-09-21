Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E94DCF9C68
	for <ltp@archiver.kernel.org>; Sat, 21 Sep 2024 04:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726893563; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=O69gR+qIL3SEjR4XuH9A8RupXg/cgaXJYnaRhAIZ4RY=;
 b=JwU4CohFffyka+s+qsC2s3QiC9OALnte0PInTivTpG3HId+TWNz9ymICH0FzQZkMMNNJD
 McMmbMw3LjTiD5xNH4RaPK75iaTPfTEd9kCcAln64Kxc3VQhip5yK6WHSE7t8KuNjJjCwM2
 DSmGbodgPQh2/mJ/vPC/+jWALCJAMmU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F31C93C30F4
	for <ltp@archiver.kernel.org>; Sat, 21 Sep 2024 06:39:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC3363C100E
 for <ltp@lists.linux.it>; Sat, 21 Sep 2024 06:39:02 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DE3DA1401623
 for <ltp@lists.linux.it>; Sat, 21 Sep 2024 06:39:01 +0200 (CEST)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so2024336b3a.0
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 21:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1726893540; x=1727498340; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdPZ1SqVvS09TQ1bruW19RDIrpFyCgG8s7dpCVxqXmQ=;
 b=SwfxBSRtXkOT/+srM0kiUFKkO9MhIxiHO+ryDEQciUwejgE6m2VsGJdat7XTmQujWX
 H69gY4d+Kv8UzITjxKuzqlwpPQ4pSbQvmdlK+4+ynswWfdLK8xGiTh7jtJvQweLL+zD1
 FyAXWAM6I4Mh9UrqbIcqSLJK16N8zlmEleAUxgiCw/QYEL4TQQCCF35FhEmf8wmG8KrD
 ykzni+YrjTCi/0XldK+Ut8THIGQ/E+hYdDEinQ7bpDwu1OKfyFNEy2V0rK4CJlSQPeql
 5q+32e2h+n4hbTmO9Jsf1QC8dl5oORUOFb9tRpTOWjBl6oHDnpxpeDlb5RPd+AdzvIVa
 hyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726893540; x=1727498340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tdPZ1SqVvS09TQ1bruW19RDIrpFyCgG8s7dpCVxqXmQ=;
 b=jlH+Tq9Xow01+TpiL8sfsx94/TzFsUJK0+MVXs5WPhhJd/817i3Zbrw88mlf8xZtUe
 UE2foznj+8h21gNqTniQD3T7rTvSFd6dH4luhxarJ3493hCynMFBxfLfo055gTbLpPND
 PzunxkAk9Lr26lprbA5irFPUsdqzLdY47dJBj/xwucLFJdZ4n/Ics9P2KiYkfgeSr6y1
 rLDdS2SdgeHiE/chZISko+VbMsUc8BZiEV5vZwEfA/kXW/5ru4+qrygJezbpLTZw9MWH
 awzHcB+0ZiX3N7dspY0VPmrQy6XAU9TwgWjT5U78Jzcfo2jWKhRwEs8dSOhfLfvOzn4l
 cbxQ==
X-Gm-Message-State: AOJu0YwmRblA63Hv4CzEa/S71OA3wJ9Q50C9qjbO+l4soLzVxdAwPBV2
 xvi+rJFbKu3xHKSsufhyp7BigjFfovSsKeUzVv9pwRQX1FZnyvd08OjjA5h+Fuk=
X-Google-Smtp-Source: AGHT+IGcOkaTjGs4k1Xg8LidFnC9KpC4PN2G2lVRRyzkcV7BX9lK1qSDSdFUkIee0hNZtSCYtexdow==
X-Received: by 2002:a05:6a20:8c26:b0:1d3:b38:891 with SMTP id
 adf61e73a8af0-1d30b380969mr6724472637.6.1726893540282; 
 Fri, 20 Sep 2024 21:39:00 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944b9a74esm10558984b3a.169.2024.09.20.21.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 21:38:59 -0700 (PDT)
To: chrubis@suse.cz
Date: Sat, 21 Sep 2024 12:38:54 +0800
Message-Id: <20240921043854.392547-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Zu1pGq6bklSY3SSZ@yuki.lan>
References: <Zu1pGq6bklSY3SSZ@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ht_affinity.c: fix ht_affinity test failure
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
Cc: Haifeng Xu <haifeng.xu@shopee.com>, ltp@lists.linux.it
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

After using sizeof on the mask instead of sizeof(unsigned long), ht_affinity
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
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
Changes since v1:
- Don't change the type of the mask and use sizeof on it. 
---
 .../kernel/sched/hyperthreading/ht_affinity/ht_affinity.c     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
index f6e9f2745..3c2fe1bf1 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
@@ -67,7 +67,7 @@ int HT_SetAffinity(void)
 		tst_resm(TINFO, "Set test process affinity.");
 		printf("mask: %x\n", mask);
 
-		sched_setaffinity(pid, sizeof(unsigned long), &mask);
+		sched_setaffinity(pid, sizeof(mask), &mask);
 
 		for (j = 0; j < 10; j++) {
 			for (k = 0; k < 10; k++) {
@@ -95,7 +95,7 @@ int HT_SetAffinity(void)
 		tst_resm(TINFO, "Set test process affinity.");
 		printf("mask: %x\n", mask);
 
-		sched_setaffinity(pid, sizeof(unsigned long), &mask);
+		sched_setaffinity(pid, sizeof(mask), &mask);
 
 		for (j = 0; j < 10; j++) {
 			for (k = 0; k < 10; k++) {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
