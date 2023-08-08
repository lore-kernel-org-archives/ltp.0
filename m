Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BB4C001DE
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 15:41:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1288A3CD50F
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 17:41:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D98823CD0FE
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 17:41:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5B57510006D3
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 17:41:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D59C02031B;
 Tue,  8 Aug 2023 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691509303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p4HZ0oZ8zwROdDL/XEYBACNFEThWC3mzSzByHet5jeA=;
 b=tQYWDUpOdO6TeMzdc+kxp1gMDMhkkaAy2AauTqWpFWbX6jxGKf/5xDdxwVlGYvOQ1eWWbL
 gtns96mBoibwtq9M+7zHFcQK9gCUmt1I5vtrhNhobroP/VsxznZHlho+s+ikJh/f3nJ+1Z
 2IONaxUnckKG853ehEOChxi528lFWxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691509303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p4HZ0oZ8zwROdDL/XEYBACNFEThWC3mzSzByHet5jeA=;
 b=+y0g77nOV0m+SfGZXBoampL3cLAGy707jRTPYnXT8g49IpSVEBIBG38sISr96nzOgbo9ff
 H5+vv/qIAgY8L8BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F2C2139D1;
 Tue,  8 Aug 2023 15:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TaeLFTdi0mRhWQAAMHmgww
 (envelope-from <akumar@suse.de>); Tue, 08 Aug 2023 15:41:43 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Aug 2023 21:11:40 +0530
Message-ID: <20230808154141.23780-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] gethostname01: Fix docparse format and make check
 warning
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/gethostname/gethostname01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/gethostname/gethostname01.c b/testcases/kernel/syscalls/gethostname/gethostname01.c
index ff8c342d8..f2276a38c 100644
--- a/testcases/kernel/syscalls/gethostname/gethostname01.c
+++ b/testcases/kernel/syscalls/gethostname/gethostname01.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2023 SUSE LLC Ioannis Bonatakis <ybonatakis@suse.com>
  */
 
-/*
+/*\
  * [Description]
  *
  * Test is checking that gethostname() succeeds.
@@ -16,6 +16,7 @@
 static void run(void)
 {
 	char hname[100];
+
 	TST_EXP_PASS(gethostname(hname, sizeof(hname)));
 }
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
