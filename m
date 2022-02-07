Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD86C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24F3D3C9AED
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 15:17:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D35D3C9B1D
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:16:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 26427600768
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:16:36 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8C20E210E3;
 Mon,  7 Feb 2022 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644243396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAILJJNZx4YwXXwNUukmbOzgUezciJ1a++Z1lhrA59Y=;
 b=R94BKvOryRbzrux7hrcRvs+qizPphrgWQGc3EoE8EGfOvteI2rzOO2NE9W75NoG4ZGph8g
 3X+OR3X97fJRva1egsGfOQcX0qU5grDR6Udz+6zWEqvV2zf6Sjh3BNe/uCbSNsSOvmeWLf
 7eUkLrNYIrd4YeGlt9+0HEn2sJSZ6mU=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 44B74A3B96;
 Mon,  7 Feb 2022 14:16:36 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  7 Feb 2022 14:16:17 +0000
Message-Id: <20220207141618.2844-5-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207141618.2844-1-rpalethorpe@suse.com>
References: <20220207141618.2844-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/5] API/cgroup: Make tst_cgroup_group_mk sprintf
 like
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

Allows the name to be formatted which is trivial because we already
copy it into a buffer. Also this removes the init function which is
now just unnecessary verbiage.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_cgroup.h                          |  5 +--
 lib/tst_cgroup.c                              | 31 ++++++++-----------
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |  9 +++---
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 83bdb4b0d..39aa95a88 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -132,8 +132,9 @@ void tst_cgroup_init(void);
 /* Create a descendant CGroup */
 struct tst_cgroup_group *
 tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
-		    const char *const group_name)
-		    __attribute__ ((nonnull, warn_unused_result));
+		    const char *const group_name_fmt, ...)
+	    __attribute__ ((nonnull, warn_unused_result, format (printf, 2, 3)));
+
 const char *
 tst_cgroup_group_name(const struct tst_cgroup_group *const cg)
 		      __attribute__ ((nonnull, warn_unused_result));
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index bb379caf5..93d374c56 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -834,21 +834,6 @@ clear_data:
 	memset(roots, 0, sizeof(roots));
 }
 
-__attribute__((nonnull(1)))
-static void cgroup_group_init(struct tst_cgroup_group *const cg,
-			      const char *const group_name)
-{
-	memset(cg, 0, sizeof(*cg));
-
-	if (!group_name)
-		return;
-
-	if (strlen(group_name) > NAME_MAX)
-		tst_brk(TBROK, "Group name is too long");
-
-	strcpy(cg->group_name, group_name);
-}
-
 __attribute__((nonnull(2, 3)))
 static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
 				 struct tst_cgroup_group *const cg,
@@ -880,18 +865,28 @@ static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
 
 struct tst_cgroup_group *
 tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
-		    const char *const group_name)
+		    const char *const group_name_fmt, ...)
 {
 	struct tst_cgroup_group *cg;
 	struct cgroup_dir *const *dir;
 	struct cgroup_dir *new_dir;
+	va_list ap;
+	size_t name_len;
 
 	cg = SAFE_MALLOC(sizeof(*cg));
-	cgroup_group_init(cg, group_name);
+	memset(cg, 0, sizeof(*cg));
+
+	va_start(ap, group_name_fmt);
+	name_len = vsnprintf(cg->group_name, NAME_MAX,
+			     group_name_fmt, ap);
+	va_end(ap);
+
+	if (name_len >= NAME_MAX)
+		tst_brk(TBROK, "CGroup name is too long");
 
 	for_each_dir(parent, 0, dir) {
 		new_dir = SAFE_MALLOC(sizeof(*new_dir));
-		cgroup_dir_mk(*dir, group_name, new_dir);
+		cgroup_dir_mk(*dir, cg->group_name, new_dir);
 		cgroup_group_add_dir(parent, cg, new_dir);
 	}
 
diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index aae1e321b..2c28b83a2 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -56,11 +56,12 @@ static void set_cpu_quota(const struct tst_cgroup_group *const cg,
 }
 
 static void mk_cpu_cgroup(struct tst_cgroup_group **cg,
-		const struct tst_cgroup_group *const cg_parent,
-		const char *const cg_child_name,
-		const float quota_percent)
+			  const struct tst_cgroup_group *const cg_parent,
+			  const char *const cg_child_name,
+			  const float quota_percent)
+
 {
-	*cg = tst_cgroup_group_mk(cg_parent, cg_child_name);
+	*cg = tst_cgroup_group_mk(cg_parent, "%s", cg_child_name);
 
 	set_cpu_quota(*cg, quota_percent);
 }
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
