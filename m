Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4E5C4167B
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 23:01:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E243C3CF2E3
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 00:01:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CAD43CE995
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 00:01:05 +0100 (CET)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4EF5B600848
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 00:01:05 +0100 (CET)
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-5a08e5c7debso1166491a12.2
 for <ltp@lists.linux.it>; Thu, 02 Nov 2023 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698966064; x=1699570864; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=gtTbwB1fpkSZ/tWVCQMG3xAd6Z1QEVn9cd0fkdjINCk=;
 b=jSN7ZKZ18c8CteLLCkXE2pcpM6PvNHTb/g0hTn43jCxqsnmLsnTAXp6shHY9Nf4HVE
 FDVgUkcdskUxqruJZw1C1hCwIh65kwt9CF+Hg+OLOszOzipSPX6EU+wePk8xtRHCDp73
 dD2JBVyVWUQqYjGVmOQDQ+l/Y+8/E7JTO8RDmf5mFxxIpXu8zz4mOvAgZOcnkIuhLkGe
 R4kZO0mvoqJeoyLUIDfqDYdmTXdE2bHx6PFH0nuhBlfkHJp595TNeehfItKeU5dlbOXe
 drj/u0UfJp+89eIa5tmehd43iv2iGma7ScscXSfetq91+u0mbnhnQsTq3XevKYFkYu1s
 urAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698966064; x=1699570864;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtTbwB1fpkSZ/tWVCQMG3xAd6Z1QEVn9cd0fkdjINCk=;
 b=H05Wt1cLPbAF8TvvNRS9APWxIRTRvf5t3neMmapmO7LWVWJIp/0qHO/PDD8LxbuPY+
 JM5qsfgUqMbNPZghguLeaO5xxSMlYyAFNDztTnUW9g9FlmiZLRThHtBGjzBgysTZDXC2
 sfaSTwhZipKzMJEWIMaPz23hliA7QlbV0vJtZipEVb3zamZJxfFixXnATermM3fRPpvA
 vQfNn2lXCSTjHTlV3/6/3H9+T3PAepssTGbLsmB+JbVv1Pso7CxwISf51z4+udLFT3o6
 BFAKWE9lVLmXaAO4GwtiFqWvMXGF/yiHVHHueASjuT54MHXxUBY9iI3kDiDEbL5iYNF0
 T15Q==
X-Gm-Message-State: AOJu0Yx5zXNYlF64L2AXC4toCCXBNXEUvYqNNBCmTkyXuq87W3RIPF0H
 73+Zrd0qkBHBxtXQ4z0gV+XSJow3BtuFGcc0QlVoPgogXHR32jYGpzm9Og/IS2oyrGvDv8Qr2nN
 LBVdzU/CKtoFTcme9t6R93a5cWqZp6SFZoAG1pFFbEJ/hnrhX9j6o47RE
X-Google-Smtp-Source: AGHT+IECTJb9vbR6Egah/9dQ4O1xJzL8JtbU6FpTT8au7u3K7RAovLxouc1U8o2OHeuCSaytXlVtOvNGGVo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:9258:0:b0:56b:6acd:d5f8 with SMTP id
 s24-20020a639258000000b0056b6acdd5f8mr319527pgn.7.1698966063345; Thu, 02 Nov
 2023 16:01:03 -0700 (PDT)
Date: Thu,  2 Nov 2023 23:00:54 +0000
In-Reply-To: <20231102230054.3195864-1-edliaw@google.com>
Mime-Version: 1.0
References: <20231102230054.3195864-1-edliaw@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102230054.3195864-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] madvise11: Replace /etc/mtab with /proc/mounts
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

Android does not have the /etc/mtab symlink, so trying to open it fails
with TBROK.  Replace it with /proc/mounts.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 0793319d2..55556f530 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -308,9 +308,9 @@ static int open_unpoison_pfn(void)
 		SAFE_CMD(cmd_modprobe, NULL, NULL);
 
 	/* debugfs mount point */
-	mntf = setmntent("/etc/mtab", "r");
+	mntf = setmntent("/proc/mounts", "r");
 	if (!mntf) {
-		tst_brk(TBROK | TERRNO, "Can't open /etc/mtab");
+		tst_brk(TBROK | TERRNO, "Can't open /proc/mounts");
 		return -1;
 	}
 	while ((mnt = getmntent(mntf)) != NULL) {
-- 
2.42.0.869.gea05f2083d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
