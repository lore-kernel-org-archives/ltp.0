Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C7C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 14:55:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC9623C1BD6
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 16:55:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7078D3CA611
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:10 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A20B81400E72
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:09 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id k23so10561301ejd.3
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nj4NkCbtsvWnMxxMv7j0NIqDq1M1rAiqYtiqt3fJ7uU=;
 b=hSivAO2yh32UoVadnGy31wrDrwHi3+J0c83G+oUjHo09GYezQwrJPyNoX+iJP4ACd5
 Vxb0UD3sfwfdn741XSDQAJVFNxutYZC52WhmXk49gGDNR76JDhSPpQBiWs8GvHoicv+D
 w64NcYXG957xcrWwRlY01XTj/DbZgyMW8mAUGsgIAy2my+i36jZFwy5RJBPXZzxe+hXt
 Y3zr0Xndji5lzyMnRsckCt5DBfyBEg37M5N4eBnj5mmdKpfp5c7Sgsf51OA/mqOO6tEn
 MTExFY0+M2IMjjVU5KVJr4KB0Lcc8WBF5hgexN+keUkw0AeliMVcJgk1jP1OAZ5ja/lH
 dOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nj4NkCbtsvWnMxxMv7j0NIqDq1M1rAiqYtiqt3fJ7uU=;
 b=AX/k3o+FH9TqsNrDb3Ox3E7eHtDwIsuDbIWmIA9pMJ79ZEepoHIcv19KpL+wM9aZ/f
 qOQkAqgQxYoj/00WQpkcPLjTENLomSlcyvq1oS+UVrP9DkbbdchzR8CkT2FXiDrMS5Sd
 NgZ7DvzCcXsF6uMhPXbPZrqPcI+t0ZMr8wQU2awUOnAXR2T1Rm6l0LEQ3bLq1g9WmnJA
 UVdXgvlePhw2/yISct8wvYodzEpENvhhWmZYTXMJGdH/n+zkQ1A3JxTw9JEamrpJUp5d
 udz7NFKbCDM00O1l9pq8anOgTdu1Nw1Bq/ItlWg4yvOeyb5MRRs+LOIc5HjmGXbe3N8W
 zE5A==
X-Gm-Message-State: AOAM5313PVREakFkUmyK6tyvwcUHXGNvfoXdTaaM8Mln0AAqMtxU73wy
 FNojK+E4UyxeaHwVLhYbXug=
X-Google-Smtp-Source: ABdhPJwks5gEuui3nE0UMFjugC/PotLVmaqg0Hm1LOC+0ZMK2QesdfGs9vDJ2Mba4FIP/Acr/+FzhA==
X-Received: by 2002:a17:906:2883:b0:6e8:7012:4185 with SMTP id
 o3-20020a170906288300b006e870124185mr2665161ejd.204.1649948049142; 
 Thu, 14 Apr 2022 07:54:09 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
 by smtp.gmail.com with ESMTPSA id
 kb28-20020a1709070f9c00b006d5d8bf1b72sm695026ejc.78.2022.04.14.07.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 07:54:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Apr 2022 17:53:57 +0300
Message-Id: <20220414145357.3184012-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414145357.3184012-1-amir73il@gmail.com>
References: <20220414145357.3184012-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] syscalls/fanotify16: Test FAN_RENAME with ignored
 mask
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

When a file is moved between two directories and only one of them is
watching for FAN_RENAME events, the FAN_RENAME event will include only
the information about the entry in the watched directory.

When one of the directories or filesystem is watching FAN_RENAME, but
the other is ignoring FAN_RENAME events, the FAN_RENAME event will not
be reported at all.

