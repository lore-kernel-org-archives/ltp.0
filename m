Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECC6C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 13:50:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 898BA3C9EF3
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 14:50:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B57023C9B4B
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 14:50:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 31BD46010E6
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 14:50:16 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6A3721F3A8;
 Fri, 11 Feb 2022 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644587416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=psVWXUYjWqsIOj8zmpFXEYCliHzn0QAG4gJt9VpOyV0=;
 b=eE1YGqVCHEk9WtqtUq+AJntczMTaysmdVJbAgAno0dGxb7GafIwDNXrhLnDSXcKdtw/VUK
 6y1A5CNXwYqBrpxeJ/2yJ84VsDNR0/8Qib+0K2YT1hdun5qVpxXbchS92JAWf+mY5OizOq
 pEQtUJP31/C7st5nJjX7klJmXlcVm4o=
Received: from localhost.de (unknown [10.163.30.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 35017A3B8B;
 Fri, 11 Feb 2022 13:50:16 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 15:50:13 +0200
Message-Id: <20220211135013.27443-1-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] syscalls/swapping01: Use .needs_kconfigs instead
 of .setup
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
From: Bogdan Lezhepekov via ltp <ltp@lists.linux.it>
Reply-To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

needs_kconfigs is more beneficial for docparser

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 3b4f0a61a..f6133cc0d 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -155,18 +155,15 @@ static void check_swapping(void)
 	SAFE_WAITPID(pid, &status, 0);
 }
 
-static void setup(void)
-{
-	if (access("/proc/swaps", F_OK))
-		tst_brk(TCONF, "swap not supported by kernel");
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.min_mem_avail = 10,
 	.test_all = test_swapping,
-	.setup = setup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SWAP=y",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "50a15981a1fa"},
 		{}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
