Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01301C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 08:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16D4F3C98ED
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 09:19:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77B5C3C8F8A
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 09:19:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD3391000CEA
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 09:19:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 52ECF1F43D;
 Thu,  3 Feb 2022 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643876354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5U+PGl4JiYRrKRiSwFGxTU6DZohMXpM7JgxF2LJlfI=;
 b=V+/nGBIvZVMwLqs5Nkaidgg0XTObIdpnTslDW4xxyGlXTVuAnR4GvA3t1CWQFhFsFxIN5b
 H+XB4thl9MxOeqf8R9OGqsRojiGUMotr9kaq1R5F8rHC48yTvyFNd4D3CN3imIwhJsvT64
 /wqLwPO6XsC7tGntqfGtd+Qu65WDSts=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 20F4CA3B81;
 Thu,  3 Feb 2022 08:19:14 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  3 Feb 2022 08:18:18 +0000
Message-Id: <20220203081820.29521-5-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203081820.29521-1-rpalethorpe@suse.com>
References: <20220203081820.29521-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] API/cgroup: Allow formatting of new cg names
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

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_cgroup.h |  5 +++--
 lib/tst_cgroup.c     | 29 ++++++++++++-----------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 17adefd2b..d7a3433fa 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -126,8 +126,9 @@ void tst_cgroup_init(void);
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
index d9cd6aa8e..66f17575e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -840,21 +840,6 @@ clear_data:
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
@@ -886,14 +871,24 @@ static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
 
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
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
