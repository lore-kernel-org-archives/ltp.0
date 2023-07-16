Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D73EB64DD
	for <ltp@archiver.kernel.org>; Sun, 16 Jul 2023 05:36:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 551683CEC06
	for <ltp@archiver.kernel.org>; Sun, 16 Jul 2023 07:35:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80DF83CBE84
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 07:35:39 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B760C600A72
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 07:35:38 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1986098f8f.1
 for <ltp@lists.linux.it>; Sat, 15 Jul 2023 22:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689485738; x=1692077738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esiHodUSrzIBf7dBnOo1Le8ZuqzXoilGry7ZM+s9Z5k=;
 b=ge54Smcou8jAN3EfQv8Qzd0zlQlcGiaNYidDQ4NRQhIqcQfLm40VySUfrSEtOdSd2i
 n3bIpF5+9So0OJCqkHmfRgFrS2ADrRyjQW89Ij4/eyM8KbsyL0PG4WVQ3LMV4fUB92nN
 j2lFCmaiN8jKXLsqwOGZYlxJbZtyQIBzAEBBG27IwGD3nKVfQc7iaer0ALd26bydMYIY
 1mIrxJk5Vu4JWnX0ExXuIURW6WP/0kjIfPzaHgLPZ595gvndp2w2Ha2RPXVDhzRM1seU
 2i79ky+VW6zARk3vp8nkQESXFvCdWhz92u9wc0JJIi/Xb5JzrYys64ZDchctaZjQnfQ9
 KhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689485738; x=1692077738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esiHodUSrzIBf7dBnOo1Le8ZuqzXoilGry7ZM+s9Z5k=;
 b=BAA1gevH5/AqV87uc4cNqt6M6MFD6Z8+WMU6D4+HMgmvR+Im6JZ7Ri6ybx8UYkfZ1i
 Ox++3YK60XoWeEig7pJ3tnMOGQv9qzGB3NQpIXjevCUQfHZR4gltT1yfelpKPRPPYRqa
 H/TtbRZnLuYtT6+MqinSZLcIaR4HPge+526kEVz1rWQRPiJuflBhvsVPpzjLsORz2IST
 VLDC9ZFqRVWiRpGvjIJB0sFmRvoXVha9p3mk3dn178/pwg6Od2M3qngIo73j5f3J9uZB
 uFJlPZfLz5bBev14Sokk2w2wgSVvsxZrWZXB8QXB+M9sGvEU9KOYDoNTFF9BJum9Z1Wj
 e0HQ==
X-Gm-Message-State: ABy/qLZt3bi6r9nMK1Rq2D4109N7hp64sqBRFAbDXvx9C0HhANSB2WDn
 ogdB8XNzrI5MgVbY54PVhx77KMpgKnE=
X-Google-Smtp-Source: APBJJlHIPy1gDwVtWNpa6yJmX5gWOfqhCWlDmaXz2bJZHbXXL6jUA8ovGAExG9gZ6dXWKn95XGSalQ==
X-Received: by 2002:adf:f30f:0:b0:307:7959:6461 with SMTP id
 i15-20020adff30f000000b0030779596461mr5686929wro.31.1689485738153; 
 Sat, 15 Jul 2023 22:35:38 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a5d4682000000b00313e2abfb8dsm15556087wrq.92.2023.07.15.22.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 22:35:37 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sun, 16 Jul 2023 08:35:29 +0300
Message-Id: <20230716053530.1629416-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230716053530.1629416-1-amir73il@gmail.com>
References: <20230716053530.1629416-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] fanotify14: Use named initializers
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
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In preparation for adding a new optional test case struct member.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 160 +++++++++++++-----
 1 file changed, 114 insertions(+), 46 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 08cd94858..2c6f6afea 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -62,92 +62,160 @@ static struct test_case_t {
 	int expected_errno;
 } test_cases[] = {
 	/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
-	{FLAGS_DESC(FAN_CLASS_CONTENT | FAN_REPORT_FID), {}, {}, EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_CONTENT | FAN_REPORT_FID),
+		.expected_errno = EINVAL,
+	},
 
 	/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
