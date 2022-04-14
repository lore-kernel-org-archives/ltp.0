Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD54C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 14:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 245393CA606
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 16:54:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 523893CA614
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:06 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8EA4A1400F56
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:05 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id c64so6664044edf.11
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nlxl4VK/9+5TLVoSwE9zF4GmkMT59AKrotkFuP1ORHM=;
 b=YUYdj7efJxhAXGv3YXtU69eWdex8j7VAoWqsc+KIJwRP0CPRTWBr49EBVeWNIY2wR/
 guGOBV43wwm0zoR1huHECDj9C6YZsfA1kUMqiGGK5n6vC3KqsOshr5sqaWSv4X7w3Kgr
 6kZfQXOoz11ED8/Eb8yNkgIifdfSjlARtKXJS4UJpS9ynBQit/wmxV/8t84Pmde6Ndqh
 6+DWm8Qs3nVKiQxX0TSuS4JN2YLWrm/z3Epxm9FnQC/lp6SsGu2bEqWx5sSDpNY8R7Jc
 WVodMBNZFFT6UtmQvfrTfncABN+3kZA9PZ5AE9TbAQ5UEb2CPYi9NXljRIsAqcAr66tp
 cWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nlxl4VK/9+5TLVoSwE9zF4GmkMT59AKrotkFuP1ORHM=;
 b=ch8+wtDDOwnx9IF22OxyTa39fFlVdHRc/JHs8wmKqQKc+fgtv//0RFvPof/7m1o8iP
 mbjmkMytvSRJemlil+JlE3crSsohqyE3yexsUXiM0GGVPM6VWByMQANpWTQA1Qyu5mni
 HVbthWbHFFdvPLfFyPGEcGaiGOwSAAXm67y2QJ00EgAELuheff0IZJcDz4CfTftXuNQA
 B5Syf+HzUehJ6Gcv55Y/twMyouMZIchzGwUJK5ErxbEdkxhelKcGx0oO81u1GQSHRkyH
 BxqzGWjkFraTe0sRE3umxY9bxYy8zPKdN9F07hkJEMy9QAGBg2kfktD6rwO2+yRwj8lW
 4EMw==
X-Gm-Message-State: AOAM532kq6DJEijEtI1I7bm6K99Z07k5V4ys09VRes146PbRm7rNhrT8
 cuE/t+DUDjQJ+12+OlDhcHI=
X-Google-Smtp-Source: ABdhPJyQYUASQ5skSOc4LSlO4p3RDLIBN3H0S0rZVhLD9lWLCq6ICr3z1SJiNIkVDpsWTXfhN3fgeA==
X-Received: by 2002:a05:6402:11d2:b0:41d:8443:6849 with SMTP id
 j18-20020a05640211d200b0041d84436849mr3453455edw.311.1649948044991; 
 Thu, 14 Apr 2022 07:54:04 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
 by smtp.gmail.com with ESMTPSA id
 kb28-20020a1709070f9c00b006d5d8bf1b72sm695026ejc.78.2022.04.14.07.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 07:54:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Apr 2022 17:53:54 +0300
Message-Id: <20220414145357.3184012-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414145357.3184012-1-amir73il@gmail.com>
References: <20220414145357.3184012-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] syscalls/fanotify16: Add test cases for
 FAN_REPORT_TARGET_FID
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

Verify both parent and child fids are reported for dirent events
with FAN_REPORT_TARGET_FID.

When child fid is reported for dirent events, they can be merged
with events "on child" (e.g. open/close).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify16.c     | 69 +++++++++++++++----
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 40bcdd581..529d18ee2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -14,6 +14,7 @@
  * - FAN_REPORT_DIR_FID   (dir fid)
  * - FAN_REPORT_DIR_FID | FAN_REPORT_FID   (dir fid + child fid)
  * - FAN_REPORT_DFID_NAME | FAN_REPORT_FID (dir fid + name + child fid)
+ * - FAN_REPORT_DFID_NAME_TARGET (dir fid + name + created/deleted file fid)
  */
 
 #define _GNU_SOURCE
@@ -64,6 +65,8 @@ static char event_buf[EVENT_BUF_LEN];
 #define FILE_NAME2 "test_file2"
 #define MOUNT_PATH "fs_mnt"
 
+static int fan_report_target_fid_unsupported;
+
 static struct test_case_t {
 	const char *tname;
 	struct fanotify_group_type group;
@@ -148,6 +151,25 @@ static struct test_case_t {
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
 	},
+	{
+		"FAN_REPORT_DFID_NAME_TARGET monitor filesystem for create/delete/move/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_TARGET),
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR,
+		/* Mount watch for events possible on children */
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+	},
+	{
+		"FAN_REPORT_DFID_NAME_TARGET monitor directories for create/delete/move/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_TARGET),
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_ONDIR,
+		/* Watches for self events on subdir and events on subdir's children */
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
+		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+	},
 };
 
 static void do_test(unsigned int number)
@@ -158,9 +180,18 @@ static void do_test(unsigned int number)
 	struct fanotify_mark_type *mark = &tc->mark;
 	struct fanotify_mark_type *sub_mark = &tc->sub_mark;
 	struct fanotify_fid_t root_fid, dir_fid, file_fid;
+	struct fanotify_fid_t *child_fid = NULL, *subdir_fid = NULL;
+	int report_name = (group->flag & FAN_REPORT_NAME);
+	int report_target_fid = (group->flag & FAN_REPORT_TARGET_FID);
 
 	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
 
