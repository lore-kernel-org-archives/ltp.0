Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0D1C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 13:28:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2853C3C924E
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 15:28:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 501723C927E
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:49 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3F9CB1000373
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:48 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id v14so14698974wra.5
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=38g23xwve3LJp2dx4uaaPIFPIJPvuVpMA5sZtWThGsk=;
 b=XdlCHmChNqJANehXrBAdBcn2h9BqFdCkKSe0nV+R6LMIYtf6bb3ugDPjRtqBp1EZGY
 dWBU9BzQP1QPJWSa/yAfff/Nabt8jJQ28WTbd0fvHfjqouwa4wlGftDwZd5JkxjqLPgg
 EZj5sw36LsOXhjFUf00KvokYOYHymoPZeK2vPY+KZYlTQrZ1rAuX85A+VfmSS7rrUocP
 jNC6hOif2O/Ojm8/tIOi/OIeZW3bTTc2p7rMrZCYJ823vedDcPJQ6gvzqyYeww4JAyfr
 H43f3bLP1msycW3QJjk5Kk375GZq5QDgBILEg3nLrJZqN8Mhdl4VF6IELhP1R7BUVZZg
 OZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=38g23xwve3LJp2dx4uaaPIFPIJPvuVpMA5sZtWThGsk=;
 b=LxXFTRUf3qqxJ/Crmw7vMjIt5hY8XwpLJU2VP4OjLlTE4wNWKFcc8Y0CCxgL1ssmy6
 /PhEmncniSdcVXTmFTZXKCQj3wW5vBxgAuOZbKb89VQVG11fZ8QSt/eokzxCEp1yr8ar
 Ew8FEfMuXBRoGE/J22qPm34y8jlD97DK6gc2kFXKwPqgJEbZn5giW5FcEuVaxDg/sLyJ
 b3cxgIhDXi0K7hjFAHi7Yb1/DMvCUPOmE9uX5GeUL7aXmy7dcRu6hvCdboCPrUrlqXR4
 uxEbtUB46DFZJ9Cl3GHroVDQi4CtWcB6YcM48jHrFvI59djxSO/0qiidATFEV3anYeB1
 LPEg==
X-Gm-Message-State: AJIora+AHBD1HEzfcXvpV4MTxi65oqbBeAXLDzbYConK4af1qRnvOu9b
 3a3Z+mHk+qDx11EkN5TOqWEWAXZCjhpkhg==
X-Google-Smtp-Source: AGRyM1sHGF3k4mNNloR4K+PoDq1dGU2pjJRIldtOMbau0AkZNI2jD0vprbSMnhNRhVJRdZqxEZVAZg==
X-Received: by 2002:a5d:5847:0:b0:218:5319:f4e3 with SMTP id
 i7-20020a5d5847000000b002185319f4e3mr23937844wrf.500.1655731667786; 
 Mon, 20 Jun 2022 06:27:47 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a5d4f85000000b0021b862ad439sm9086556wru.9.2022.06.20.06.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 06:27:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jun 2022 16:27:37 +0300
Message-Id: <20220620132737.2015073-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620132737.2015073-1-amir73il@gmail.com>
References: <20220620132737.2015073-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] syscalls/fanotify09: Add test cases for merge of
 ignore mask
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

1. Verify that an ignore mask that does not survive modify event,
   does survive a modify event on child, if parent is not watching
   events on children.

2. Verify that an ignore mask on parent does not ignore close events
   sent to mount mark, if parent is not watching events on children.

The behavior of these corner cases of ignore mask on parent dir have
always been undefined, so do not run the test for kernel < v5.19.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify09.c     | 72 +++++++++++++++++--
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 070ad9933..0eb83e2f8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -27,6 +27,11 @@
  * Test case #5 is a regression test for commit:
  *
  *      7372e79c9eb9 fanotify: fix logic of reporting name info with watched parent
+ *
+ * Test cases #6-#7 are regression tests for commit:
+ * (from v5.19, unlikely to be backported thus not in .tags):
+ *
+ *      e730558adffb fanotify: consistent behavior for parent not watching children
  */
 
 #define _GNU_SOURCE
@@ -73,6 +78,7 @@ static struct tcase {
 	const char *tname;
 	struct fanotify_mark_type mark;
 	unsigned int ondir;
+	unsigned int ignore;
 	unsigned int report_name;
 	const char *close_nowrite;
 	int nevents;
@@ -83,6 +89,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
 		0,
+		0,
 		DIR_NAME,
 		1, 0,
 	},
@@ -91,6 +98,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_ONDIR,
 		0,
+		0,
 		DIR_NAME,
 		2, 0,
 	},
