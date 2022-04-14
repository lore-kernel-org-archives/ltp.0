Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1B4C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 14:54:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2D383CA5FB
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 16:54:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA6993CA5E1
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:07 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DC9241A00CB7
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:06 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id bh17so10534586ejb.8
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b2HoLEG6AZP4lUl1eVjobC+IyO6jgmLe6pH5NM2YEAs=;
 b=GPvx8Epnt3syVeqb7S+lbMJMj2KXqLkcwITO+iGEFgs7xh5D/UFjoxvwMmGeh6s4vo
 SHqyFM2QiOJq6wWE86IzKwZWWmVTWeOvXFGXYghG3kCrBr1lhIcC5MU0W/MsOEeMJDFf
 yumRi3wNRMzGtT9g1ZF57TatyLQQZ/ZMMJriRzGIZxVwLkQWGLOqz2xvsTaZvVjeeV7Q
 22YbiXl+tNJc7F+OEYCAdai2pGQvLjOv08a9NM74RSPj/U0JyDN5p/2P+TNjzCVQyzKM
 WCDO+h8D3P/cpAP79lxp1riKUf7AnMqbdzeyffgJx1mX8CC2xBglpOhnX0nxrSWMD0Wl
 +lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b2HoLEG6AZP4lUl1eVjobC+IyO6jgmLe6pH5NM2YEAs=;
 b=W5RSP6j4ysi7RUiWPd2jS/RM+su+bquOHJ6CoElIvvOQJT1M3pmllFWx4eIv7JpZpf
 fA3w52vyQZittg3g6iQTY7pU3/bKvXrNP65QFouxIJabaXyrf/FgS9hqd1ltKGRxl1Co
 Hidxcg8tViVYJMCvqVM7W7Mt+EK4FAXbDGkIftpcsrHFirJFndI4pd4r+th4tjQCNobJ
 EbZSnb+kbTk+QC147HX7L2h6UF4Dw/zhvzZYVo9oWMmBdZvPsMlW1NjgTyBHdmZrfE9E
 7ciV8ubpI+qhTx3ObVSfZkOfQdd/AvNO1oxVXSxCX5wpG5w+Im83WwYZnQOsNwslZ3b/
 /X3A==
X-Gm-Message-State: AOAM5332eZLGnOzhj/MDs9zbGXXjZz9/Q0hhL+zuWek7nCuQBWgCTr+w
 3OM46F/zs28L2VuiytXSFU4=
X-Google-Smtp-Source: ABdhPJyF51hGAKhoyB5llA5Mb9tu8AM1mPCRUMOotdeBvuzHMLhwxo359tqY5ClZ1JNqlEOKk3zsVQ==
X-Received: by 2002:a17:906:af7b:b0:6e8:8123:78ab with SMTP id
 os27-20020a170906af7b00b006e8812378abmr2624403ejb.434.1649948046340; 
 Thu, 14 Apr 2022 07:54:06 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
 by smtp.gmail.com with ESMTPSA id
 kb28-20020a1709070f9c00b006d5d8bf1b72sm695026ejc.78.2022.04.14.07.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 07:54:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Apr 2022 17:53:55 +0300
Message-Id: <20220414145357.3184012-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414145357.3184012-1-amir73il@gmail.com>
References: <20220414145357.3184012-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] syscalls/fanotify16: Add test cases for FAN_RENAME
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

In the special case of FAN_RENAME event, the second record contains the
the new parent + name, which also prevent merge of FAN_RENAME event
with any other event.

TODO: check 2nd name and child fid

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify16.c     | 88 ++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 529d18ee2..b5b53e7d8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -49,6 +49,7 @@ struct event_t {
 	struct fanotify_fid_t *fid;
 	struct fanotify_fid_t *child_fid;
 	char name[BUF_SIZE];
+	char name2[BUF_SIZE];
 };
 
 static char fname1[BUF_SIZE + 11], fname2[BUF_SIZE + 11];
@@ -66,6 +67,7 @@ static char event_buf[EVENT_BUF_LEN];
 #define MOUNT_PATH "fs_mnt"
 
 static int fan_report_target_fid_unsupported;
+static int rename_events_unsupported;
 
 static struct test_case_t {
 	const char *tname;
@@ -170,6 +172,44 @@ static struct test_case_t {
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
 	},
+	{
+		"FAN_REPORT_DFID_NAME_FID monitor filesystem for create/delete/move/rename/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_FID),
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR,
+		/* Mount watch for events possible on children */
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+	},
+	{
+		"FAN_REPORT_DFID_NAME_FID monitor directories for create/delete/move/rename/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_FID),
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_ONDIR,
+		/* Watches for self events on subdir and events on subdir's children */
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
+		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+	},
+	{
+		"FAN_REPORT_DFID_NAME_TARGET monitor filesystem for create/delete/move/rename/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_TARGET),
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR,
+		/* Mount watch for events possible on children */
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+	},
+	{
+		"FAN_REPORT_DFID_NAME_TARGET monitor directories for create/delete/move/rename/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_TARGET),
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_ONDIR,
+		/* Watches for self events on subdir and events on subdir's children */
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_RENAME | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
+		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+	},
 };
 
 static void do_test(unsigned int number)
