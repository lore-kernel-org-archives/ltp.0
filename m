Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ED2C433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 15:30:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58C763CA927
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:30:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB4053CA8C7
 for <ltp@lists.linux.it>; Tue,  3 May 2022 17:29:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DAB87600765
 for <ltp@lists.linux.it>; Tue,  3 May 2022 17:29:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 400B91F74C;
 Tue,  3 May 2022 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651591797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDLgpZEahaeHDRBbi8rIQtfeoICbw6XWKjISf86DGbk=;
 b=F9ca2Bht2SSGQoF3BVgPa9i4P/f29iiSIAVZwyr9kO7ZAwe9t2cG7XwBu24YG5MLlPydeM
 fORWTmlg2ssPYoIRDvwWVwonyjknrzV43mt6/0UifQ+QBUTPRaFx/B0R4noV8WLdNkN2aN
 CIUaVniQ5gCzGKCRSQ/br1pt/yFU7qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651591797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDLgpZEahaeHDRBbi8rIQtfeoICbw6XWKjISf86DGbk=;
 b=gF+Dfc80+yuIS/hOctVIFEncyOQIWRFlKQs08xZBZxMkiz3/4XdQczOT/1hFoz3EzFPYAu
 cu22iVTuY28OkFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E04F113ABE;
 Tue,  3 May 2022 15:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wHPoM3RKcWKtBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 May 2022 15:29:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 17:29:47 +0200
Message-Id: <20220503152948.6369-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503152948.6369-1-pvorel@suse.cz>
References: <20220503152948.6369-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi/mount.h: Remove <linux/mount.h>
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

To avoid constants redefinition:

tst_cgroup.c: note: in included file (through ../include/lapi/mount.h):
/usr/include/linux/mount.h:13:9: warning: preprocessor token MS_RDONLY redefined
tst_cgroup.c: note: in included file:
/usr/include/sys/mount.h:36:9: this was the original definition

c0cb5d196 was missing #include "config.h" which leaded to always
including <sys/mount.h> while keeping including <sys/mount.h> before
lapi/mount.h (will be removed in separate commit).

Because <linux/mount.h> conflicts with <sys/mount.h>, but does not
include some common functions (e.g. mount(), umount()), it's better to
include in lapi/mount.h only <sys/mount.h>. This requires to include
<linux/mount.h> instead of lapi/mount.h in lapi/fsmount.h.

Fixes: c0cb5d196 ("lapi/mount.h: Include kernel/libc header")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/fsmount.h | 7 +++++--
 include/lapi/mount.h   | 6 +-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 377af85ec..3609855f6 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -8,11 +8,14 @@
 #ifndef LAPI_FSMOUNT_H__
 #define LAPI_FSMOUNT_H__
 
+#include "config.h"
 #include <sys/syscall.h>
 #include <sys/types.h>
 
-#include "config.h"
-#include "lapi/mount.h"
+#ifdef HAVE_LINUX_MOUNT_H
+# include <linux/mount.h>
+#endif
+
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index 6d098e3fd..66e1d1319 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -7,11 +7,7 @@
 #ifndef LAPI_MOUNT_H__
 #define LAPI_MOUNT_H__
 
-#ifdef HAVE_LINUX_MOUNT_H
-# include <linux/mount.h>
-#else
-# include <sys/mount.h>
-#endif
+#include <sys/mount.h>
 
 #ifndef MS_REC
 # define MS_REC 16384
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
