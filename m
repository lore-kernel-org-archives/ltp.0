Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F59FC433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 12:46:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354CD3CA4F2
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 14:46:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 772703CA249
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 14:46:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16C046006C6
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 14:46:30 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 32EC4200A4;
 Tue, 12 Jul 2022 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1657629989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU5q37VmdSS+kJ/gOvnueftdzyqdYre6nemvBpAI4HQ=;
 b=MGosue6LwJwXcbYLN/DjinmDYoJID/1nDcNITaA+NqGAmOOvsrC+o6bC8/GFcGJMRFIHtU
 Rxd1QUwG+p5rQ6TqL87nz+UIBY29jiYPr9MYgMOe4Xg8SeAYDd7F4T9F1VIm4SzvL9CIS3
 L2d6hLnzv1RFatbm3Xm2FulfkL/9cP8=
Received: from g78.suse.de (unknown [10.163.24.226])
 by relay2.suse.de (Postfix) with ESMTP id ED5972C141;
 Tue, 12 Jul 2022 12:46:28 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 13:46:17 +0100
Message-Id: <20220712124617.23139-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712124617.23139-1-rpalethorpe@suse.com>
References: <20220712124617.23139-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] read_all: Fix type warnings
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
 testcases/kernel/fs/read_all/read_all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index d8c68bd33..813991f2c 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -168,7 +168,7 @@ static void sanitize_str(char *buf, ssize_t count)
 {
 	int i;
 
-	for (i = 0; i < MIN(count, MAX_DISPLAY); i++)
+	for (i = 0; i < MIN(count, (ssize_t)MAX_DISPLAY); i++)
 		if (!isprint(buf[i]))
 			buf[i] = ' ';
 
@@ -439,7 +439,7 @@ static void setup(void)
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
