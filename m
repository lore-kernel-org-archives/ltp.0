Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E66DC433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 10:07:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C63113C94FB
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 12:06:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64DFE3C0756
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 12:06:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4DB7600067
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 12:06:47 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3664237589;
 Mon, 25 Jul 2022 10:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1658743607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdxQcTiPkBJmV3teKxQo0wIsOmyH5XlP/WxciZOQrFM=;
 b=MnMGq4O+n4nibjO5GCTGUW0rFenAGZTRNDZpHYuemLaZnabfF/DkxWHRs4fTfgN3zE8wTo
 dwPqfIK7TIbrIVHmafBIe2uRvvjvA/Pob9FNAfHCyg3s+gPFwHNFHdG1AwoFp7lPPFklQB
 AHwUIfrb+ba9F2WJVzcgT3dXEqnjEdM=
Received: from g78.suse.de (unknown [10.163.24.226])
 by relay2.suse.de (Postfix) with ESMTP id DE17D2C149;
 Mon, 25 Jul 2022 10:06:46 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 25 Jul 2022 11:06:39 +0100
Message-Id: <20220725100641.11625-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725100641.11625-1-rpalethorpe@suse.com>
References: <20220725100641.11625-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] read_all: Fix type warnings
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 4449fe894..02c8f1754 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -184,7 +184,7 @@ static void sanitize_str(char *buf, ssize_t count)
 {
 	int i;
 
-	for (i = 0; i < MIN(count, MAX_DISPLAY); i++)
+	for (i = 0; i < MIN(count, (ssize_t)MAX_DISPLAY); i++)
 		if (!isprint(buf[i]))
 			buf[i] = ' ';
 
@@ -552,7 +552,7 @@ static void setup(void)
 		tst_brk(TBROK, "The directory argument (-d) is required");
 
 	if (!worker_count)
-		worker_count = MIN(MAX(tst_ncpus() - 1, 1), max_workers);
+		worker_count = MIN(MAX(tst_ncpus() - 1, 1L), max_workers);
 	workers = SAFE_MALLOC(worker_count * sizeof(*workers));
 
 	if (tst_parse_int(str_worker_timeout, &worker_timeout, 1, INT_MAX)) {
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
