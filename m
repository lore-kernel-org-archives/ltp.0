Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D8EC47074
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 00:18:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CECC13CE6EE
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 01:18:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E8B83CC8A9
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 01:17:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AF07D6009AF
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 01:17:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99F8D21E23;
 Fri,  5 Jan 2024 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704413871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xcN1/lu9QxywYzzPC5DMKsH6YoTRMgOke6J/2iBRFBg=;
 b=FCLOyjsr7xHdgkzhxUukdue4BFzwisz9rZb3tRbnTsMbf0dYudSAaL11yXOhWU7j2oiiRg
 E1+ZciH626aFgKL2cIxSIZ9oB+3zx9v5+nyCNso3RbDLwxZ0F3Za3W1TKjzO2wD9zR2df0
 YDLt1U87fsK9SQCY2RKxsG7AsjJqIlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704413871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xcN1/lu9QxywYzzPC5DMKsH6YoTRMgOke6J/2iBRFBg=;
 b=MRo1Kwlmg8RsJ779NbYEDm028m4dqSfmJMbtAWHCj2qfTFfZdNk3nQpcWtvozZqVkb4TvL
 pKrMjafI6Azlt/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704413871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xcN1/lu9QxywYzzPC5DMKsH6YoTRMgOke6J/2iBRFBg=;
 b=FCLOyjsr7xHdgkzhxUukdue4BFzwisz9rZb3tRbnTsMbf0dYudSAaL11yXOhWU7j2oiiRg
 E1+ZciH626aFgKL2cIxSIZ9oB+3zx9v5+nyCNso3RbDLwxZ0F3Za3W1TKjzO2wD9zR2df0
 YDLt1U87fsK9SQCY2RKxsG7AsjJqIlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704413871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xcN1/lu9QxywYzzPC5DMKsH6YoTRMgOke6J/2iBRFBg=;
 b=MRo1Kwlmg8RsJ779NbYEDm028m4dqSfmJMbtAWHCj2qfTFfZdNk3nQpcWtvozZqVkb4TvL
 pKrMjafI6Azlt/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FB5D137E8;
 Fri,  5 Jan 2024 00:17:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0adbGa9Kl2V3TwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 05 Jan 2024 00:17:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 Jan 2024 01:17:45 +0100
Message-ID: <20240105001745.1461744-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.61 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 URIBL_BLOCKED(0.00)[linaro.org:email,sourceware.org:url,suse.cz:email];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.09)[95.57%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lapi/fsmount.h: Fix headers conflict
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
Tested:
https://github.com/pevik/ltp/actions/runs/7416306243

vs. failures on Cyril's tst_fd iterator patchset which would be affected
by this
https://github.com/pevik/ltp/actions/runs/7415994730

Kind regards,
Petr

 include/lapi/fsmount.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 07eb42ffa..da3cdf3c2 100644
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
@@ -11,12 +11,13 @@
 #include "config.h"
 #include <sys/syscall.h>
 #include <sys/types.h>
-#include <sys/mount.h>
 
 #ifndef HAVE_FSOPEN
 # ifdef HAVE_LINUX_MOUNT_H
 #  include <linux/mount.h>
 # endif
+#elif !defined(HAVE_LINUX_MOUNT_H)
+# include <sys/mount.h>
 #endif
 
 #include "lapi/fcntl.h"
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
