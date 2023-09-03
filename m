Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08495C83F2C
	for <ltp@archiver.kernel.org>; Sun,  3 Sep 2023 11:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 941413CB9AD
	for <ltp@archiver.kernel.org>; Sun,  3 Sep 2023 13:16:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85B853CB949
 for <ltp@lists.linux.it>; Sun,  3 Sep 2023 13:16:11 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B3605140007F
 for <ltp@lists.linux.it>; Sun,  3 Sep 2023 13:16:10 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso1605745e9.1
 for <ltp@lists.linux.it>; Sun, 03 Sep 2023 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693739770; x=1694344570; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1jOC3lAVfW77frHZvY9W0gFzy1Cj1TNNQ+t9mwJjV4=;
 b=oAoegRl1jqY2fUvKOEpwQALjV6zL7Tug0gzeldNCKq+D4r6pQba12Xr1aT9+rc/fot
 M6cX3o3t1hpxofR2ZSp0laVtrHt5VeIn9AwZD0d2MddZccUyZVfdKrccEwUKkGcKK1uT
 L6dAbRhl4Yt7mRjZCTh6nHJT2DLRn6/CAGt4xjjjgAh42dLAdfPRkxNTQkaoBlZDDREK
 iL3Nw5JcXILUhTYWGRzAcjNtKMfyQ5PMa3Vqn1eXyg1v8swUiwIyfAZerJYZFQ11Xu6u
 SI8H0WbQ+tg+do4Xw+oZR8/NM8pt+XySs2/b0fQgH8cPaKZc3Rp+7CVAyQ+qwJFlnzlp
 4dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693739770; x=1694344570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1jOC3lAVfW77frHZvY9W0gFzy1Cj1TNNQ+t9mwJjV4=;
 b=OkRq5zMmi5asMhvSx2vC8IMb9wDzLya+LzkzOua875/p6fYsSRoXOmTRD9ZtRUb4GC
 qcqSEr8xsnj9CAqvNMSUk/qEUgT0PewsKEZ7FJoe5nnK0iz+tWbNgwN6PTKMUaqlgCpW
 8qGzHQgabBZ7WHJb8IyzK3oTFxQnozbXMegWlJ1CM7nWW32IVwRJsMCd2F1dq/0Kk40A
 z4nXLDNvuuBohQCjFKEao/x0jAdIxstBp1mew6cJx3OnKkTBs+ljYloDVMJGy5OiaAdk
 8Am2wHwrJiK0jRcMaEJHbbRS5FRRnBJlb1XrN/Ki1Trzl70UP3Nc+PfyttzNDP5nqNNk
 hMzw==
X-Gm-Message-State: AOJu0YyfBQ+Df6xWPYG+T3EICH/lczSvoOpwUyMSqr/ubPS0uBsSFj/D
 uiL3lqxrgQny/Uhf9nNNsO8=
X-Google-Smtp-Source: AGHT+IFXuAcaNiuAAsJSWq5YgSZbsZR4mpMCtzpd7sbaMzosKLe/qXI48RHNV/c6oP6XKjXZ6nSYqw==
X-Received: by 2002:a05:600c:20d4:b0:3f8:fc2a:c7eb with SMTP id
 y20-20020a05600c20d400b003f8fc2ac7ebmr4388803wmm.5.1693739769994; 
 Sun, 03 Sep 2023 04:16:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c228900b003fc080acf68sm13899065wmf.34.2023.09.03.04.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 04:16:09 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sun,  3 Sep 2023 14:15:58 +0300
Message-Id: <20230903111558.2603332-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903111558.2603332-1-amir73il@gmail.com>
References: <20230903111558.2603332-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] fanotify13: Test unique overlayfs fsid
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

With feature uuid=auto, overlayfs gets an fsid which is different than
the base fs fsid.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify13.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 5c1d287d7..3bb9eb1df 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -96,6 +96,7 @@ static int fanotify_fd;
 static int filesystem_mark_unsupported;
 static char events_buf[BUF_SIZE];
 static struct event_t event_set[EVENT_MAX];
+static struct fanotify_fid_t base_fs_fid;
 
 static void create_objects(void)
 {
@@ -113,8 +114,19 @@ static void get_object_stats(void)
 {
 	unsigned int i;
 
+	fanotify_save_fid(OVL_BASE_MNTPOINT, &base_fs_fid);
 	for (i = 0; i < ARRAY_SIZE(objects); i++)
 		fanotify_save_fid(objects[i].path, &objects[i].fid);
+
+	/* Variant #2: watching overlayfs - expect fsid != base fs fsid */
+	if (ovl_mounted && tst_variant == 2 &&
+	    memcmp(&objects[0].fid.fsid, &base_fs_fid.fsid,
+		   sizeof(base_fs_fid.fsid)) == 0) {
+		tst_res(TFAIL,
+			"overlayfs fsid is the same as stat.f_fsid that was "
+			"obtained via statfs(2) on the base fs");
+	}
+
 }
 
 static int setup_marks(unsigned int fd, struct test_case_t *tc)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
