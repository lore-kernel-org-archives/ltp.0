Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF53BECAAD3
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:44:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 609803CA992
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:44:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 222073CA94F
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 016A1600A12
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:53 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 m3-20020a05600c3b0300b003a5e0557150so7145184wms.0
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=oQCRvbYbM6uNGo38pVjcKnzdoCJXamT5k0pfmGFUTTE=;
 b=D+bpoeig3jXGGCJFes8oBvsB+zb3ltW0gmgr6jNQ2QHhPki0T+1+kGdS8ENtwYLTlg
 UDIqt5KeSVKN+67zFLUNTwEZ4waCAT06y4xUPcRZxpLrorxshzByNo7HOzCoCzMdHUrh
 leec2JFGdqbMwFakGvCLKW41OEced9FBBWkRwpZ7+fuWiS5mnbnrkzb5mFv2hEznwd49
 LlZ7K+DZPfhg5USOEgAtf5aiiCJYrKHGrusKzVkMVlfPgfYpcdMwgUXO5eXsYXAO+jJ2
 T/afaZu8W6ZacZQ7pjaLIlozFDPhQCQVZhnYJeQTbEbGOUCk5qnog12aF3CcNwCg3QfC
 vXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=oQCRvbYbM6uNGo38pVjcKnzdoCJXamT5k0pfmGFUTTE=;
 b=U2KxvM1ICrRMX2FpRe+UBGMgrV4Da14Q9WghX2sAYPMh5E4VSM6CgpD5nhepCd1G/+
 4kNqoGMous37U9DwoUWROTZvZtYgC81akiRsJInIsccRGfUOW0zgP+mqDyAQNhj1pX97
 k9l/kk1L+eSwBX8jCiLl4ZJEG6vz46ylP0YUmrsDvNM2+GDqpr1nJ23FAZNTyZjzPje7
 kFPkRnUPOzan2nASxUdvE13dm27A2PqaAj0+HhM45znwFN5VsWZCGakD2RStf1w6uBe5
 5ZGK50iXsMtsh2NrtKnpDSQu9VqjXr+4OZlvw6keB3NEPS1j7oXpFaPly8Kb55u4kStP
 MVXg==
X-Gm-Message-State: ACgBeo0yRzwFwEz0JTV88xeL7/830I2keMiwGeISAg3wAsU4c76hDj/E
 JGUQ43C/MX25BzWwXaiODd4=
X-Google-Smtp-Source: AA6agR56q2u/YGhFYZztMmhdErLDBzg4HZFMbdL0S5dZr4ZX/TsZiJfK2xKw9D6b3cbaWCMiLeYudg==
X-Received: by 2002:a05:600c:5028:b0:3a8:4349:153c with SMTP id
 n40-20020a05600c502800b003a84349153cmr11140990wmr.130.1662392572524; 
 Mon, 05 Sep 2022 08:42:52 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:52 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:35 +0300
Message-Id: <20220905154239.2652169-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/9] syscalls/fanotify10: Add more verifications and
 debug info
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

Check that non-evictable inode ignore marks exist as expected
and print mask of unexpected events.

Fix information printed for events from unexpected pid.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h |  4 ++
 .../kernel/syscalls/fanotify/fanotify10.c     | 41 ++++++++++++-------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index d67c079af..810a48e81 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -112,6 +112,10 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #ifndef FAN_MARK_IGNORE_SURV
 #define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
 #endif
+/* Non-uapi convenience macros */
+#ifndef FAN_MARK_TYPES
+#define FAN_MARK_TYPES (FAN_MARK_INODE | FAN_MARK_MOUNT | FAN_MARK_FILESYSTEM)
+#endif
 
 /* New dirent event masks */
 #ifndef FAN_ATTRIB
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index b8358b489..ea05e4ff0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -328,18 +328,21 @@ static struct tcase {
 	},
 };
 
