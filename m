Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCD3C3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 20:15:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 068D03D1D7D
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 22:15:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 447F43D1D3A
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 22:14:53 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 514081A00CA3
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 22:14:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 434E621BD5;
 Mon, 29 Jul 2024 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722284087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HRMf3XuTXvIpqIHM54Hj3VSiS8ya97u/lYELpvBrm6Q=;
 b=yaNV+caZB8cO0yN5UOHvLNtAvBzEeLHBb7JEYvPgF/y8u5IwKZO/t42YmHX/6WmGLFPq2/
 H4ud3H43jkKMOemhNm5PsG2XvD+6BRTIM84YYUaPzU5oMywqnv+jj2IJHRRv/dhSRBBpLE
 dtCnGo+OTqSlHzT+HZxBUKLHy59ZCKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722284087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HRMf3XuTXvIpqIHM54Hj3VSiS8ya97u/lYELpvBrm6Q=;
 b=DVhrubpm3Isfj3nCFFS1O3N+hsaDuFe1TEfNgiTVsss2j77c91a8mJVPdJtSSylhFoZzvq
 UB04nCtBREbkGaDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yaNV+caZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DVhrubpm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722284087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HRMf3XuTXvIpqIHM54Hj3VSiS8ya97u/lYELpvBrm6Q=;
 b=yaNV+caZB8cO0yN5UOHvLNtAvBzEeLHBb7JEYvPgF/y8u5IwKZO/t42YmHX/6WmGLFPq2/
 H4ud3H43jkKMOemhNm5PsG2XvD+6BRTIM84YYUaPzU5oMywqnv+jj2IJHRRv/dhSRBBpLE
 dtCnGo+OTqSlHzT+HZxBUKLHy59ZCKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722284087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HRMf3XuTXvIpqIHM54Hj3VSiS8ya97u/lYELpvBrm6Q=;
 b=DVhrubpm3Isfj3nCFFS1O3N+hsaDuFe1TEfNgiTVsss2j77c91a8mJVPdJtSSylhFoZzvq
 UB04nCtBREbkGaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 973AB1368A;
 Mon, 29 Jul 2024 20:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mDYJHjb4p2a1RwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 20:14:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 29 Jul 2024 22:14:35 +0200
Message-ID: <20240729201435.1286799-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 434E621BD5
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lapi: Remove HAVE_LINUX_FS_H
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

Remove workaround for glibc bug fixed in glibc 2.37:

https://github.com/kraj/glibc/commit/774058d72942249f71d74e7f2b639f77184160a6

It's not needed any more (it was needed for some Fedora version only).

Suggested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested: https://github.com/pevik/ltp/actions/runs/10094313234

 configure.ac           | 1 -
 include/lapi/ficlone.h | 6 +-----
 include/lapi/fs.h      | 4 +---
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 122ef5cb79..ebbf49e289 100644
--- a/configure.ac
+++ b/configure.ac
@@ -51,7 +51,6 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/cryptouser.h \
     linux/close_range.h \
     linux/dccp.h \
-    linux/fs.h \
     linux/futex.h \
     linux/genetlink.h \
     linux/if_alg.h \
diff --git a/include/lapi/ficlone.h b/include/lapi/ficlone.h
index a973a8b21b..2216733131 100644
--- a/include/lapi/ficlone.h
+++ b/include/lapi/ficlone.h
@@ -8,11 +8,7 @@
 #define LAPI_FICLONE_H__
 
 #include "config.h"
-
-#ifdef HAVE_LINUX_FS_H
-# include <linux/fs.h>
-#endif
-
+#include <linux/fs.h>
 #include <stdint.h>
 
 #ifndef HAVE_STRUCT_FILE_CLONE_RANGE
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 635979b024..8261ca41da 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -11,9 +11,7 @@
 
 #include "config.h"
 #ifndef HAVE_MOUNT_SETATTR
-# ifdef HAVE_LINUX_FS_H
-#  include <linux/fs.h>
-# endif
+# include <linux/fs.h>
 #endif
 
 #include <sys/user.h>
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
