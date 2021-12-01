Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEF0C433EF
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 11:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C089D3C8F93
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 12:19:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 745703C8BC0
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 12:19:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 869D6140115C
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 12:19:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F0981FD34
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638357587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VpxG4Pe9bcC82pGx2sor0sTYWbR95CcNLknrgpI3pRc=;
 b=xHd2cPIYGOptVHgksHyv1zL6gy+dU3bzzpKQfM89Yz4pezD/5QLMwUu29h9VfWYmuKsTCO
 PgrDsuaqxmRBwRcP8LCDzo6b+V+DnpTf77RF1FkuYEY87yelReghX9auy+j81pb9gDtYbA
 RAQZal1KIVueEKVLDTGlVXinM4JkJWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638357587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VpxG4Pe9bcC82pGx2sor0sTYWbR95CcNLknrgpI3pRc=;
 b=xcleZHhgVrbQLEqnpie62moqLP4w2hwFv2DYxw/Ukg6WKAMcNDrcbUHvGUZn3DzJrptUXP
 IYODQLCOL8UF65CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 056AB13BA8
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 11:19:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wuO6N1Jap2GafwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 01 Dec 2021 11:19:46 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  1 Dec 2021 12:20:59 +0100
Message-Id: <20211201112059.8173-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] checkpoints: Fix WAIT/WAKE macros
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

There shouldn't be semicolons there in the first place and
the WAKE_AND_WAIT() should have been wrapped in do { } while (0).

This fixes the usage of the macros in if () conditions with a single
line as:

	if (foo)
		TST_CHECKPOINT_WAKE_AND_WAIT(0);

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_checkpoint.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index 5c8067d0d..1b6911d73 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -8,20 +8,21 @@
 #include "tst_checkpoint_fn.h"
 
 #define TST_CHECKPOINT_WAIT(id) \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0);
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0)
 
 #define TST_CHECKPOINT_WAIT2(id, msec_timeout) \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, msec_timeout);
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, msec_timeout)
 
 #define TST_CHECKPOINT_WAKE(id) \
-        tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1);
+        tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1)
 
 #define TST_CHECKPOINT_WAKE2(id, nr_wake) \
-        tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, nr_wake);
+        tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, nr_wake)
 
-#define TST_CHECKPOINT_WAKE_AND_WAIT(id) \
+#define TST_CHECKPOINT_WAKE_AND_WAIT(id) do { \
         tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1); \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0);
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0); \
+} while (0)
 
 extern const char *tst_ipc_path;
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
