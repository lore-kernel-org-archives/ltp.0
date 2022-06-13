Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911F9CCA47B
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 20:35:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9C6D3C9468
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 22:35:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78A643C91E8
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1302F200388
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B92BD21A26;
 Mon, 13 Jun 2022 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655152433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYPMeVbEpCqbc4Kcon8LoojRKKZyHkwo1Kl6rjcLIBw=;
 b=jiMHLDatKCv0nBQ4GXRkTYM4l4aqFOSi5G61kC/ULeS08HOVZVF0x/8Yl8wyY8Qj+6xiq6
 Eco0JMXH6cc5J7mU6kxhstBEs+CDRevBh90LwVNJqJgV/CganqfT2G7xsHiW9Ke7ub8gPS
 cezNCuYcTn3hQsDZtz7N6Nr7awMxcAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655152433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYPMeVbEpCqbc4Kcon8LoojRKKZyHkwo1Kl6rjcLIBw=;
 b=Esp7jNT5k8r6Vce9qJ+lHrTYDYej5IySv6VLqUilXT+secYulgzq/ZJ36xvFiGuIMvrhLk
 i4HHT5j2nAr0bgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81929134CF;
 Mon, 13 Jun 2022 20:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aG+JHDGfp2L3QgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jun 2022 20:33:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 13 Jun 2022 22:33:33 +0200
Message-Id: <20220613203333.24839-7-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220613203333.24839-1-andrea.cervesato@suse.de>
References: <20220613203333.24839-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 6/6] Rename common header in mqns test suite
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
index e6ebe0ea8..8521c5448 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -13,7 +13,7 @@
  */
 
 #include <mqueue.h>
-#include "common.h"
+#include "mqns.h"
 
 #define MQNAME "/MQ1"
 
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index b2130b624..27c1d86fe 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -13,7 +13,7 @@
  */
 
 #include <mqueue.h>
-#include "common.h"
+#include "mqns.h"
 
 #define MQNAME "/MQ1"
 
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index 51909217d..67a6be1e2 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -27,7 +27,7 @@
 #include <stdio.h>
 #include <mqueue.h>
 #include "tst_safe_stdio.h"
-#include "common.h"
+#include "mqns.h"
 
 #define MQNAME1 "/MQ1"
 #define MQNAME2 "/MQ2"
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index ce7a86e64..76604d666 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -26,7 +26,7 @@
 #include <stdio.h>
 #include <mqueue.h>
 #include "tst_safe_stdio.h"
-#include "common.h"
+#include "mqns.h"
 
 #define CHECK_MQ_OPEN_RET(x) ((x) >= 0 || ((x) == -1 && errno != EMFILE))
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
