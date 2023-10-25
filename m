Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF80C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 11:06:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9E803CEC57
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 13:05:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBBAC3CB558
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:05:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD347687258
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:05:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1F65421B63;
 Wed, 25 Oct 2023 11:05:47 +0000 (UTC)
Received: from g78.cable.virginm.net (unknown [10.163.25.62])
 by relay2.suse.de (Postfix) with ESMTP id A45642D2CA;
 Wed, 25 Oct 2023 11:05:46 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 12:05:33 +0100
Message-ID: <20231025110533.6516-1-rpalethorpe@suse.com>
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
 RCVD_COUNT_TWO(0.00)[2]; BAYES_HAM(-0.00)[23.24%]
X-Rspamd-Queue-Id: 1F65421B63
X-Spam: Yes
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup: Handle trailing new line in cgroup.controllers
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

The last item in cgroup.controllers (misc in my case) contained a new
line character which caused the controller search to fail.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

This stops cgroup_regression_test.sh from failing on
Tumbleweed. However there are other issues with that test which are
not addressed by this patch.

 lib/tst_cgroup.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 5240aadaa..d70b5431d 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -433,9 +433,20 @@ __attribute__ ((nonnull, warn_unused_result))
 static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
 {
 	struct cgroup_ctrl *ctrl;
+	int l = 0;
+
+	while (ctrl_name[l] >= 'a' && ctrl_name[l] <= 'z')
+		l++;
+
+	switch (ctrl_name[l]) {
+	case '\n': break;
+	case '\0': break;
+	default:
+		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, ctrl_name[l]);
+	}
 
 	for_each_ctrl(ctrl) {
-		if (!strcmp(ctrl_name, ctrl->ctrl_name))
+		if (!strncmp(ctrl_name, ctrl->ctrl_name, l))
 			return ctrl;
 	}
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
