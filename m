Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C00ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:44:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0DF43CA98B
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:44:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 420093CA94D
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:43:00 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 618CF1A00A58
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:57 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id n17so11876148wrm.4
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=2YA9pTrIc2G7VK4N3BV/CiLqxpHClrLD8c8b14a7nxc=;
 b=p7WYoJypbHRoGtbTcMW88Qzk6CoNPiNEVINMOZXuUObEsvYJF1cdSMA5Rle9u/LGC+
 FomKrefanCiLSXonL4vsBJZlYZEVwxcmOFC81vcw+PTo4SrIaqlJffdjjjgZHidF6zu5
 2Uo9UqW25+SjqOtNJR3Rm0QgNXLdvNeZ6l2dzb7X64vvuswI44O2kgcammdI8HKTQ+fP
 Zuh8OqsZXt4ZreCbfrNT7/jQo0NONrPca5NWsRns96TCZhAaFRIqKpXFOl7bz+HNaDjU
 YGhFI7OOwEcWSDNmueXJaHOCPX4g7GXUoRXB13asTE7+OIu5X89bAydrY/+lO+HHHrhv
 8rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=2YA9pTrIc2G7VK4N3BV/CiLqxpHClrLD8c8b14a7nxc=;
 b=rBHns+CBcRugcYpyJVsgGWuuG9H40N3WOTru4hVi08ofMO3LAagKNfNH+yDX4cimgV
 fCeeULNydlOPiUeN/CHkuzk1b0q+x7xZTIeWRlF9V11gRs2rdt9+h+l4YhHG6VY2zWaX
 KDTPdiwPs0PZO/gUW4SBaRDtWoaf8arFPOANIB8BIJxJM8etQEsKDQR0pxTOGM6hkN1K
 udBMMsbpGupXS95KFTvWvmPiFQ5WnL+2KordiIuSP+VpF4Fdjk3Xks39d9bsp+Iy2+ZC
 e8QiX5lTFsX269q+xrzNsqCdYD2lYHvFHm6Z2qVMzpON522FA6bXR6XuCAz8JF8tWobR
 2I8w==
X-Gm-Message-State: ACgBeo2lfnzOmI/LYVDHViprElDw6FI/gtDQg4w9ZVhgISxDs8CIAeiC
 Yu/KuulSEFZoQbRxefH5tqo=
X-Google-Smtp-Source: AA6agR4BT4nv3EP7lpsPSMWnZ5utK7XohDVJxybbp8SwgVespePVR1tqJb4RnUfHX4XbcN19sDFO8g==
X-Received: by 2002:a5d:64e1:0:b0:226:db58:868b with SMTP id
 g1-20020a5d64e1000000b00226db58868bmr21920561wri.79.1662392576935; 
 Mon, 05 Sep 2022 08:42:56 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:56 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:39 +0300
Message-Id: <20220905154239.2652169-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 9/9] syscalls/fanotify10: Test FAN_MARK_IGNORE with
 FAN_ONDIR
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

Verify correct behavior with FAN_MARK_IGNORE when the FAN_ONDIR flag
is set in ignore mask and not in mask and when the flag is set in
mask and not in ignore mask.

These test cases are skipped for the FAN_MARK_IGNORED_MASK variant
where ignore mask is always applied to directories regardless of
FAN_ONDIR flag in mask or ignore mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h |  3 +
 .../kernel/syscalls/fanotify/fanotify10.c     | 56 ++++++++++++++++---
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 6fbd96d11..ddd365cff 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -119,6 +119,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #ifndef FAN_MARK_PARENT
 #define FAN_MARK_PARENT		FAN_MARK_ONLYDIR
 #endif
+#ifndef FAN_MARK_SUBDIR
+#define FAN_MARK_SUBDIR		FAN_MARK_ONLYDIR
+#endif
 #ifndef FAN_MARK_TYPES
 #define FAN_MARK_TYPES (FAN_MARK_INODE | FAN_MARK_MOUNT | FAN_MARK_FILESYSTEM)
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 0095bda2a..671fbf8fd 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -80,11 +80,13 @@ static int ignore_mark_unsupported;
 #define DIR_NAME "testdir"
 #define FILE_NAME "testfile"
 #define FILE2_NAME "testfile2"
