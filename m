Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE4C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 20:35:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F184F3C948F
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 22:35:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B9E13C4D12
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BB55C1400536
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E9671F95A;
 Mon, 13 Jun 2022 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655152433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8WdQA6GIuyUWCZyvA1PXR1m8TLjaDPcrHSAHZcecN4=;
 b=R7pnbmmwCVXX6slEHOvVr0FS1GzPtng5pyY6C+9OuhoXR3cVZ77wcQubcqjABGRV+cqrr9
 sjHWiVy+j7tMm7PCnVRFAMoXTR0XE+OdkqDugFl7TxtPT0QQHy0ctkyKgjODy+NrzdwbaI
 iPB71jxJoNylC/Y7hoHhr+lkDc7GR6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655152433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8WdQA6GIuyUWCZyvA1PXR1m8TLjaDPcrHSAHZcecN4=;
 b=GQGDLoEaNjherZAvHfK8mZ7rDl3esKvAP1vhOl3HeseCZTMGf/Nlab4E93j3lh4x7Oep++
 33NrNvra+76iiLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33946134CF;
 Mon, 13 Jun 2022 20:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gIRlCTGfp2L3QgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jun 2022 20:33:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 13 Jun 2022 22:33:32 +0200
Message-Id: <20220613203333.24839-6-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220613203333.24839-1-andrea.cervesato@suse.de>
References: <20220613203333.24839-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 5/6] Delete header files from mqns tests
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
 testcases/kernel/containers/mqns/Makefile     | 27 ++-------
 testcases/kernel/containers/mqns/mqns.h       | 11 ----
 .../kernel/containers/mqns/mqns_helper.h      | 56 -------------------
 3 files changed, 5 insertions(+), 89 deletions(-)
 delete mode 100644 testcases/kernel/containers/mqns/mqns.h
 delete mode 100644 testcases/kernel/containers/mqns/mqns_helper.h

diff --git a/testcases/kernel/containers/mqns/Makefile b/testcases/kernel/containers/mqns/Makefile
index 64c3763ee..eb0f97c2b 100644
--- a/testcases/kernel/containers/mqns/Makefile
+++ b/testcases/kernel/containers/mqns/Makefile
@@ -1,29 +1,12 @@
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2009                 ##
-## Copyright (c) Nadia Derbey, 2009                                           ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
+# Copyright (c) Nadia Derbey, 2009 
+# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lpthread -lrt -lclone $(LDLIBS)
+LDLIBS			:= -lpthread -lrt $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
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
index 605378d48..000000000
--- a/testcases/kernel/containers/mqns/mqns_helper.h
+++ /dev/null
@@ -1,56 +0,0 @@
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
-	if (tst_kvercmp(2, 6, 30) < 0)
-		tst_brkm(TCONF, NULL, "Kernel version is lower than expected");
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
