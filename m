Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7ACC433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:38:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 686AF3C88F8
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:37:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 644A53C5A8A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 016C31001268
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8ED1321110;
 Fri, 25 Mar 2022 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648200990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OERBM4ZwfNVTtN7b6cNOEaDKCXhNarmeDAB9OWCClzA=;
 b=Cne4aISw+ONmeK/sqRZ0P2GSO7q0O54hrO8kxyP8ZuJzO8qFliqLo4l/pV7MLcbQQC3Lsy
 zJgCTpRYROQIeQ8bx2dIoh20+NVzqk5C0uID2+TsuR4DmrSWiYkQHMosSLmJWBJzoyi85O
 2px+nHIvJ59F9m8p4ZtUlT9s9sx0yko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648200990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OERBM4ZwfNVTtN7b6cNOEaDKCXhNarmeDAB9OWCClzA=;
 b=GSrYgyEclv3e4PF1AwHPYjJ3HpUaxOdj6gOrjpj6INWLIAm4WflYPl4SAIbeEqYZbxqJkb
 dIdCUZjimTetESCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 594A2132E9;
 Fri, 25 Mar 2022 09:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OPPUEx6NPWI1BQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 09:36:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 10:36:26 +0100
Message-Id: <20220325093626.11114-10-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325093626.11114-1-andrea.cervesato@suse.de>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 9/9] Remove obsolete userns_helper.h from userns
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
