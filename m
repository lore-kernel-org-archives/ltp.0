Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6C5EB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 08:18:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F4343C99F5
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 10:18:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF5A3C99BA
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:18:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5AA311400B86
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:18:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA63F2188E;
 Wed, 28 Jun 2023 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687940315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3i1PkT8JD2OJGFphOMrUu65Qtg1I5AkPSS9asZTgmyA=;
 b=ajM+5vdWT+mCRgS2VeJuMWMdNbaLcj7jENknjJT+CEyJi6OesxGjy9xdR36wXLrghCe+S2
 Ey1moWLfXPWGTNfMmVDSVCEzU0ltqGJTN+I3dQ+xMkG2/Oiieg2mfCOkPZwR4L1zTDev1E
 rpcp1fAXudui3mTrTArPYhYjpFlqjk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687940315;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3i1PkT8JD2OJGFphOMrUu65Qtg1I5AkPSS9asZTgmyA=;
 b=tecZZwEmQEFVC3ERgsGTqtrK3BNitsNE3Ml+O3mjs0+JYRgiAKO62NvLHkVTUcGt/4y3EP
 s4Z4cHJQMWzTBYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F114138E8;
 Wed, 28 Jun 2023 08:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cN37JNvsm2QhVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 08:18:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 28 Jun 2023 10:18:31 +0200
Message-Id: <20230628081831.123189-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230628081831.123189-1-pvorel@suse.cz>
References: <20230628081831.123189-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] ltpscsi/scsimain.c: Remove O_DIRECT fallback
 definition
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
Cc: NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To avoid potential problems with different O_DIRECT values across archs,
just replace the fallback definition with _GNU_SOURCE definition.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/scsi/ltpscsi/scsimain.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/scsi/ltpscsi/scsimain.c b/testcases/kernel/fs/scsi/ltpscsi/scsimain.c
index ae484e0f1..ce23ae1e7 100644
--- a/testcases/kernel/fs/scsi/ltpscsi/scsimain.c
+++ b/testcases/kernel/fs/scsi/ltpscsi/scsimain.c
@@ -28,6 +28,7 @@
 [0x12][   |lu][pg cde][res   ][al len][cntrl ]
 */
 
+#define _GNU_SOURCE
 #include <unistd.h>
 #include <fcntl.h>
 #include <stdio.h>
@@ -53,10 +54,6 @@
 
 #define ME "scsimain: "
 
-#ifndef O_DIRECT
-#define O_DIRECT 040000
-#endif
-
 #define NUMERIC_SCAN_DEF 1	/* change to 0 to make alpha scan default */
 //static char * version_str = "0.21 20030513";
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
