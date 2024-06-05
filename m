Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69438C27C52
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717610767; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=DyX3rKy03L4h3iRA1xw9yNmxYNwGT23YBdYd1nRY6Po=;
 b=qsqfKo21FSIqB+hahRIMf9xocB6lnPOH3jeaYXAc3bdHLkJkN/B3HgOpfCj+mW6BUzw1z
 MA3xcUGeI5N8Scfur997UiJfJ/Tsqk1v6DLobDDxOY/RZWg2npqqiduPktcrZpXEAZ9wfYF
 yHwTgWc46I7QgXUNX5WtBmK4GkQvato=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A71CE3D09BA
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 20:06:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDE7F3C888E
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 20:05:44 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3769E1A01555
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 20:05:44 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-627e4afa326so345477b3.2
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717610743; x=1718215543; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BqThqLmy/7MfpupiMoxj6SzXoQfpZmJaWjw5jfsyUg0=;
 b=Emr5Eoq9lNqIziDDn9Z5WOSt5GF+7H0p79XNentJwhN2ZybMfvC/xbgcIPdQ2mk/mN
 fhxJNq1uOUE1qyabK/tRCoVJHjkXO7gPBpfRsxdCjO+KlfYJHR0++83BFuduhK0YTUld
 Z5ZoMqrHxTLekrTB+lCCyXpZsvYxfdHqNKBJ3pDOWa7Hk5ED5pF25pFrsCW8xGGgDfGB
 N2GIJ2Bv418+Ha8sFxbA1BGmBy6sADGwb8bBlkrRrjjWNTYBZe1NydJ2Ick6QgiW5t4j
 tZhiMzRc3prdoqtlgpQPrGt+OlSl1zgaW5JwLYBqLRLkMxyJT9W+L+dFQMeHqo8BYIZD
 aqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717610743; x=1718215543;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BqThqLmy/7MfpupiMoxj6SzXoQfpZmJaWjw5jfsyUg0=;
 b=DL1OkWmBiUT/4AmCzqUZ0bTt//DcM6+srfadNp3ERA62qWSRWVP9zlp/I8gnQOptb5
 lsGlrlXs5Qj76NXwaTcuydCWc5BeDU7FufFmxu1K8Y7zfO4kwySuPPlEYlaFs5A4frHX
 kinoJZIYBNycwlb+saARzA+N4DH1qyVyzwn53/0IOw2FGQ5YUDPyMq4juwN+aAgFwPVt
 hM580DoLrpSJmfGDQWBJ1C5joInTDxDnCGH+be34muydm/5R2JAGns3ADbepgjC1on+7
 t08/ouDkYkSPmGKJdMOGtfwOkAlqWE9Dqot7Xx5orE9uuFhnI8OHDfBG/HQGUICQOuW5
 9cMA==
X-Gm-Message-State: AOJu0YwYszwBVy6RadgCHhLXD2LWRZC2c5qxWNA/k6OU3zxcBb5A7h+F
 rZbRyyg/Rzon+4NyDLoIWfBhbYDOKgrF28WH18mQFFrg5tsIRhOIAH7C86SoMBnjqsj1RuMzrsl
 SUB3cvvs4qU1ZeWjfCRwmJZM51fPHJZ/jmMeZIfmLNZd7NhzGYlKs3VBs6blny2WaHfJ1S9voWL
 KgEW/NtO7uP7ZoA1fY2m0vYXqPzoE=
X-Google-Smtp-Source: AGHT+IFcC2JOa1ShLD4Sess6Vle8UMC8qWwv58xX+qsp4nX4/wUOyJmSjn7zT4WbFUuvgukOd9zQgHy7YfQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:101:b0:61b:1d66:61c4 with SMTP id
 00721157ae682-62cbb5de93fmr8419427b3.10.1717610742583; Wed, 05 Jun 2024
 11:05:42 -0700 (PDT)
Date: Wed,  5 Jun 2024 18:05:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605180536.1288027-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched/starvation: Choose from available cpus
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

Use the first available cpu in the sched_getaffinity set.

This test was failing as a 32bit test for some arm architectures where
cpu 0 does not support 32bit applications.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/sched/cfs-scheduler/starvation.c     | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index eb9fd6ff5..e0ea30d19 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -49,13 +49,28 @@ again:
 static void setup(void)
 {
 	cpu_set_t mask;
+	int cpu = 0;
+	long ncpus = tst_ncpus_conf();
 
 	CPU_ZERO(&mask);
 
-	CPU_SET(0, &mask);
+	/* Restrict test to a single cpu */
+	TST_EXP_POSITIVE(sched_getaffinity(0, sizeof(mask), &mask));
+
+	if (CPU_COUNT(&mask) == 0)
+		tst_brk(TCONF, "No cpus available");
+
+	while (CPU_ISSET(cpu, &mask) == 0 && cpu < ncpus)
+		cpu++;
+
+	CPU_ZERO(&mask);
+
+	CPU_SET(cpu, &mask);
 
 	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));
 
+	tst_res(TINFO, "Set affinity to CPU %d", cpu);
+
 	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
 		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
 
-- 
2.45.1.467.gbab1589fc0-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
