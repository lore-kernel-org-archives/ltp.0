Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E86C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 20:18:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 754A63C920F
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 21:18:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE8C63C042E
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 21:18:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 482EF20035F
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 21:18:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 713771F3B4;
 Mon, 20 Dec 2021 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640031501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xF8UI9FgWc1Smu0QRAF/jpx5r67aCeVdf44ZbpLSTMA=;
 b=1xMtXzg4enJslcRTvy1lkewlpK5F9CiE22WI1oxZIAryf5fcepiEpbwXyrt9o7Gw+ZdAvV
 np8aAn5A07DexYa8LAuV2TJ8bzpDT/ear1sUICg7/lnFtUux/LlhSCe9r5vFGmLAQkT1ZF
 hWceDTI+KSLH86wjxi+6v4WvOIzOMFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640031501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xF8UI9FgWc1Smu0QRAF/jpx5r67aCeVdf44ZbpLSTMA=;
 b=92uOj5at9AJg1p7Uy1dxCS7BBkN3T6DJpbomyI45Ek2TNkiSrnLjJlPjqAXNvw9fouIBm1
 7LfgoaC7agJvScBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2904B13DBD;
 Mon, 20 Dec 2021 20:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W8IqBg3lwGH9LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 20:18:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Dec 2021 21:18:14 +0100
Message-Id: <20211220201814.31596-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] sched_get_priority_max01: Add more policies
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../sched_get_priority_max/sched_get_priority_max01.c    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index a1c54efd0e..0d01317033 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -13,6 +13,8 @@
  * compare them with expected value.
  */
 
+#define _GNU_SOURCE
+
 #include <sched.h>
 #include "lapi/syscalls.h"
 #include "tst_test.h"
@@ -24,9 +26,12 @@ static struct test_case {
 	int policy;
 	int retval;
 } tcases[] = {
-	{POLICY_DESC(SCHED_OTHER), 0},
+	{POLICY_DESC(SCHED_BATCH), 0},
+	{POLICY_DESC(SCHED_DEADLINE), 0},
 	{POLICY_DESC(SCHED_FIFO), 99},
-	{POLICY_DESC(SCHED_RR), 99}
+	{POLICY_DESC(SCHED_IDLE), 0},
+	{POLICY_DESC(SCHED_OTHER), 0},
+	{POLICY_DESC(SCHED_RR), 99},
 };
 
 static void run_test(unsigned int nr)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
