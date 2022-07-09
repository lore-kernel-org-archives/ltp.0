Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3525FC43334
	for <ltp@archiver.kernel.org>; Sat,  9 Jul 2022 16:50:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C9F63CA3B0
	for <ltp@archiver.kernel.org>; Sat,  9 Jul 2022 18:50:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A542A3CA375
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 18:50:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 14C5E6006C4
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 18:50:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F42621F3D
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657385410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gSWRMR4MGgCXOl0DUyfnQ0FVG8/dFi9At3ZTGrZFjik=;
 b=C3Rc0qbiZK56UuMr3AANT0My4rEh0rHrIN4xVXu0NjZuznOOSyQSuO4r52dmlwlrBCTEvQ
 R8m264FJwizYCLNXqOU4DQdIPih+rfFq2h/lzciDrC3OFBAruTPLOWmmWqnhffmvVibRP9
 1sgon7hjZL0i4+v6FUXENv1XyMMPRzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657385410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gSWRMR4MGgCXOl0DUyfnQ0FVG8/dFi9At3ZTGrZFjik=;
 b=eB6h4qObOkTBArkgDUspNPbfWrvkWG5aAXiAta1yrNCLvXV7KMrNIpH+AXHY/lAUfqJIrN
 dNYHRLB2O86GiOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE70D13482
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 16:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mEjnJsGxyWJjagAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Sat, 09 Jul 2022 16:50:09 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Sat,  9 Jul 2022 22:20:00 +0530
Message-Id: <20220709165000.27830-3-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open08.c: Remove redundant headers
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
 testcases/kernel/syscalls/open/open08.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 8bb151447..10f55fb90 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -36,16 +36,8 @@
  */
 
 #define _GNU_SOURCE		/* for O_DIRECTORY */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <stdio.h>
-#include <errno.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-#include <signal.h>
 #include <pwd.h>
 #include "tst_test.h"
-#include "tst_get_bad_addr.h"
 
 static char *existing_fname = "open08_testfile";
 static char *toolong_fname = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
