Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE505C02185
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 09:34:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AE003C1832
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:34:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD2923C149D
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 09:50:51 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=acarmina@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E502E1BD73B2
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 09:50:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737363049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uyo0RNOrd7Lw3M9C/mUrnVTwd291EhYOLVPHNzCocw8=;
 b=GF3JyV0z8Iyl1vOi+d5bC6qaSSnPUckHxiJqNbKboFj40s2/O5O+RDPB2ImtiOmx8orEmt
 945fEhWyhJhQVBl3a2m2OiBFQNyJpI8LS2q0beUC8AE6Z/x5nJD3aQFDfY9QDCGeXek9SY
 ZtS7UXhLoaEyrlVo7q4cQ6xb0c2qNys=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-5WMYGGPfMtKL-EAwn4365g-1; Mon, 20 Jan 2025 03:50:48 -0500
X-MC-Unique: 5WMYGGPfMtKL-EAwn4365g-1
X-Mimecast-MFC-AGG-ID: 5WMYGGPfMtKL-EAwn4365g
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38bf4913659so2222801f8f.1
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 00:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737363046; x=1737967846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uyo0RNOrd7Lw3M9C/mUrnVTwd291EhYOLVPHNzCocw8=;
 b=IWd4GvAuwyh8vC5bCNBvjjk3k6CRhuFsEvfNoJijApNF7Hj5Ld9Udw9F0UUf0y8KN5
 QCkdkwpPcJTH4Whl0hRfS/oOwaPyGg323UchTZygzurySNurRw5nTiVUHlqX170zzzai
 rsNKeHeSvf8gdE0okw7RseTl8ico2idYcccjw+SYpT4WTpcsjl1TEfUQ3ScVnN+w/vGm
 qFunEelBxgoZJgiIhGLeF4YZNhRZJAA8mToWy17OrfQzBNZj2Olsz9XVR280y4dS7qJI
 lZo/ekBvzE8Rzcpa+us7w1v39ie23JX+XbcNK48VKupYOsHNLbEx88mZqj+RqikvjUIx
 s00Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUqZFbLvOTp0zBDuSgFlju7Me+rHKMRlIRG2XiufQ0NJ/cBDwKQYBGUjdh9mDPT+nCbe0=@lists.linux.it
X-Gm-Message-State: AOJu0YxqEJzGiauFxAk9zv3le69TnhTwOm6NhplHhHQC1aPlMMHzCnHT
 4VVG3z8gHaGKbylwTbNa3Av45NmSilfJCq0DW8MXTAqLt6ba1iUjgfoD8W3f814OfqMYSpO36h2
 MFtW2fIE+wrp+QvL4X7BasiZNCgTk3yC9FRO5Ss85GWnZyQsL7lVilyXc
X-Gm-Gg: ASbGnctfvwgDxtiBIhng+h7H6GnXL4wntPa/4EsRdw5l5i6zaascm8UIYvPpsLLCsA7
 z9qKvdWA1ACzV1MsHxLYhFQy8EaXaRXbalBx2t+jJf74YzGPshg8BTR2+hv4MSwQGruBl1b4IUd
 pkrq+fgsWnxArElFryhnRS0xTb22JGxZAb+UmzUbqPk/ynlIqjeEUHns/JGfGhtYv9XrQ+G44SW
 RGtOOESU1s32QX0Gn+EnZBQH2pAxtXUHrR9rwMLVmj1FRRpq2DeMxIgYWtDeX1dEKGSXZQOsjc=
X-Received: by 2002:a5d:4845:0:b0:386:857:cc54 with SMTP id
 ffacd0b85a97d-38bf5679b17mr8416157f8f.9.1737363046592; 
 Mon, 20 Jan 2025 00:50:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiBMvcY4CkznvkYS3FyA205PnbILAUCicby9Fxgl9kTVPrqzif9/eNuNe4wvvdK/VF2Di8sA==
X-Received: by 2002:a5d:4845:0:b0:386:857:cc54 with SMTP id
 ffacd0b85a97d-38bf5679b17mr8416141f8f.9.1737363046266; 
 Mon, 20 Jan 2025 00:50:46 -0800 (PST)
Received: from lab.hqhome163.com ([81.57.75.210])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275901sm9837470f8f.61.2025.01.20.00.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 00:50:45 -0800 (PST)
From: Alessandro Carminati <acarmina@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2025 08:50:17 +0000
Message-Id: <20250120085017.63442-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FOdpABf4uxgMDrM3nVWmoFh3yw4RpnJ4dWxrbAo5sc0_1737363047
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jan 2025 10:34:24 +0100
Subject: [LTP] [PATCH] cfs-scheduler/starvation.c: Skip test on realtime
 kernels
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
Cc: Alessandro Carminati <acarmina@redhat.com>,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit introduces a check in the starvation test case to detect and
skip execution on realtime kernels. The test is designed for use with the
Completely Fair Scheduler and produces meaningless results when run on
realtime kernels.

By skipping the test on realtime kernels, we avoid confusion caused by
misleading results.

Changes include:
- Added a detection mechanism for realtime kernels.
- Logic to skip the test execution if the kernel is identified as
  realtime.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 include/tst_kernel.h                              |  9 +++++++++
 lib/tst_kernel.c                                  | 10 ++++++++++
 testcases/kernel/sched/cfs-scheduler/starvation.c |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 5f49952b7..63ecb19a4 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -58,4 +58,13 @@ int tst_check_builtin_driver(const char *driver);
  */
 int tst_check_driver(const char *driver);
 
+/**
+ * tst_check_preempt_rt() - Check if the running kernel is RT.
+ *
+ * Check support for the kernel module (both built-in and loadable).
+ *
+ * Return: -1 if the kernel is RT, 0 otherwise.
+ */
+int tst_check_preempt_rt(void);
+
 #endif	/* TST_KERNEL_H__ */
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 8dabfeba2..7084289c3 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -214,3 +214,13 @@ int tst_check_driver(const char *driver)
 
 	return -1;
 }
+
+int tst_check_preempt_rt(void)
+{
+	struct utsname uval;
+
+	uname(&uval);
+	if (strstr(uval.version, "PREEMPT_RT"))
+		return -1;
+	return 0;
+}
diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index 901556a7b..c620c9c3e 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -82,6 +82,9 @@ static void setup(void)
 
 	CPU_ZERO(&mask);
 
+	if (tst_check_preempt_rt())
+		tst_brk(TCONF, "This test is not designed for the RT kernel");
+
 	/* Restrict test to a single cpu */
 	if (sched_getaffinity(0, sizeof(mask), &mask) < 0)
 		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
