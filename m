Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721FFC47422
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 19:54:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C01B93CB4DA
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 20:54:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16C373CB4DA
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 20:54:39 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5D0DD1A007E4
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 20:54:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 928951F387;
 Wed, 17 Jan 2024 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705521277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kqPvyD2RQCvDVKahEDoGXRYwy30ORC7FdNM0R0c8r50=;
 b=S0/3DQnnW4XhNyNgWXq1VOyJYIPDpn8F0n+UKTJD2Kx4iD0PRJa9kAUCmsoYZtaooNnnde
 UEQ0ct5G/fRrCjgU4K80i3Y+pADEMK0N7aB0lWc7dmzWpNWUIaWYYTtlq10+bkfasOM/W8
 r/WMu6O3rDyi6dqwtVCEn6OKXO+2xHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705521277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kqPvyD2RQCvDVKahEDoGXRYwy30ORC7FdNM0R0c8r50=;
 b=sX+GJIxwxL/RtQFg3zsfNaNnMdy0olebBmHm8N59wOfICHcktl4z2aZCfd3dtKZL85rHAx
 SwUO76DBK4w0pQBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705521277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kqPvyD2RQCvDVKahEDoGXRYwy30ORC7FdNM0R0c8r50=;
 b=S0/3DQnnW4XhNyNgWXq1VOyJYIPDpn8F0n+UKTJD2Kx4iD0PRJa9kAUCmsoYZtaooNnnde
 UEQ0ct5G/fRrCjgU4K80i3Y+pADEMK0N7aB0lWc7dmzWpNWUIaWYYTtlq10+bkfasOM/W8
 r/WMu6O3rDyi6dqwtVCEn6OKXO+2xHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705521277;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kqPvyD2RQCvDVKahEDoGXRYwy30ORC7FdNM0R0c8r50=;
 b=sX+GJIxwxL/RtQFg3zsfNaNnMdy0olebBmHm8N59wOfICHcktl4z2aZCfd3dtKZL85rHAx
 SwUO76DBK4w0pQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34CF113800;
 Wed, 17 Jan 2024 19:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i3JrCX0wqGWkagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 19:54:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jan 2024 20:54:32 +0100
Message-ID: <20240117195432.2719142-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.11 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.59)[98.17%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lapi/fsmount: Further fix header conflict on old
 distros
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

12867c0d6 fix on lapi/io_uring was not enough.  glibc doc [1] mentions
conflict between <linux/mount.h> and <sys/mount.h>. Because <linux/fs.h>
includes <linux/mount.h> it's easy to get <linux/mount.h> mounted
indirectly.

Problem was fixed on glibc 2.37:
774058d729 ("linux: Fix sys/mount.h usage with kernel headers")
and it got backported to git tree for 2.36 and to some distros.
But it still fails for older glibc.

Therefore include <sys/mount.h> only if <linux/mount.h> not already
included.

[1] https://sourceware.org/glibc/wiki/Synchronizing_Headers
Fixes: #1121
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
CI: https://github.com/pevik/ltp/actions/runs/7561031650

 include/lapi/fsmount.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 07eb42ffa..2ed4da86f 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
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