This is not the same behavior as MOVED_FROM/TO events. User cannot
request to ignore MOVED_FROM events according to destination directory
nor MOVED_TO events according to source directory.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify16.c     | 60 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index ee77e2285..d33e945ad 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -79,6 +79,7 @@ static struct test_case_t {
 	unsigned long mask;
 	struct fanotify_mark_type sub_mark;
 	unsigned long sub_mask;
+	unsigned long tmpdir_ignored_mask;
 } test_cases[] = {
 	{
 		"FAN_REPORT_DFID_NAME monitor filesystem for create/delete/move/open/close",
@@ -88,6 +89,7 @@ static struct test_case_t {
 		/* Mount watch for events possible on children */
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME monitor directories for create/delete/move/open/close",
@@ -98,6 +100,7 @@ static struct test_case_t {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+		0,
 	},
 	{
 		"FAN_REPORT_DIR_FID monitor filesystem for create/delete/move/open/close",
@@ -107,6 +110,7 @@ static struct test_case_t {
 		/* Mount watch for events possible on children */
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+		0,
 	},
 	{
 		"FAN_REPORT_DIR_FID monitor directories for create/delete/move/open/close",
@@ -117,6 +121,7 @@ static struct test_case_t {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_FID monitor filesystem for create/delete/move/open/close",
@@ -126,6 +131,7 @@ static struct test_case_t {
 		/* Mount watch for events possible on children */
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_FID monitor directories for create/delete/move/open/close",
@@ -136,6 +142,7 @@ static struct test_case_t {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME_FID monitor filesystem for create/delete/move/open/close",
@@ -145,6 +152,7 @@ static struct test_case_t {
 		/* Mount watch for events possible on children */
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME_FID monitor directories for create/delete/move/open/close",
@@ -155,6 +163,7 @@ static struct test_case_t {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME_TARGET monitor filesystem for create/delete/move/open/close",
@@ -164,6 +173,7 @@ static struct test_case_t {
 		/* Mount watch for events possible on children */
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME_TARGET monitor directories for create/delete/move/open/close",
@@ -174,6 +184,7 @@ static struct test_case_t {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME_FID monitor filesystem for create/delete/move/rename/open/close",
@@ -183,6 +194,7 @@ static struct test_case_t {
 		/* Mount watch for events possible on children */
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME_FID monitor directories for create/delete/move/rename/open/close",
@@ -193,6 +205,7 @@ static struct test_case_t {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME_TARGET monitor filesystem for create/delete/move/rename/open/close",
@@ -202,6 +215,7 @@ static struct test_case_t {
 		/* Mount watch for events possible on children */
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+		0,
 	},
 	{
 		"FAN_REPORT_DFID_NAME_TARGET monitor directories for create/delete/move/rename/open/close",
@@ -212,6 +226,30 @@ static struct test_case_t {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+		0,
+	},
+	{
+		"FAN_REPORT_DFID_NAME_FID monitor directories and ignore FAN_RENAME events to/from temp directory",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_FID),
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_ONDIR,
+		/* Watches for self events on subdir and events on subdir's children */
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
+		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+		/* Ignore FAN_RENAME to/from tmpdir */
+		FAN_MOVE | FAN_RENAME,
+	},
+	{
+		"FAN_REPORT_DFID_NAME_FID monitor filesystem and ignore FAN_RENAME events to/from temp directory",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_FID),
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR,
+		/* Mount watch for events possible on children */
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+		/* Ignore FAN_RENAME to/from tmpdir */
+		FAN_MOVE | FAN_RENAME,
 	},
 };
 
@@ -228,6 +266,7 @@ static void do_test(unsigned int number)
 	int report_target_fid = (group->flag & FAN_REPORT_TARGET_FID);
 	int report_rename = (tc->mask & FAN_RENAME);
 	int fs_mark = (mark->flag == FAN_MARK_FILESYSTEM);
+	int rename_ignored = (tc->tmpdir_ignored_mask & FAN_RENAME);
 
 	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
 
@@ -269,6 +308,17 @@ static void do_test(unsigned int number)
 	if (tc->sub_mask)
 		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | sub_mark->flag,
 				   tc->sub_mask, AT_FDCWD, dname1);
+	/*
+	 * ignore FAN_RENAME to/from tmpdir, so we won't get the FAN_RENAME events
+	 * when subdir is moved via tmpdir.
+	 * FAN_MOVE is also set in ignored mark of tmpdir, but it will have no effect
+	 * and the MOVED_FROM/TO events will still be reported.
+	 */
+	if (tc->tmpdir_ignored_mask)
+		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD |
+				   FAN_MARK_IGNORED_MASK |
+				   FAN_MARK_IGNORED_SURV_MODIFY,
+				   tc->tmpdir_ignored_mask, AT_FDCWD, TEMP_DIR);
 
 	memset(event_set, 0, sizeof(event_set));
 	event_set[tst_count].mask = FAN_CREATE | FAN_ONDIR;
@@ -410,8 +460,11 @@ static void do_test(unsigned int number)
 	 * will observe the same MOVED_FROM/MOVED_TO events as a direct rename,
 	 * but will observe 2 FAN_RENAME events with 1 info dir+name record each
 	 * instead of 1 FAN_RENAME event with 2 dir+name info records.
+	 *
+	 * If tmpdir is ignoring FAN_RENAME, we will get the MOVED_FROM/MOVED_TO
+	 * events and will not get the FAN_RENAME event for rename via tmpdir.
 	 */
-	if (!fs_mark) {
+	if (!fs_mark || rename_ignored) {
 		SAFE_RENAME(dname1, tmpdir);
 		SAFE_RENAME(tmpdir, dname2);
 	} else {
@@ -428,8 +481,9 @@ static void do_test(unsigned int number)
 	 * When renamed via an unwatched tmpdir, the 1st FAN_RENAME event has the
 	 * info record of root_fid+DIR_NAME1 and the 2nd FAN_RENAME event has the
 	 * info record of root_fid+DIR_NAME2.
+	 * If tmpdir is ignoring FAN_RENAME, we get no FAN_RENAME events at all.
 	 */
-	if (report_rename) {
+	if (report_rename && !rename_ignored) {
 		event_set[tst_count].mask = FAN_RENAME | FAN_ONDIR;
 		event_set[tst_count].fid = &root_fid;
 		event_set[tst_count].child_fid = subdir_fid;
@@ -446,7 +500,7 @@ static void do_test(unsigned int number)
 	event_set[tst_count].child_fid = subdir_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME1);
 	tst_count++;
-	if (report_rename && !fs_mark) {
+	if (report_rename && !fs_mark && !rename_ignored) {
 		event_set[tst_count].mask = FAN_RENAME | FAN_ONDIR;
 		event_set[tst_count].fid = &root_fid;
 		event_set[tst_count].child_fid = subdir_fid;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
