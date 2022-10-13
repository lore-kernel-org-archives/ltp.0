Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09096C4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 15:50:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30F623CAEE1
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 17:50:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C99CF3CAECD
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 17:49:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C976601BC5
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 17:49:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4745E20876;
 Thu, 13 Oct 2022 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665676176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VA6UCuWs1GIa2xJZ7hUFhQjME+fQ6ujmPE5qUP91jdE=;
 b=QlsBD4hg6UDyrQgI6cFyy11A/+KmDmVKtYzViY/E9rwrjfVzPt8yP7JX0JYkf+UjHiuqDw
 HbgYsn4aCqV+DBwQgHgqYc4lLUX/fhpknqRD541fQICxnUDsJhMXsLHlZKISwN26dzCvv7
 qj9Y7pkuC1I580vP556uZLdzwKnbbaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665676176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VA6UCuWs1GIa2xJZ7hUFhQjME+fQ6ujmPE5qUP91jdE=;
 b=c6CXr+xil73f2beDqiPouc+KwdZTb5yz9RP/DeCqjqxAyLcF2Xt9bWlAkuZQsuRtrWIBB4
 cUJ68IIqgu6z1ABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EB3F13B85;
 Thu, 13 Oct 2022 15:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SFP5AZAzSGMnDQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 13 Oct 2022 15:49:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: amir73il@gmail.com,
	ltp@lists.linux.it
Date: Thu, 13 Oct 2022 17:49:32 +0200
Message-Id: <20221013154935.20461-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221013154935.20461-1-mdoucha@suse.cz>
References: <20221013154935.20461-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] fanotify14: Print human-readable test case flags
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It's hard to tell which test case is failing from the current fanotify14
output. Print test case flags to make failure analysis easier.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 194 ++++++++++--------
 1 file changed, 108 insertions(+), 86 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 594259ccf..ee42aaf68 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -38,6 +38,8 @@
 #define INODE_EVENTS (FAN_ATTRIB | FAN_CREATE | FAN_DELETE | FAN_MOVE | \
 		      FAN_DELETE_SELF | FAN_MOVE_SELF)
 
+#define FLAGS_DESC(flags) (flags), (#flags)
+
 static int fanotify_fd;
 static int fan_report_target_fid_unsupported;
 static int ignore_mark_unsupported;
