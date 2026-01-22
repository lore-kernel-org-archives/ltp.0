Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC0DD3EE74
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 15:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 066413CB970
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 16:09:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCF3C3CB803
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 16:07:17 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 398F66001B1
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 16:07:17 +0100 (CET)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0834769f0so8055855ad.2
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769094435; x=1769699235; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WuERdrGTvdWeuXdx7mrq/RbXNtnigAExMPcd8qecl00=;
 b=dRvEnwCQBDsWHaK3/wMl6hOQWULZkaV2+1FIvpkMldopbcYxv2bkbE2lvn+EsFqtG4
 giiArYjTfiXxiYdQxBj+4mx5ZuT7l3VFL5uOeyqrzbJe5tE4liYltk3A6v16a9K9JdRc
 Xy4u9lHwaE0w5wZMc0Mp2hfR5CtFwV1Z19/iF/CCpIwi/KTvFKx4d8nxsEuQjak11Mxl
 aIcb0VCjFW9fxbnPd4yQNBGjXkpBrTLrOOYXdGKnNSJMBkpQQQxqfPioSjCPM2ai3rxo
 kIeSasQ9ZhIfHZWubBavRorUwockKDLKtyMg2Vqs6Oc5NMBmxfatZXCmRsBqOyZnXLGv
 Xe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769094435; x=1769699235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuERdrGTvdWeuXdx7mrq/RbXNtnigAExMPcd8qecl00=;
 b=ObR4n1zsCQGD0Z9mK/w36Z2W+rGG62FKpki4wY0q6iAecBW0aCfn9yqhZoVPBZb25t
 7eZP2R7nWRYLCafzl5Gb4KE39Mn/0KxUeC0e00jNWrdq1Dq50OPbWslniY677zhmKQWB
 U6S0c80qeEAibd4T4RosHCFjKgQGRENM3kCL99jKDwUrBX2XKKG9m//ZODq8FY37gwnh
 eB4l5uI5PuzPV1XtS80tNASMc0k7YB2cjbf0PkNKlOSHixfKlatuYy+FwMgqKaXBCtvK
 Iv9Lmk1yoFy9N0hOFIBeNQKmYLOjoVBHA7j93KGCFl3J6k3DHzKhDigy9Wi9CI8C9cL1
 xdyg==
X-Gm-Message-State: AOJu0YzZElS4zdJZweyVt/Q1QWy8J+cTQiUogwD0X8l0RDviXAIK8w9e
 zkb81NdBTr4kNEgy7c0HLdoK7MqF8nONcmxWUtbqI7PRjHNvV5FC3oppipGwnzQb
X-Gm-Gg: AZuq6aJyUpowbj09xDljImHWXkiKNAjKNNAwRfweB9ph0Fw2Oc5qn8LhtMSqszVqzTH
 glfmi/cLDjw0QXZfI/UTe9wLLJ+JwoyJjIBGhKuEvVh7rtbtvJchF5XLsP3TjUeKQIdV/pJl9JD
 r3DcbVPw9hTF7RWPmcwMkNK4s9CWxh0ffcnVmMhK10cynkcqLjLEx0n0wdzie+puA4ggWi/1ayD
 Rvzw8HRmtVtEDhVIbU6vYrEpUP8MZA/S921dJKpJQoTPwVcm6GTTGL73GvolmYWDo2gsEn37p/2
 +sUbVcxqczyvwLMZ9NaA81GZtwAse38saaTax746DqqZ1Om+m7ElOSUXaOC52Zs8IcBosBF8GhV
 79ZyEoshLZDQhyk6+q0q0HwLJUCjhZf/w6kq20FUXvlg0Hp5Th/MdvdwVE6AGvU0b3yDv5zg6HM
 ZGay58oAJcUCVv
X-Received: by 2002:a17:902:da90:b0:297:d6c2:d06 with SMTP id
 d9443c01a7336-2a7188898a9mr175275355ad.20.1769094434971; 
 Thu, 22 Jan 2026 07:07:14 -0800 (PST)
