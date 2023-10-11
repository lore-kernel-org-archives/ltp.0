Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9A4CD98EA
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 16:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FC883CFF35
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 18:08:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6EC73CD60D
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:08:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 086881400BE8
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:08:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 135861FEFF;
 Wed, 11 Oct 2023 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697040506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0oYHexrwi8Xds9QIhall2Ly/pFJQuTl8qKl5nKRl84=;
 b=DEjFDNtqDDNjOtL9Ocy5220N1A8BkTELGx9cB/Ei/JMfHMh2H4277bGqYytHsRWUuIvKoq
 8u5HIp79Ti2lRbxYj2VDJ6fSFbaPvOzO8FIwaR0pAyPUaq+3rr6mPKzWaGcc0uU8yV6Wxz
 vUadTEw3tefKjYyF1WmmBw+QoYR5LC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697040506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0oYHexrwi8Xds9QIhall2Ly/pFJQuTl8qKl5nKRl84=;
 b=iq77qXoxe7pMN4K4FKbWjkrsCeDyPj0TYhUjI2FFbRieKKtd1kjmrK2IvOTbgebWqpFBOt
 W51nfTf98wbcgqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF13913A7A;
 Wed, 11 Oct 2023 16:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gIrxMHnIJmVVIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Oct 2023 16:08:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 18:08:20 +0200
Message-ID: <20231011160822.578637-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011160822.578637-1-pvorel@suse.cz>
References: <20231011160822.578637-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_ioctl: Cleanup the code
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <petr.vorel@gmail.com>

* Use SAFE_{OPEN,CLOSE}() (simplification), -1 return code is removed.
* Cleanup unused headers.
* Include tst_fs.h, to keep signature checked during compilation.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_ioctl.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/lib/tst_ioctl.c b/lib/tst_ioctl.c
index 364220bcd..34a056cf4 100644
--- a/lib/tst_ioctl.c
+++ b/lib/tst_ioctl.c
@@ -1,37 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
 #include <sys/ioctl.h>
 #include <linux/fs.h>
 
 #define TST_NO_DEFAULT_MAIN
 
 #include "tst_test.h"
+#include "tst_fs.h"
 
 int tst_fibmap(const char *filename)
 {
-	/* test if FIBMAP ioctl is supported */
 	int fd, block = 0;
 
-	fd = open(filename, O_RDWR | O_CREAT, 0666);
-	if (fd < 0) {
-		tst_res(TWARN | TERRNO,
-			 "open(%s, O_RDWR | O_CREAT, 0666) failed", filename);
-		return -1;
-	}
+	fd = SAFE_OPEN(filename, O_RDWR | O_CREAT, 0666);
 
 	if (ioctl(fd, FIBMAP, &block)) {
 		tst_res(TINFO | TERRNO, "FIBMAP ioctl is NOT supported");
 		close(fd);
 		return 1;
 	}
+
 	tst_res(TINFO, "FIBMAP ioctl is supported");
+	SAFE_CLOSE(fd);
 
-	if (close(fd)) {
-		tst_res(TWARN | TERRNO, "close(fd) failed");
-		return -1;
-	}
 	return 0;
 }
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
