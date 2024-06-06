Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AA5C25B76
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 01:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717638051; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ABruaEzCI9KF9clQoGh4+ocneMt15Hd4Jr4hbGhe8Bw=;
 b=JXlC1MaWmYNExida+Wb6paTLIRKhFkgiBvUmCN7KTwjPcArfP9Z/oF5f0nfBxQoMLNb9a
 UCz/ZYI/oZpgkapef2MW2GaH0HehLXEKkz57S5qSZ3T2EcBv3N1y+SKAC3hDtQ/BzM4Zl9i
 dRQRS5FutpkLsGARbHEEqHqMSUwCzxA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CDAC3D09CE
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 03:40:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8681C3CE360
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 03:40:27 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1DFE7601E23
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 03:40:27 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-62a080977a5so7324897b3.0
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 18:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717638025; x=1718242825; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ewZtl/K3l2znhBtMJVoxQXcerOQ/8JtwTlBc4d+ldxY=;
 b=CSUIaGhEu2XP8LnajAADmO0vEFhUK+5yVGhmMzn/43IYuwnizibjLbadBIXIbpZ6vC
 G227zToJFr40+VcAqygSNdLKtc9Vp4ig4/8aLamWcnN/61JdoMPVXhVWOIpc2NGOrsfg
 DAmumRD8G1xA0hILIo/rmEhgcbFeYbdrClR04sijVF3BYS+MU1UMcBOf37+Q4mKTtO5N
 fj/gBAotH0mdPnGKvn12276oIRteN2mUJuYnsUAJ3r2GOLKZc8ydT4wVRDu+TRhh5mDS
 Us16lmFOfkSoEai0vuOFS807/DdbFJHExoE5nGWsx13kv2/ArIsllIf3D0+Uyj0sQhBL
 deRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717638025; x=1718242825;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ewZtl/K3l2znhBtMJVoxQXcerOQ/8JtwTlBc4d+ldxY=;
 b=fNgHnlBveBUwfT0U0LdQCGsOpQ+Fx8VM1zt6oiq+D3KEV4CbLiCUayZBv2iYjeWVRK
 G3Kwp5DAQmRPCZuSzqpA9eLLunraj8LcAzgv6S1iUrwlJOuVKumV2LXInLlwYwJ0gTal
 MurGExziWf8w6v805nhT7jldcffPEXeE/E7k6UIUoGoCfPsOFUG0j1iz76y8cUpPosPB
 aBOJym5HReQOJ81/bOfNR+WFNFpvLc1Rod9BqeUGdKBRvW9q6FEDORPyK1aU9GEUJCu0
 VQXYuoEWZU4vYDwNC8mXENwdbUooOgoSH+M5Q528/rnP8tLoqXRQjK5BB0hMy8KtEJdA
 VEuw==
X-Gm-Message-State: AOJu0YzZSkRuSlN7dI5GHqiE0zch+qvIqaKzy2jj5MIuGcadyZauY2Nu
 p8DJr+Nt6a0bNfxl6kJaL1Psf96aoyIwO450BJwVFFeyC8Zhf3wqR5ZSeWav9H+s+FTGFIsxVpr
 5fbO2bHJDPQc5V06QoBtpGQ2dD4QPtws+8bLHMGwXgf1CLtUMTgB8ml3dTOQo/LX5657E9/1LsL
 rmCBzH6xL2UiG6KFwVt+L7HD89zno=
X-Google-Smtp-Source: AGHT+IE6pGzaaKyeCC/Iv/XLersuTuU1LHpVZs99IETw2kD3olb37QqSISZSqj2QeLcZLJq75KTCf3OQuDU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:150b:b0:dfa:59bc:883e with SMTP id
 3f1490d57ef6-dfacab2a232mr1186866276.1.1717638025307; Wed, 05 Jun 2024
 18:40:25 -0700 (PDT)
Date: Thu,  6 Jun 2024 01:40:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240606014022.1425928-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sched/starvation: Choose from available cpus
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
 .../kernel/sched/cfs-scheduler/starvation.c   | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index eb9fd6ff5..0fd45e281 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -49,12 +49,27 @@ again:
 static void setup(void)
 {
 	cpu_set_t mask;
+	int cpu = 0;
+	long ncpus = tst_ncpus_conf();
 
 	CPU_ZERO(&mask);
 
-	CPU_SET(0, &mask);
+	/* Restrict test to a single cpu */
+	TST_EXP_PASS(sched_getaffinity(0, sizeof(mask), &mask));
 
-	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));
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
+	TST_EXP_PASS(sched_setaffinity(0, sizeof(mask), &mask));
+
+	tst_res(TINFO, "Set affinity to CPU %d", cpu);
 
 	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
 		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
-- 
2.45.1.467.gbab1589fc0-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
