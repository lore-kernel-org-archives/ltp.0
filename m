Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68301C64EC7
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:20:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC6A53CBF0C
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:20:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2F943CBF0D
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8578D200A01
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D2DC227CC;
 Wed, 15 Feb 2023 10:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJ0hYdNdQweKJ3aGAWxnZwQ2qtqUffOOJ7qihAs5M1M=;
 b=PeeGP8b8bJ5JCXNeH2UAlxC2uInV+hvAHF7bNDWoKvIEEN86ecJVBLw+pN6hKwPxT2BjXs
 6byPs0b1AFvS/AB6WF2tZ8yI4B8qzL3j+v3S8glnHf9pGIrpTD09Hz1Z00MXxM1UdBrnN7
 IWLv8kPgc1VB170LCYi5u5PnHeI9Dig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF0DB13483;
 Wed, 15 Feb 2023 10:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CKDNL22x7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:21 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:13 +0100
Message-Id: <20230215101615.27534-9-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215101615.27534-1-andrea.cervesato@suse.com>
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 08/10] Remove check_newuser from userns testing
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CLONE_NEWUSER is supported from kernel 3.8 and LTP supports all
kernels >= 3.10. For this reason, we can remove any check for
CLONE_NEWUSER support and to make userns common.h a bit simpler.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/userns/common.h | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/testcases/kernel/containers/userns/common.h b/testcases/kernel/containers/userns/common.h
index 635d0f190..9b3a47b69 100644
--- a/testcases/kernel/containers/userns/common.h
+++ b/testcases/kernel/containers/userns/common.h
@@ -8,35 +8,17 @@
 #define COMMON_H
 
 #include "tst_test.h"
-#include "lapi/sched.h"
 
 #define UID_MAP 0
 #define GID_MAP 1
 
-static int dummy_child(void *v)
-{
-	(void)v;
-	return 0;
-}
-
-static inline void check_newuser(void)
-{
-	int pid, status;
-
-	pid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, dummy_child, NULL);
-	if (pid == -1)
-		tst_brk(TCONF | TTERRNO, "CLONE_NEWUSER not supported");
-
-	SAFE_WAIT(&status);
-}
-
 static inline void updatemap(int cpid, int type, int idnum, int parentmappid)
 {
 	char path[BUFSIZ];
 	char content[BUFSIZ];
 	int fd;
 
-	switch(type) {
+	switch (type) {
 	case UID_MAP:
 		sprintf(path, "/proc/%d/uid_map", cpid);
 		break;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