+	if (fan_report_target_fid_unsupported && report_target_fid) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
+					    fan_report_target_fid_unsupported);
+		return;
+	}
+
 	fd_notify = SAFE_FANOTIFY_INIT(group->flag, 0);
 
 	/*
@@ -181,6 +212,9 @@ static void do_test(unsigned int number)
 
 	/* Save the subdir fid */
 	fanotify_save_fid(dname1, &dir_fid);
+	/* With FAN_REPORT_TARGET_FID, report subdir fid also for dirent events */
+	if (report_target_fid)
+		subdir_fid = &dir_fid;
 
 	if (tc->sub_mask)
 		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | sub_mark->flag,
@@ -188,7 +222,7 @@ static void do_test(unsigned int number)
 
 	event_set[tst_count].mask = FAN_CREATE | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
-	event_set[tst_count].child_fid = NULL;
+	event_set[tst_count].child_fid = subdir_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME1);
 	tst_count++;
 
@@ -197,6 +231,9 @@ static void do_test(unsigned int number)
 
 	/* Save the file fid */
 	fanotify_save_fid(fname1, &file_fid);
+	/* With FAN_REPORT_TARGET_FID, report child fid also for dirent events */
+	if (report_target_fid)
+		child_fid = &file_fid;
 
 	SAFE_WRITE(1, fd, "1", 1);
 	SAFE_RENAME(fname1, fname2);
@@ -214,7 +251,7 @@ static void do_test(unsigned int number)
 	 */
 	event_set[tst_count].mask = FAN_CREATE | FAN_MOVED_FROM;
 	event_set[tst_count].fid = &dir_fid;
-	event_set[tst_count].child_fid = NULL;
+	event_set[tst_count].child_fid = child_fid;
 	strcpy(event_set[tst_count].name, FILE_NAME1);
 	tst_count++;
 	/*
@@ -224,7 +261,7 @@ static void do_test(unsigned int number)
 	 * FAN_REPORT_NAME is not set, then FAN_CREATE above is merged with
 	 * FAN_DELETE below and FAN_OPEN will be merged with FAN_CLOSE.
 	 */
-	if (group->flag & FAN_REPORT_NAME) {
+	if (report_name) {
 		event_set[tst_count].mask = FAN_OPEN;
 		event_set[tst_count].fid = &dir_fid;
 		event_set[tst_count].child_fid = &file_fid;
@@ -233,15 +270,22 @@ static void do_test(unsigned int number)
 	}
 
 	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO;
+	/*
+	 * With FAN_REPORT_TARGET_FID, close of FILE_NAME2 is merged with
+	 * moved_to and delete events, because they all have parent and
+	 * child fid records.
+	 */
+	if (report_target_fid)
+		event_set[tst_count].mask |= FAN_CLOSE_WRITE;
 	event_set[tst_count].fid = &dir_fid;
-	event_set[tst_count].child_fid = NULL;
+	event_set[tst_count].child_fid = child_fid;
 	strcpy(event_set[tst_count].name, FILE_NAME2);
 	tst_count++;
 	/*
 	 * When not reporting name, open of FILE_NAME1 is merged
 	 * with close of FILE_NAME2.
 	 */
-	if (!(group->flag & FAN_REPORT_NAME)) {
+	if (!report_name) {
 		event_set[tst_count].mask = FAN_OPEN | FAN_CLOSE_WRITE;
 		event_set[tst_count].fid = &dir_fid;
 		event_set[tst_count].child_fid = &file_fid;
@@ -261,11 +305,10 @@ static void do_test(unsigned int number)
 		tst_count++;
 	}
 	/*
-	 * When reporting name, close of FILE_NAME2 is not merged with
-	 * open of FILE_NAME1 and it is received after the merged self
-	 * events.
+	 * Without FAN_REPORT_TARGET_FID, close of FILE_NAME2 is not merged with
+	 * open of FILE_NAME1 and it is received after the merged self events.
 	 */
-	if (group->flag & FAN_REPORT_NAME) {
+	if (report_name && !report_target_fid) {
 		event_set[tst_count].mask = FAN_CLOSE_WRITE;
 		event_set[tst_count].fid = &dir_fid;
 		event_set[tst_count].child_fid = &file_fid;
@@ -305,12 +348,12 @@ static void do_test(unsigned int number)
 
 	event_set[tst_count].mask = FAN_MOVED_FROM | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
-	event_set[tst_count].child_fid = NULL;
+	event_set[tst_count].child_fid = subdir_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME1);
 	tst_count++;
 	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
-	event_set[tst_count].child_fid = NULL;
+	event_set[tst_count].child_fid = subdir_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME2);
 	tst_count++;
 	/* Expect no more events */
@@ -355,7 +398,7 @@ static void do_test(unsigned int number)
 		if (!(group->flag & FAN_REPORT_FID))
 			expected_child_fid = NULL;
 
-		if (!(group->flag & FAN_REPORT_NAME))
+		if (!report_name)
 			expected->name[0] = 0;
 
 		if (expected->name[0]) {
@@ -545,6 +588,8 @@ check_match:
 static void setup(void)
 {
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_DIR_FID, MOUNT_PATH);
+	fan_report_target_fid_unsupported =
+		fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME_TARGET, MOUNT_PATH);
 
 	sprintf(dname1, "%s/%s", MOUNT_PATH, DIR_NAME1);
 	sprintf(dname2, "%s/%s", MOUNT_PATH, DIR_NAME2);
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
