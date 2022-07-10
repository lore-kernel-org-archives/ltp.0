Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38AFC433EF
	for <ltp@archiver.kernel.org>; Sun, 10 Jul 2022 15:27:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 734D43CA490
	for <ltp@archiver.kernel.org>; Sun, 10 Jul 2022 17:27:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 955693CA56D
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 17:27:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 62DB5140044B
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 17:27:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4AC122269
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657466843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qa92Qm/v4TZxrjj9cfWg2oXXJ4S3RHvDAoDZhu64Z58=;
 b=lZZ1SEw+0pLSk53Av43nL7MN96P+xWLDUTvScvMMK60DYuxOgKFkNc4ci+1NFfFkCL1NDb
 NNFoKl9BxPrEyI4GBwFdOGinTOP9eBMfKBCx7EKYwAV2nYTI55BJKbDPQ8YooChgsli0dr
 SVOhz419heZ2LhXwkc5ckK+8pCiyEjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657466843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qa92Qm/v4TZxrjj9cfWg2oXXJ4S3RHvDAoDZhu64Z58=;
 b=rlK9t7GmIRAoH+td4DEeRz3xteXsbenrHFI6zQSSuPLfu++ZdFAMirNoKUe9YveSDqYsZx
 WNWcpBxyZzoaMcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43D95132FD
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 15:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ijDIAdvvymI8cwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 15:27:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Sun, 10 Jul 2022 20:57:17 +0530
Message-Id: <20220710152717.23849-2-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open02.c: docparse formatted comment
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
 testcases/kernel/syscalls/open/open02.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index bc7d04797..3c9cc7e17 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -4,11 +4,13 @@
  * Ported to LTP: Wayne Boyer
  *	06/2017 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */
-/*
- * DESCRIPTION
- *	1. open a new file without O_CREAT, ENOENT should be returned.
- *	2. open a file with O_RDONLY | O_NOATIME and the caller was not
- *	   privileged, EPERM should be returned.
+
+/*\
+ * [Description]
+ *
+ * 1. open a new file without O_CREAT, ENOENT should be returned.
+ * 2. open a file with O_RDONLY | O_NOATIME and the caller was not
+ * privileged, EPERM should be returned.
  */
 
 #define _GNU_SOURCE
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
