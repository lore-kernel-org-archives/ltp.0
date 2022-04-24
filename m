Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB2C433F5
	for <ltp@archiver.kernel.org>; Sun, 24 Apr 2022 19:58:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD0D43CA72B
	for <ltp@archiver.kernel.org>; Sun, 24 Apr 2022 21:58:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBBAE3C0058
 for <ltp@lists.linux.it>; Sun, 24 Apr 2022 21:58:43 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1D21C200085
 for <ltp@lists.linux.it>; Sun, 24 Apr 2022 21:58:43 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 n32-20020a05600c3ba000b00393ea7192faso926844wms.2
 for <ltp@lists.linux.it>; Sun, 24 Apr 2022 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x5WWJ1Aj+tSYbSXlNs1x8rePxrAjdrRdveV9mKEKWC4=;
 b=EEAxMB+YEX7KWrS3cmAWDSymD5o61zN25jZLUcpzBuECKIZPZU+MxOUHPt5EFebrkN
 +vt0hQMePHzwgxGOpQaAvWyILCQhQ8wkaKCY0YYjLYmzlKDJ2AeV/PAz2UN9KpV4D+K3
 TTKY0HkW70Zu64byhFW/nz689lCbeTB9pPULkowh0+mUXGDsuKk+W2krn+ZE7tB9ceaa
 v8RuyKEIqKeTFS7A67FPybCTeVlmDMBtes+2QBBzb8Tyz5m2bLgW42gguYVDTLqL4Wuz
 fzwNugW3rsLqIIO2FJcBeaH4yWqAiA2UlnYGCpyVDu6qu5Rc6plikpSBXnSTUox9JLt+
 Wwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x5WWJ1Aj+tSYbSXlNs1x8rePxrAjdrRdveV9mKEKWC4=;
 b=f8iTVR+Kkb1PNFCneqiIRJuku+sTNhUfMOrJgM3zZW/DT8ly1wuVD+vxN3K3Ygmd2+
 1tRjFg6SBXg/Aa0SGwbM137dvniZaLA3cYTFB6xlokWk6Arxja0lNiglgSkkf6NdpnLH
 jeTGcq9RlLo1ZXOI1wCw1pD6BxzANtQ5VUmWHSLAh2TJIuvcY16IDqh+YFUe0zHeDzmU
 Lp8i9Rys/ddCzh1NplUV5FMW5VK2IZwrc6zhbDnEB/tiYWWy9hDSMubja3bumY01v4WM
 P2FPZJDMhTMkgLOJnOJp/iNGcE8BxpOmdSjDinwoa7wyhKxnkuGNjmvPyex+6D6cbadF
 5EEQ==
X-Gm-Message-State: AOAM532ADcbyrnAyN1mRYNbr4aUCm8Blk3BlVPt0ITaWoUz07CpMlalc
 0We3hnXIMzVOyzwCJbs79+twiI9kmyI=
X-Google-Smtp-Source: ABdhPJw7SPv67ZADSHKI/bM51jozAdhSuZofvCayHON3tWii+wXvkaYw+GqlyU+7+heNPVR6J/uFqA==
X-Received: by 2002:a05:600c:1d8b:b0:392:ab4f:365d with SMTP id
 p11-20020a05600c1d8b00b00392ab4f365dmr22132858wms.113.1650830322471; 
 Sun, 24 Apr 2022 12:58:42 -0700 (PDT)
Received: from kali.home (2a01cb088e0b5b002be75de2a1caa253.ipv6.abo.wanadoo.fr.
 [2a01:cb08:8e0b:5b00:2be7:5de2:a1ca:a253])
 by smtp.gmail.com with ESMTPSA id
 m188-20020a1c26c5000000b0039187bb7e9asm9901117wmm.6.2022.04.24.12.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Apr 2022 12:58:42 -0700 (PDT)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 24 Apr 2022 21:56:36 +0200
Message-Id: <20220424195636.842942-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] testcases/kernel/fs: declare int openlog as static
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
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Declare int openlog as static to avoid the following build failure when
building statically (e.g. on buildroot):

/nvmedata/autobuild/instance-15/output-1/per-package/ltp-testsuite/host/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/10.3.0/../../../../mipsel-buildroot-linux-uclibc/bin/ld: /nvmedata/autobuild/instance-15/output-1/per-package/ltp-testsuite/host/bin/../mipsel-buildroot-linux-uclibc/sysroot/usr/lib/libc.a(syslog.os): in function `openlog':
syslog.c:(.text+0x6b8): multiple definition of `openlog'; /tmp/ccvRnqfT.o:/nvmedata/autobuild/instance-15/output-1/build/ltp-testsuite-20220121/testcases/kernel/fs/fs-bench/random-access.c:14: first defined here

Fixes:
 - http://autobuild.buildroot.org/results/bfd0d906a05564a4f323db604f3b908abf552b20

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 testcases/kernel/fs/fs-bench/random-access-del-create.c | 2 +-
 testcases/kernel/fs/fs-bench/random-access.c            | 2 +-
 testcases/kernel/fs/fs-bench/random-del-create.c        | 2 +-
 testcases/kernel/fs/scsi/ltpfs/main.c                   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/fs-bench/random-access-del-create.c b/testcases/kernel/fs/fs-bench/random-access-del-create.c
index 1f62a76b5..8e21c7f74 100644
--- a/testcases/kernel/fs/fs-bench/random-access-del-create.c
+++ b/testcases/kernel/fs/fs-bench/random-access-del-create.c
@@ -11,7 +11,7 @@
 #define FAIL 0
 #define SUCCESS 1
 
-int openlog[2] = { 0, 0 };
+static int openlog[2] = { 0, 0 };
 
 #define MAXNUM 0x100000
 
diff --git a/testcases/kernel/fs/fs-bench/random-access.c b/testcases/kernel/fs/fs-bench/random-access.c
index cf41d6e81..c2f32b86e 100644
--- a/testcases/kernel/fs/fs-bench/random-access.c
+++ b/testcases/kernel/fs/fs-bench/random-access.c
@@ -11,7 +11,7 @@
 #define FAIL 0
 #define SUCCESS 1
 
-int openlog[2] = { 0, 0 };
+static int openlog[2] = { 0, 0 };
 
 #define MAXNUM 0x100000
 
diff --git a/testcases/kernel/fs/fs-bench/random-del-create.c b/testcases/kernel/fs/fs-bench/random-del-create.c
index 0a86f976f..345031f28 100644
--- a/testcases/kernel/fs/fs-bench/random-del-create.c
+++ b/testcases/kernel/fs/fs-bench/random-del-create.c
@@ -11,7 +11,7 @@
 #define FAIL 0
 #define SUCCESS 1
 
-int openlog[2] = { 0, 0 };
+static int openlog[2] = { 0, 0 };
 
 #define MAXNUM 0x100000
 
diff --git a/testcases/kernel/fs/scsi/ltpfs/main.c b/testcases/kernel/fs/scsi/ltpfs/main.c
index 2c67c7a47..90a5531ac 100644
--- a/testcases/kernel/fs/scsi/ltpfs/main.c
+++ b/testcases/kernel/fs/scsi/ltpfs/main.c
@@ -38,7 +38,7 @@ int startc = 0;
 int showchar[] = { 124, 47, 45, 92, 124, 47, 45, 92 };
 
 int nullFileHandle;
-int openlog[2] = { 0, 0 };
+static int openlog[2] = { 0, 0 };
 
 int cFileCount, dFileCount, errorCount;
 static int disk_space_pool = 0;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
