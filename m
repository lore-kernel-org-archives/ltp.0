Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8D3C43458
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782482053; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=hR9W/Jre6bF9s9nDcUNE2c4Ux1dwEehNlvkoAv3yHIc=;
 b=dO0RcLm9fD3zE8lo8RwHamAW4ev5G0M4caH1YW39zR4rJqgOG3VkioepSVumm4vWBI8O1
 Kinhh95T7yoIjBMOaIZQQvORarlSLL40s7+qBvQXQDez9CpmsMf4Fd5GakudNE5SFqM6Der
 OcNvB1pMNS/SajWeFO+hoIqH8YQSpUQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C8DB3CE498
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 15:54:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95B073C581E
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 15:53:49 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0C8C41400E56
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 15:53:48 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso12982265e9.2
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782482028; x=1783086828; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lgRhiEPJwcryw4WvhErSnaTDJYN4PQY/THoXKt5CT6U=;
 b=Wa6yM7BpchyiaCx+Ogoc1gMnR80kBuHOWTkOBoe+xcEeKX4sVqkRFAl+12kHRWBhDi
 P25C0EOtlUyAlpsULgLlSCxDPE03kk8DkWs8NI/UxMBaySMPJaRLBzM89H0IrAJYUcdI
 ukWGPX/giPy1FJeofoGgtPdekr79cM9mgHSmCvkGO/LUVm85aWrJ5OIlwnSLAlzffGJR
 ynVQyU1suj3WW9/waktZy4/KNX0DBSRdnMzJSYjl8Ce3j+2ueRJs5lNOq4rUNffn+01b
 pSdKiefe1o9IGyanjRot6O0GxMjvohcPQb0xuCpz86nJ0FGJHaatNF9aoEVWCb8OSj91
 Yieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782482028; x=1783086828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lgRhiEPJwcryw4WvhErSnaTDJYN4PQY/THoXKt5CT6U=;
 b=n+NWukX/2AmDHXNgQD4fP7/Dx+VfT6LqMSAaI9mDF8yxgGNY3RHZaviIuroeX5iS52
 SGgHAYuVsjAa8lP5nS9reY4mgH1oTOF7vM76rrK3aoo3Eo5jyWGLxYM4QxEyw3M/+J3d
 X1sCogeDI7aH04Yml8DV71ptZ6XjB+hGu8iWybZKFxeWxvSohuu1vdDM3DFwSrCCinJ7
 ljGWi50Nkplf9wO/9YvQR8O8ymhow3oi4fzRZjxu18hUWLFza7XBc95aazga2rKDxrdm
 ldAcRJQwAfMxAXfuKs4+DDRCo6Y8Hcol8CKDK73U9lTBUOOgy5nxlbnko4Y0sRErSGhy
 VFZQ==
X-Gm-Message-State: AOJu0YzjqP+XfkeY+26S6pvmQ52KJ36CXydvpp7zT1dNb4xJtVOaSh0c
 paYRM0OaGdAsOfvtwCRgxo9hHp8n63eKNfmgM3YEH00mYYnx4p/W2KrtJo6rT77dcBQLWTUgijK
 0+OPTUQg=
X-Gm-Gg: AfdE7ckUk/Lv+9Ycm9HMOX8eZl3rn+9fCMefGwNDlds0v3y3uicdTGn7AiubFaWtAnC
 iMuxFJz5fKHqn0AvfxisovmWohc874Ht7XPRnAN9gDASdKQF1Vgvp7ScmOS92jSxHTAEWvfN0d5
 m2o3JVbCbU0wksUSKkvmiBZV2mAbaMDNsCX5k6vJZspRCxCpbyIDFPZ2SXkikq/7zoSXlr8LSkT
 +Q1q0JapA8JISP6iYNJf1zh0BEBIWZPa30163Y+XR93ZL793SPMRsekda80cb6i3XTM8EZ14vcG
 rFEccR8GE/FGeA2lHq/gddeC4pCnWgjzUqOefS/GK1Kek5DE4bqm7CdyocrK0nicLDchNcl3ISt
 k15RxGqej79AkFDylNtuh9S611a5Dxo2iWlfSIhCv2YNYTWHMhciTUbpVLT6AQSylhmmCl15N9R
 E=
X-Received: by 2002:a05:600c:3e19:b0:492:4c5d:4db3 with SMTP id
 5b1f17b1804b1-492668322camr98523165e9.5.1782482028161; 
 Fri, 26 Jun 2026 06:53:48 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f4ffc11d9sm4273588f8f.37.2026.06.26.06.53.47
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 06:53:47 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 26 Jun 2026 15:53:46 +0200
Message-ID: <20260626135347.48218-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6a3e42d0.2cf1dda8.3b5368.08d7@mx.google.com>
References: <6a3e42d0.2cf1dda8.3b5368.08d7@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] set_mempolicy: require CONFIG_NUMA
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

On kernels without CONFIG_NUMA=y set_mempolicy() returns ENOSYS,
which the test misreports as TFAIL.

set_mempolicy05 -

set_mempolicy05.c:105: TFAIL: set_mempolicy should fail with EFAULT or EINVAL, instead returned 38

remaining of these tests (set_mempolicy[01-04]) checks for minimum two
NUMA nodes and reports TCONF, but those also should exit on CONFIG_NUMA
check.

tse_numa.c:200: TINFO: Found 1 NUMA memory nodes
tse_numa.c:141: TINFO: File '/sys/devices/system/node/node0/meminfo' does not exist! NUMA not enabled?
get_mempolicy02.c:60: TCONF: test requires at least one NUMA memory node

Add .needs_kconfigs with CONFIG_NUMA=y

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 4 ++++
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c | 4 ++++
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c | 4 ++++
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c | 4 ++++
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c | 4 ++++
 5 files changed, 20 insertions(+)

diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
index a85a56332..07836cc69 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -120,6 +120,10 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.timeout = 600,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_NUMA=y",
+		NULL
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
index 94d8aa336..d98f81545 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
@@ -109,6 +109,10 @@ static struct tst_test test = {
 	.tcnt = 2,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_NUMA=y",
+		NULL
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
index bc5e03217..43e0439d4 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
@@ -103,6 +103,10 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_NUMA=y",
+		NULL
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
index 672232c84..fa88385ce 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
@@ -134,6 +134,10 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.mntpoint = MNTPOINT,
 	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_NUMA=y",
+		NULL
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
index 7481dcd8d..fb118c4ac 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
@@ -115,6 +115,10 @@ static struct tst_test test = {
 		"ppc",
 		NULL
 	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_NUMA=y",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "cf01fb9985e8"},
 		{"CVE", "2017-7616"},
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
