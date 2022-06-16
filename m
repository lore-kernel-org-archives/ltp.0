Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9BEC433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 14:08:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E21E33C19CA
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 16:08:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D267E3C62DD
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 16:07:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F1C68600699
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 16:07:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3A0421BDA;
 Thu, 16 Jun 2022 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1655388445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgqlsNQCrj+wB8qa02orTSnoyqo5p3N8+WC0O3rY44Q=;
 b=ot7TErx71waueP6eVo/pX+v1tO8af5f8I5OCW+9R6J2mwiT60dgXgbEZclZ8wF9j7dGJj4
 69NhKPqcZnUd9u5KNXVkm/nMxzLQpYX5Q5QdkLFCmrt2djc2j6jr6VCVbGgIIHFtmYPLEA
 5ptCly5Mx+yUcyhTZLVF3uVhgIVm/8E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7860F13A70;
 Thu, 16 Jun 2022 14:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kMEfGx05q2IlJwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 16 Jun 2022 14:07:25 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Jun 2022 16:07:17 +0200
Message-Id: <20220616140717.23708-8-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616140717.23708-1-andrea.cervesato@suse.com>
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/7] Rename common.h into mqns.h for mqns suite
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
 testcases/kernel/containers/mqns/{common.h => mqns.h} | 8 ++++----
 testcases/kernel/containers/mqns/mqns_01.c            | 2 +-
 testcases/kernel/containers/mqns/mqns_02.c            | 2 +-
 testcases/kernel/containers/mqns/mqns_03.c            | 2 +-
 testcases/kernel/containers/mqns/mqns_04.c            | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename testcases/kernel/containers/mqns/{common.h => mqns.h} (94%)

diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/mqns.h
similarity index 94%
rename from testcases/kernel/containers/mqns/common.h
rename to testcases/kernel/containers/mqns/mqns.h
index 58ddfe5f4..a1ea86a53 100644
--- a/testcases/kernel/containers/mqns/common.h
+++ b/testcases/kernel/containers/mqns/mqns.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-#ifndef MQNS_COMMON_H
-#define MQNS_COMMON_H
+#ifndef MQNS_H
+#define MQNS_H
 
 #include <stdlib.h>
 #include "lapi/namespaces_constants.h"
@@ -23,7 +23,7 @@ static int dummy_child1(void *v)
 	return 0;
 }
 
-static void check_newipc(void)
+static inline void check_newipc(void)
 {
 	int pid, status;
 
@@ -98,4 +98,4 @@ static void clone_unshare_test(int use_clone, unsigned long clone_flags,
 	}
 }
 
-#endif /* MQNS_COMMON_H */
+#endif /* MQNS_H */
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index 40f08fa77..33613ed4e 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -12,7 +12,7 @@
  * the isolated/forked child namespace.
  */
 
-#include "common.h"
+#include "mqns.h"
 
 #define MQNAME "/MQ1"
 
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index e04e23de4..2a6febbe1 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -12,7 +12,7 @@
  * then check namespace isolation.
  */
 
-#include "common.h"
+#include "mqns.h"
 
 #define MQNAME "/MQ1"
 
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index 0a9311fbd..ac0c67e6d 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -25,7 +25,7 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
-#include "common.h"
+#include "mqns.h"
 #include "tst_safe_stdio.h"
 
 #define MQNAME1 "/MQ1"
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index 95ff18ef2..b3f538592 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -24,7 +24,7 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
-#include "common.h"
+#include "mqns.h"
 #include "tst_safe_stdio.h"
 
 #define CHECK_MQ_OPEN_RET(x) ((x) >= 0 || ((x) == -1 && errno != EMFILE))
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
