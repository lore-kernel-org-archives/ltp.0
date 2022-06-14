Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD89C43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 11:45:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40B0D3C9442
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 13:44:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04A9A3C8CA7
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 13:44:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 90BAA1000910
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 13:44:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D172A1F8F1
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655207087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yOy9tSiqxscqXak1tg4QHAynxNL0U82+KCtKFWtGPqw=;
 b=TgB5JAGGSiG9ulE1t/S/1+4bFsQPithH7lsjMX8yN2z7XFloroYGXJv847/eIYOCyse/6e
 JkBrxSvyMwFtrM936sbKtrwUbrcjLLbyNMRFXfvh6HfCTNAccNwKEqu179V4099RCSkHLx
 d6Ff2nzr/ui9b3kMOE2tmXwsELbeErs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655207087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yOy9tSiqxscqXak1tg4QHAynxNL0U82+KCtKFWtGPqw=;
 b=Hi3Yn1o5NMFtCIwQJaHDhhKZbwocvmLRopm+BhgTQWps/BHDU2eKFMljY/8QHzaoHIZ8V9
 2nvq+CsR3khqr0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFAFD139EC
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 11:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JXTILa90qGJkeAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 11:44:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Jun 2022 13:46:55 +0200
Message-Id: <20220614114655.9676-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] syscalls/futex_cmp_requeue01: Remove
 unused tst_timer_test.h
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/futex/futex_cmp_requeue01.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index bef44838e..872704467 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -14,7 +14,6 @@
 #include <stdlib.h>
 #include <sys/time.h>
 
-#include "tst_timer_test.h"
 #include "tst_test.h"
 #include "futextest.h"
 #include "lapi/futex.h"
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
