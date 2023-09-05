Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023FFCA0FF7
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 08:37:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55C663CEB5B
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 10:37:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88F553CB798
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 10:37:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B354B601103
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 10:37:25 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DA19C1F750;
 Tue,  5 Sep 2023 08:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1693903044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8YfwdMxvRSnb29I/ctpyw76IPgHtlzaF+yfjDUvdDSM=;
 b=gc/RhSQzrBf2frZqpoUN46lXDiP0Outgec30KaTOblsTRLcsRpjnfqNj3DCWD9Rr5ekYNZ
 wpUJrx3ek4EC4USDnuyQIhmGrEL4xXO18UhiiLb56iXCnpiY5o9NUT713kFxAp0FNvXMYb
 1AGch4g/67SubLiRivFhcDKCJv3P/7c=
Received: from g78.cable.virginm.net (rpalethorpe.udp.ovpn1.nue.suse.de
 [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id E03862C142;
 Tue,  5 Sep 2023 08:37:23 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 09:37:13 +0100
Message-ID: <20230905083713.12312-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2016-10044: Check sscanf matches and syntax fixups
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

The test appears to work, but we were not checking that sscanf fills
the expected number of fields. Also the trailing 7 probably had no
effect, but is a confusing typo.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reported-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/cve/cve-2016-10044.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index 9ac644fc2..6a8c77f3e 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -19,7 +19,7 @@
 #include "tst_safe_stdio.h"
 #include "lapi/syscalls.h"
 
-static FILE *f;
+static FILE * f;
 
 static void cleanup(void)
 {
@@ -29,7 +29,7 @@ static void cleanup(void)
 
 static void run(void)
 {
-	void* ctx = 0;
+	void *ctx = 0;
 	char perms[8], line[BUFSIZ];
 
 	SAFE_PERSONALITY(READ_IMPLIES_EXEC);
@@ -44,7 +44,7 @@ static void run(void)
 	tst_brk(TCONF, "Could not find mapping in /proc/self/maps");
 
 found_mapping:
-	if (sscanf(line, "%*x-%*x %s7", perms) < 0)
+	if (sscanf(line, "%*x-%*x %s", perms) != 1)
 		tst_brk(TBROK, "failed to find permission string in %s", line);
 	if (strchr(perms, (int)'x'))
 		tst_res(TFAIL, "AIO mapping is executable: %s!", perms);
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
