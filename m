Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F6AC43334
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 12:06:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D69063C9F94
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 14:06:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A3C83C9F80
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 14:05:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D52CE200B7B
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 14:05:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8218E348BE;
 Fri, 22 Jul 2022 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1658491537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkgjROSg6sXfpjD0lPnV4Zg1oz6x7GkezZWCOLJMw4c=;
 b=inM6Zsl+vDqbvpsteFvGjuY2T5K++OXO1SwUdG+fx8Qp/D2hpP3MRlf9B744bIRqVh5qTA
 HuXoKldWoGacYeYzwbz8ajWqySQqCA4u3MBR7XVh62k35wZmdWFbn+HLAnCpeSRFqLH9nA
 PKb0+VytMshuEa5oOvaNKespu7qiEzs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17370134A9;
 Fri, 22 Jul 2022 12:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uOpYO5CS2mJULwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 22 Jul 2022 12:05:36 +0000
To: ltp@lists.linux.it
Date: Fri, 22 Jul 2022 14:05:01 +0200
Message-Id: <20220722120501.28670-8-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722120501.28670-1-andrea.cervesato@suse.com>
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/7] Rename common.h into mqns.h for mqns suite
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
 testcases/kernel/containers/mqns/{common.h => mqns.h} | 0
 testcases/kernel/containers/mqns/mqns_01.c            | 2 +-
 testcases/kernel/containers/mqns/mqns_02.c            | 2 +-
 testcases/kernel/containers/mqns/mqns_03.c            | 2 +-
 testcases/kernel/containers/mqns/mqns_04.c            | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename testcases/kernel/containers/mqns/{common.h => mqns.h} (100%)

diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/mqns.h
similarity index 100%
rename from testcases/kernel/containers/mqns/common.h
rename to testcases/kernel/containers/mqns/mqns.h
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index a34dc4f66..7e62ab3d6 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -12,7 +12,7 @@
  * the isolated/forked child namespace.
  */
 
-#include "common.h"
+#include "mqns.h"
 
 #define MQNAME "/MQ1"
 
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index 4383fef73..59d483be7 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -12,7 +12,7 @@
  * then check namespace isolation.
  */
 
-#include "common.h"
+#include "mqns.h"
 
 #define MQNAME "/MQ1"
 
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index 5914a2a9b..54ba54304 100644
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