-	{FLAGS_DESC(FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID), {}, {}, EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID),
+		.expected_errno = EINVAL,
+	},
 
 	/* INODE_EVENTS in mask without class FAN_REPORT_FID are not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF), FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(INODE_EVENTS),
-		EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(INODE_EVENTS),
+		.expected_errno = EINVAL,
+	},
 
 	/* INODE_EVENTS in mask with FAN_MARK_MOUNT are not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_FID),
-		FLAGS_DESC(FAN_MARK_MOUNT), FLAGS_DESC(INODE_EVENTS), EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_FID),
+		.mark = FLAGS_DESC(FAN_MARK_MOUNT),
+		.mask = FLAGS_DESC(INODE_EVENTS),
+		.expected_errno = EINVAL,
+	},
 
 	/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_NAME), {}, {}, EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_NAME),
+		.expected_errno = EINVAL,
+	},
 
 	/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME), {},
-		{}, EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME),
+		.expected_errno = EINVAL,
+	},
 
 	/* FAN_REPORT_TARGET_FID without FAN_REPORT_FID is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME),
-		{}, {}, EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME),
+		.expected_errno = EINVAL,
+	},
 
 	/* FAN_REPORT_TARGET_FID without FAN_REPORT_NAME is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID),
-		{}, {}, EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID),
+		.expected_errno = EINVAL,
+	},
 
 	/* FAN_RENAME without FAN_REPORT_NAME is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID), FLAGS_DESC(FAN_MARK_INODE),
-		FLAGS_DESC(FAN_RENAME), EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(FAN_RENAME),
+		.expected_errno = EINVAL,
+	},
 
 	/* With FAN_MARK_ONLYDIR on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF), FLAGS_DESC(FAN_MARK_ONLYDIR),
-		FLAGS_DESC(FAN_OPEN), ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_ONLYDIR),
+		.mask = FLAGS_DESC(FAN_OPEN),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* With FAN_REPORT_TARGET_FID, FAN_DELETE on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
-		FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(FAN_DELETE), ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(FAN_DELETE),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* With FAN_REPORT_TARGET_FID, FAN_RENAME on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
-		FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(FAN_RENAME), ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(FAN_RENAME),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* With FAN_REPORT_TARGET_FID, FAN_ONDIR on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
-		FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(FAN_OPEN | FAN_ONDIR), ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(FAN_OPEN | FAN_ONDIR),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* With FAN_REPORT_TARGET_FID, FAN_EVENT_ON_CHILD on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
-		FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(FAN_OPEN | FAN_EVENT_ON_CHILD),
-		ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(FAN_OPEN | FAN_EVENT_ON_CHILD),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* FAN_MARK_IGNORE_SURV with FAN_DELETE on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
-		FLAGS_DESC(FAN_MARK_IGNORE_SURV), FLAGS_DESC(FAN_DELETE),
-		ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
+		.mark = FLAGS_DESC(FAN_MARK_IGNORE_SURV),
+		.mask = FLAGS_DESC(FAN_DELETE),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* FAN_MARK_IGNORE_SURV with FAN_RENAME on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
-		FLAGS_DESC(FAN_MARK_IGNORE_SURV), FLAGS_DESC(FAN_RENAME),
-		ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
+		.mark = FLAGS_DESC(FAN_MARK_IGNORE_SURV),
+		.mask = FLAGS_DESC(FAN_RENAME),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* FAN_MARK_IGNORE_SURV with FAN_ONDIR on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
-		FLAGS_DESC(FAN_MARK_IGNORE_SURV),
-		FLAGS_DESC(FAN_OPEN | FAN_ONDIR), ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
+		.mark = FLAGS_DESC(FAN_MARK_IGNORE_SURV),
+		.mask = FLAGS_DESC(FAN_OPEN | FAN_ONDIR),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* FAN_MARK_IGNORE_SURV with FAN_EVENT_ON_CHILD on non-dir is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
-		FLAGS_DESC(FAN_MARK_IGNORE_SURV),
-		FLAGS_DESC(FAN_OPEN | FAN_EVENT_ON_CHILD), ENOTDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
+		.mark = FLAGS_DESC(FAN_MARK_IGNORE_SURV),
+		.mask = FLAGS_DESC(FAN_OPEN | FAN_EVENT_ON_CHILD),
+		.expected_errno = ENOTDIR,
+	},
 
 	/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on directory is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF), FLAGS_DESC(FAN_MARK_IGNORE),
-		FLAGS_DESC(FAN_OPEN), EISDIR},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_IGNORE),
+		.mask = FLAGS_DESC(FAN_OPEN),
+		.expected_errno = EISDIR,
+	},
 
 	/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on mount mark is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF),
-		FLAGS_DESC(FAN_MARK_MOUNT | FAN_MARK_IGNORE),
-		FLAGS_DESC(FAN_OPEN), EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_MOUNT | FAN_MARK_IGNORE),
+		.mask = FLAGS_DESC(FAN_OPEN),
+		.expected_errno = EINVAL,
+	},
 
 	/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on filesystem mark is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF),
-		FLAGS_DESC(FAN_MARK_FILESYSTEM | FAN_MARK_IGNORE),
-		FLAGS_DESC(FAN_OPEN), EINVAL},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_FILESYSTEM | FAN_MARK_IGNORE),
+		.mask = FLAGS_DESC(FAN_OPEN),
+		.expected_errno = EINVAL,
+	},
 };
 
 static void do_test(unsigned int number)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
