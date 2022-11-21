Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1D6C433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 13:56:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA3FE3CCBD3
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 14:56:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B33903C0CDE
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 14:56:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C7AB013B5290
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 14:56:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9C59A220C2;
 Mon, 21 Nov 2022 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1669038979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FAp5LJaEBDFYiEtfxij5LQ25grLgIRzVHjtJmomwgP0=;
 b=SFgh4tMxApNg/Of9VwsBxOW3hIU2O7ZOLc8AfQ9Gcif28I8KfMJQLSzx5gl70s7j4ug5ql
 2fs9yqKsqcRpKLYej61Bubm0DiSGpr9pjymDOYgUz+ZmOYybdMXpwQdS2eerwRy9S0iN7c
 tqr0r3WK5DDt9wfPBJuAE8qHpDOSoSI=
Received: from g78.cable.virginm.net (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id 6A0EE2C143;
 Mon, 21 Nov 2022 13:56:19 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 13:56:16 +0000
Message-Id: <20221121135616.19369-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pty03: Add CONFIG_SERIO_SERPORT as a hint
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

It's not clear what module implements the mouse ldisc. So adding this
helps configure test kernels.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/pty/pty03.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 53df6d62c..6324bc876 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -153,6 +153,10 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.max_runtime = 30,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_SERIO_SERPORT",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "0ace17d568241"},
 		{"CVE", "2020-14416"},
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
