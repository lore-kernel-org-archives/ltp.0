Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B45C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:37:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D491F3C8C6D
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:37:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9413B3C1351
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D65CA1A00F64
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5A5FB2111A;
 Tue, 14 Dec 2021 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639478218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6o4nFx3ev7FpJ1ICm5MByu/71+kpQjPMOQynpgQkPA=;
 b=HGjsKmN9UPAseTMSLlzCklvMO2bzbQenoIn/6wwv51Z7ygtRfspJTwydrZyt/9ubORNvob
 Q6PP5rvHSlKLxuLLsXBD6bLT9il9jlANFPXnpGgv4eep+vxKAUGlRZJHMhtbZJ3t1BISI0
 wdQIDI8uJq+xqavsraPecACykPKfdwE=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id 27350A3B83;
 Tue, 14 Dec 2021 10:36:58 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 10:36:43 +0000
Message-Id: <20211214103645.16148-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211214103645.16148-1-rpalethorpe@suse.com>
References: <20211214103645.16148-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] API/cgroup: Lift out assignments in if statements
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

checkpatch.pl forbids this; for good reason because it can mask
accidental use of '=' instead of '=='. Also included is a script to
automatically fix occurrences of this.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c                           | 22 ++++++++++------
 scripts/coccinelle/fix-if-assignment.cocci | 30 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 8 deletions(-)
 create mode 100644 scripts/coccinelle/fix-if-assignment.cocci

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index d9d74faa8..8eeb98a26 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -370,7 +370,8 @@ static void cgroup_root_scan(const char *const mnt_type,
 	SAFE_FILE_READAT(mnt_dfd, "cgroup.controllers", buf, sizeof(buf));
 
 	for (tok = strtok(buf, " "); tok; tok = strtok(NULL, " ")) {
-		if ((const_ctrl = cgroup_find_ctrl(tok)))
+		const_ctrl = cgroup_find_ctrl(tok);
+		if (const_ctrl)
 			add_ctrl(&ctrl_field, const_ctrl);
 	}
 
@@ -386,7 +387,8 @@ static void cgroup_root_scan(const char *const mnt_type,
 
 v1:
 	for (tok = strtok(mnt_opts, ","); tok; tok = strtok(NULL, ",")) {
-		if ((const_ctrl = cgroup_find_ctrl(tok)))
+		const_ctrl = cgroup_find_ctrl(tok);
+		if (const_ctrl)
 			add_ctrl(&ctrl_field, const_ctrl);
 
 		no_prefix |= !strcmp("noprefix", tok);
@@ -1008,8 +1010,9 @@ int safe_cgroup_has(const char *const file, const int lineno,
 		return 0;
 
 	for_each_dir(cg, cfile->ctrl_indx, dir) {
-		if (!(alias = cgroup_file_alias(cfile, *dir)))
-		    continue;
+		alias = cgroup_file_alias(cfile, *dir);
+		if (!alias)
+			continue;
 
 		if (!faccessat((*dir)->dir_fd, alias, F_OK, 0))
 			return 1;
@@ -1077,7 +1080,8 @@ ssize_t safe_cgroup_read(const char *const file, const int lineno,
 	ssize_t read_ret = 0;
 
 	for_each_dir(cg, cfile->ctrl_indx, dir) {
-		if (!(alias = cgroup_file_alias(cfile, *dir)))
+		alias = cgroup_file_alias(cfile, *dir);
+		if (!alias)
 			continue;
 
 		if (prev_len)
@@ -1115,8 +1119,9 @@ void safe_cgroup_printf(const char *const file, const int lineno,
 	va_list va;
 
 	for_each_dir(cg, cfile->ctrl_indx, dir) {
-		if (!(alias = cgroup_file_alias(cfile, *dir)))
-		    continue;
+		alias = cgroup_file_alias(cfile, *dir);
+		if (!alias)
+			continue;
 
 		va_start(va, fmt);
 		safe_file_vprintfat(file, lineno,
@@ -1141,7 +1146,8 @@ void safe_cgroup_scanf(const char *const file, const int lineno,
 		return;
 
 	va_start(va, fmt);
-	if ((ret = vsscanf(buf, fmt, va)) < 1) {
+	ret = vsscanf(buf, fmt, va);
+	if (ret < 1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			 "'%s': vsscanf('%s', '%s', ...)", file_name, buf, fmt);
 	}
diff --git a/scripts/coccinelle/fix-if-assignment.cocci b/scripts/coccinelle/fix-if-assignment.cocci
new file mode 100644
index 000000000..4dad22fe0
--- /dev/null
+++ b/scripts/coccinelle/fix-if-assignment.cocci
@@ -0,0 +1,30 @@
+@@
+expression V, E;
+@@
+
++ V = E;
+  if (
+-	(V = E)
++ 	V
+  ) { ... }
+
+@@
+expression V, E;
+@@
+
++ V = E;
+  if (!
+-	(V = E)
++ 	V
+  ) { ... }
+
+@@
+expression V, E;
+binary operator B; 
+@@
+
++ V = E;
+  if (
+-	(V = E)
++ 	V
+  B ...) { ... }
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
