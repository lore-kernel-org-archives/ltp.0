Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0ACC6FA9D
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 15:31:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F1B93CDD68
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 16:31:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7BCF3CB124
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 16:30:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5802E1001396
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 16:30:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 860371FE1A;
 Wed,  1 Mar 2023 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677684623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDayqiprD00g+zF6WSbdd/wLux5xjUkopp0EhDYVODk=;
 b=rNWHU0qk2VzlQKXbJ7QgUFT8IKB4S/PY3gpLtb5F/v43olkixHqORyVpPt4hBKsszTs054
 hpL9JBKOi64OQhJQ+f2y3m/0HgvzLbs0kCO3Z/VVUYuR+3RmJCc4dFrOaPLo98kF7pIrV3
 SpsRidFAlCTgSoVDGcHfAOs2fa/9FYQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 621F513A3E;
 Wed,  1 Mar 2023 15:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aKATFo9v/2MjXgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 01 Mar 2023 15:30:23 +0000
To: ltp@lists.linux.it
Date: Wed,  1 Mar 2023 16:28:17 +0100
Message-Id: <20230301152818.4427-6-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230301152818.4427-1-andrea.cervesato@suse.com>
References: <20230301152818.4427-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/6] Remove deprecated header files from mqns suite
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/mqns/mqns.h       | 11 ----
 .../kernel/containers/mqns/mqns_helper.h      | 53 -------------------
 2 files changed, 64 deletions(-)
 delete mode 100644 testcases/kernel/containers/mqns/mqns.h
 delete mode 100644 testcases/kernel/containers/mqns/mqns_helper.h

diff --git a/testcases/kernel/containers/mqns/mqns.h b/testcases/kernel/containers/mqns/mqns.h
deleted file mode 100644
index 5a9056838..000000000
--- a/testcases/kernel/containers/mqns/mqns.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __MQNS_H
-#define __MQNS_H
-
-#define DEV_MQUEUE "/dev/mqueue"
-#define DEV_MQUEUE2 "/dev/mqueue2"
-#define SLASH_MQ1 "/MQ1"
-#define NOSLASH_MQ1 "MQ1"
-#define SLASH_MQ2 "/MQ2"
-#define NOSLASH_MQ2 "MQ2"
-
-#endif /* __MQNS_H */
diff --git a/testcases/kernel/containers/mqns/mqns_helper.h b/testcases/kernel/containers/mqns/mqns_helper.h
deleted file mode 100644
index 03f50aa36..000000000
--- a/testcases/kernel/containers/mqns/mqns_helper.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright (c) International Business Machines Corp., 2009
- * Copyright (c) Nadia Derbey, 2009
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Author: Serge Hallyn <serue@us.ibm.com>
- ***************************************************************************/
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <mqueue.h>
-#include "../libclone/libclone.h"
-#include "lapi/syscalls.h"
-#include "safe_macros.h"
-#include "test.h"
-
-static int dummy_child(void *v)
-{
-	(void) v;
-	return 0;
-}
-
-static void check_mqns(void)
-{
-	int pid, status;
-	mqd_t mqd;
-
-	mq_unlink("/checkmqnsenabled");
-	mqd =
-	    mq_open("/checkmqnsenabled", O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
-	if (mqd == -1)
-		tst_brkm(TCONF, NULL, "mq_open check failed");
-
-	mq_close(mqd);
-	mq_unlink("/checkmqnsenabled");
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, dummy_child, NULL);
-	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWIPC not supported");
-
-	SAFE_WAIT(NULL, &status);
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
