Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95579C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:37:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 502F83C8C0B
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:37:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F3FD3C1351
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E35C1401211
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:59 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id F32CC212B6;
 Tue, 14 Dec 2021 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639478219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZN82T4PUnYJak2ZAAli54dMySqS4v8moyUI0CDPjAoA=;
 b=FPKGAU+l/kxB3FxHAXCdiqWYGhqoKb/FpNZ6Auhau8VE96UTJWqICEKOeaDlzItmZkZzna
 SnRsdVHcnQUmXRueHhRRuUIg0edkcXaegUhW1r6RYfnmSXGoO3JtTYqAMLxphGcEHKRAyb
 +pzKr5Ax99rJ2Gs1RBnfhYMP379Nhqo=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id B7CD4A3B85;
 Tue, 14 Dec 2021 10:36:58 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 10:36:45 +0000
Message-Id: <20211214103645.16148-5-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211214103645.16148-1-rpalethorpe@suse.com>
References: <20211214103645.16148-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] API/cgroup: Use __func__ in tst_cgroup_require
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

Required by checkpatch.pl.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index c22f5b32c..7c4de34c6 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -609,10 +609,9 @@ void tst_cgroup_require(const char *const ctrl_name,
 	if (!options)
 		options = &default_opts;
 
-	if (ctrl->we_require_it) {
-		tst_res(TWARN, "Duplicate tst_cgroup_require(%s, )",
-			ctrl->ctrl_name);
-	}
+	if (ctrl->we_require_it)
+		tst_res(TWARN, "Duplicate %s(%s, )", __func__, ctrl->ctrl_name);
+
 	ctrl->we_require_it = 1;
 
 	if (ctrl->ctrl_root)
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
