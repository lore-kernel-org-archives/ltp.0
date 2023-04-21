Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C2EC77B73
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 01:27:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7D883CBFE2
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 03:27:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 622743CBFE4
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 03:27:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7766A6009F1
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 03:27:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F5EE1FDD6;
 Fri, 21 Apr 2023 01:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1682040431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=av7O8wqA5l5acpG9v4iebekjhlfuxbzl44uj2XY0t4c=;
 b=Wzi8nQ7sHtrr8x7IG/ny3h5v0ZtxPHKCgLLmo8tm9rzKU3V5Fcu+pC0/1O8jwEXTISZGgQ
 pMzdvZOEhZZy0UBzVIj2KzKdHFjmgoj7QXcQiD/UgluvG408Ox36ZnZfaf4AG6OMZZdMka
 OnYzM+Cr7muKkIjpXM4gEmjWuZOl/5s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B25F613584;
 Fri, 21 Apr 2023 01:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QJY1IW7mQWT7eAAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 21 Apr 2023 01:27:10 +0000
To: ltp@lists.linux.it
Date: Thu, 20 Apr 2023 21:26:42 -0400
Message-Id: <20230421012642.16625-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230421012642.16625-1-wegao@suse.com>
References: <20230419151849.13152-1-wegao@suse.com>
 <20230421012642.16625-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] tst_cgroup.c: Add a cgroup pseudo controller
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
 lib/tst_cgroup.c | 54 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 77575431d..6a70bf4b4 100644
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
 
+static const struct cgroup_file cgroup_pseudo_ctrl_files[] = {
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
+	CGROUP_CTRL_MEMBER(cgroup_pseudo, CTRL_PSEUDO),
 	{ }
 };
 
@@ -798,6 +804,7 @@ void tst_cg_require(const char *const ctrl_name,
 	const char *const cgsc = "cgroup.subtree_control";
 	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
 	struct cgroup_root *root;
+	int cgroup_pseudo = !strcmp(ctrl->ctrl_name, "cgroup_pseudo");
 
 	if (!ctrl) {
 		tst_brk(TBROK, "'%s' controller is unknown to LTP", ctrl_name);
@@ -827,6 +834,9 @@ void tst_cg_require(const char *const ctrl_name,
 	if (options->needs_ver != TST_CG_V2)
 		cgroup_mount_v1(ctrl);
 
+	if (cgroup_pseudo)
+		ctrl->ctrl_root = roots;
+
 	if (!ctrl->ctrl_root) {
 		tst_brk(TCONF,
 			"'%s' controller required, but not available",
@@ -849,13 +859,15 @@ mkdirs:
 			ctrl->ctrl_name);
 	}
 
-	if (cgroup_ctrl_on_v2(ctrl)) {
-		if (root->we_mounted_it) {
-			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
-					   cgsc, "+%s", ctrl->ctrl_name);
-		} else {
-			tst_file_printfat(root->mnt_dir.dir_fd,
-					  cgsc, "+%s", ctrl->ctrl_name);
+	if (!cgroup_pseudo) {
+		if (cgroup_ctrl_on_v2(ctrl)) {
+			if (root->we_mounted_it) {
+				SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
+						cgsc, "+%s", ctrl->ctrl_name);
+			} else {
+				tst_file_printfat(root->mnt_dir.dir_fd,
+						cgsc, "+%s", ctrl->ctrl_name);
+			}
 		}
 	}
 
@@ -864,15 +876,17 @@ mkdirs:
 	else
 		root->ltp_dir.ctrl_field |= root->mnt_dir.ctrl_field;
 
-	if (cgroup_ctrl_on_v2(ctrl)) {
-		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
-				   cgsc, "+%s", ctrl->ctrl_name);
-	} else {
-		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
-				   "cgroup.clone_children", "%d", 1);
+	if (!cgroup_pseudo) {
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
@@ -1050,8 +1064,10 @@ static void cgroup_group_add_dir(const struct tst_cg_group *const parent,
 		if (!parent || dir->dir_root->ver == TST_CG_V1)
 			continue;
 
-		SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
-				   "+%s", ctrl->ctrl_name);
+		if (strcmp(ctrl->ctrl_name, "cgroup_pseudo")) {
+			SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
+					"+%s", ctrl->ctrl_name);
+		}
 	}
 
 	for (i = 0; cg->dirs[i]; i++)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
