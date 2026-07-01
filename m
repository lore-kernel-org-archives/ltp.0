Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B4FC43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782893028; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=OJmcTxKxd6G2fEmF5ZA+1OytUWzlEUz5Y7Q9yfXfyFI=;
 b=DX6ezNylg+nuAZ/+WaRsI+60AW1jy2IGdGWzd+stK6pUxO62LeT22Q6XlR8IoLJZjkzMx
 unfY2hYVcP6kuVL3s/aZ2TMsRPqQZWlnHfTTw7WIMpEHrUZkYiX0G0JhsR4QzoJYKcoTcm+
 gGEJ/okgwnxeBH2yP2OnTbNTYqyip/g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B1E33E529E
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 10:03:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6D793E4A85
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 10:03:27 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE4BB200778
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 10:03:26 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493be1b9564so2742425e9.2
 for <ltp@lists.linux.it>; Wed, 01 Jul 2026 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782893006; x=1783497806; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bbHdcJYLN1csW1huxSONUwiZ/IQom6sttZHOAzqOy4c=;
 b=dOJNzDf/F7uwhjMSgS/LfIYKCVyMHz8hGaYGk2uIUtn1HYT+OoNEMl81DMqDSD7R31
 9YZjz+26VyRymt8GbQ8TSKbS/yLjbo4q5OTMFbycyabm/BaIzVA0VGiYUU8vWIYhZTAJ
 V1cfDnXoEPE1x3Y0YmS6L72eK4b9aTzY59IflwWHgg3gqD/gU3wXiELFtwWawye+B6Mi
 GX5ujTaFZoc9j9x5NvhsnrL1z82Ekgy4YOQFczwdiuQYReegA9XEIi9bvQNSOELN2llz
 ohS2ajOXOdH6TNvkz7Ie6DxZrL2Nr0qr/3MpE6USdNSbi/sM4ucSSONT8pGK0RKUKGbh
 Hykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782893006; x=1783497806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbHdcJYLN1csW1huxSONUwiZ/IQom6sttZHOAzqOy4c=;
 b=Jo0t2V9kIbYqI1MHWbBYXufWu0qTrO5fk0ztvfm5H0xFpdWVwJUdnpUJAqF9vHvktu
 FOH4bUrzTs3Zv8WRr+rZx39Wjzd+qlYzS3GL7sdMk/dbjfdCGqYz6KV0o1fqvptQrmwp
 4yRT304tPIWu6PikMhAY2QGJKEXSktE/al6OX7nVLSmiiJvZZRj3QaDKTPBTfI/Nly7U
 0iu4H8owOEg0Xc3MoG/toWVhk/x3iaass68Hl8DRT9mVt/hh7dDfzb96SVmWfJy1iO8l
 EaOPrFAa+2WLAqvBq126vyhuOIYK/oTMlENmse5ijE+kuYJDJ809h8tnqrsJO7kWAFDN
 s92g==
X-Gm-Message-State: AOJu0YxfR1c5/Um+8PXh6ucstvRPmX49bEb+xLeU2yiaZLMxFlnbd/qn
 dspu0uP1VA7oImB52x4cLYokCX/Pl/8FrMKUKlWZhGCVB1rsSQ6OWddKk15wHRcjuyPmQcCJztp
 MDPY=
X-Gm-Gg: AfdE7cniPUChLaHgjx9/8Acv/SV8XQtlHJLKWZVwMWajvGYUbnuorsgWu1gRDLeSJns
 BJHWK4eG/ZHuhcIyxkljAm7yEhl95fyNFS9xsYR8kdK0a6v0XKnGcYxvsIaNUOX5K8Vci9eGJhr
 5LAZcVjiMSMftI70WqKzxqL8OG7foZo66YgiXBPopJbbhwmRQHkCw95pqjz0Bu8evFNufKyAjp0
 D2d8/BPEqELPNMBg9cND8pZpKqzTqmO8bBKjKyWIkUWwhljzS7oVpHfb6VptZmGDacAW8qni4ZI
 vag4ntnsJh9LqZsE/fyOvaIxnAmFCK2R7/ez5LfXiB5T/Iq+3jaqoYcP0sDEq3RypUYvkUt/gKK
 t4lG5Tt//gQn3POMeOPBzASBVTqq8lxdAl6DSw5R/copnk2N8ffQpZE7xIfgSshUMVV9yz4N/AY
 wz
X-Received: by 2002:a7b:cbd0:0:b0:493:a613:56b2 with SMTP id
 5b1f17b1804b1-493c2b3bbffmr5507015e9.8.1782893005832; 
 Wed, 01 Jul 2026 01:03:25 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493bef17c82sm27605545e9.1.2026.07.01.01.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 01:03:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  1 Jul 2026 08:03:22 +0000
Message-ID: <20260701080324.19270-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] statx/statx04: Skip testing casefolded filesystems
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On newer kernels (v7.1-rc1+), vfat and exfat implement fileattr_get to
support reporting casefolding. This causes the FS_IOC_GETFLAGS ioctl to
return success with FS_CASEFOLD_FL set, whereas on older kernels it
returned ENOTTY.

Since FS_IOC_GETFLAGS succeeds, statx04 assumes standard writable inode
attributes (append, immutable, nodump) are supported on these
filesystems. However, they are not, causing the statx() attribute check
to fail with TFAIL.

Fix this by checking if the retrieved flags contain FS_CASEFOLD_FL,
and if so, skip the test with TCONF. Additionally, define
FS_CASEFOLD_FL in include/lapi/fs.h for compatibility with older
user-space headers.

This addresses the failures introduced by the following upstream Linux
kernel commits:
- 27e0b573dd4a ("exfat: Implement fileattr_get for case sensitivity")
- c92db2ca72fe ("fat: Implement fileattr_get for case sensitivity")

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/fs.h                         |  4 ++++
 testcases/kernel/syscalls/statx/statx04.c | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 471ad0a25..0e2ed6e2d 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -69,6 +69,10 @@ struct fsxattr {
 # define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
 #endif
 
+#ifndef FS_CASEFOLD_FL
+# define FS_CASEFOLD_FL    0x40000000 /* Folder is case insensitive */
+#endif
+
 #ifndef FS_XFLAG_APPEND
 # define FS_XFLAG_APPEND	0x00000010	/* all writes append */
 #endif
diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index af30a200e..a4b663d2c 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -91,6 +91,16 @@ static void setup(void)
 	if (TST_RET)
 		tst_brk(TBROK | TTERRNO, "Unexpected ioctl() error");
 
+	/*
+	 * On newer kernels (v7.1-rc1+), vfat and exfat implement fileattr_get
+	 * to support reporting casefolding, which causes FS_IOC_GETFLAGS to
+	 * return success with FS_CASEFOLD_FL. However, they do not support
+	 * standard writable inode attributes (append, immutable, nodump).
+	 * Check FS_CASEFOLD_FL to gracefully skip them.
+	 */
+	if (i & FS_CASEFOLD_FL)
+		tst_brk(TCONF, "Casefolded directories/filesystems are not supported for this test");
+
 	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
 		expected_mask |= attr_list[i].attr;
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