Received: from bng-30.. ([49.207.234.222]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a71941c56bsm188487085ad.92.2026.01.22.07.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 07:07:14 -0800 (PST)
From: Kushal Chand K <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 20:36:51 +0530
Message-ID: <20260122150652.227342-1-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 22 Jan 2026 16:09:14 +0100
Subject: [LTP] [PATCH v1] kvm: Add needs_driver support to check for kvm
 driver
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
Cc: Kushal Chand K <kushalkataria5@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch adds needs_driver field in kvm testcases to check for kvm driver

Signed-off-by: Kushal Chand K <kushalkataria5@gmail.com>
---
 testcases/kernel/kvm/kvm_pagefault01.c | 4 ++++
 testcases/kernel/kvm/kvm_svm01.c       | 4 ++++
 testcases/kernel/kvm/kvm_svm02.c       | 4 ++++
 testcases/kernel/kvm/kvm_svm03.c       | 4 ++++
 testcases/kernel/kvm/kvm_svm04.c       | 4 ++++
 testcases/kernel/kvm/kvm_vmx01.c       | 4 ++++
 testcases/kernel/kvm/kvm_vmx02.c       | 4 ++++
 7 files changed, 28 insertions(+)

diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
index db526cb7e..2b477f7af 100644
--- a/testcases/kernel/kvm/kvm_pagefault01.c
+++ b/testcases/kernel/kvm/kvm_pagefault01.c
@@ -165,6 +165,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = tst_kvm_cleanup,
 	.needs_root = 1,
+	.needs_drivers = (const char *const []) {
+		"kvm",
+		NULL
+	},
 	.supported_archs = (const char *const []) {
 		"x86_64",
 		NULL
diff --git a/testcases/kernel/kvm/kvm_svm01.c b/testcases/kernel/kvm/kvm_svm01.c
index 32d15526b..f81602567 100644
--- a/testcases/kernel/kvm/kvm_svm01.c
+++ b/testcases/kernel/kvm/kvm_svm01.c
@@ -108,6 +108,10 @@ static struct tst_test test = {
 	.test_all = tst_kvm_run,
 	.setup = tst_kvm_setup,
 	.cleanup = tst_kvm_cleanup,
+	.needs_drivers = (const char *const []) {
+		"kvm",
+		NULL
+	},
 	.supported_archs = (const char *const []) {
 		"x86_64",
 		"x86",
diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_svm02.c
index 6914fdcba..701f2731d 100644
--- a/testcases/kernel/kvm/kvm_svm02.c
+++ b/testcases/kernel/kvm/kvm_svm02.c
@@ -129,6 +129,10 @@ static struct tst_test test = {
 	.test_all = tst_kvm_run,
 	.setup = tst_kvm_setup,
 	.cleanup = tst_kvm_cleanup,
+	.needs_drivers = (const char *const []) {
+		"kvm",
+		NULL
+	},
 	.supported_archs = (const char *const []) {
 		"x86_64",
 		"x86",
diff --git a/testcases/kernel/kvm/kvm_svm03.c b/testcases/kernel/kvm/kvm_svm03.c
index 87164d013..faafaf7cf 100644
--- a/testcases/kernel/kvm/kvm_svm03.c
+++ b/testcases/kernel/kvm/kvm_svm03.c
@@ -154,6 +154,10 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.needs_drivers = (const char *const []) {
+		"kvm",
+		NULL
+	},
 	.min_cpus = 2,
 	.supported_archs = (const char *const []) {
 		"x86_64",
diff --git a/testcases/kernel/kvm/kvm_svm04.c b/testcases/kernel/kvm/kvm_svm04.c
index 75fcbfdcf..af3c8b1c6 100644
--- a/testcases/kernel/kvm/kvm_svm04.c
+++ b/testcases/kernel/kvm/kvm_svm04.c
@@ -295,6 +295,10 @@ static struct tst_test test = {
 	.test_all = tst_kvm_run,
 	.setup = tst_kvm_setup,
 	.cleanup = tst_kvm_cleanup,
+	.needs_drivers = (const char *const []) {
+		"kvm",
+		NULL
+	},
 	.supported_archs = (const char *const []) {
 		"x86_64",
 		"x86",
diff --git a/testcases/kernel/kvm/kvm_vmx01.c b/testcases/kernel/kvm/kvm_vmx01.c
index 5bffbe946..d0c4913c9 100644
--- a/testcases/kernel/kvm/kvm_vmx01.c
+++ b/testcases/kernel/kvm/kvm_vmx01.c
@@ -269,6 +269,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = tst_kvm_cleanup,
 	.needs_root = 1,
+	.needs_drivers = (const char *const []) {
+		"kvm",
+		NULL
+	},
 	.supported_archs = (const char *const []) {
 		"x86_64",
 		"x86",
diff --git a/testcases/kernel/kvm/kvm_vmx02.c b/testcases/kernel/kvm/kvm_vmx02.c
index 3fcfebb3b..4ce225e56 100644
--- a/testcases/kernel/kvm/kvm_vmx02.c
+++ b/testcases/kernel/kvm/kvm_vmx02.c
@@ -183,6 +183,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = tst_kvm_cleanup,
 	.needs_root = 1,
+	.needs_drivers = (const char *const []) {
+		"kvm",
+		NULL
+	},
 	.supported_archs = (const char *const []) {
 		"x86_64",
 		"x86",
--
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
