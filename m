Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0955DC7618E
	for <ltp@archiver.kernel.org>; Sat, 22 Apr 2023 13:54:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 274E13CBE52
	for <ltp@archiver.kernel.org>; Sat, 22 Apr 2023 15:54:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CD8F3CBDE9
 for <ltp@lists.linux.it>; Sat, 22 Apr 2023 15:54:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EA4016002B6
 for <ltp@lists.linux.it>; Sat, 22 Apr 2023 15:54:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 393B51F38D;
 Sat, 22 Apr 2023 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1682171640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE4BQR6SMvGF0pA2UqpU+i7IL1mbYkKtD5rQJJmr0QY=;
 b=Qd9gHE0BKLPQW+JF42VvkfuKgI6woBHzBU7mS0uoU3hKx5KreGIrpy4cuas2EzN3c4Wvw4
 TSj5g1/nJJxKE152p4VbVgM3JXwSAUHQaKIpSghgkfGy8PL8nKblgKKD4rZLvyYU9vSWqU
 Bb6KlJ4JQ+T261wnG0GefJO0YMUbzKY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6006313591;
 Sat, 22 Apr 2023 13:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +M72CvfmQ2TOLAAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 22 Apr 2023 13:53:59 +0000
To: ltp@lists.linux.it
Date: Sat, 22 Apr 2023 09:53:37 -0400
Message-Id: <20230422135337.12087-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230422135337.12087-1-wegao@suse.com>
References: <20230421012642.16625-1-wegao@suse.com>
 <20230422135337.12087-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 2/2] tst_cgroup.c: Add a cgroup pseudo controller
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For new test case such as kill01.c no need specific controller, it just
need LTP cgroup library start work, so we need add a "cgroup" pseudo
controller.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_cgroup.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 77575431d..ed3e0758f 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -94,9 +94,10 @@ enum cgroup_ctrl_indx {
 	CTRL_MISC,
 	CTRL_PERFEVENT,
 	CTRL_DEBUG,
-	CTRL_RDMA
+	CTRL_RDMA,
+	CTRL_PSEUDO
 };
-#define CTRLS_MAX CTRL_RDMA
+#define CTRLS_MAX CTRL_PSEUDO
 
 /* At most we can have one cgroup V1 tree for each controller and one
  * (empty) v2 tree.
@@ -259,6 +260,10 @@ static const struct cgroup_file rdma_ctrl_files[] = {
 	{ }
 };
 
+static const struct cgroup_file pseudo_ctrl_files[] = {
+	{ }
+};
+
 #define CTRL_NAME_MAX 31
 #define CGROUP_CTRL_MEMBER(x, y)[y] = { .ctrl_name = #x, .files = \
 	x ## _ctrl_files, .ctrl_indx = y, NULL, 0 }
@@ -282,6 +287,7 @@ static struct cgroup_ctrl controllers[] = {
 	CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),
 	CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),
 	CGROUP_CTRL_MEMBER(rdma, CTRL_RDMA),
+	CGROUP_CTRL_MEMBER(pseudo, CTRL_PSEUDO),
 	{ }
 };
 
@@ -798,6 +804,10 @@ void tst_cg_require(const char *const ctrl_name,
 	const char *const cgsc = "cgroup.subtree_control";
 	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
 	struct cgroup_root *root;
+	int pseudo = !strcmp(ctrl->ctrl_name, "pseudo");
+
+	if (pseudo && options->needs_ver != TST_CG_V2)
+		tst_brk(TCONF, "pseudo control only support needs_ver TST_CG_V2!");
 
 	if (!ctrl) {
 		tst_brk(TBROK, "'%s' controller is unknown to LTP", ctrl_name);
@@ -827,6 +837,9 @@ void tst_cg_require(const char *const ctrl_name,
 	if (options->needs_ver != TST_CG_V2)
 		cgroup_mount_v1(ctrl);
 
+	if (pseudo)
+		ctrl->ctrl_root = roots;
+
 	if (!ctrl->ctrl_root) {
 		tst_brk(TCONF,
 			"'%s' controller required, but not available",
@@ -849,13 +862,13 @@ mkdirs:
 			ctrl->ctrl_name);
 	}
 
-	if (cgroup_ctrl_on_v2(ctrl)) {
+	if (cgroup_ctrl_on_v2(ctrl) && !pseudo) {
 		if (root->we_mounted_it) {
 			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
-					   cgsc, "+%s", ctrl->ctrl_name);
+					cgsc, "+%s", ctrl->ctrl_name);
 		} else {
 			tst_file_printfat(root->mnt_dir.dir_fd,
-					  cgsc, "+%s", ctrl->ctrl_name);
+					cgsc, "+%s", ctrl->ctrl_name);
 		}
 	}
 
@@ -864,15 +877,17 @@ mkdirs:
 	else
 		root->ltp_dir.ctrl_field |= root->mnt_dir.ctrl_field;
 
-	if (cgroup_ctrl_on_v2(ctrl)) {
-		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
-				   cgsc, "+%s", ctrl->ctrl_name);
-	} else {
-		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
-				   "cgroup.clone_children", "%d", 1);
+	if (!pseudo) {
+		if (cgroup_ctrl_on_v2(ctrl)) {
+			SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
+					cgsc, "+%s", ctrl->ctrl_name);
+		} else {
+			SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
+					"cgroup.clone_children", "%d", 1);
 
-		if (ctrl->ctrl_indx == CTRL_CPUSET)
-			cgroup_copy_cpuset(root);
+			if (ctrl->ctrl_indx == CTRL_CPUSET)
+				cgroup_copy_cpuset(root);
+		}
 	}
 
 	cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
@@ -1050,8 +1065,10 @@ static void cgroup_group_add_dir(const struct tst_cg_group *const parent,
 		if (!parent || dir->dir_root->ver == TST_CG_V1)
 			continue;
 
-		SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
-				   "+%s", ctrl->ctrl_name);
+		if (strcmp(ctrl->ctrl_name, "pseudo")) {
+			SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
+					"+%s", ctrl->ctrl_name);
+		}
 	}
 
 	for (i = 0; cg->dirs[i]; i++)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
