Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0D4CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 08:36:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D05913D0EA6
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 10:36:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38D553D07B4
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:45:10 +0200 (CEST)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D87D5204737
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:45:09 +0200 (CEST)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-304e58292d3so108609eec.0
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780382708; x=1780987508; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UKQbbEqxb7F/P0Tjk8hfaZfpsX/ODUK4uq5OwP3p3No=;
 b=UDS+tAbyBt6HE9H4CroEpqXZsaxqP8wE3y8LjE2hUQohxqBd1H1e7rwfaJPBHZqfue
 zbeAUr47zdM31dpjM6zspxcpKGNqMGzOCaGVvOqWYuDP3Id+Mz503E86qbonReisnnkl
 P5vkVuovDX5NqhKuUcUULhZ4WjTu3TM2M/e+IPFJroFYi8L4ovJr1ktRp/m+gdszWS/H
 ugKqhs3VLU8gIdgFwdS/tffDt/vAtuomdVklPVVJCThO3prEZ8P/Muo8w3UHVjbhERKn
 qcKwP429Z3JqnUUKRsDZeu0Tz2ENwIAm1FTMwEiQQCNhzC6Zvb21j8MuH+sSJopFQPy0
 AV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780382708; x=1780987508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UKQbbEqxb7F/P0Tjk8hfaZfpsX/ODUK4uq5OwP3p3No=;
 b=CHzurQeC0Q/K2wnJGWdH4mz84rtUnFZ7dhHAF0bAUl2c6wJkle8RZhFO4ymJPmBcxn
 NL8NgmijigI8tDEBqWHIYv5KBtsVT35k4b4+5FF2Ios5RmoZdksUU4IWje3fT++E6hIw
 UJSTNggJ8X9czcoLkaF2O3h2YY4UV4sUNbrcksBXhvi9CZucogaaUcZZfqaHQWOiVmU3
 8cFLSCuwrmZPI2oSABE7pcqKkF6S6PMGqUnItv8IfSnpzzWZT4/iMtgfqvFEVMV4J83O
 gf2uK+QkjTera8OZNaRcAC1evbTQz8W9x4TPbnFDhAJ8HDWUpc6Fosp0ON3jykaUlKQI
 1i/g==
X-Gm-Message-State: AOJu0YxhJpVwuvw866S/sbQvKZS0AbsVKswO6/WnL0qIH9EQgtyGLZtS
 MkTzYnT64Nz+jJxX5MLIB8UQrgG64jzfKdcrTyZ+rh0eRtbocYhiR/ictHt33A==
X-Gm-Gg: Acq92OH9YO2I5ga/OT9eKW4rChaIkjESe0xq63U5iOYjoRo7nSEZMhwfvpowetYfmDC
 tHO3w0EkurqL1UDF6K4xac4n2qLjcVM6HDkwVIiYVTWkMhE4VlmzLBoPymhJw6n751AqiwZt4sk
 3YgT8VgnMTn+CUFoeRabYSi2lozcQ/AeIHo3ElFy7AiVzagpXl2tt3GzAjaw4yV+16Fn3VCA34E
 enLLEKVm/sd2fCD2/p0+QKYUV+gtnlTIKIg/bywRTSguqzDHxCMsjtMELX0NXk7HnLReuJ2AwvY
 y//+degP7Lxe8bo3lqec+dzPO7a2d2Ff1migyEnjJfF74z8whMx9PNq/ellD5fcmQBeA2/SD6OC
 eMDYWrudDw85YL2oeR8lUL/SiZbN3NwB58x5GKdu5zd6QmjxugfQ6hmD+JR77WVYc5iPbxTGKv3
 g7P31bcaOhedrGvzV+W9K2pi7KE0p5EIlQZmMnzV51SjB9pJJlT05QpILIiniK0Q==
X-Received: by 2002:a05:7301:2926:b0:2f5:2556:5acd with SMTP id
 5a478bee46e88-304fa581d3emr6531977eec.13.1780382707985; 
 Mon, 01 Jun 2026 23:45:07 -0700 (PDT)
Received: from localhost.localdomain ([91.246.176.15])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2efb4esm11000638eec.8.2026.06.01.23.45.06
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 23:45:07 -0700 (PDT)
From: XiaoLei Wu <wxl18715129466@gmail.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 14:45:02 +0800
Message-ID: <20260602064502.718525-1-wxl18715129466@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:35:48 +0200
Subject: [LTP] [PATCH] syscalls: skip ntfs3 in ioctl_fiemap01 and mount03
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since commit 7dc8e9a515ce ("lib: Treat kernel ntfs3 as a separate FS"),
tests with all_filesystems=1 run on ntfs3 independently.

ioctl_fiemap01 and mount03 already skip ntfs, but still run on ntfs3.
ioctl_fiemap01 fails because the returned FIEMAP extents do not match
the layout expected by the test. mount03 fails because directory
timestamps are not updated as expected under strictatime. Add ntfs3 to
their skip lists, matching the existing ntfs skips.

Signed-off-by: XiaoLei Wu <wxl18715129466@gmail.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c | 2 +-
 testcases/kernel/syscalls/mount/mount03.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
index 31187b1..8a660f0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
@@ -119,7 +119,7 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const[]) {
-		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL
+		"exfat", "vfat", "fuse", "ntfs", "ntfs3", "tmpfs", NULL
 	},
 	.test_all = verify_ioctl,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 8dd6f3e..628b3f2 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -256,6 +256,7 @@ static struct tst_test test = {
 		"exfat",
 		"vfat",
 		"ntfs",
+		"ntfs3",
 		NULL
 	},
 };
-- 
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
