Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC1FC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:37:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4749B3C8D54
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:37:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C9C83C1351
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A483E60067B
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C8D6F2114E;
 Tue, 14 Dec 2021 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639478217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F1l4+eQwdif6bRyHeqLP4Z/vlLmnGPWCQ6JS6LrqC4M=;
 b=P9EkpcqOaYK469IBrQQrA544uNAzrpXPAQzqyrx3zbkCfLsZS+Nob+SQbIsA5Z6gRn3hdF
 7cHuz1yGweH7Aitw+KbPws8CjaMXQiQ+3CKSHYXgEILB1BFqdmflOqhTOjbYpDZ2Twbv24
 XzAXyT0A14af57iQTZLwJia/pn8x48I=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id 9552CA3B83;
 Tue, 14 Dec 2021 10:36:57 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 10:36:41 +0000
Message-Id: <20211214103645.16148-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] API/cgroup: Whitespace fixes
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

Reduce make check noise

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 61cc02fa7..2dcfbc8ff 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -199,7 +199,8 @@ static struct cgroup_ctrl controllers[] = {
 static const struct tst_cgroup_opts default_opts = { 0 };
 
 /* We should probably allow these to be set in environment
- * variables */
+ * variables
+ */
 static const char *ltp_cgroup_dir = "ltp";
 static const char *ltp_cgroup_drain_dir = "drain";
 static char test_cgroup_dir[NAME_MAX + 1];
@@ -798,7 +799,8 @@ void tst_cgroup_cleanup(void)
 			continue;
 
 		/* This probably does not result in the CGroup root
-		 * being destroyed */
+		 * being destroyed
+		 */
 		if (umount2(root->mnt_path, MNT_DETACH))
 			continue;
 
@@ -817,7 +819,7 @@ clear_data:
 	memset(roots, 0, sizeof(roots));
 }
 
-__attribute__ ((nonnull (1)))
+__attribute__((nonnull(1)))
 static void cgroup_group_init(struct tst_cgroup_group *const cg,
 			      const char *const group_name)
 {
@@ -832,7 +834,7 @@ static void cgroup_group_init(struct tst_cgroup_group *const cg,
 	strcpy(cg->group_name, group_name);
 }
 
-__attribute__((nonnull (2, 3)))
+__attribute__((nonnull(2, 3)))
 static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
 				 struct tst_cgroup_group *const cg,
 				 struct cgroup_dir *const dir)
@@ -856,7 +858,8 @@ static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
 				   "+%s", ctrl->ctrl_name);
 	}
 
-	for (i = 0; cg->dirs[i]; i++);
+	for (i = 0; cg->dirs[i]; i++)
+		;
 	cg->dirs[i] = dir;
 }
 
@@ -923,7 +926,7 @@ static const struct cgroup_file *cgroup_file_find(const char *const file,
 	memcpy(ctrl_name, file_name, len);
 	ctrl_name[len] = '\0';
 
-        ctrl = cgroup_find_ctrl(ctrl_name);
+	ctrl = cgroup_find_ctrl(ctrl_name);
 
 	if (!ctrl) {
 		tst_brk_(file, lineno, TBROK,
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
