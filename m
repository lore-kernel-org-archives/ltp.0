Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9647C433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 14:55:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2833D3CA5FE
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 16:55:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B06B3CA60A
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:09 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3CA4E1400E72
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:08 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id b24so6657095edu.10
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BDB5xuc41BAs0PvHuIfDdBn8of2zIkb5SJlrIvZxWH8=;
 b=q5SCB1m5tSq6ctGIEDLvXQfrpuAd3Gg/ADqakKDJyvdUohOXMEs8GYxZXw5Plnjemt
 BfH9BuskcpeCQZ5ZgEkuXGQrR7DBmcgZyBbMN+vwp71XOH/D2CiHk7bmJ8qkYRNmMio9
 yqUaFzxG/9R0sPv5tFQd0ZjYu3uwC+BNy5GDlmNO/OXQvMh7xYLcurm0e4SdhCKnaRmQ
 +X0SzVV6S1gtok2oNCsDDoHHgmJVcqGdYguVoESxKTTG/hCzmPFtSkWer2IaRIR6mIqJ
 coD1Z6+cpMX0LWsLzWw43feO8RgBmKB7o8sF0CYQAzoNbhdhx8FeluWg+qL92UgSfcxo
 CMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BDB5xuc41BAs0PvHuIfDdBn8of2zIkb5SJlrIvZxWH8=;
 b=8AJh69EiIT7TCH5bUows8zOO+XU2Co8z7bLEEQRpq34Tmm/nriDqBbWfrsyyVnvJAt
 yddSCzvPFzB09q8DLNe5FYTNjam9Q1rmIWrLOBFGoPricA1WZlyCNUPKFIL+k77TW1RD
 w+Z0NwYCS1jAox//2WUMIHXHNGUBrqfu4fqDA5TMYbJPQkFhcjLbL+fh0w6PSFLKuEOL
 61y/2JCpKBtMylCww76G+fBiwuplMhtp1+Ihg76ce4JBGPFSTH2qe8tjzIqVYKZVbV3n
 qZyGLoVA6WZcuwitBt7OC2+eEP72nL07KjOoQNRI6LrCN5XEs/9nIXjkU66LRNlhMQiN
 OPgg==
X-Gm-Message-State: AOAM531G9fKook0xq7pJ8W3jpFqdB8Bjd9DjOdFzJFPWiV5NFhUaXgcB
 9tIlOdlYyFVaIkl2pJduJZIZavZgLEs=
X-Google-Smtp-Source: ABdhPJzV4r+djaRzTSmL3mrFz+qBNap3FsJy0Bl+zTfiPPhsufXE2XnSi/q1V1lezwAtsxHI0FtyDQ==
X-Received: by 2002:a05:6402:4493:b0:41d:83ca:35d6 with SMTP id
 er19-20020a056402449300b0041d83ca35d6mr3427309edb.89.1649948047809; 
 Thu, 14 Apr 2022 07:54:07 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
 by smtp.gmail.com with ESMTPSA id
 kb28-20020a1709070f9c00b006d5d8bf1b72sm695026ejc.78.2022.04.14.07.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 07:54:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Apr 2022 17:53:56 +0300
Message-Id: <20220414145357.3184012-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414145357.3184012-1-amir73il@gmail.com>
References: <20220414145357.3184012-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] syscalls/fanotify16: Test FAN_RENAME with one
 watching directory
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

When root/dir1 is renamed to root/dir2 via an intermediate unwatched
tmpdir, two FAN_RENAME events are reported:
The 1st FAN_RENAME event has the info record of root_fid+dir1 and
the 2nd FAN_RENAME event has the info record of root_fid+dir2.

MOVED_FROM/MOVED_TO events in this scenario look the same as a direct
rename from root/dir1 to root/dir2.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify16.c     | 53 ++++++++++++++++---
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index b5b53e7d8..ee77e2285 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -50,10 +50,12 @@ struct event_t {
 	struct fanotify_fid_t *child_fid;
 	char name[BUF_SIZE];
 	char name2[BUF_SIZE];
+	char *old_name;
+	char *new_name;
 };
 
 static char fname1[BUF_SIZE + 11], fname2[BUF_SIZE + 11];
-static char dname1[BUF_SIZE], dname2[BUF_SIZE];
+static char dname1[BUF_SIZE], dname2[BUF_SIZE], tmpdir[BUF_SIZE];
 static int fd_notify;
 
 static struct event_t event_set[EVENT_MAX];
@@ -65,6 +67,7 @@ static char event_buf[EVENT_BUF_LEN];
 #define FILE_NAME1 "test_file1"
 #define FILE_NAME2 "test_file2"
 #define MOUNT_PATH "fs_mnt"
+#define TEMP_DIR MOUNT_PATH "/temp_dir"
 
 static int fan_report_target_fid_unsupported;
 static int rename_events_unsupported;
@@ -224,6 +227,7 @@ static void do_test(unsigned int number)
 	int report_name = (group->flag & FAN_REPORT_NAME);
 	int report_target_fid = (group->flag & FAN_REPORT_TARGET_FID);
 	int report_rename = (tc->mask & FAN_RENAME);
+	int fs_mark = (mark->flag == FAN_MARK_FILESYSTEM);
 
 	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
 
@@ -266,6 +270,7 @@ static void do_test(unsigned int number)
 		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | sub_mark->flag,
 				   tc->sub_mask, AT_FDCWD, dname1);
 
+	memset(event_set, 0, sizeof(event_set));
 	event_set[tst_count].mask = FAN_CREATE | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
 	event_set[tst_count].child_fid = subdir_fid;