@@ -99,6 +107,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_ONDIR,
 		0,
+		0,
 		".",
 		2, 0
 	},
@@ -107,6 +116,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_ONDIR,
 		0,
+		0,
 		DIR_NAME,
 		2, 0,
 	},
@@ -115,6 +125,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
 		0,
+		0,
 		FILE2_NAME,
 		2, FAN_CLOSE_NOWRITE,
 	},
@@ -122,10 +133,29 @@ static struct tcase {
 		"Events on non-dir child with both parent and mount marks and filename info",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
+		0,
 		FAN_REPORT_DFID_NAME,
 		FILE2_NAME,
 		2, FAN_CLOSE_NOWRITE,
 	},
+	{
+		"Events on non-dir child with ignore mask on parent",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		0,
+		FAN_MARK_IGNORED_MASK,
+		0,
+		DIR_NAME,
+		1, 0,
+	},
+	{
+		"Events on non-dir children with surviving ignore mask on parent",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		0,
+		FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
+		0,
+		FILE2_NAME,
+		2, FAN_CLOSE_NOWRITE,
+	},
 };
 
 static void create_fanotify_groups(struct tcase *tc)
@@ -140,13 +170,14 @@ static void create_fanotify_groups(struct tcase *tc)
 		 */
 		unsigned int report_name = tc->report_name;
 		unsigned int mask_flags = tc->ondir | FAN_EVENT_ON_CHILD;
-		unsigned int parent_mask;
+		unsigned int parent_mask, ignore = 0;
 
 		/*
 		 * The non-first groups do not request events on children and
-		 * subdirs.
+		 * subdirs and may set an ignore mask on parent dir.
 		 */
 		if (i > 0) {
+			ignore = tc->ignore;
 			report_name = 0;
 			mask_flags = 0;
 		}
@@ -168,10 +199,15 @@ static void create_fanotify_groups(struct tcase *tc)
 		 * but only the first group requests events on child.
 		 * The one mark with FAN_EVENT_ON_CHILD is needed for
 		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry flag.
+		 *
+		 * The inode mark on non-first group is either with FAN_MODIFY
+		 * in mask or FAN_CLOSE_NOWRITE in ignore mask. In either case,
+		 * it is not expected to get the modify event on a child, nor
+		 * the close event on dir.
 		 */
 		parent_mask = FAN_MODIFY | tc->ondir | mask_flags;
-		SAFE_FANOTIFY_MARK(fd_notify[i], FAN_MARK_ADD,
-				    parent_mask,
+		SAFE_FANOTIFY_MARK(fd_notify[i], FAN_MARK_ADD | ignore,
+				    ignore ? FAN_CLOSE_NOWRITE : parent_mask,
 				    AT_FDCWD, ".");
 	}
 }
@@ -186,6 +222,21 @@ static void cleanup_fanotify_groups(void)
 	}
 }
 
+static void check_ignore_mask(int fd)
+{
+	unsigned int ignored_mask, mflags;
+	char procfdinfo[100];
+
+	sprintf(procfdinfo, "/proc/%d/fdinfo/%d", (int)getpid(), fd);
+	if (FILE_LINES_SCANF(procfdinfo, "fanotify ino:%*x sdev:%*x mflags: %x mask:0 ignored_mask:%x",
+				&mflags, &ignored_mask) || !ignored_mask) {
+		tst_res(TFAIL, "The ignore mask did not survive");
+	} else {
+		tst_res(TPASS, "Found mark with ignore mask (ignored_mask=%x, mflags=%x) in %s",
+				ignored_mask, mflags, procfdinfo);
+	}
+}
+
 static void event_res(int ttype, int group,
 		      struct fanotify_event_metadata *event,
 		      const char *filename)
@@ -274,6 +325,12 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
+	if (tc->ignore && tst_kvercmp(5, 19, 0) < 0) {
+		tst_res(TCONF, "ignored mask on parent dir has undefined "
+				"behavior on kernel < 5.19");
+		return;
+	}
+
 	create_fanotify_groups(tc);
 
 	/*
@@ -326,6 +383,13 @@ static void test_fanotify(unsigned int n)
 	 * got the FAN_CLOSE_NOWRITE event only on a non-directory.
 	 */
 	for (i = 1; i < NUM_GROUPS; i++) {
+		/*
+		 * Verify that ignore mask survived the modify event on child,
+		 * which was not supposed to be sent to this group.
+		 */
+		if (tc->ignore)
+			check_ignore_mask(fd_notify[i]);
+
 		ret = read(fd_notify[i], event_buf, EVENT_BUF_LEN);
 		if (ret > 0) {
 			event = (struct fanotify_event_metadata *)event_buf;
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
