Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2039DC433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 14:41:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AC983C92B9
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 15:41:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8790B3C92B9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:40:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F3A61600C75
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:40:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CD7F218E9;
 Tue, 25 Jan 2022 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643121649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwRzttwLtE7SXKeIiKh3b5zZlAb3l6Q8zdFx7Cmi5dI=;
 b=ngL+frDlHmJCWn+t9tkrbtinG2bJKFIzJmhaa1gjSlA7mscCte8sZmbezbagg+6W8WANJH
 dyHC3AcVc+XZN3Y7q2P+j6SBrEHO8oadhSlEMlBAZYXwOthd1zmxd9BYLPiovZP4stFixm
 suGS7jS71i5p60WPO8Kymd8ABcQeEDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643121649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwRzttwLtE7SXKeIiKh3b5zZlAb3l6Q8zdFx7Cmi5dI=;
 b=vosgweALzer47O+BDusmbVdPoT8vTJ271BBMgChyDfEPXbMPbdh9ZVtaMYG4817rV7Haq8
 xJnLl64dUX7ISrDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 220D713DEB;
 Tue, 25 Jan 2022 14:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8J+gBvEL8GGFdAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 14:40:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Jan 2022 15:40:40 +0100
Message-Id: <20220125144043.31798-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125144043.31798-1-pvorel@suse.cz>
References: <20220125144043.31798-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] lapi/sched.h: Add include <sched.h>
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

We including headers in lapi headers instead of depending headers are
included in tests which use lapi headers.

Also remove redundant include lapi/syscalls.h from tests which use
lapi/sched.h (included in lapi/sched.h).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 include/lapi/sched.h                                      | 3 ++-
 testcases/kernel/syscalls/kcmp/kcmp03.c                   | 1 -
 testcases/kernel/syscalls/sched_getattr/sched_getattr01.c | 2 --
 testcases/kernel/syscalls/sched_getattr/sched_getattr02.c | 2 --
 testcases/kernel/syscalls/sched_setattr/sched_setattr01.c | 1 -
 5 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 036edd51d1..2fc32a38ca 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -6,9 +6,10 @@
 #ifndef LAPI_SCHED_H__
 #define LAPI_SCHED_H__
 
-#include "lapi/syscalls.h"
+#include <sched.h>
 #include <stdint.h>
 #include <inttypes.h>
+#include "lapi/syscalls.h"
 
 struct sched_attr {
 	uint32_t size;
diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index 30ac3ec9db..df8633c5fc 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -18,7 +18,6 @@
 
 #include <errno.h>
 #include <stdlib.h>
-#include <sched.h>
 #include <sys/wait.h>
 #include "tst_test.h"
 #include "kcmp.h"
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
index 2a2c13a40f..0ffbce9c8d 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
@@ -22,11 +22,9 @@
 #include <linux/types.h>
 #include <sys/syscall.h>
 #include <pthread.h>
-#include <sched.h>
 #include <errno.h>
 
 #include "test.h"
-#include "lapi/syscalls.h"
 #include "lapi/sched.h"
 
 char *TCID = "sched_getattr01";
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
index 2d7e15a470..9f4a09f88f 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -31,11 +31,9 @@
 #include <linux/types.h>
 #include <sys/syscall.h>
 #include <pthread.h>
-#include <sched.h>
 #include <errno.h>
 
 #include "test.h"
-#include "lapi/syscalls.h"
 #include "lapi/sched.h"
 
 char *TCID = "sched_getattr02";
diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
index 37ca56a0aa..82156b95cb 100644
--- a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
@@ -29,7 +29,6 @@
 #include <linux/types.h>
 #include <sys/syscall.h>
 #include <pthread.h>
-#include <sched.h>
 #include <errno.h>
 
 #include "test.h"
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