@@ -324,6 +329,8 @@ static void do_test(unsigned int number)
 		event_set[tst_count].child_fid = child_fid;
 		strcpy(event_set[tst_count].name, FILE_NAME1);
 		strcpy(event_set[tst_count].name2, FILE_NAME2);
+		event_set[tst_count].old_name = event_set[tst_count].name;
+		event_set[tst_count].new_name = event_set[tst_count].name2;
 		tst_count++;
 	}
 
@@ -355,7 +362,7 @@ static void do_test(unsigned int number)
 	 * Filesystem watch gets self event w/o name info if FAN_REPORT_FID
 	 * is set.
 	 */
-	if (mark->flag == FAN_MARK_FILESYSTEM && (group->flag & FAN_REPORT_FID)) {
+	if (fs_mark && (group->flag & FAN_REPORT_FID)) {
 		event_set[tst_count].mask = FAN_DELETE_SELF | FAN_MOVE_SELF;
 		event_set[tst_count].fid = &file_fid;
 		event_set[tst_count].child_fid = NULL;
@@ -398,7 +405,18 @@ static void do_test(unsigned int number)
 	strcpy(event_set[tst_count].name, ".");
 	tst_count++;
 
-	SAFE_RENAME(dname1, dname2);
+	/*
+	 * If only root dir and subdir are watched, a rename via an unwatched tmpdir
+	 * will observe the same MOVED_FROM/MOVED_TO events as a direct rename,
+	 * but will observe 2 FAN_RENAME events with 1 info dir+name record each
+	 * instead of 1 FAN_RENAME event with 2 dir+name info records.
+	 */
+	if (!fs_mark) {
+		SAFE_RENAME(dname1, tmpdir);
+		SAFE_RENAME(tmpdir, dname2);
+	} else {
+		SAFE_RENAME(dname1, dname2);
+	}
 	SAFE_RMDIR(dname2);
 
 	/* Read more events on dirs */
@@ -407,13 +425,20 @@ static void do_test(unsigned int number)
 	/*
 	 * FAN_RENAME event is independent of MOVED_FROM/MOVED_TO and not merged
 	 * with any other event because it has different info records.
+	 * When renamed via an unwatched tmpdir, the 1st FAN_RENAME event has the
+	 * info record of root_fid+DIR_NAME1 and the 2nd FAN_RENAME event has the
+	 * info record of root_fid+DIR_NAME2.
 	 */
 	if (report_rename) {
 		event_set[tst_count].mask = FAN_RENAME | FAN_ONDIR;
 		event_set[tst_count].fid = &root_fid;
 		event_set[tst_count].child_fid = subdir_fid;
 		strcpy(event_set[tst_count].name, DIR_NAME1);
-		strcpy(event_set[tst_count].name2, DIR_NAME2);
+		event_set[tst_count].old_name = event_set[tst_count].name;
+		if (fs_mark) {
+			strcpy(event_set[tst_count].name2, DIR_NAME2);
+			event_set[tst_count].new_name = event_set[tst_count].name2;
+		}
 		tst_count++;
 	}
 	event_set[tst_count].mask = FAN_MOVED_FROM | FAN_ONDIR;
@@ -421,6 +446,14 @@ static void do_test(unsigned int number)
 	event_set[tst_count].child_fid = subdir_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME1);
 	tst_count++;
+	if (report_rename && !fs_mark) {
+		event_set[tst_count].mask = FAN_RENAME | FAN_ONDIR;
+		event_set[tst_count].fid = &root_fid;
+		event_set[tst_count].child_fid = subdir_fid;
+		strcpy(event_set[tst_count].name, DIR_NAME2);
+		event_set[tst_count].new_name = event_set[tst_count].name;
+		tst_count++;
+	}
 	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
 	event_set[tst_count].child_fid = subdir_fid;
@@ -472,9 +505,13 @@ static void do_test(unsigned int number)
 			expected->name[0] = 0;
 
 		if (expected->mask & FAN_RENAME) {
-			info_type = FAN_EVENT_INFO_TYPE_OLD_DFID_NAME;
+			/* If old name is not reported, first record is new name */
+			info_type = expected->old_name ?
+				FAN_EVENT_INFO_TYPE_OLD_DFID_NAME :
+				FAN_EVENT_INFO_TYPE_NEW_DFID_NAME;
 			/* The 2nd fid is same as 1st becaue we rename in same parent */
-			expected_child_fid = expected_fid;
+			if (expected->name2[0])
+				expected_child_fid = expected_fid;
 		} else if (expected->name[0]) {
 			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
 		} else if (expected->mask & FAN_ONDIR) {
@@ -628,7 +665,7 @@ check_match:
 			 * has the same fid as the source dir in 1st record.
 			 * TODO: check the 2nd name and the 3rd child fid record.
 			 */
-			if (event->mask & FAN_RENAME) {
+			if (event->mask & FAN_RENAME && expected->name2[0]) {
 				info_type = FAN_EVENT_INFO_TYPE_NEW_DFID_NAME;
 				expected_fid = expected->fid;
 			}
@@ -677,8 +714,10 @@ static void setup(void)
 	rename_events_unsupported =
 		fanotify_events_supported_by_kernel(FAN_RENAME, FAN_REPORT_DFID_NAME, 0);
 
+	SAFE_MKDIR(TEMP_DIR, 0755);
 	sprintf(dname1, "%s/%s", MOUNT_PATH, DIR_NAME1);
 	sprintf(dname2, "%s/%s", MOUNT_PATH, DIR_NAME2);
+	sprintf(tmpdir, "%s/%s", TEMP_DIR, DIR_NAME2);
 	sprintf(fname1, "%s/%s", dname1, FILE_NAME1);
 	sprintf(fname2, "%s/%s", dname1, FILE_NAME2);
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
