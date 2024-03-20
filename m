Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28606C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 11:43:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 316F33CFBFE
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 12:43:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FC963C92E2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 12:42:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E167A6096B1
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 12:42:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE7ED34322
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710934967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T/aT8SZQRKdtRawBtxpAE4NT4vg85p7uBe7LACWZ298=;
 b=tWI3D90n/vs5bfjk7+1yIS0K/jbY1FlsSLI3CW2idx9SP4gGeo9cV8yxxBYBkNJA+W/LV6
 +vYRdxk/6tswEXPSXhmedimrVrZHorQlND2nLDE8NYdHKnC71ccWoUBxeXz4RA9Rr0TG5Z
 lDKA2Y2RrLKitxDbWRH1nh0/NzzCfl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710934967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T/aT8SZQRKdtRawBtxpAE4NT4vg85p7uBe7LACWZ298=;
 b=o+U6hVRk0ySMdvDvHDbjr5XM0ozpsFyG/GIBNwn4iSAG5DOicbT38pw0o18FblwMJjBH2W
 4EWm1pebXbkipnBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710934967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T/aT8SZQRKdtRawBtxpAE4NT4vg85p7uBe7LACWZ298=;
 b=tWI3D90n/vs5bfjk7+1yIS0K/jbY1FlsSLI3CW2idx9SP4gGeo9cV8yxxBYBkNJA+W/LV6
 +vYRdxk/6tswEXPSXhmedimrVrZHorQlND2nLDE8NYdHKnC71ccWoUBxeXz4RA9Rr0TG5Z
 lDKA2Y2RrLKitxDbWRH1nh0/NzzCfl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710934967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T/aT8SZQRKdtRawBtxpAE4NT4vg85p7uBe7LACWZ298=;
 b=o+U6hVRk0ySMdvDvHDbjr5XM0ozpsFyG/GIBNwn4iSAG5DOicbT38pw0o18FblwMJjBH2W
 4EWm1pebXbkipnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D16CC136CD
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZuUcM7fL+mU9BQAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:42:47 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 12:42:46 +0100
Message-ID: <20240320114247.9518-1-akumar@suse.de>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [3.67 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.03)[56.81%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fpathconf01: Fix SPDX license ID
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

Fixes: dbfe867b4dfe ("fpathconf01: Convert to new API")
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/fpathconf/fpathconf01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
index 3c9adb033..a328f972f 100644
--- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
+++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) Linux Test Project, 2003-2024
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
