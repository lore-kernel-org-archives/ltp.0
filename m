Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B409C433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 192483CB1CA
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 15:09:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 301C03CAFB4
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:08:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5247A200C87
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:08:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7865B223C0;
 Thu, 20 Oct 2022 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666271324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vf8G7QwBM6hHTddmC/NRADtTNMNJwL8tgmhfhO2kAto=;
 b=c6mPjUX2OWfJ5YyCICj21cZPDDqEmKoO+WJBbQqSihLmXWEA1OHhni6hJJ5ysuyg+Is2Ue
 PwfEMp9S3ILB54BcFnMmyP3+2lsIQDoXf6xl6ehRc5/AOxjnPjgpBmGi4pD/MCdRicwNmf
 9LbOiFXLmLJitsHwhIaYSFIiOOPsYZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666271324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vf8G7QwBM6hHTddmC/NRADtTNMNJwL8tgmhfhO2kAto=;
 b=nOlwmji0ypGRNNG8IdGNT15QCUBf/+oTwRaDbtremYGuptaeb/Tn4UDhD6AD5QHDW7ygJI
 kG+/3OUQwHahVODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62E8013B72;
 Thu, 20 Oct 2022 13:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cHZ1F1xIUWNLOgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Oct 2022 13:08:44 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: amir73il@gmail.com,
	ltp@lists.linux.it
Date: Thu, 20 Oct 2022 15:08:41 +0200
Message-Id: <20221020130843.15147-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020130843.15147-1-mdoucha@suse.cz>
References: <20221020130843.15147-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] fanotify14: Print human-readable test case
 flags
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

Changes since v1:
- Fixed checkpatch.pl complaints about FLAGS_DESC() macro by adding
  a helper struct into testcases

 .../kernel/syscalls/fanotify/fanotify14.c     | 221 ++++++++++--------
 1 file changed, 121 insertions(+), 100 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 594259ccf..bfa0349fe 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -38,137 +38,158 @@
 #define INODE_EVENTS (FAN_ATTRIB | FAN_CREATE | FAN_DELETE | FAN_MOVE | \
 		      FAN_DELETE_SELF | FAN_MOVE_SELF)
 
+#define FLAGS_DESC(flags) {(flags), (#flags)}
+
 static int fanotify_fd;
 static int fan_report_target_fid_unsupported;
 static int ignore_mark_unsupported;
 
+struct test_case_flags_t {
+	unsigned long long flags;
+	const char *desc;
+};
+
 /*
  * Each test case has been designed in a manner whereby the values defined
  * within should result in the interface to return an error to the calling
  * process.
  */
 static struct test_case_t {
-	unsigned int init_flags;
-	unsigned int mark_flags;
-	/* zero mask expects to fail on fanotify_init() */
-	unsigned long long mask;
+	struct test_case_flags_t init;
+	struct test_case_flags_t mark;
+	/* when mask.flags == 0, fanotify_init() is expected to fail */
+	struct test_case_flags_t mask;
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
+	{FLAGS_DESC(FAN_CLASS_CONTENT | FAN_REPORT_FID), {}, {}, EINVAL},
+
+	/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
+	{FLAGS_DESC(FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID), {}, {}, EINVAL},
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
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_NAME), {}, {}, EINVAL},
+
+	/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME), {},
+		{}, EINVAL},
+
+	/* FAN_REPORT_TARGET_FID without FAN_REPORT_FID is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME),
+		{}, {}, EINVAL},
+
+	/* FAN_REPORT_TARGET_FID without FAN_REPORT_NAME is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID),
+		{}, {}, EINVAL},
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
 
-	if (fan_report_target_fid_unsupported && tc->init_flags & FAN_REPORT_TARGET_FID) {
+	tst_res(TINFO, "Test case %d: fanotify_init(%s, O_RDONLY)", number,
+		tc->init.desc);
+
+	if (fan_report_target_fid_unsupported && tc->init.flags & FAN_REPORT_TARGET_FID) {
 		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
 					    fan_report_target_fid_unsupported);
 		return;
 	}
 
-	if (ignore_mark_unsupported && tc->mark_flags & FAN_MARK_IGNORE) {
+	if (ignore_mark_unsupported && tc->mark.flags & FAN_MARK_IGNORE) {
 		tst_res(TCONF, "FAN_MARK_IGNORE not supported in kernel?");
 		return;
 	}
 
-	TST_EXP_FD_OR_FAIL(fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY),
-			   !tc->mask && tc->expected_errno ? tc->expected_errno : 0);
+	if (!tc->mask.flags && tc->expected_errno) {
+		TST_EXP_FAIL(fanotify_init(tc->init.flags, O_RDONLY),
+			tc->expected_errno);
+	} else {
+		TST_EXP_FD(fanotify_init(tc->init.flags, O_RDONLY));
+	}
+
+	fanotify_fd = TST_RET;
 
 	if (fanotify_fd < 0)
 		return;
 
-	if (!tc->mask)
+	if (!tc->mask.flags)
 		goto out;
 
 	/* Set mark on non-dir only when expecting error ENOTDIR */
 	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
 
-	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
-					 tc->mask, AT_FDCWD, path),
+	tst_res(TINFO, "Testing fanotify_mark(FAN_MARK_ADD | %s, %s)",
+		tc->mark.desc, tc->mask.desc);
+	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+					 tc->mask.flags, AT_FDCWD, path),
 					 tc->expected_errno);
 
 	/*
@@ -178,15 +199,15 @@ static void do_test(unsigned int number)
 	 * and it should succeed.
 	 */
 	if (TST_PASS && tc->expected_errno == ENOTDIR) {
-		SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
-				   tc->mask, AT_FDCWD, MNTPOINT);
+		SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+				   tc->mask.flags, AT_FDCWD, MNTPOINT);
 		tst_res(TPASS,
 			"Adding an inode mark on directory did not fail with "
 			"ENOTDIR error as on non-dir inode");
 
-		if (!(tc->mark_flags & FAN_MARK_ONLYDIR)) {
-			SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags |
-					   FAN_MARK_FILESYSTEM, tc->mask,
+		if (!(tc->mark.flags & FAN_MARK_ONLYDIR)) {
+			SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark.flags |
+					   FAN_MARK_FILESYSTEM, tc->mask.flags,
 					   AT_FDCWD, FILE1);
 			tst_res(TPASS,
 				"Adding a filesystem mark on non-dir did not fail with "
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
