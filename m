Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB5EC4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 10:00:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39D193CEAC4
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 11:00:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CD403C81F9
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 11:00:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A8FFB200914
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 11:00:22 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4988221CC2;
 Mon, 30 Oct 2023 10:00:21 +0000 (UTC)
Received: from g78.cable.virginm.net (rpalethorpe.tcp.ovpn1.nue.suse.de
 [10.163.17.14]) by relay2.suse.de (Postfix) with ESMTP id B17912D782;
 Mon, 30 Oct 2023 10:00:20 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 30 Oct 2023 10:00:08 +0000
Message-ID: <20231030100008.5280-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com
 (policy=quarantine); 
 spf=fail (smtp-out1.suse.de: domain of rpalethorpe@suse.com does not designate
 149.44.160.134 as permitted sender) smtp.mailfrom=rpalethorpe@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00]; ARC_NA(0.00)[];
 R_SPF_FAIL(1.00)[-all]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid
 DKIM,quarantine]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 4988221CC2
X-Spam: Yes
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup: Fix scanning V1 mount options
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

The validation in cgroup_find_ctrl did not take into consideration how
we scan V1 mounts. For V1 we try using each mount option as if it is a
controller name. Some mount options contain characters which would be
invalid in a controller name.

This commit ignores errors when scanning V1 mount options.

Ideally we would have a place where we can read the subsys name
knowing that only subsys names will be read from that location. Such
as with V2. One possibility is /proc/cgroups which contains a numeric
value for the hierarchy. However it would require more investigation.

Fixes: #1093
Fixes: 5292c46e5 "cgroup: Handle trailing new line in cgroup.controllers"
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index f904ae168..a8a598e0e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -429,7 +429,8 @@ void tst_cg_print_config(void)
 }
 
 __attribute__ ((nonnull, warn_unused_result))
-static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
+static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name,
+					    unsigned int strict)
 {
 	struct cgroup_ctrl *ctrl;
 	int l = 0;
@@ -438,11 +439,15 @@ static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
 	while (c == '_' || (c >= 'a' && c <= 'z'))
 		c = ctrl_name[++l];
 
-	if (l > 32)
+	if (l > 32 && strict)
 		tst_res(TWARN, "Subsys name len greater than max known value of MAX_CGROUP_TYPE_NAMELEN: %d > 32", l);
 
-	if (!(c == '\n' || c == '\0'))
+	if (!(c == '\n' || c == '\0')) {
+		if (!strict)
+			return NULL;
+
 		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, c);
+	}
 
 	for_each_ctrl(ctrl) {
 		if (!strncmp(ctrl_name, ctrl->ctrl_name, l))
@@ -478,7 +483,7 @@ static void cgroup_parse_config_line(const char *const config_entry)
 	if (vars_read != 7)
 		tst_brk(TBROK, "Incorrect number of vars read from config. Config possibly malformed?");
 
-	ctrl = cgroup_find_ctrl(ctrl_name);
+	ctrl = cgroup_find_ctrl(ctrl_name, 1);
 	if (!ctrl)
 		tst_brk(TBROK, "Could not find ctrl from config. Ctrls changing between calls?");
 
@@ -571,7 +576,7 @@ static void cgroup_root_scan(const char *const mnt_type,
 	SAFE_FILE_READAT(mnt_dfd, "cgroup.controllers", buf, sizeof(buf));
 
 	for (tok = strtok(buf, " "); tok; tok = strtok(NULL, " ")) {
-		const_ctrl = cgroup_find_ctrl(tok);
+		const_ctrl = cgroup_find_ctrl(tok, 1);
 		if (const_ctrl)
 			add_ctrl(&ctrl_field, const_ctrl);
 	}
@@ -588,7 +593,7 @@ static void cgroup_root_scan(const char *const mnt_type,
 
 v1:
 	for (tok = strtok(mnt_opts, ","); tok; tok = strtok(NULL, ",")) {
-		const_ctrl = cgroup_find_ctrl(tok);
+		const_ctrl = cgroup_find_ctrl(tok, 0);
 		if (const_ctrl)
 			add_ctrl(&ctrl_field, const_ctrl);
 
@@ -815,7 +820,7 @@ void tst_cg_require(const char *const ctrl_name,
 			const struct tst_cg_opts *options)
 {
 	const char *const cgsc = "cgroup.subtree_control";
-	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
+	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name, 1);
 	struct cgroup_root *root;
 	int base = !strcmp(ctrl->ctrl_name, "base");
 
@@ -1171,7 +1176,7 @@ static const struct cgroup_file *cgroup_file_find(const char *const file,
 	memcpy(ctrl_name, file_name, len);
 	ctrl_name[len] = '\0';
 
-	ctrl = cgroup_find_ctrl(ctrl_name);
+	ctrl = cgroup_find_ctrl(ctrl_name, 1);
 
 	if (!ctrl) {
 		tst_brk_(file, lineno, TBROK,
@@ -1198,7 +1203,7 @@ enum tst_cg_ver tst_cg_ver(const char *const file, const int lineno,
 				    const struct tst_cg_group *const cg,
 				    const char *const ctrl_name)
 {
-	const struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
+	const struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name, 1);
 	const struct cgroup_dir *dir;
 
 	if (!strcmp(ctrl_name, "cgroup")) {
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
