Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4732C47073
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 00:29:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E103D3CE6E5
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 01:29:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7136B3CD1AB
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 01:29:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E96296009AF
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 01:29:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE4421F839;
 Fri,  5 Jan 2024 00:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704414557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Kdzd3QWdUf+Br5XRl0cLbrFuLoU/O6ECwJdPeUuk8M=;
 b=2/bUJYeK0N8nGkrg5GWBk+OxRB4EOuuT+i95GyaoQ3qhUKLdq9evbzXMQzqK28Sfe7wtsO
 zJqyfJ1YzzBkUsN7TnPP7JheZKoligJJsRR5IdjLmd1+3YHGICOJPKd2XPp9+DKatQ6/XU
 hRoTJr5T9QQA72c5QKS7aXGiVmWaWwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704414557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Kdzd3QWdUf+Br5XRl0cLbrFuLoU/O6ECwJdPeUuk8M=;
 b=EokwYKGakvDnC+uZgNOs3FhMoNqYA5WlvAneft6B40jhf35iqUOQTDWVm8N7lmhlOn3aRb
 mZ6grRTx3Ztj6zAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704414556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Kdzd3QWdUf+Br5XRl0cLbrFuLoU/O6ECwJdPeUuk8M=;
 b=tfY9/Am9J2ro9K19thG4B8ADX7HA9e9wqdw2R+RvZCT7Ctzy14x1K2MuLLXURwJTUBj300
 lZGqK0LA/4RovQXVVIttGYKnFpp7z+sYtuG0HahFerLgxPsBMvlWqWu42suFZXfPdXfutV
 ANKjFJORlDKnlE8p2NUIb605gdHO2JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704414556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Kdzd3QWdUf+Br5XRl0cLbrFuLoU/O6ECwJdPeUuk8M=;
 b=YEjZligDiw+G71+HhjWwaD4Bo2fMKTupwnZanjjqPh3I8tI5JUNxDVM79DIhqp3fdxq1XW
 Hl9ag4xEz36VJUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE3BA137E8;
 Fri,  5 Jan 2024 00:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JJYeMVxNl2X6UQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 05 Jan 2024 00:29:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 Jan 2024 01:29:14 +0100
Message-ID: <20240105002914.1463989-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="tfY9/Am9";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YEjZligD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.42 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-1.07)[87.91%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,linaro.org:email,sourceware.org:url];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,linaro.org:email,sourceware.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: EE4421F839
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] lapi/fsmount.h: Fix headers conflict
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

glibc doc [1] mentions conflict between <linux/mount.h> and
<sys/mount.h>. Because <linux/fs.h> includes <linux/mount.h> it's easy
to get <linux/mount.h> mounted indirectly.

Problem was fixed on glibc 2.37:
774058d729 ("linux: Fix sys/mount.h usage with kernel headers")
and it got backported to git tree for 2.36 and to some distros.
But it still fails for older glibc.

Therefore include <sys/mount.h> only if <linux/mount.h> not already
included.

[1] https://sourceware.org/glibc/wiki/Synchronizing_Headers

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Really fix the inlusion.

Tested:
https://github.com/pevik/ltp/actions/runs/7416363524

 include/lapi/fsmount.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 07eb42ffa..a9491a16d 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Linux Test Project, 2021-2022
+ * Copyright (c) Linux Test Project, 2021-2024
  * Copyright (c) 2020 Linaro Limited. All rights reserved.
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
@@ -11,12 +11,11 @@
 #include "config.h"
 #include <sys/syscall.h>
 #include <sys/types.h>
-#include <sys/mount.h>
 
-#ifndef HAVE_FSOPEN
-# ifdef HAVE_LINUX_MOUNT_H
-#  include <linux/mount.h>
-# endif
+#if !defined(HAVE_FSOPEN) && defined(HAVE_LINUX_MOUNT_H)
+# include <linux/mount.h>
+#else
+# include <sys/mount.h>
 #endif
 
 #include "lapi/fcntl.h"
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