@@ -183,9 +223,15 @@ static void do_test(unsigned int number)
 	struct fanotify_fid_t *child_fid = NULL, *subdir_fid = NULL;
 	int report_name = (group->flag & FAN_REPORT_NAME);
 	int report_target_fid = (group->flag & FAN_REPORT_TARGET_FID);
+	int report_rename = (tc->mask & FAN_RENAME);
 
 	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
 
+	if (report_rename && rename_events_unsupported) {
+		tst_res(TCONF, "FAN_RENAME not supported in kernel?");
+		return;
+	}
+
 	if (fan_report_target_fid_unsupported && report_target_fid) {
 		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
 					    fan_report_target_fid_unsupported);
@@ -268,6 +314,18 @@ static void do_test(unsigned int number)
 		strcpy(event_set[tst_count].name, FILE_NAME1);
 		tst_count++;
 	}
+	/*
+	 * FAN_RENAME event is independent of MOVED_FROM/MOVED_TO and not merged
+	 * with any other event because it has different info records.
+	 */
+	if (report_rename) {
+		event_set[tst_count].mask = FAN_RENAME;
+		event_set[tst_count].fid = &dir_fid;
+		event_set[tst_count].child_fid = child_fid;
+		strcpy(event_set[tst_count].name, FILE_NAME1);
+		strcpy(event_set[tst_count].name2, FILE_NAME2);
+		tst_count++;
+	}
 
 	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO;
 	/*
@@ -346,6 +404,18 @@ static void do_test(unsigned int number)
 	/* Read more events on dirs */
 	len += SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
 
+	/*
+	 * FAN_RENAME event is independent of MOVED_FROM/MOVED_TO and not merged
+	 * with any other event because it has different info records.
+	 */
+	if (report_rename) {
+		event_set[tst_count].mask = FAN_RENAME | FAN_ONDIR;
+		event_set[tst_count].fid = &root_fid;
+		event_set[tst_count].child_fid = subdir_fid;
+		strcpy(event_set[tst_count].name, DIR_NAME1);
+		strcpy(event_set[tst_count].name2, DIR_NAME2);
+		tst_count++;
+	}
 	event_set[tst_count].mask = FAN_MOVED_FROM | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
 	event_set[tst_count].child_fid = subdir_fid;
@@ -401,7 +471,11 @@ static void do_test(unsigned int number)
 		if (!report_name)
 			expected->name[0] = 0;
 
-		if (expected->name[0]) {
+		if (expected->mask & FAN_RENAME) {
+			info_type = FAN_EVENT_INFO_TYPE_OLD_DFID_NAME;
+			/* The 2nd fid is same as 1st becaue we rename in same parent */
+			expected_child_fid = expected_fid;
+		} else if (expected->name[0]) {
 			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
 		} else if (expected->mask & FAN_ONDIR) {
 			info_type = FAN_EVENT_INFO_TYPE_DFID;
@@ -548,6 +622,16 @@ check_match:
 			expected_fid = expected->child_fid;
 			info_id = 1;
 			info_type = FAN_EVENT_INFO_TYPE_FID;
+			/*
+			 * With FAN_RENAME event, expect a second record of
+			 * type NEW_DFID_NAME, which in our case
+			 * has the same fid as the source dir in 1st record.
+			 * TODO: check the 2nd name and the 3rd child fid record.
+			 */
+			if (event->mask & FAN_RENAME) {
+				info_type = FAN_EVENT_INFO_TYPE_NEW_DFID_NAME;
+				expected_fid = expected->fid;
+			}
 			file_handle = (struct file_handle *)event_fid->handle;
 			fhlen = file_handle->handle_bytes;
 			child_fid = NULL;
@@ -590,6 +674,8 @@ static void setup(void)
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_DIR_FID, MOUNT_PATH);
 	fan_report_target_fid_unsupported =
 		fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME_TARGET, MOUNT_PATH);
+	rename_events_unsupported =
+		fanotify_events_supported_by_kernel(FAN_RENAME, FAN_REPORT_DFID_NAME, 0);
 
 	sprintf(dname1, "%s/%s", MOUNT_PATH, DIR_NAME1);
 	sprintf(dname2, "%s/%s", MOUNT_PATH, DIR_NAME2);
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
