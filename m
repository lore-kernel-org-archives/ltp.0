Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D10C636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:20:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2B7F3CC441
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:20:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D4C33CBF1E
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0E86C1400C60
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5C1120570;
 Wed, 15 Feb 2023 10:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sbb9oAn3ydzA9nSPHzGe8fvqAkrqL3y0JV5b/GEzAF4=;
 b=uTMQBgmeBRkwA/jvshRcihQwN2ovK5ap8T4wHMunhR1X2LRaDt7R8ddqueOmZupLe9/UKq
 nVgoBjnpgIfc4NZrCqUHAsY5fRWtqdr4gytfrOAJQCty8O5N6uz4yzP8z4yUsMOpmU04es
 1K0oEtak+vttmR7a9fpNYfSyEtPj64M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7224A13483;
 Wed, 15 Feb 2023 10:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MKMJGW6x7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:22 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:15 +0100
Message-Id: <20230215101615.27534-11-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 10/10] Delete userns_helper.h from userns suite
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

userns_helper.h has been replaced by common.h inside the userns testing
suite.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/containers/userns/userns_helper.h  | 59 -------------------
 1 file changed, 59 deletions(-)
 delete mode 100644 testcases/kernel/containers/userns/userns_helper.h

diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
deleted file mode 100644
index be47690ea..000000000
--- a/testcases/kernel/containers/userns/userns_helper.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
- */
-
-#include "../libclone/libclone.h"
-#include "test.h"
-#include "safe_macros.h"
-#include <stdbool.h>
-
-#define UID_MAP 0
-#define GID_MAP 1
-
-static int dummy_child(void *v)
-{
-	(void) v;
-	return 0;
-}
-
-static int check_newuser(void)
-{
-	int pid, status;
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, dummy_child, NULL);
-	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUSER not supported");
-	SAFE_WAIT(NULL, &status);
-
-	return 0;
-}
-
-LTP_ATTRIBUTE_UNUSED static int updatemap(int cpid, bool type, int idnum,
-	int parentmappid, void (*cleanup)(void))
-{
-	char path[BUFSIZ];
-	char content[BUFSIZ];
-	int fd;
-
-	if (type == UID_MAP)
-		sprintf(path, "/proc/%d/uid_map", cpid);
-	else if (type == GID_MAP)
-		sprintf(path, "/proc/%d/gid_map", cpid);
-	else
-		tst_brkm(TBROK, cleanup, "invalid type parameter");
-
-	sprintf(content, "%d %d 1", idnum, parentmappid);
-	fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, content, strlen(content));
-	SAFE_CLOSE(cleanup, fd);
-	return 0;
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
