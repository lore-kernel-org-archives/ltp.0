Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B43CD3423
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 08:07:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66D523E2C7F
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:07:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B0843E4AC0
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:06:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3ED2F140044F
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:06:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30E356AAD2;
 Mon,  4 May 2026 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777882001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMLqtNRfmvrKgY2g5U0csxbJvcICXOuSWNBmd7rjq/U=;
 b=JrTX9hATqYDUK1bm/ci+rhyxI2G9kIqrUEAzzf3qCrjEcR6jbBiaQaZL5WQpQOrWnaCV3p
 DiANeunJkhxCaRaIQ/etn/aAsaPXigd0ZWydLCDrmXrX/lFO9jelRjPdJ4Z9OIcznjfdRU
 g4dtCj11lsCYika/InxhEbImNpis7zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777882001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMLqtNRfmvrKgY2g5U0csxbJvcICXOuSWNBmd7rjq/U=;
 b=S23JeaLoHboSeItAJ8TzPBqoEeTLqyoliUDfp0Ug4VexsexFZXncUt/Qei/VAFBqBrK1dZ
 TRHwHMuk76mCe2Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777882001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMLqtNRfmvrKgY2g5U0csxbJvcICXOuSWNBmd7rjq/U=;
 b=JrTX9hATqYDUK1bm/ci+rhyxI2G9kIqrUEAzzf3qCrjEcR6jbBiaQaZL5WQpQOrWnaCV3p
 DiANeunJkhxCaRaIQ/etn/aAsaPXigd0ZWydLCDrmXrX/lFO9jelRjPdJ4Z9OIcznjfdRU
 g4dtCj11lsCYika/InxhEbImNpis7zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777882001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMLqtNRfmvrKgY2g5U0csxbJvcICXOuSWNBmd7rjq/U=;
 b=S23JeaLoHboSeItAJ8TzPBqoEeTLqyoliUDfp0Ug4VexsexFZXncUt/Qei/VAFBqBrK1dZ
 TRHwHMuk76mCe2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17DA4593A3;
 Mon,  4 May 2026 08:06:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gKRUBJFT+GktTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 08:06:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 10:04:55 +0200
MIME-Version: 1.0
Message-Id: <20260504-safe_splice-v2-2-aa7eaa6b5ed7@suse.com>
References: <20260504-safe_splice-v2-0-aa7eaa6b5ed7@suse.com>
In-Reply-To: <20260504-safe_splice-v2-0-aa7eaa6b5ed7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777882000; l=1789;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=p0YHGOST3qEJCVhtCCknzR+cMPal4AFtUeGAa5lVitU=;
 b=7XFSkD5xwCccoFPadAlSnTZVkJCUdHWm+rtAT5lErb39cf43WvQPYB3R1asKuadZU2PdBNDz3
 RAsucnCC2OhDq+S+Nq+JMN9NRvC9gmMLdhb89S+reT7ZPsS27YM+igk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] tee01, vmsplice01, af_alg08: Use SAFE_SPLICE()
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Replace raw splice() calls with SAFE_SPLICE() in tests where splice is
utility plumbing, not the subject of testing.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/crypto/af_alg08.c              | 1 +
 testcases/kernel/syscalls/tee/tee01.c           | 1 +
 testcases/kernel/syscalls/vmsplice/vmsplice01.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
index 05f17eea4797b7575c97e194e34c0390c6d6be22..5517a7cec31f56c6769d0a5ac37d20477986c3f0 100644
--- a/testcases/kernel/crypto/af_alg08.c
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -27,6 +27,7 @@
 #include "tst_test.h"
 #include "tst_af_alg.h"
 #include "lapi/socket.h"
+#include "lapi/splice.h"
 
 #define TESTFILE "copy_fail"
 #define OVERWRITE_SIZE 4
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 680793eb2b21cfd2609492d3be3bef10abb25acf..24d1b6e4810492e4e4761038fd88505d1df8e49c 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -14,6 +14,7 @@
 
 #include "tst_test.h"
 #include "lapi/fcntl.h"
+#include "lapi/splice.h"
 #include "lapi/tee.h"
 
 #define TEST_BLOCK_SIZE 1024
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 7b55e66a373d2d72824fbb9146b2af353a5ff1c9..64eed8391797fb01b14c548ebcfe390a403da5ec 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -15,6 +15,7 @@
 
 #include "tst_test.h"
 #include "lapi/fcntl.h"
+#include "lapi/splice.h"
 #include "lapi/vmsplice.h"
 
 #define TEST_BLOCK_SIZE (1<<17)	/* 128K */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
