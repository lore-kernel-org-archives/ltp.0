Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052B4C25B48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 09:50:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6570C3CEC07
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:50:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7741B3C8207
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:50:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7BC4E1A006A4
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:50:05 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 35A7F21B44;
 Thu, 26 Oct 2023 09:50:04 +0000 (UTC)
Received: from g78.cable.virginm.net (unknown [10.163.25.62])
 by relay2.suse.de (Postfix) with ESMTP id B31542D56F;
 Thu, 26 Oct 2023 09:50:03 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 26 Oct 2023 10:49:57 +0100
Message-ID: <20231026094957.15371-1-rpalethorpe@suse.com>
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
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 VIOLATED_DIRECT_SPF(3.50)[]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid
 DKIM,quarantine]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 BAYES_HAM(-0.01)[48.28%]
X-Rspamd-Queue-Id: 35A7F21B44
X-Spam: Yes
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cgroup: Handle trailing new line in
 cgroup.controllers
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

The last item in cgroup.controllers (misc or rdma in my case)
contained a new line character which caused the controller search to
fail.

This commit avoids including the newline character inside the name
comparison.

The search failure caused the "cgroup_regression_test.sh" test to fail
with a confusing error when it tries to mount a V1 subsys thus
removing the V2 and causing the available set of V2s to change between
scans.

According to the V2 docs subsys names can only include lowercase
characters and '_'. So we strictly look for those characters.

The newline (and delimiting space) is just what the kernel currently
prints. IDK if it is specified anywhere, but if it changes then the
error should be obvious.

Fixes: 310da3784 ("Add new CGroups APIs")
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Marius Kittler <mkittler@suse.de>
---

V2:
* Add underscore
* Add length check
* Expand commit message
* Use shorter syntax

 lib/tst_cgroup.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 5240aadaa..c5cb20505 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -433,9 +433,20 @@ __attribute__ ((nonnull, warn_unused_result))
 static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
 {
 	struct cgroup_ctrl *ctrl;
+	int l = 0;
+	char c = ctrl_name[l];
+
+	while (c == '_' || (c >= 'a' && c <= 'z'))
+		c = ctrl_name[++l];
+
+	if (l > 32)
+		tst_res(TWARN, "Subsys name len greater than max known value of MAX_CGROUP_TYPE_NAMELEN: %d > 32", l);
+
+	if (!(c == '\n' || c == '\0'))
+		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, c);
 
 	for_each_ctrl(ctrl) {
-		if (!strcmp(ctrl_name, ctrl->ctrl_name))
+		if (!strncmp(ctrl_name, ctrl->ctrl_name, l))
 			return ctrl;
 	}
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