-static void show_fanotify_marks(int fd)
+static void show_fanotify_ignore_marks(int fd, int expected)
 {
 	unsigned int mflags, mask, ignored_mask;
 	char procfdinfo[100];
 
 	sprintf(procfdinfo, "/proc/%d/fdinfo/%d", (int)getpid(), fd);
 	if (FILE_LINES_SCANF(procfdinfo, "fanotify ino:%*x sdev:%*x mflags: %x mask:%x ignored_mask:%x",
-				&mflags, &mask, &ignored_mask)) {
-		tst_res(TPASS, "No fanotify inode marks as expected");
+				&mflags, &mask, &ignored_mask) || !ignored_mask) {
+		tst_res(!expected ? TPASS : TFAIL,
+			"No fanotify inode ignore marks %sexpected",
+			!expected ? "as " : "is un");
 	} else {
-		tst_res(TFAIL, "Unexpected inode mark (mflags=%x, mask=%x ignored_mask=%x)",
-				mflags, mask, ignored_mask);
+		tst_res(expected ? TPASS : TFAIL,
+			"Found %sexpected inode ignore mark (mflags=%x, mask=%x ignored_mask=%x)",
+			expected ? "" : "un", mflags, mask, ignored_mask);
 	}
 }
 
@@ -358,9 +361,11 @@ static int create_fanotify_groups(unsigned int n)
 	unsigned int mark_ignored, mask;
 	unsigned int p, i;
 	int evictable_ignored = (tc->ignore_mark_type == FANOTIFY_EVICTABLE);
+	int ignore_mark_type;
 
 	mark = &fanotify_mark_types[tc->mark_type];
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
+	ignore_mark_type = ignore_mark->flag & FAN_MARK_TYPES;
 
 	/* Open fd for syncfs before creating groups to avoid the FAN_OPEN event */
 	fd_syncfs = SAFE_OPEN(MOUNT_PATH, O_RDONLY);
@@ -382,7 +387,7 @@ static int create_fanotify_groups(unsigned int n)
 					    FAN_EVENT_ON_CHILD,
 					    AT_FDCWD, tc->mark_path);
 
-			/* Add ignore mark for groups with higher priority */
+			/* Do not add ignore mark for first priority groups */
 			if (p == 0)
 				continue;
 
@@ -411,14 +416,18 @@ add_mark:
 	}
 
 	/*
-	 * drop_caches should evict inode from cache and remove evictable marks
+	 * Verify that first priority groups have no ignore inode marks and that
+	 * drop_caches evicted the evictable ignore marks of other groups.
 	 */
-	if (evictable_ignored) {
+	if (evictable_ignored)
 		drop_caches();
+
+	if (ignore_mark_type == FAN_MARK_INODE) {
 		for (p = 0; p < num_classes; p++) {
 			for (i = 0; i < GROUPS_PER_PRIO; i++) {
 				if (fd_notify[p][i] > 0)
-					show_fanotify_marks(fd_notify[p][i]);
+					show_fanotify_ignore_marks(fd_notify[p][i],
+								   p > 0 && !evictable_ignored);
 			}
 		}
 	}
@@ -464,7 +473,7 @@ static void verify_event(int p, int group, struct fanotify_event_metadata *event
 		tst_res(TFAIL, "group %d (%x) got event: mask %llx pid=%u "
 			"(expected %u) fd=%u", group, fanotify_class[p],
 			(unsigned long long)event->mask, (unsigned int)event->pid,
-			(unsigned int)getpid(), event->fd);
+			(unsigned int)child_pid, event->fd);
 	} else {
 		tst_res(TPASS, "group %d (%x) got event: mask %llx pid=%u fd=%u",
 			group, fanotify_class[p], (unsigned long long)event->mask,
@@ -582,14 +591,18 @@ static void test_fanotify(unsigned int n)
 	for (p = 1; p < num_classes && !tc->expected_mask_with_ignore; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
 			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
-			if (ret == 0) {
+			if (ret >= 0 && ret < (int)FAN_EVENT_METADATA_LEN) {
 				tst_brk(TBROK,
-					"zero length read from fanotify fd");
+					"short read when reading fanotify "
+					"events (%d < %d)", ret,
+					(int)EVENT_BUF_LEN);
 			}
+			event = (struct fanotify_event_metadata *)event_buf;
 			if (ret > 0) {
 				tst_res(TFAIL, "group %d (%x) with %s and "
-					"%s ignore mask got event",
-					i, fanotify_class[p], mark->name, ignore_mark->name);
+					"%s ignore mask got unexpected event (mask %llx)",
+					i, fanotify_class[p], mark->name, ignore_mark->name,
+					event->mask);
 				if (event->fd != FAN_NOFD)
 					SAFE_CLOSE(event->fd);
 			} else if (errno == EAGAIN) {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
