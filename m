Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4468BC433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:31:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10C973C935A
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 14:31:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCDD23C91EA
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 14:30:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6489A14010C3
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 14:30:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B210E21900;
 Tue, 15 Mar 2022 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647351049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxY2zi+R8X8JfWiva4dIZNV3TbDJHBC3mHONOhlY4/4=;
 b=dVAH/Fbi715ynPYvCd51DBCAkMVVitr/6sTEh5hgGcFLRjk4IiCHdJzRgAmzYTpRFiHOsS
 ggU60uc4NKh0/gIeh6lAzsQ2SJcO+BeEG9gpAixS9ovvw57m2PQ9lXm0Jfu/liJjnpsixI
 eC30rekuqJxBLGBdS8Fa4dSfKSB+auU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647351049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxY2zi+R8X8JfWiva4dIZNV3TbDJHBC3mHONOhlY4/4=;
 b=RCp6W2rJq1vmkd1tofZLApo1LRSUi/bB/B0cvEtAYTGNdhR+Aq3xCGMb6U8zNfXAKxKsiG
 r2kK2oHp/fShDdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8362313B4E;
 Tue, 15 Mar 2022 13:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SMUNHgmVMGLAbQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Mar 2022 13:30:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 14:30:48 +0100
Message-Id: <20220315133048.27193-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315122351.8556-2-andrea.cervesato@suse.de>
References: <20220315122351.8556-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Remove obsolete userns_helper.h from userns
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
This patch goes after [PATCH v2 8/8] Rewrite userns08.c using new LTP API

 .../kernel/containers/userns/userns_helper.h  | 62 -------------------
 1 file changed, 62 deletions(-)
 delete mode 100644 testcases/kernel/containers/userns/userns_helper.h

diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
deleted file mode 100644
index 12b491f62..000000000
--- a/testcases/kernel/containers/userns/userns_helper.h
+++ /dev/null
@@ -1,62 +0,0 @@
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
-	if (tst_kvercmp(3, 8, 0) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWUSER not supported");
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
-	SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
-	SAFE_CLOSE(cleanup, fd);
-	return 0;
-}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