@@ -49,101 +51,113 @@ static int ignore_mark_unsupported;
  */
 static struct test_case_t {
 	unsigned int init_flags;
+	const char *init_desc;
 	unsigned int mark_flags;
+	const char *mark_desc;
 	/* zero mask expects to fail on fanotify_init() */
 	unsigned long long mask;
+	const char *mask_desc;
 	int expected_errno;
 } test_cases[] = {
-	{
-		/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
-		FAN_CLASS_CONTENT | FAN_REPORT_FID, 0, 0, EINVAL
-	},
-	{
-		/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
-		FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, 0, 0, EINVAL
-	},
-	{
-		/* INODE_EVENTS in mask without class FAN_REPORT_FID are not valid */
-		FAN_CLASS_NOTIF, 0, INODE_EVENTS, EINVAL
-	},
-	{
-		/* INODE_EVENTS in mask with FAN_MARK_MOUNT are not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_FID, FAN_MARK_MOUNT, INODE_EVENTS, EINVAL
-	},
-	{
-		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_NAME, 0, 0, EINVAL
-	},
-	{
-		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, 0, 0, EINVAL
-	},
-	{
-		/* FAN_REPORT_TARGET_FID without FAN_REPORT_FID is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME, 0, 0, EINVAL
-	},
-	{
-		/* FAN_REPORT_TARGET_FID without FAN_REPORT_NAME is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, 0, 0, EINVAL
-	},
-	{
-		/* FAN_RENAME without FAN_REPORT_NAME is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, 0, FAN_RENAME, EINVAL
-	},
-	{
-		/* With FAN_MARK_ONLYDIR on non-dir is not valid */
-		FAN_CLASS_NOTIF, FAN_MARK_ONLYDIR, FAN_OPEN, ENOTDIR
-	},
-	{
-		/* With FAN_REPORT_TARGET_FID, FAN_DELETE on non-dir is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_DELETE, ENOTDIR
-	},
-	{
-		/* With FAN_REPORT_TARGET_FID, FAN_RENAME on non-dir is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_RENAME, ENOTDIR
-	},
-	{
-		/* With FAN_REPORT_TARGET_FID, FAN_ONDIR on non-dir is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_OPEN | FAN_ONDIR, ENOTDIR
-	},
-	{
-		/* With FAN_REPORT_TARGET_FID, FAN_EVENT_ON_CHILD on non-dir is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, 0, FAN_OPEN | FAN_EVENT_ON_CHILD, ENOTDIR
-	},
-	{
-		/* FAN_MARK_IGNORE_SURV with FAN_DELETE on non-dir is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, FAN_MARK_IGNORE_SURV, FAN_DELETE, ENOTDIR
-	},
-	{
-		/* FAN_MARK_IGNORE_SURV with FAN_RENAME on non-dir is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, FAN_MARK_IGNORE_SURV, FAN_RENAME, ENOTDIR
-	},
-	{
-		/* FAN_MARK_IGNORE_SURV with FAN_ONDIR on non-dir is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, FAN_MARK_IGNORE_SURV, FAN_OPEN | FAN_ONDIR, ENOTDIR
-	},
-	{
-		/* FAN_MARK_IGNORE_SURV with FAN_EVENT_ON_CHILD on non-dir is not valid */
-		FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME, FAN_MARK_IGNORE_SURV, FAN_OPEN | FAN_EVENT_ON_CHILD, ENOTDIR
-	},
-	{
-		/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on directory is not valid */
-		FAN_CLASS_NOTIF, FAN_MARK_IGNORE, FAN_OPEN, EISDIR
-	},
-	{
-		/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on mount mark is not valid */
-		FAN_CLASS_NOTIF, FAN_MARK_MOUNT | FAN_MARK_IGNORE, FAN_OPEN, EINVAL
-	},
-	{
-		/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on filesystem mark is not valid */
-		FAN_CLASS_NOTIF, FAN_MARK_FILESYSTEM | FAN_MARK_IGNORE, FAN_OPEN, EINVAL
-	},
+	/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
+	{FLAGS_DESC(FAN_CLASS_CONTENT | FAN_REPORT_FID), 0, NULL, 0, NULL,
+		EINVAL},
+
+	/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
+	{FLAGS_DESC(FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID), 0, NULL, 0, NULL,
+		EINVAL},
+
+	/* INODE_EVENTS in mask without class FAN_REPORT_FID are not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF), FLAGS_DESC(0), FLAGS_DESC(INODE_EVENTS),
+		EINVAL},
+
+	/* INODE_EVENTS in mask with FAN_MARK_MOUNT are not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_FID),
+		FLAGS_DESC(FAN_MARK_MOUNT), FLAGS_DESC(INODE_EVENTS), EINVAL},
+
+	/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_NAME), 0, NULL, 0, NULL,
+		EINVAL},
+
+	/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME), 0,
+		NULL, 0, NULL, EINVAL},
+
+	/* FAN_REPORT_TARGET_FID without FAN_REPORT_FID is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME),
+		0, NULL, 0, NULL, EINVAL},
+
+	/* FAN_REPORT_TARGET_FID without FAN_REPORT_NAME is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID),
+		0, NULL, 0, NULL, EINVAL},
+
+	/* FAN_RENAME without FAN_REPORT_NAME is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID), FLAGS_DESC(0),
+		FLAGS_DESC(FAN_RENAME), EINVAL},
+
+	/* With FAN_MARK_ONLYDIR on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF), FLAGS_DESC(FAN_MARK_ONLYDIR),
+		FLAGS_DESC(FAN_OPEN), ENOTDIR},
+
+	/* With FAN_REPORT_TARGET_FID, FAN_DELETE on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
+		FLAGS_DESC(0), FLAGS_DESC(FAN_DELETE), ENOTDIR},
+
+	/* With FAN_REPORT_TARGET_FID, FAN_RENAME on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
+		FLAGS_DESC(0), FLAGS_DESC(FAN_RENAME), ENOTDIR},
+
+	/* With FAN_REPORT_TARGET_FID, FAN_ONDIR on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
+		FLAGS_DESC(0), FLAGS_DESC(FAN_OPEN | FAN_ONDIR), ENOTDIR},
+
+	/* With FAN_REPORT_TARGET_FID, FAN_EVENT_ON_CHILD on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET),
+		FLAGS_DESC(0), FLAGS_DESC(FAN_OPEN | FAN_EVENT_ON_CHILD),
+		ENOTDIR},
+
+	/* FAN_MARK_IGNORE_SURV with FAN_DELETE on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
+		FLAGS_DESC(FAN_MARK_IGNORE_SURV), FLAGS_DESC(FAN_DELETE),
+		ENOTDIR},
+
+	/* FAN_MARK_IGNORE_SURV with FAN_RENAME on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
+		FLAGS_DESC(FAN_MARK_IGNORE_SURV), FLAGS_DESC(FAN_RENAME),
+		ENOTDIR},
+
+	/* FAN_MARK_IGNORE_SURV with FAN_ONDIR on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
+		FLAGS_DESC(FAN_MARK_IGNORE_SURV),
+		FLAGS_DESC(FAN_OPEN | FAN_ONDIR), ENOTDIR},
+
+	/* FAN_MARK_IGNORE_SURV with FAN_EVENT_ON_CHILD on non-dir is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME),
+		FLAGS_DESC(FAN_MARK_IGNORE_SURV),
+		FLAGS_DESC(FAN_OPEN | FAN_EVENT_ON_CHILD), ENOTDIR},
+
+	/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on directory is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF), FLAGS_DESC(FAN_MARK_IGNORE),
+		FLAGS_DESC(FAN_OPEN), EISDIR},
+
+	/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on mount mark is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF),
+		FLAGS_DESC(FAN_MARK_MOUNT | FAN_MARK_IGNORE),
+		FLAGS_DESC(FAN_OPEN), EINVAL},
+
+	/* FAN_MARK_IGNORE without FAN_MARK_IGNORED_SURV_MODIFY on filesystem mark is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF),
+		FLAGS_DESC(FAN_MARK_FILESYSTEM | FAN_MARK_IGNORE),
+		FLAGS_DESC(FAN_OPEN), EINVAL},
 };
 
 static void do_test(unsigned int number)
 {
 	struct test_case_t *tc = &test_cases[number];
 
+	tst_res(TINFO, "Test case %d: fanotify_init(%s, O_RDONLY)", number,
+		tc->init_desc);
+
 	if (fan_report_target_fid_unsupported && tc->init_flags & FAN_REPORT_TARGET_FID) {
 		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
 					    fan_report_target_fid_unsupported);
@@ -155,8 +169,14 @@ static void do_test(unsigned int number)
 		return;
 	}
 
-	TST_EXP_FD_OR_FAIL(fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY),
-			   !tc->mask && tc->expected_errno ? tc->expected_errno : 0);
+	if (!tc->mask && tc->expected_errno) {
+		TST_EXP_FAIL(fanotify_init(tc->init_flags, O_RDONLY),
+			tc->expected_errno);
+	} else {
+		TST_EXP_FD(fanotify_init(tc->init_flags, O_RDONLY));
+	}
+
+	fanotify_fd = TST_RET;
 
 	if (fanotify_fd < 0)
 		return;
@@ -167,6 +187,8 @@ static void do_test(unsigned int number)
 	/* Set mark on non-dir only when expecting error ENOTDIR */
 	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
 
+	tst_res(TINFO, "Testing fanotify_mark(FAN_MARK_ADD | %s, %s)",
+		tc->mark_desc, tc->mask_desc);
 	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
 					 tc->mask, AT_FDCWD, path),
 					 tc->expected_errno);
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