+#define SUBDIR_NAME "testdir2"
 #define TEST_APP "fanotify_child"
 #define TEST_APP2 "fanotify_child2"
 #define DIR_PATH MOUNT_PATH"/"DIR_NAME
 #define FILE_PATH DIR_PATH"/"FILE_NAME
 #define FILE2_PATH DIR_PATH"/"FILE2_NAME
+#define SUBDIR_PATH DIR_PATH"/"SUBDIR_NAME
 #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
 #define FILE2_EXEC_PATH MOUNT_PATH"/"TEST_APP2
 #define DIR_MNT2 MNT2_PATH"/"DIR_NAME
@@ -104,6 +106,7 @@ static unsigned int num_classes = NUM_CLASSES;
 enum {
 	FANOTIFY_INODE,
 	FANOTIFY_PARENT,
+	FANOTIFY_SUBDIR,
 	FANOTIFY_MOUNT,
 	FANOTIFY_FILESYSTEM,
 	FANOTIFY_EVICTABLE,
@@ -112,6 +115,7 @@ enum {
 static struct fanotify_mark_type fanotify_mark_types[] = {
 	INIT_FANOTIFY_MARK_TYPE(INODE),
 	INIT_FANOTIFY_MARK_TYPE(PARENT),
+	INIT_FANOTIFY_MARK_TYPE(SUBDIR),
 	INIT_FANOTIFY_MARK_TYPE(MOUNT),
 	INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
 	INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
@@ -123,7 +127,7 @@ static struct tcase {
 	int mark_type;
 	const char *ignore_path;
 	int ignore_mark_type;
-	unsigned int ignored_onchild;
+	unsigned int ignored_flags;
 	const char *event_path;
 	unsigned long long expected_mask_with_ignore;
 	unsigned long long expected_mask_without_ignore;
@@ -329,6 +333,28 @@ static struct tcase {
 		FAN_EVENT_ON_CHILD,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
+	/* FAN_MARK_IGNORE specific test cases */
+	{
+		"ignore events on subdir inside a parent watching subdirs",
+		SUBDIR_PATH, FANOTIFY_SUBDIR,
+		DIR_PATH, FANOTIFY_PARENT,
+		FAN_EVENT_ON_CHILD | FAN_ONDIR,
+		SUBDIR_PATH, 0, FAN_OPEN | FAN_ONDIR
+	},
+	{
+		"don't ignore events on subdir inside a parent not watching children",
+		SUBDIR_PATH, FANOTIFY_SUBDIR,
+		DIR_PATH, FANOTIFY_PARENT,
+		FAN_ONDIR,
+		SUBDIR_PATH, FAN_OPEN | FAN_ONDIR, FAN_OPEN | FAN_ONDIR
+	},
+	{
+		"don't ignore events on subdir inside a parent watching non-dir children",
+		SUBDIR_PATH, FANOTIFY_SUBDIR,
+		DIR_PATH, FANOTIFY_PARENT,
+		FAN_EVENT_ON_CHILD,
+		SUBDIR_PATH, FAN_OPEN | FAN_ONDIR, FAN_OPEN | FAN_ONDIR
+	},
 };
 
 static void show_fanotify_ignore_marks(int fd, int expected)
@@ -365,6 +391,7 @@ static int create_fanotify_groups(unsigned int n)
 	unsigned int p, i;
 	int evictable_ignored = (tc->ignore_mark_type == FANOTIFY_EVICTABLE);
 	int ignore_mark_type;
+	int ignored_onchild = tc->ignored_flags & FAN_EVENT_ON_CHILD;
 
 	mark = &fanotify_mark_types[tc->mark_type];
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
@@ -387,7 +414,7 @@ static int create_fanotify_groups(unsigned int n)
 			SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | mark->flag,
 					    tc->expected_mask_without_ignore |
-					    FAN_EVENT_ON_CHILD,
+					    FAN_EVENT_ON_CHILD | FAN_ONDIR,
 					    AT_FDCWD, tc->mark_path);
 
 			/* Do not add ignore mark for first priority groups */
@@ -400,7 +427,7 @@ static int create_fanotify_groups(unsigned int n)
 			 * 2. FAN_MARK_IGNORE
 			 */
 			mark_ignored = tst_variant ? FAN_MARK_IGNORE_SURV : FAN_MARK_IGNORED_SURV;
-			mask = FAN_OPEN | tc->ignored_onchild;
+			mask = FAN_OPEN | tc->ignored_flags;
 add_mark:
 			SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | ignore_mark->flag | mark_ignored,
@@ -414,7 +441,7 @@ add_mark:
 			 * This is needed to indicate that parent ignored mask
 			 * should be applied to events on children.
 			 */
-			if (tc->ignored_onchild && mark_ignored & FAN_MARK_IGNORED_MASK) {
+			if (ignored_onchild && mark_ignored & FAN_MARK_IGNORED_MASK) {
 				mark_ignored = 0;
 				goto add_mark;
 			}
@@ -437,10 +464,12 @@ add_mark:
 			 */
 			if (mark_ignored & FAN_MARK_IGNORE &&
 			    tc->ignore_mark_type == FANOTIFY_PARENT) {
-				if (!tc->ignored_onchild)
-					mask = FAN_CLOSE_WRITE | FAN_EVENT_ON_CHILD;
+				if (!ignored_onchild)
+					mask = FAN_CLOSE_WRITE | FAN_EVENT_ON_CHILD | FAN_ONDIR;
 				else if (tc->mark_type == FANOTIFY_PARENT)
 					continue;
+				else if (tc->ignored_flags & FAN_ONDIR)
+					mask = FAN_CLOSE | ignored_onchild;
 				else
 					mask = FAN_CLOSE | FAN_ONDIR;
 				mark_ignored = 0;
@@ -497,6 +526,10 @@ static void mount_cycle(void)
 static void verify_event(int p, int group, struct fanotify_event_metadata *event,
 			 unsigned long long expected_mask)
 {
+	/* Only FAN_REPORT_FID reports the FAN_ONDIR flag in events on dirs */
+	if (!(fanotify_class[p] & FAN_REPORT_FID))
+		expected_mask &= ~FAN_ONDIR;
+
 	if (event->mask != expected_mask) {
 		tst_res(TFAIL, "group %d (%x) got event: mask %llx (expected %llx) "
 			"pid=%u fd=%u", group, fanotify_class[p],
@@ -572,12 +605,19 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
-	if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
+	if (tc->ignored_flags & FAN_EVENT_ON_CHILD && tst_kvercmp(5, 9, 0) < 0) {
 		tst_res(TCONF, "ignored mask in combination with flag FAN_EVENT_ON_CHILD"
 				" has undefined behavior on kernel < 5.9");
 		return;
 	}
 
+	if (tc->ignored_flags && tc->ignore_mark_type == FANOTIFY_PARENT &&
+			!tst_variant && tc->mark_type == FANOTIFY_SUBDIR) {
+		tst_res(TCONF, "flags FAN_EVENT_ON_CHILD and FAN_ONDIR do not take effect"
+				" with legacy FAN_MARK_IGNORED_MASK");
+		return;
+	}
+
 	if (create_fanotify_groups(n) != 0)
 		goto cleanup;
 
@@ -675,6 +715,7 @@ static void setup(void)
 	}
 
 	SAFE_MKDIR(DIR_PATH, 0755);
+	SAFE_MKDIR(SUBDIR_PATH, 0755);
 	SAFE_FILE_PRINTF(FILE_PATH, "1");
 	SAFE_FILE_PRINTF(FILE2_PATH, "1");
 
@@ -701,6 +742,7 @@ static void cleanup(void)
 
 	SAFE_UNLINK(FILE_PATH);
 	SAFE_UNLINK(FILE2_PATH);
+	SAFE_RMDIR(SUBDIR_PATH);
 	SAFE_RMDIR(DIR_PATH);
 	SAFE_RMDIR(MNT2_PATH);
 }
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
