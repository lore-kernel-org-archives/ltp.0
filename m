Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B9DC433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 13:34:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F2F93CA296
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 14:34:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92B233C9DD8
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 14:33:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED908600C48
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 14:33:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8BD031F8AA;
 Mon, 28 Feb 2022 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646055180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqBlbxhEu9KV6hO3BSohNjecDYKqvwWX2EzoPRvrTmg=;
 b=CovAB0jgWpXuZAOAmPjAE2pVsNEF3olkbcLrQOEta+SKd5P2siaThCsXTYA5xzPPHj7k0i
 KwYwLKrTBrolNFM5ZodjR2Wq6tS07u4bA2X8QHM0kHNcUtoywowbgzpkL1Jz7rOR1Vfmr4
 Y0j5RJmZj3ObswdjnGegNvRjivVo2B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646055180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqBlbxhEu9KV6hO3BSohNjecDYKqvwWX2EzoPRvrTmg=;
 b=VUZ+WX87Q3akOGTmxZFPt89NWCUPuxOLD6Wmfxv9q3hNaIoaJgug5UKxh5Jdiwtjh9eJV1
 4bw3z2PJ5g8lPMAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BAC613C44;
 Mon, 28 Feb 2022 13:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8HzAEwzPHGKhRQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 28 Feb 2022 13:33:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 28 Feb 2022 14:32:55 +0100
Message-Id: <20220228133256.12763-6-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228133256.12763-1-andrea.cervesato@suse.de>
References: <20220228133256.12763-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/6] Removed obsolete mountns_helper.h
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

After refactoring mountns testing suite, helper is no longer needed
since it has been replaced by mountns.h

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 .../containers/mountns/mountns_helper.h       | 61 -------------------
 1 file changed, 61 deletions(-)
 delete mode 100644 testcases/kernel/containers/mountns/mountns_helper.h

diff --git a/testcases/kernel/containers/mountns/mountns_helper.h b/testcases/kernel/containers/mountns/mountns_helper.h
deleted file mode 100644
index 4b4538eb8..000000000
--- a/testcases/kernel/containers/mountns/mountns_helper.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* Copyright (c) 2014 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of version 2 the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "libclone.h"
-#include "test.h"
-#include "safe_macros.h"
-
-#define DIRA "A"
-#define DIRB "B"
-
-static int dummy_child(void *v)
-{
-	(void) v;
-	return 0;
-}
-
-static int check_newns(void)
-{
-	int pid, status;
-
-	if (tst_kvercmp(2, 4, 19) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWNS not supported");
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWNS, dummy_child, NULL);
-	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWNS not supported");
-	SAFE_WAIT(NULL, &status);
-
-	return 0;
-}
-
-static void cleanup(void)
-{
-	umount(DIRA);
-	umount(DIRB);
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	tst_require_root();
-	check_newns();
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(tst_rmdir);
-	SAFE_MKDIR(cleanup, DIRA, 0777);
-	SAFE_MKDIR(cleanup, DIRB, 0777);
-	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
-	SAFE_TOUCH(cleanup, DIRB"/B", 0, NULL);
-}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
