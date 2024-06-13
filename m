Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67434C27C4F
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 21:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718312542; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JPC8rwzLorzy+xTmSMf06n1Auuf7n2usBOuH4Zx9YIE=;
 b=P/HRaJuYExtFE7FZPlRKbm5rv3gWnwC3hBgHB9wmKlHJelDyh2I6yb/tQUUCV+6GKXHAO
 tzauV239C8QZ1e3DYIgaKR7K6xyw6ziEct44AXvbz5oY+DQOTjZ+BUs6zKM7zr2iqQhP0fG
 OJIOzFHy/PLQPCvUW5mW4OZ9OPjyQu8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9F3F3D0C6D
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 23:02:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 053903D0C62
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 23:01:07 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 755B7600BFD
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 23:01:07 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2c2e7927a77so1309144a91.3
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718312466; x=1718917266; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=7tcpVP6ZIV5BKbOnCsVfRUmjz6PTJVpdIFbEniVmaMw=;
 b=I0/akAQJj/403MlApsI/J3y9cPYHk8wpX7RS1gCOfq4E7HMmRUj55MIqDOb3CGBnEU
 lGIwkRjU4CqbEtC8N5QaG8vnr1miVSKvB92vpMXPHRFBFCitpohf8RPP+dzMgEULgNAC
 6SiP0DrUowvHHm2i1ijc8qKp2o2RBFakdWSWcyLp8MMhkrpMAIZ5HJ8AsKWLwP1DEDfp
 /5aSbttfh2VU/jJQ6Bf+JQ3mkWZfP1lWLyvWR8pEllvlEKMuv4WHUzEwSAfu/sSIA8iQ
 DxGmOe2e/deYa+KTqOzsvzvEEhOmZXTywN3RlzaWYIwHbiQrqMvWMtNAt80zXU9CSh+j
 /BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718312466; x=1718917266;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7tcpVP6ZIV5BKbOnCsVfRUmjz6PTJVpdIFbEniVmaMw=;
 b=nfHUiWnRWP9/EK6UgG/7VbSXgdFt0Drvqwe2t/SiA7ViCcF6xv2pZNIfd4J3VHnLFW
 IbRH3Xl9iXDMVQIdIkm6wuoeFlz9O/0KBJ+Mq2K1Sn+6k8MMHyxuYvU3K3Nl6vN8IIV4
 Tk5osfobCy7ZtglCiv3fErD8RgWeY/ISTJh0VbQexbvE5qTiQO07AKcUNfhSc17kOoS+
 W69sQ7zNK22IJ4Uyvgxzslpd7nK2CMqINUix/t9Mtik0cdjAAMiyeprDEgA57glKzjp+
 /NdkzrY2EkoBB0pAhulzvgtR6QbsSjm37W1JFLY7glQXG67XZIZavMIoQlEXTevIHtNV
 aOYA==
X-Gm-Message-State: AOJu0Yw0isYbt37JuhWbxSBGr4QcV56ow+aUkttwjZ7vEz8eCKgKHrnC
 +x/4T9KCxkFcGc7lE6M0SZS/70wYth81Vxa+C+7Ti0bZRJsE1NvKoOHPdnmkhQes0rtKYN9pReg
 OUU080z8G3ECtF8JaRgjSig4E77hfeg6XpLCVkWriBEffzbz8b1PVDZPKwe0vchs0pRkwUag5tc
 SjCs4Nm+Wj3bbf88/oW2gPGddjVpo=
X-Google-Smtp-Source: AGHT+IEiKwO4/rWU7zBAdLls+5f4oqZuRI6LeAQ213l/S4QJz4ZgGHR83MZbN3kAMKXXUSyxWJ++/DO5dXg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:c711:b0:2c2:c661:fa3e with SMTP id
 98e67ed59e1d1-2c4dbd30a72mr21664a91.6.1718312465519; Thu, 13 Jun 2024
 14:01:05 -0700 (PDT)
Date: Thu, 13 Jun 2024 21:00:59 +0000
In-Reply-To: <20240613210059.352767-1-edliaw@google.com>
Mime-Version: 1.0
References: <20240613210059.352767-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613210059.352767-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] sched/starvation: Choose from available cpus
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
2.45.2.627.g7a2c4fd464-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
