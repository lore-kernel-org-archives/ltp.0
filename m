Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC22C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:37:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A20793C8BC0
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:37:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0E03C8CE5
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6D9F06007A4
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:59 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A80DC1F3C4;
 Tue, 14 Dec 2021 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639478218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdGRI8bcuKEl8mzqerw/UGr4mSnqvlE+ZNCqGq3SydQ=;
 b=IT+fGXo5UTlchf9RF22VvpwVmQS+7/Q/0kuD30Bce60eTl3YTIxWix8nSqj/5NsjQK45QH
 BY1FQfBC0hCQOu7GPTFA7QEoYWJuV9LMI+ZA5jI/HCEcJD+VFYwlYoqd4NzDhqnUGUiWXV
 Xg6Pbj+yXkXTV9nmOcYy5tGK970zMcE=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id 69A0CA3B89;
 Tue, 14 Dec 2021 10:36:58 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 10:36:44 +0000
Message-Id: <20211214103645.16148-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211214103645.16148-1-rpalethorpe@suse.com>
References: <20211214103645.16148-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] API/cgroup: remove ltp_ prefix from static vars
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP-003 reserves this prefix for use in public symbols. Also it tends
to be used in parts of the old API. The new API uses tst_.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 8eeb98a26..c22f5b32c 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -199,11 +199,11 @@ static const struct tst_cgroup_opts default_opts = { 0 };
 /* We should probably allow these to be set in environment
  * variables
  */
-static const char *ltp_cgroup_dir = "ltp";
-static const char *ltp_cgroup_drain_dir = "drain";
-static char test_cgroup_dir[NAME_MAX + 1];
-static const char *ltp_mount_prefix = "/tmp/cgroup_";
-static const char *ltp_v2_mount = "unified";
+static const char *cgroup_ltp_dir = "ltp";
+static const char *cgroup_ltp_drain_dir = "drain";
+static char cgroup_test_dir[NAME_MAX + 1];
+static const char *cgroup_mount_ltp_prefix = "/tmp/cgroup_";
+static const char *cgroup_v2_ltp_mount = "unified";
 
 #define first_root				\
 	(roots[0].ver ? roots : roots + 1)
@@ -464,7 +464,7 @@ static void cgroup_mount_v2(void)
 {
 	char mnt_path[PATH_MAX];
 
-	sprintf(mnt_path, "%s%s", ltp_mount_prefix, ltp_v2_mount);
+	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, cgroup_v2_ltp_mount);
 
 	if (!mkdir(mnt_path, 0777)) {
 		roots[0].mnt_dir.we_created_it = 1;
@@ -506,7 +506,7 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
 	char mnt_path[PATH_MAX];
 	int made_dir = 0;
 
-	sprintf(mnt_path, "%s%s", ltp_mount_prefix, ctrl->ctrl_name);
+	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, ctrl->ctrl_name);
 
 	if (!mkdir(mnt_path, 0777)) {
 		made_dir = 1;
@@ -653,7 +653,7 @@ mkdirs:
 	}
 
 	if (!root->ltp_dir.dir_fd)
-		cgroup_dir_mk(&root->mnt_dir, ltp_cgroup_dir, &root->ltp_dir);
+		cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir, &root->ltp_dir);
 	else
 		root->ltp_dir.ctrl_field |= root->mnt_dir.ctrl_field;
 
@@ -668,10 +668,10 @@ mkdirs:
 			cgroup_copy_cpuset(root);
 	}
 
-	cgroup_dir_mk(&root->ltp_dir, ltp_cgroup_drain_dir, &root->drain_dir);
+	cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
 
-	sprintf(test_cgroup_dir, "test-%d", getpid());
-	cgroup_dir_mk(&root->ltp_dir, test_cgroup_dir, &root->test_dir);
+	sprintf(cgroup_test_dir, "test-%d", getpid());
+	cgroup_dir_mk(&root->ltp_dir, cgroup_test_dir, &root->test_dir);
 }
 
 static void cgroup_drain(const enum tst_cgroup_ver ver,
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
