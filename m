Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D95C43458
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 01:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783043889; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=apikVu/Truz5wJy0JEjCAr81akvt82g//pxIvpbGHf8=;
 b=kiOb909Lh6v358iSBA2SUl+uwx4O0B2MXyuQw5tRZe/neJeB1tG0tojJQkfUa0bQPR75X
 8EQK8NRUrRpiJCTNIILfwJsNtir4NxnRbnuu03KAyOE6EJwTi+/cjaWUCrYfdprq1yz9KXt
 RyaCt8hVUd3LBggZ5zgOdU6s6QGdtFM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D25D73E72DB
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 03:58:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D35833E4A2B
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 03:57:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 313DD600A04
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 03:57:49 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493c83474ddso177555e9.3
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783043868; x=1783648668; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgg872BBYqOZ8WuUCMp3wlLNRLeeU3mutxF6eajlVao=;
 b=YkKf57RBLogz3bs0M36RaKOuT94vlllUrbH6I2K2ZW+8jiMBTTsrrbxWSLNkAfRDvr
 O6Dwh0uHYW/nQMTvMyprlUkg7nPbvpvYX1/58TwnihYS3KOLvhNVizfoUwy4VEr64rsw
 TWvYtKv/H0AUcbxHnPi5eSoq48e/Rw565Z7+JZthb/Os8mxi05Slq1ZGYmgqN0tkfY6o
 OMKUKMLb3KRwZoH7HkQxiG7FhMzrVs6tVglXwm+r0LKgWubeixhiHk5Opc3nC0HWT/6T
 8QWpO4zwT2/7/Mh0ZnH7/opBI8YvDFYOAvYurXHeHJz9vN8Rt/R0XlKIjoIiWCp5k6a9
 s5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043868; x=1783648668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rgg872BBYqOZ8WuUCMp3wlLNRLeeU3mutxF6eajlVao=;
 b=AECeMqGny+a0KXQ7LiVgjW77U4dU7GX/Fb9NQqWK/mXUmPIbCkzaL5sLS/QTRqg+E8
 Nx+ZbZk08QeZK9VXeeTeQfi1qLLUNg1m/CMxoelGCeOIkfK4lUcq1QkNyGbK3sriC//Z
 8XorWoLgziv1YnHdAMOKJfGEUsbPaEa+IOlHI9mvg6DRi+ShIHDAOHhu3MVDuccuiK7H
 F8X0WysH7wAwsU9lQwx7Uds7wCJJXauP9LmMxep9ZcCnPPZGB2w89b4+2lTLp5NUJT/2
 EWv2A4c8/N0bgJXYGF9xpagniC1o50P0uF40AE+cDqeKvbJ9nw2VvuELs9xHborADQ/e
 Htjg==
X-Gm-Message-State: AOJu0YyDIxLIkdsVAOnWWnqMe4rX7WBm5lruy2JqCMJN4x2j80xqhiU0
 ZefkDT7OKvVj7KmwDNSiTvj8CSnEtE5EdLEoN/4aKBhpoP9ShOuFMAiTfsfwNZLlte+7cu0xl1s
 tlb0=
X-Gm-Gg: AfdE7cmg3OBoHBxcw2Kq306Hi5zfNKo/9H0PWGSYDnin5kKodxSH5JGFfKXPChKF8hw
 KDS2PJiGMdSb670RLSP0et7TDKUdZxa6h6gMNlxBivza0bAXJ7YY+4y7tE4gYFHYFGPBpTSmAnb
 8g5SI1H5X0yK7WRosObwudJ7DAsqcjvynbohNnpab5NIJNciO1uS51YVLHXzNBDNnBRlaXr63hV
 ua/bIY4B3Bafibrt9yB/fjaG27dFBVuRF4se5XJaQYU7X9Spu9l9an3zA6uizQfyUjG+5oT/Ksz
 D/xzkWoM5lnxQI/FMThfMRw+TSawG4R4EGz1wCht5rBCl4z6UbTNeCQMYAHRvBahRH8xv+4CSop
 euEYhMgxRN0T5qgSv6JFf1FV2XhO2ZyE4qlqVKwy5I6Zo+1A5AAUb2Pb3MhFM9/8Ty/PRErvFoc
 hd
X-Received: by 2002:a05:600c:5307:b0:493:bfea:2786 with SMTP id
 5b1f17b1804b1-493c3df38b1mr109373965e9.32.1783043868432; 
 Thu, 02 Jul 2026 18:57:48 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493c637568dsm95417635e9.4.2026.07.02.18.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:57:47 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri,  3 Jul 2026 01:57:24 +0000
Message-ID: <20260703015745.20728-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701080324.19270-1-wegao@suse.com>
References: <20260701080324.19270-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] statx/statx04: Skip vfat and exfat filesystems
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
return success, whereas on older kernels it returned ENOTTY.

Since FS_IOC_GETFLAGS succeeds, statx04 assumes standard writable inode
attributes (append, immutable, nodump) are supported on these
filesystems. However, they are not, causing the statx() attribute check
to fail with TFAIL.

Fix this by checking if the filesystem type is vfat or exfat and skipping
the test with TCONF.

This addresses the failures introduced by the following upstream Linux
kernel commits:
- 27e0b573dd4a ("exfat: Implement fileattr_get for case sensitivity")
- c92db2ca72fe ("fat: Implement fileattr_get for case sensitivity")

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/statx/statx04.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index af30a200e..b2a2ac9cc 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -91,6 +91,15 @@ static void setup(void)
 	if (TST_RET)
 		tst_brk(TBROK | TTERRNO, "Unexpected ioctl() error");
 
+	/*
+	 * On newer kernels (v7.1-rc1+), vfat and exfat implement fileattr_get
+	 * to support reporting casefolding, which causes FS_IOC_GETFLAGS to
+	 * return success. However, they do not support standard writable inode
+	 * attributes (append, immutable, nodump). Skip them.
+	 */
+	if (!strcmp(tst_device->fs_type, "vfat") || !strcmp(tst_device->fs_type, "exfat"))
+		tst_brk(TCONF, "vfat and exfat do not support standard attributes");
+
 	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
 		expected_mask |= attr_list[i].attr;
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
