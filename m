Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7BCECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:43:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D5133CA9A0
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:43:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E6FD3CA983
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:54 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D160E1000A55
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:51 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id d5so5448194wms.5
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=2XhFHyV28r1799jbW4a5fTrzcHMO925zWfkr8pA+66o=;
 b=Z+//iVN6eKW8rVwF/72h103sUyk3eW7Rc3fAqj5EfgFqSvGvPqZZBUKJi2kQ/f4cRr
 jMAMEX+uKYB/3A0UQd60hPX3IxpcqhcxIFJktAiPJfYe5AcIBqXSufZpswS5b+fVfpe7
 C4A9htGfKIkliVtc15IKvHx0e3VMCBlIoP1stYggYeqh+BapZJvE9atK0VUpbfa6Abd4
 3/tQe4qppWFSra+ZRu1PbEOHm+ULQxtYesyiZxP7b8JFqPFMfBMalZlhYulM3LnMnYi1
 +2NR28bt5aRQVb4EADzqdgyAmDAyxLzPz0Q1/YOJEzwZJ9eY9Hv87XetKB/aZILgkKcw
 O4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=2XhFHyV28r1799jbW4a5fTrzcHMO925zWfkr8pA+66o=;
 b=1DU2uNp7Irh0Ywd8xpKtt/fmDdR0lswvQMB96FvFp36AogzfCFChhupNDEUtb6uAyC
 4O//w4tsywWS9XidJFZugxB5HX4zhz3C1r1iS/ieuYhhp2Z7biuWzc5bBXojQyewYSGF
 HAPacv1GUtgs0zATWO3SMvODD+9+Au9h52obDOLPIH3A1MpO5xgZcneIEIQBTnHDDR0+
 HJwf+rGgfWl6dkCSfPyXFPdMLMmwqVHz1qlLzlxe6xY5JOP0LPzL3smxb/NEMQshmovo
 owg4FKK91IlBViPLoDdgzPXoo30Cbj6o5Spl69DEXjI0mUd4E4FB7MJcT+JyGGwEJRji
 F+Ow==
X-Gm-Message-State: ACgBeo0R5AWsZNVp/Q6O7B2mI4U6ZRrKwWsDb/Wgz5Omsvad/NdYnqkv
 RGBUXCjqWaunYu6Z0aAWSESey+dM+OQ=
X-Google-Smtp-Source: AA6agR7yY3e6Fe/iaDaWWbsY4RLn1YlguBgYgjTGf2keIVexrlg2abGRRzUwS2/UOwyfWq4glX7hVQ==
X-Received: by 2002:a05:600c:3b10:b0:3a8:3b77:b5e0 with SMTP id
 m16-20020a05600c3b1000b003a83b77b5e0mr11156431wms.129.1662392571408; 
 Mon, 05 Sep 2022 08:42:51 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:50 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:34 +0300
Message-Id: <20220905154239.2652169-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/9] syscalls/fanotify10: Avoid undesired event in test
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

Open fd for syncfs before creating groups to avoid the
FAN_OPEN event that this open generates.

This event does not break any of the existing test cases,
but should avoid it to avoid noise in future test cases.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify10.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 93340255f..b8358b489 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -66,6 +66,7 @@ static unsigned int fanotify_class[] = {
 #define GROUPS_PER_PRIO 3
 
 static int fd_notify[NUM_CLASSES][GROUPS_PER_PRIO];
+static int fd_syncfs;
 
 static char event_buf[EVENT_BUF_LEN];
 static int exec_events_unsupported;
@@ -342,14 +343,11 @@ static void show_fanotify_marks(int fd)
 	}
 }
 
-static void drop_caches(const char *path)
+static void drop_caches()
 {
-	int fd = SAFE_OPEN(path, O_RDONLY);
-
-	if (syncfs(fd) < 0)
+	if (syncfs(fd_syncfs) < 0)
 		tst_brk(TBROK | TERRNO, "Unexpected error when syncing filesystem");
 
-	SAFE_CLOSE(fd);
 	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
 }
 
@@ -364,6 +362,9 @@ static int create_fanotify_groups(unsigned int n)
 	mark = &fanotify_mark_types[tc->mark_type];
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
 
+	/* Open fd for syncfs before creating groups to avoid the FAN_OPEN event */
+	fd_syncfs = SAFE_OPEN(MOUNT_PATH, O_RDONLY);
+
 	for (p = 0; p < num_classes; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
 			fd_notify[p][i] = SAFE_FANOTIFY_INIT(fanotify_class[p] |
@@ -413,7 +414,7 @@ add_mark:
 	 * drop_caches should evict inode from cache and remove evictable marks
 	 */
 	if (evictable_ignored) {
-		drop_caches(tc->mark_path);
+		drop_caches();
 		for (p = 0; p < num_classes; p++) {
 			for (i = 0; i < GROUPS_PER_PRIO; i++) {
 				if (fd_notify[p][i] > 0)
@@ -435,6 +436,8 @@ static void cleanup_fanotify_groups(void)
 				SAFE_CLOSE(fd_notify[p][i]);
 		}
 	}
+	if (fd_syncfs > 0)
+		SAFE_CLOSE(fd_syncfs);
 }
 
 /* Flush out all pending dirty inodes and destructing marks */
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
