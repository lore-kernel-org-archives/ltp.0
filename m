Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA9BCDE001
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782399465; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=aKm3rJohTH/p4WUvSYnBEMMsW+p7Zvma7XJur2NjZ4g=;
 b=LP5S92BASV2ULUZ5d5B9H+zXopX1cbysQpDRpqDBFk+oE74oNxyGtHl9dqQqtSga2Z3C4
 nDlhxEYWjwXNQU6BEJ6ZV7Gy6FC8poOq3FMCuUJ2yIfrh2E6cYIPHsmv0l+w4yQM1ezY3Wy
 rhePBfg7d3DcGRTBO/RK4wRhCflL+J4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 544EE3E61CF
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 16:57:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D5E93E4D94
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 16:57:26 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85C252005CA
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 16:57:25 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso28455665e9.1
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782399445; x=1783004245; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tBo4cS+K5zTw7i0oD+3417+vzOOYdjokEYJflePO6NM=;
 b=QROCBE1f1NE/cHyQAmQDFRithq1JQR2UUVg35EonAg8kGDl0hOxdQ0fppvb0s76/uj
 ZNjoB50v521KIT8wbl/HGFfrpypHUehdsWNTbaD+yn5ffe3xeDDcmc5UmHl9HSlh67eF
 /pnvEBU0H7/v0mfmMJiUX0bWybQXyerXb3f0G5eZqZ8rde7cuzhnCe/GkQuXKCuFPyyF
 6nDyy/aeatfp0G0bNSxph6qDNKJihSEfRjbsuZo/Lapbp/3bGa7H9qNEMv3xJeptzxhI
 5WiVJ7KgkZUerLYFYAPCIWZIRQP1jR9F1yUgZaZuBToc6e19vz5ht+YUMrrJE1maS1bT
 lNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399445; x=1783004245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tBo4cS+K5zTw7i0oD+3417+vzOOYdjokEYJflePO6NM=;
 b=ZKwbJkCejkrifF47p1TlUdyQhtzK5afjrVDYHCy92Gw2uGBnL/l47TDlChCVoP8VpX
 IRKt3+YKLDAtaUaTuzYH3RUJTg0L80Rw5d6ZMaNl1nP9sk752+Hs+7TRt48mJMJQgF9N
 +1Gj+4Ut1C6CuSuYU+zQctEFpGWm1V0Vv0tB3FREPcevj1Q01mIZdjOrgKpuT4XzI/Qm
 RF0vje1w170BytcCR46C5UELTP7nzPaM4JKYxn1keNITWLWEcsHPb93SsKtCLYAlu0aP
 Cu33G9dLmhgMwTLcdN8ZBtNpW0XfIbDmA3LeXcJ/7Ca2AijotKSgxa1/m1P4oKtp0ZHi
 /h/A==
X-Gm-Message-State: AOJu0YzcodCZLJrlq9Yot++IlMpfkSF0ZcxNkbfNCaSewPhzyytG4+4M
 Sf2dKPX/oYC+IJoKnwOUcqRrnZ/44WA24Kc4sA5O94BBbLgS3S/quXcMEs3yZAfblrIAjoKHeiA
 oPqz6x6o=
X-Gm-Gg: AfdE7cnJHQZn+GYAZ07gptCJJLQU+dJ/KkHtFs/IpQu2GDgf8TDS7z/sb5/V9+Y6WCG
 fA2NWE7rkdN904zbZON6ls//7jRM58YOlLJ9AYYOa+YIRd8ixBAx18nyWwocWbj5/3Z+ealYvrj
 k7HsS2gPAzi3XlcY3gpRWA5mPkIFDjhGTirCgS1UzLfQqws3PzRabKj2qtdPZdW2btQg6KE/y9a
 J/ijuzT/bwCe0kqFS3Hk4gVIWyocl/6MAMXQvVCZ3Pgr1SQxt+lSfuRARVrm/ePE64a3jhYP4TA
 RD9dJHXjdjlyhXA/a7Iy2JTjCxOPipr7YD9aBvvgntaiFBOXKisZy5ZHIJvElOejCqEQzTx13D6
 suHfU4vEtx/4M1iFuNdttS2ZNogh73OaP+FHfFtZJdEU6iro0Yq+FLTwVZ5Wxp/Jdoy1vrRVe0p
 A=
X-Received: by 2002:a05:600c:1d1e:b0:492:2f3c:d0ed with SMTP id
 5b1f17b1804b1-4926688a528mr38772665e9.30.1782399444718; 
 Thu, 25 Jun 2026 07:57:24 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fd9e77sm3097055e9.4.2026.06.25.07.57.23
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:57:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 25 Jun 2026 16:57:22 +0200
Message-ID: <20260625145722.131551-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6a3cd262.453a015d.200201.5a98@mx.google.com>
References: <6a3cd262.453a015d.200201.5a98@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] set_mempolicy: require CONFIG_NUMA
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
index 65061bf3d..6c91beebc 100644
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
 		{"CVE", "CVE-2017-7616"},
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
