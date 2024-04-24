Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C7EC07E8E
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:18:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 310C33D0040
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 16:18:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC4313CFF34
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 16:17:57 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C88FB208E02
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 16:17:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 303BD66EAD;
 Wed, 24 Apr 2024 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713968275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKbef4NkyoFb3pPpOlrga9Kgx77/xtlsja9dh0sCfK8=;
 b=xoSbTTVDGr7xE0JR3dMbbrxIpWVQwAq48zQrmpt2mDMW1Kb99qEKex/qbYf1IpuIesj1XU
 rZNHiJvYQ1MWxQmCV2E8vsZx/781fqoEQS236w41PD5FZijiaRUUrktduK7J/9AmLNM/uX
 KoqE+Xhr0mbKv16JkPfqfyzFXZOl7GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713968275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKbef4NkyoFb3pPpOlrga9Kgx77/xtlsja9dh0sCfK8=;
 b=zbXkZGB6wY5TngE5BX81UtGmVEA6PAow2/0AqOhOtkYBu7dGfkIqyelwi4EB+N8zr4XfCu
 89LN2UWPYAwf+rCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xoSbTTVD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zbXkZGB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713968275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKbef4NkyoFb3pPpOlrga9Kgx77/xtlsja9dh0sCfK8=;
 b=xoSbTTVDGr7xE0JR3dMbbrxIpWVQwAq48zQrmpt2mDMW1Kb99qEKex/qbYf1IpuIesj1XU
 rZNHiJvYQ1MWxQmCV2E8vsZx/781fqoEQS236w41PD5FZijiaRUUrktduK7J/9AmLNM/uX
 KoqE+Xhr0mbKv16JkPfqfyzFXZOl7GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713968275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKbef4NkyoFb3pPpOlrga9Kgx77/xtlsja9dh0sCfK8=;
 b=zbXkZGB6wY5TngE5BX81UtGmVEA6PAow2/0AqOhOtkYBu7dGfkIqyelwi4EB+N8zr4XfCu
 89LN2UWPYAwf+rCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 109C813941;
 Wed, 24 Apr 2024 14:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UK1FA5MUKWZ9EgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Apr 2024 14:17:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Apr 2024 16:17:50 +0200
Message-ID: <20240424141751.247015-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424141751.247015-1-pvorel@suse.cz>
References: <20240424141751.247015-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 303BD66EAD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lapi/fs: Include lapi/fcntl.h + define
 _GNU_SOURCE
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

Add required _GNU_SOURCE definition in lapi/fs.h to get loff_t
definition. This fixes build error on musl (alpine):

    In file included from unlink09.c:18:
    ../../../../include/lapi/fs.h:58:15: error: unknown type name 'loff_t'
       58 | static inline loff_t tst_max_lfs_filesize(void)

loff_t is defined in <fcntl.h> (but guarded _GNU_SOURCE), but just for
safety include lapi/fcntl.h in case lapi/fs.h is included in test which
needs fallback definitions from lapi/fcntl.h.

Also, instead adding _GNU_SOURCE to unlink09.c just include lapi/fs.h
after tst_test.h. But reverting the order requires also add <unistd.h>
to lapi/fcntl.h to fix missing getpagesize() on 32 bit build:

    In file included from unlink09.c:17:
    ../../../../include/lapi/fs.h: In function 'tst_max_lfs_filesize':
    ../../../../include/lapi/fs.h:66:26: error: implicit declaration of function 'getpagesize' [-Werror=implicit-function-declaration]
       66 |         long page_size = getpagesize();
	  |                          ^~~~~~~~~~~

(For some reason <unistd.h> is not required on 64 bit build.)
getpagesize() is also guarded _GNU_SOURCE.

Obviously having functions in lapi headers (or any headers) which
depends on _GNU_SOURCE brings problems. But moving
tst_max_lfs_filesize() out of lapi to lib/tst_*.c would not help either,
because here is loff_t also in the function signature which we need to
API header, which would again need _GNU_SOURCE definition.

Fixes: 2cf78f47a ("unlink: Add error tests for EPERM and EROFS")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* include/lapi/fs.h: Add #include <unistd.h>, more comments.
* unlink09.c: replace _GNU_SOURCE with switched lapi/fs.h and tst_test.h
  includes.

I wonder why getpagesize() requires _GNU_SOURCE only on 32 bit build
(triggered by -Werror=implicit-function-declaration).

NOTE: I was going to send patch which moves tst_max_lfs_filesize() to
lib/tst_file.c (renamed lib/tst_fill_file.c). IMHO it'd be better to
avoid static inline functions in headers (unless off_t), but there would
be _GNU_SOURCE required and I did not want to add it into include/fs.h.
Doing a cleanup in library includes and C files would be good, but let's
for now just fix the build.

Kind regards,
Petr

 include/lapi/fs.h                           | 10 +++++++++-
 testcases/kernel/syscalls/unlink/unlink09.c |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index c19ee821d..ac558350c 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -9,15 +9,23 @@
 #ifndef LAPI_FS_H__
 #define LAPI_FS_H__
 
+/*
+ * loff_t in <fcntl.h> loaded via lapi/fcntl.h,
+ * getpagesize() in <unistd.h>.
+ */
+#define _GNU_SOURCE
+
 #include "config.h"
+#include <unistd.h>
+
 #ifndef HAVE_MOUNT_SETATTR
 # ifdef HAVE_LINUX_FS_H
 #  include <linux/fs.h>
 # endif
 #endif
 
-#include <sys/user.h>
 #include <limits.h>
+#include "lapi/fcntl.h"
 #include "lapi/abisize.h"
 
 #ifndef FS_IOC_GETFLAGS
diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index cc4b4a07e..4f9d1eaaf 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -14,8 +14,8 @@
  */
 
 #include <sys/ioctl.h>
-#include "tst_test.h"
 #include "lapi/fs.h"
+#include "tst_test.h"
 
 #define TEST_EPERM_IMMUTABLE "test_eperm_immutable"
 #define TEST_EPERM_APPEND_ONLY "test_eperm_append_only"
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
