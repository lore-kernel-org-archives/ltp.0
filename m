Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A812C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:39:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4DB53C9451
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:39:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95523C217F
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:38 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9EBD7600801
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:37 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 l2-20020a05600c4f0200b0039c55c50482so4712929wmq.0
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3iysMeozJ/rAuh0/XI/m+0zgq2w1OAtqu7aaJ/uGlGM=;
 b=CakXiq/Dp2fAozbit5+mPG2FJfVP/h/rBe2mT5OFDSdjALK+Fqh2MPP3ptOyckFo8w
 ZF6t7sAT8Kk7GRgCw2+RG2BaZsd50NpKu8ti6qpqPMtx7NRaSj9/a3vyyFtEenE3/0Io
 qMtG8I40Xh6201lFHuCAF8RqPM3eJ5ErMKmY5NqPFDzxIJhEAG8O69MoWxS9w/m9y1vv
 2mHSGt87yjd995f9tVtMRIOCrB9iDbjAhmIZ86PW2sNUq4RS/ME5FYUFfxK2LV4u2tMJ
 dXYbvu2bYykGmSqBuFLv05hgx2jpG+c/YfsyjwODc0fzkzBdCOenCQ49waf05i1ExRJk
 R5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3iysMeozJ/rAuh0/XI/m+0zgq2w1OAtqu7aaJ/uGlGM=;
 b=UvnG9oZJ7tEqEcdm3Ih8IbMnONvfntDYQukZv09eALCuGbEEcUq7/RFV3qmOL7s5LF
 ysVmLheJFW6MkgVn+N3DkWnEh6ZxlA1YPFfAKic6gTY990YTR5kR07iPBPHVB6TH56ee
 RZGn99APdUp0Us+W/H4ltynirJif8nMvHcnplbKKgtsIV4afAKWYPQsiVZZrZz4pab7u
 ziC1HF1HHZ3Cvsb1n4dN97E9K+J60LqEnBvS5Tg+MkSqkZdkOb35WirzE/vPt5vuUHPe
 SwrZM9PfL/qtmT2bfv+Zp/pnekjmzutVnHc9dfjHrJzu+oGab2NCKFIsAtxFQCn3gONF
 GjZA==
X-Gm-Message-State: AOAM533pOQenlFnjne3oWFR4l8z5ydRFZPlrOr4dsApNzfZ0hjvGC5V2
 G1vmoQcEMyF2+WyelFCq9LU=
X-Google-Smtp-Source: ABdhPJy/epGCzeblP1GkqYfIo/E/s7fqxzpEgazje0gBwY3JuQAsavH/gfn6hEtfn0cSlvsUsCYk8g==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id
 l20-20020a7bc354000000b0039c675321f8mr15345507wmj.113.1655131117168; 
 Mon, 13 Jun 2022 07:38:37 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b0039c55bc2c97sm14833072wmq.16.2022.06.13.07.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:38:36 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Jun 2022 17:38:25 +0300
Message-Id: <20220613143826.1328830-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613143826.1328830-1-amir73il@gmail.com>
References: <20220613143826.1328830-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] syscalls/fanotify10: Mount cycle between test
 cases
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Mount cycle detects inode refcount errors and waits for all marks
of test case to be destructed before continuing to next test case.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index efef25135..b9a50672d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -360,6 +360,17 @@ static void cleanup_fanotify_groups(void)
 	}
 }
 
+/* Flush out all pending dirty inodes and destructing marks */
+static void mount_cycle(void)
+{
+	if (bind_mount_created)
+		SAFE_UMOUNT(MNT2_PATH);
+	SAFE_UMOUNT(MOUNT_PATH);
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
+	SAFE_MOUNT(MOUNT_PATH, MNT2_PATH, "none", MS_BIND, NULL);
+	bind_mount_created = 1;
+}
+
 static void verify_event(int p, int group, struct fanotify_event_metadata *event,
 			 unsigned long long expected_mask)
 {
@@ -508,6 +519,7 @@ static void test_fanotify(unsigned int n)
 	}
 cleanup:
 	cleanup_fanotify_groups();
+	mount_cycle();
 }
 
 static void setup(void)
@@ -523,25 +535,24 @@ static void setup(void)
 		num_classes = NUM_PRIORITIES;
 	}
 
-	/* Create another bind mount at another path for generating events */
-	SAFE_MKDIR(MNT2_PATH, 0755);
-	SAFE_MOUNT(MOUNT_PATH, MNT2_PATH, "none", MS_BIND, NULL);
-	bind_mount_created = 1;
-
 	SAFE_MKDIR(DIR_PATH, 0755);
 	SAFE_FILE_PRINTF(FILE_PATH, "1");
 	SAFE_FILE_PRINTF(FILE2_PATH, "1");
 
 	SAFE_CP(TEST_APP, FILE_EXEC_PATH);
 	SAFE_CP(TEST_APP, FILE2_EXEC_PATH);
+
+	/* Create another bind mount at another path for generating events */
+	SAFE_MKDIR(MNT2_PATH, 0755);
+	mount_cycle();
 }
 
 static void cleanup(void)
 {
 	cleanup_fanotify_groups();
 
-	if (bind_mount_created && tst_umount(MNT2_PATH) < 0)
-		tst_brk(TBROK | TERRNO, "bind umount failed");
+	if (bind_mount_created)
+		SAFE_UMOUNT(MNT2_PATH);
 }
 
 static const char *const resource_files[] = {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
