Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38111C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 10:34:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F233C920E
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 11:34:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 828863C9216
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 11:33:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 611C92009DE
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 11:33:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 083C41F391;
 Tue, 15 Mar 2022 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647340384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0w3Qyf5dcIQcXwt5zZqWtEJYXfBKD8QYgjyHujCFZe8=;
 b=VajZQeKbtQl1DqBkObWAZKnoi2DxlfasyqFTEMfR6vi3hkLOFeS21FSoUhik2BYQzwslsL
 E9lRtoNTJDdpBFNYfF3iKlheAFojyvBTGBMxskkLBzQlGSj0bZspnFC4vBe5CyZnwe9Rnv
 4j8qwsd94CMky8kzNBveV7KquwD3/SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647340384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0w3Qyf5dcIQcXwt5zZqWtEJYXfBKD8QYgjyHujCFZe8=;
 b=m42dwvbONmx5ulUeJzbEtnOnfIM/0ISP/5zS3vrJw84EtDb0GZTndkDRTs7sYSJcTImsci
 iGoulkaq+9lnElAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C155513B59;
 Tue, 15 Mar 2022 10:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aBVKKV9rMGKHHwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Mar 2022 10:33:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 11:32:54 +0100
Message-Id: <20220315103254.7185-11-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315103254.7185-1-andrea.cervesato@suse.de>
References: <20220315103254.7185-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 10/10] Delete ipcns_helper.h in the sysvipc test
 suite
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 .../kernel/containers/sysvipc/ipcns_helper.h  | 41 -------------------
 1 file changed, 41 deletions(-)
 delete mode 100644 testcases/kernel/containers/sysvipc/ipcns_helper.h

diff --git a/testcases/kernel/containers/sysvipc/ipcns_helper.h b/testcases/kernel/containers/sysvipc/ipcns_helper.h
deleted file mode 100644
index 01ad0fff6..000000000
--- a/testcases/kernel/containers/sysvipc/ipcns_helper.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
-* Copyright (c) International Business Machines Corp., 2007
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-* Author: Rishikesh K Rajak <risrajak@in.ibm.com>
-***************************************************************************/
-#include <sched.h>
-#include "../libclone/libclone.h"
-#include "test.h"
-#include "safe_macros.h"
-
-static int dummy_child(void *v)
-{
-	(void) v;
-	return 0;
-}
-
-static void check_newipc(void)
-{
-	int pid, status;
-
-	if (tst_kvercmp(2, 6, 19) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWIPC not supported");
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, dummy_child, NULL);
-	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWIPC not supported");
-
-	SAFE_WAIT(NULL, &status);
-}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
