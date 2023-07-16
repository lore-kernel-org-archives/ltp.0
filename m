Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70B5EB64DA
	for <ltp@archiver.kernel.org>; Sun, 16 Jul 2023 05:36:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26E2A3CDE18
	for <ltp@archiver.kernel.org>; Sun, 16 Jul 2023 07:36:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71F4A3CDE0B
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 07:35:38 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A46D71A00CC0
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 07:35:37 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso3289484f8f.0
 for <ltp@lists.linux.it>; Sat, 15 Jul 2023 22:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689485737; x=1692077737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6DJShBjG367u7tyB2/lfW0X4uTrDDEb95s1kEAhdNQ=;
 b=hlKRxmKjft+P4SS8F+P3loRf2qmESGulRUJxy7ewsO/N4NWBrrGNZIW3fdjzjh22GR
 fn0ngRygcd30bTSo7bniVUttZoYej7EeB4jCeiTP+dSFgLIITIBO10V9du8pVHLxU0tg
 aa4B4mdkseeVtXtxMkuByKekv9lBkqcNjRSzr5LPNbpghmLxIAb32ciNaPP1h5A5LfHl
 I6gs4NcKCwHxrBCvvfj65nJlHhPudCcsd4+YcV/97GStN+IqTGWfS6WKf6iwHCp9pRXc
 ZlylxOAoe8qQ1bYJCCnAU+LGofhOQ0qzdRLe2sbHoCgZT7Dv8/rOEqeGcz4N5Qw1C9lR
 HkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689485737; x=1692077737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6DJShBjG367u7tyB2/lfW0X4uTrDDEb95s1kEAhdNQ=;
 b=SOnzaHw6GgkA9C0W1Kkm2uPJu9JiFMBscJhKcmXh+GeLYEFrSzXBAArE2SnUwt7r7m
 4VvrsEZTjgRdruyhgMxADYpAGl9qiy0arJsN5mJHzSPqdmgCBKNQ59B4dycUXyxlbyhX
 oOHAgfp53WEuA316wZQ6nVJJJm8cA3MKpaq8uRB3WeJNevPQbuH7dRtkYzavrP406J4P
 XJOQwq2C/XwdQeBd3r/OLWhY0qBnYxRE3mGSgUwf4URgNaX9tCdlwagpNp5G0AWsb8VL
 s0WV0wumPPAVs2emrTmeIwpCNtk2fn1zD+tZVhD2poT6y7ZiFUox2jDGz5KIpkgVkvBS
 J/Ew==
X-Gm-Message-State: ABy/qLbKjh0EaVwYCaeoWkaRiN1l9u1oovCYV6wUPQsutOP1OdzmGHkf
 zs/0qfyO+LDzFqytYFHndV8=
X-Google-Smtp-Source: APBJJlHYEoiZENOn0VIc5ZqqKJsQU9AF7hmmsqm3vOuqPROo1nRz+V5q3X8ImXywE+NNTC1yVfeYrg==
X-Received: by 2002:adf:e504:0:b0:315:a17d:dbc6 with SMTP id
 j4-20020adfe504000000b00315a17ddbc6mr7388529wrm.14.1689485736907; 
 Sat, 15 Jul 2023 22:35:36 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a5d4682000000b00313e2abfb8dsm15556087wrq.92.2023.07.15.22.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 22:35:36 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sun, 16 Jul 2023 08:35:28 +0300
Message-Id: <20230716053530.1629416-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230716053530.1629416-1-amir73il@gmail.com>
References: <20230716053530.1629416-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] fanotify14: Use FAN_MARK_INODE semantic flag
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

FAN_MARK_INODE is defined as 0, but we use the semantic flag
to improve the test case description.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify14.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index bfa0349fe..08cd94858 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -68,7 +68,7 @@ static struct test_case_t {
 	{FLAGS_DESC(FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID), {}, {}, EINVAL},
 
 	/* INODE_EVENTS in mask without class FAN_REPORT_FID are not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF), FLAGS_DESC(0), FLAGS_DESC(INODE_EVENTS),
+	{FLAGS_DESC(FAN_CLASS_NOTIF), FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(INODE_EVENTS),
 		EINVAL},
 
 	/* INODE_EVENTS in mask with FAN_MARK_MOUNT are not valid */
@@ -91,7 +91,7 @@ static struct test_case_t {
 		{}, {}, EINVAL},
 
 	/* FAN_RENAME without FAN_REPORT_NAME is not valid */
-	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID), FLAGS_DESC(0),
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID), FLAGS_DESC(FAN_MARK_INODE),
 		FLAGS_DESC(FAN_RENAME), EINVAL},
 
 	/* With FAN_MARK_ONLYDIR on non-dir is not valid */
@@ -100,19 +100,19 @@ static struct test_case_t {
 
 	/* With FAN_REPORT_TARGET_FID, FAN_DELETE on non-dir is not valid */
 	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
-		FLAGS_DESC(0), FLAGS_DESC(FAN_DELETE), ENOTDIR},
+		FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(FAN_DELETE), ENOTDIR},
 
 	/* With FAN_REPORT_TARGET_FID, FAN_RENAME on non-dir is not valid */
 	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
-		FLAGS_DESC(0), FLAGS_DESC(FAN_RENAME), ENOTDIR},
+		FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(FAN_RENAME), ENOTDIR},
 
 	/* With FAN_REPORT_TARGET_FID, FAN_ONDIR on non-dir is not valid */
 	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
-		FLAGS_DESC(0), FLAGS_DESC(FAN_OPEN | FAN_ONDIR), ENOTDIR},
+		FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(FAN_OPEN | FAN_ONDIR), ENOTDIR},
 
 	/* With FAN_REPORT_TARGET_FID, FAN_EVENT_ON_CHILD on non-dir is not valid */
 	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
-		FLAGS_DESC(0), FLAGS_DESC(FAN_OPEN | FAN_EVENT_ON_CHILD),
+		FLAGS_DESC(FAN_MARK_INODE), FLAGS_DESC(FAN_OPEN | FAN_EVENT_ON_CHILD),
 		ENOTDIR},
 
 	/* FAN_MARK_IGNORE_SURV with FAN_DELETE on non-dir is not valid */
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
