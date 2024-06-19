Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BF0C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718814567; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pulhd93rOc6lp1HwhbNGGzJBUf3x6Oz3U2sx9DVa7rw=;
 b=hCXFeouypUNjT8hiwcDeo3FiAi6MDy4uk0PRNR2Rt2IGNeW2SmfjInMs7hdprBm1Qx7oq
 Y8V3zvSb8DAC2eKXmxDIvyq8qF4WSgMmhcwiWSiz3cHvKh0Wln6qYcXNacxWf2AoPJJk9rB
 xvsPPvGtbKkfI/IcL2TNRmyeqs4eQjg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868183D0DD5
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 18:29:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 687433D0DD9
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:28:15 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E6AA1000D52
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:28:15 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-62a080977a5so128642957b3.0
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718814494; x=1719419294; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nEXRWbLtBX/BMKM7OsR+9ENQ9wMN10Tn09vifMJpL6M=;
 b=flboklxm4x6hWtsGTM0Akd8zevvQbMBBMQA+Ws8eoJ27dDcyptTnHk2KYrgR/yJ1Jb
 iPyHBpY0DZQuC/rcAx9Ju966uI2QLtGltBC00XXxZYRojF1rjoxCWICGZPlId21M9wDz
 oKiD3/x0996SnA8R/i2BjRKL7MlgmPv9duPm5AdyYpSOPMZgWLYLf6/AqGu74nh7s2OV
 qqKgru+9oYKM7GdvJLzDxiSQhk9paBtyznc+Ip/pYMJtKTO5r1Wqjop2TjbHE1Z2rL9v
 UUcmRIu+KEmFHcea2NcWyXyuBLQXxxkZJeg+iAZ/xCFcroH+BO5YazLivaDtZrlYpY4E
 njpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718814494; x=1719419294;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nEXRWbLtBX/BMKM7OsR+9ENQ9wMN10Tn09vifMJpL6M=;
 b=jQh3D1fZhV6pUWW89VNfQRVYwr1ZLzwdDsc7Rxn1qddrHRvVf/z5m/pFZ3hKbup3Rb
 suiULZHVyhxrU150BKWmtmL7XUSBxke4mE2YsUul+j2z8FN5NSED0rgRfoATnQqy50iI
 IkbH/74w776c9AUYw5RXeOrk68PJGLSOJ7JmOTMAqvr3UbFRsC3Wh7tz0Yh9X4SoI/96
 qA8Mbus0H02UsU1XtG1gyd/mcKEiEKauv4h/qt1i8HhXqGVNJUzL30ty9qAURR7kqXZI
 bAvHDp5+UGGshmLurIQgJTrLmlUEw+67AlvVnjjERs5tKY+oFQBxMFYRfrK1KWmdUrMc
 dxKA==
X-Gm-Message-State: AOJu0YzTT/6k8ozsAnUEyOVSs+fop+KGXxnBgaTgUo+KCEIDU5zlI5OZ
 LsXm3KAGngTDcPz7Ce1zzrVh6M2e3S5hG3HxEPENgW4jjGo7Y/ix7Ep0r+UOqcdbpH1H/5e3Zfp
 cpscKhRRXOsCnwQm4XdLPQXs5F61RgEDOh8SPztdnrTsANo7AS3IIRJ1cUsPwPiDvYSFOEtGjrE
 I/77vJ6Lgw5cDry5he8SknIgZtEOQ=
X-Google-Smtp-Source: AGHT+IFZaRc+GJ6e85a0pokPLrs5A6ZOuvz20DX1ROqQWNPKUpQruTjwGshPzS4bW+6xkaOvdhxnKJLotVM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:25c7:b0:62c:fa1a:21d2 with SMTP id
 00721157ae682-63a8d447fb0mr8759647b3.1.1718814493692; Wed, 19 Jun 2024
 09:28:13 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:28:07 +0000
In-Reply-To: <20240619162807.2725018-1-edliaw@google.com>
Mime-Version: 1.0
References: <20240619162807.2725018-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240619162807.2725018-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] sched/starvation: Choose from available cpus
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/sched/cfs-scheduler/starvation.c    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index c845af849..9ac388fdc 100644
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
+	if (sched_getaffinity(0, sizeof(mask), &mask) < 0)
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
 
 	if (sched_setaffinity(0, sizeof(mask), &mask) < 0)
 		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
-- 
2.45.2.627.g7a2c4fd464-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
