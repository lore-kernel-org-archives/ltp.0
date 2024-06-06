Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56748C27C52
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717695657; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=34ifTmDW1OhjzQ9i+mPtw2GScZik7+iMW4bb90kbQws=;
 b=dBgl7eeAvp6qPCueCw/DdQMfTGAfOE4D7m0TYL4HXO+QOjuolLR4c22nZXpefKLf0Xgmw
 rjdlO3sUJ98ssMn0Hqje8sVD+z6yAlD5wCrQRUCyhTkPOzMbE+RfukcW9Phclye+xw0oTxY
 6mga8gKMS2Ud+HJrdOgLqbB8vmQzWZ0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D908C3D0A88
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 19:40:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58A8A3D0987
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:39:46 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB4261A0BC46
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:39:45 +0200 (CEST)
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-df773f9471fso2380952276.3
 for <ltp@lists.linux.it>; Thu, 06 Jun 2024 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717695584; x=1718300384; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=K4abEuoKQvd0YyYbRSUE6ydyP9nVNeVQVyHbs+ZQEps=;
 b=LrlxlMIi+7OZuLAhkZIQGtxF3LMlD+rSjoj4W9d+ZuhUhTzpHtbXGzjWeA/TR5j7fv
 n6HNOdSSuolyt1O96oS17r5g6vJl1BUMfwnlYftVWZh8SZJIQkmbePDpXvclULU60gj+
 k17TFuih7jn3dJB4cmiPTA06Tn0nPBBJhOHBPrbHNfIrKrzgJt/9EWgA3h0C/iPXhN7A
 jlv/Ya/hZkkYNmWrFIQt6xkLOT2tgkL6iqOyNj9HxDJA+K1hNbdaOjhWOQkx3VwsfaUZ
 pYgHoo0Bf0ax8nPBQMmUsw/Rgal625ioYUhY9tLIbT4ubD1KQPTwomVeDy/Zctl7BO51
 DKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717695584; x=1718300384;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K4abEuoKQvd0YyYbRSUE6ydyP9nVNeVQVyHbs+ZQEps=;
 b=sYuJ0e7nLB2K6UgbFSeDRRgLsExt9NHNFtA+uB05177Fr9BbZZDKlw2uH2sOcU2b6p
 4cqV6wRbybc4JCOk7aENFTV9cJ8cyvnEPdf2Ee0bM832sjdNcqXw64KIenRLcMNnxqGS
 t5eSJX9JM/fRVHb5kkFNN5L+34om3Y84SHN8ApqpUX9MsTtabFsmjyWsWwIX23hcndC/
 g7nSTSLurU4dUm2YB/hSTZIl0iPN1A1pMQFqeykZ+3w8bttIc9yQzTvKtGfprGM1MWfM
 +Cg4+Il8xpFDSHu1FURKZf8XijFntDYEUokqxTA6TVKVPuERKR9llL/MpGPZPB7XOorv
 s0tg==
X-Gm-Message-State: AOJu0Yw0hJdg1/fQcvL1xZBU3DqdAd3TB9FkfQfxpsR0zhIlpJYjYsuq
 foB0sCoI1PS19jVyKBeswKxoKxFYOqRKFcw824W4Rjv4mOqIAvok1CZzTGPUZCdX2eSbiqBEfVt
 aPRaMWwW+uUBB8uPAXfIO8/asFdiwuaM9BxLqaV7i/dVN6oAIAAy4m+h++rZAb/u5qPez907cy0
 HnFX+IK+KNXMxbtCjgMxNNnF+YYUo=
X-Google-Smtp-Source: AGHT+IFUmoYzYFcsSYnvsts4T+TiGsuzR8E9T92Q4Y9ar2GDcpNzZA6yh5NAMynUya1jeKvE2y6UXoiD+n8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:10c2:b0:dfa:f153:d1d with SMTP id
 3f1490d57ef6-dfaf65696a6mr23177276.2.1717695584322; Thu, 06 Jun 2024 10:39:44
 -0700 (PDT)
Date: Thu,  6 Jun 2024 17:39:32 +0000
In-Reply-To: <20240606173933.1671989-1-edliaw@google.com>
Mime-Version: 1.0
References: <20240606173933.1671989-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240606173933.1671989-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] sched/starvation: Choose from available cpus
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Edward Liaw via ltp <ltp@lists.linux.it>

Use the first available cpu in the sched_getaffinity set.

This test was failing as a 32bit test for some arm architectures where
cpu 0 does not support 32bit applications.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/sched/cfs-scheduler/starvation.c    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index 1d0d5ff97..0f876880d 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -49,10 +49,26 @@ again:
 static void setup(void)
 {
 	cpu_set_t mask;
+	int cpu = 0;
+	long ncpus = tst_ncpus_conf();
 
 	CPU_ZERO(&mask);
 
-	CPU_SET(0, &mask);
+	/* Restrict test to a single cpu */
+	if (!sched_getaffinity(0, sizeof(mask), &mask))
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
+
+	if (CPU_COUNT(&mask) == 0)
+		tst_brk(TBROK, "No cpus available");
+
+	while (CPU_ISSET(cpu, &mask) == 0 && cpu < ncpus)
+		cpu++;
+
+	CPU_ZERO(&mask);
+
+	CPU_SET(cpu, &mask);
+
+	tst_res(TINFO, "Setting affinity to CPU %d", cpu);
 
 	if (!sched_setaffinity(0, sizeof(mask), &mask))
 		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
-- 
2.45.2.505.gda0bf45e8d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
