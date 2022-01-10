Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0DCC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 13:00:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C3E03C93A8
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 14:00:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB8B23C0EC5
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 14:00:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ECF87200FCA
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 14:00:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F8F51F395
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641819604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AAGzuhDegQEc/6qy9tXtoT+SFsK2PWAqqvGHs0xT4Ow=;
 b=hAF8xaBMw6ApErDPoesk9LMWoFWzQ1eFj8ft8zLlrTBtIVj3HeQhVTkjBSLAI37TIw08qH
 EKyNCyar38Rpb6FTWrIfRxfBaqdlFHmKGDzT7+X6SrK60S00nQj3kzpKTdKv3+07HDQbyr
 UqpN53W/Wv8k04EnES/ZWQ47L5mE598=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641819604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AAGzuhDegQEc/6qy9tXtoT+SFsK2PWAqqvGHs0xT4Ow=;
 b=/5G7NMQks62rEBjUrgU+ufM4qJSlwVHygpEzfOCmWaEYRmUetCm+Jnf1QHKp0b8rP1NkxD
 oL5u8sSPSLqVdcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CE3113D58
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 13:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5nhKCdQt3GExJwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 13:00:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Jan 2022 14:01:38 +0100
Message-Id: <20220110130138.25855-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] quotaclt: Fix build faliures in metadata
 parser
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

The current parser has many limitations, one of them is that it only
parses headers directly included by the test hence the quotactl tests
have to directly include the header that defines the number of variants.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/quotactl/quotactl02.c | 1 +
 testcases/kernel/syscalls/quotactl/quotactl05.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 56fa23b9d..c16e0a3f8 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -26,6 +26,7 @@
  */
 
 #include "quotactl02.h"
+#include "quotactl_syscall_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 static uint32_t qflagu = XFS_QUOTA_UDQ_ENFD;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index e56e191df..541007e97 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -19,6 +19,7 @@
  */
 
 #include "quotactl02.h"
+#include "quotactl_syscall_var.h"
 #if defined(HAVE_XFS_XQM_H)
 
 static uint32_t qflagp = XFS_QUOTA_PDQ_ENFD;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
