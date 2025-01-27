Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C3C0218C
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 08:33:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A565D3C2A06
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 09:33:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D54D3C06F5
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 09:32:55 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=acarmina@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76AD2600CC8
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 09:32:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737966772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VKSz3euh3F5B6675/wFxBTLSM2YXojPrNciBhRu/Aok=;
 b=EinFITScLpGEV41kcnDx5TFNk9PuE1LfJE9JjkxrTe7ipoXuaCSv0SksfhObLeeHpE1FF+
 XkREV5PLm0Um5L0IQdYAFWlKF1Dro1MMuScpvf5aTIo3yojV/UQwF7dz1mg17M0FQ2nS4S
 Z6DWmIyjqwzRZ5qUxSZ11OK3aYVS3fk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-lSM9QhdUN9KFCounGRfdWg-1; Mon, 27 Jan 2025 03:32:48 -0500
X-MC-Unique: lSM9QhdUN9KFCounGRfdWg-1
X-Mimecast-MFC-AGG-ID: lSM9QhdUN9KFCounGRfdWg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862b364578so2418533f8f.1
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 00:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737966767; x=1738571567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VKSz3euh3F5B6675/wFxBTLSM2YXojPrNciBhRu/Aok=;
 b=T2MfqQP6Jx2+jF5UybcbQb0jXRiwJvCtkBHjAymCe2RZmDRNcfhtNFQE/ve+SuU6eC
 KzXbkhUpLqEveULSzNz5xnZ6z/n+quVqkfH9SXmTSCKM81ht+JEH13p8EJq8O37RySUO
 9cd6n2Uv7VZxJ873pPC58hKVAaWu2howsjU6rLt7pbvPUYesXJiNI7jPD+YMxfqNxfmP
 WnyE95suR/REZviCLFTcN6AaQkp80Ozha92vLKeAEdbcbXpGf0giLaPzIPQnzgD9inve
 7fBVTbmCLOpN2843Y7ldsueOPJB5GglKZ8ozB9kGdOeryxcIR61bRDcNbaEKmSFfqr4S
 0SNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCM80eGFyih1oPnnOG+qGruBCiaMAUZ4Hp3OdQuOaV+9yBx0/Oae1+5qAabZG6ifQONY4=@lists.linux.it
X-Gm-Message-State: AOJu0YweJ+ekWKpOdo08rYOOHEM65oC/FumBkTxNGfEiJmNj3DCp4e1V
 Z7h98CLr3P0rWUZ2BqA4yrF83CLN2daaMCW4dFsrzbGbs6MPpr36YLpFvgUp6OTSW4YruEe26XJ
 my2dJGlv48uBXCMt7MdeTqdcetgoQPobm3EqJU7cGLPPOeqR0
X-Gm-Gg: ASbGncvqoHXSqvZgpP903w5Ik5O+tfqz4CmNcUnXiRylpvpNxfBg8vTwOpkgSxVfUtO
 nAjZiJWLmDnVzOBhJ06yU6vdX3N/33ormo2FJFjrjE/fwrbG1w6HRhVOGHvBYTjXD6ZBBDWiLmT
 Bs8Fuu4J3ZSseMnngrvH1nCw1bLlmr5lpkY7FOzM+2BIj8FQWsI/iNxxz6SV/q7e+2C3tpp21qC
 iTgG4iB44oS8rhS4QKC0KzSHZQ5HaeTXi/KNPQla7izx9cf9hMy4moM8Z3w46qFJNxhVKDlogrd
 8p5bzGf93g==
X-Received: by 2002:a05:6000:1151:b0:38b:f3f4:5812 with SMTP id
 ffacd0b85a97d-38c22279d63mr13478142f8f.21.1737966767170; 
 Mon, 27 Jan 2025 00:32:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIXOsDMGfsFopA9A09Olr1PTtldNorqz9b7idMOPt6VCUHkEXZJDj/jso0yGyEssfpe7ShZA==
X-Received: by 2002:a05:6000:1151:b0:38b:f3f4:5812 with SMTP id
 ffacd0b85a97d-38c22279d63mr13478119f8f.21.1737966766804; 
 Mon, 27 Jan 2025 00:32:46 -0800 (PST)
Received: from lab.hqhome163.com ([81.57.75.210])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1763e9sm10658911f8f.16.2025.01.27.00.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 00:32:45 -0800 (PST)
From: Alessandro Carminati <acarmina@redhat.com>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Jan 2025 08:32:27 +0000
Message-Id: <20250127083227.77560-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SCFr81j9jfAtPi9qvk6IfRxQ8lmHZioS2cSX6LLMZTA_1737966767
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] cfs-scheduler/starvation.c: Skip test on realtime
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it,
 Alessandro Carminati <acarmina@redhat.com>
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
index 8dabfeba2..9ab02e5d3 100644
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
+		return 1;
+	return 0;
+}
diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index 901556a7b..27bf77f39 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -80,6 +80,9 @@ static void setup(void)
 	int cpu = 0;
 	long ncpus = tst_ncpus_conf();
 
+	if (tst_check_preempt_rt())
+		tst_brk(TCONF, "This test is not designed for the RT kernel");
+
 	CPU_ZERO(&mask);
 
 	/* Restrict test to a single cpu */
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
