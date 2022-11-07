Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CB2C4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 14:55:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C0BB3CDA1E
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 15:55:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8224D3C009F
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 15:55:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4AF29600286
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 15:54:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3FD16224B4;
 Mon,  7 Nov 2022 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667832899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nEYHRRuPvtRR3iQ8thrAEcUzWlIWSQXlJnpGXLOesyc=;
 b=LJQfP+PetmNTjcifJ4g7jjZTZzK0m+LIMMS1gOAH+tMPtUq1TmNH4k33UwdCpmssYVbmRB
 gGPOaVutTNuGeYbIviPREhETdO0/NjXg654kf4hTZgSs/uA91aq//0VvWiXwWA9H1zm4hl
 drHHBaXd0DT1ptnoW6yHCE086TnVJHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667832899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nEYHRRuPvtRR3iQ8thrAEcUzWlIWSQXlJnpGXLOesyc=;
 b=zxomZFeQtCO+1HO8+130VaccLtYL30zK5ZIc4fvcwJfmotY/RZQd3EO0b5E+Eb6gPuma8W
 4aHyflXS7camsiAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0973F13AC7;
 Mon,  7 Nov 2022 14:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oHpVAEMcaWNBEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Nov 2022 14:54:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Nov 2022 15:54:53 +0100
Message-Id: <20221107145453.25262-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] Makefile: set LC_{COLLATE, NUMERIC}=C,
 unexport LC_ALL
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

to have reproducible builds (no locale dependencies).
Get inspiration from Linux kernel, commits:
c051346b7db2 ("Makefile: set LC_CTYPE, LC_COLLATE, LC_NUMERIC to C")
07105202bdeb ("Makefile: do not override LC_CTYPE")

NOTE: we don't care about messages not being localized.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index eb12b9d69..cb80622d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2009-2021
+# Copyright (c) Linux Test Project, 2009-2022
 # Copyright (c) Cisco Systems Inc., 2009-2010
 # Ngie Cooper, July 2009
 
+# Avoid funny character set dependencies
+unexport LC_ALL
+LC_COLLATE=C
+LC_NUMERIC=C
+export LC_COLLATE LC_NUMERIC
+
 top_srcdir		?= $(CURDIR)
 
 include $(top_srcdir)/include/mk/env_pre.mk
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
