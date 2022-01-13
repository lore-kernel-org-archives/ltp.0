Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9C4C433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 19:14:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02CEC3C952F
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 20:14:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E3813C950A
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 20:14:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB5231A009AE
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 20:14:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9015A218F4;
 Thu, 13 Jan 2022 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642101275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VD9+RM5LsLM2UrDK76fa/sPAbGrX8lo4KfKNvKnYQNw=;
 b=Nce+6cOfyOW3IF5oh9WD3idmPT7jN1F71R/Jj6AYt3FdQ09mc1PirCAhb0FGp47BkouDxQ
 9iXepgPzE8ksf+nfdLUJ7DW5/yn+82jAN8CZvntE4CJeIpEKbTuQ1v6miIeK8/Tgk0YljX
 vMYXdVZRB4u4xBThparsCe3RKdDuAE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642101275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VD9+RM5LsLM2UrDK76fa/sPAbGrX8lo4KfKNvKnYQNw=;
 b=mTKxoEKMXWWr0a7LFSvC8sVel5FPLeFskj6InvUymYU70tu7GMq/pLF+kk6v1kvOpfuGDf
 o83KjtEtWCMXAgDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25A0C13EAB;
 Thu, 13 Jan 2022 19:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zRNBBht64GEYdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Jan 2022 19:14:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 13 Jan 2022 20:14:29 +0100
Message-Id: <20220113191429.12882-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] fanotify22: Add missing
 name_to_handle_at() guard
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

That fixes build on uclibc < v1.0.35, which does not have
name_to_handle_at() which is required for fanotify_get_fid() helper.

+ remove include <fcntl.h> (included in lapi/fcntl.h via fanotify.h)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

simple pre-release fix.

FYI after release I'll post name_to_handle_at() syscall wrapper for
toolchains without it (people use new kernel just don't have wrapper in
slightly older uclibc).

Kind regards,
Petr

 testcases/kernel/syscalls/fanotify/fanotify22.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index fd1c3fbbb9..bd82fbf63d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -29,7 +29,6 @@
 #include "tst_test.h"
 #include <sys/fanotify.h>
 #include <sys/types.h>
-#include <fcntl.h>
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
@@ -39,13 +38,16 @@
 #endif
 
 #define BUF_SIZE 256
-static char event_buf[BUF_SIZE];
-int fd_notify;
 
 #define MOUNT_PATH "test_mnt"
 #define BASE_DIR "internal_dir"
 #define BAD_DIR BASE_DIR"/bad_dir"
 
+#ifdef HAVE_NAME_TO_HANDLE_AT
+
+static char event_buf[BUF_SIZE];
+int fd_notify;
+
 /* These expected FIDs are common to multiple tests */
 static struct fanotify_fid_t null_fid;
 static struct fanotify_fid_t bad_file_fid;
@@ -309,6 +311,9 @@ static struct tst_test test = {
 	}
 };
 
+#else
+	TST_TEST_TCONF("system does not have required name_to_handle_at() support");
+#endif
 #else
 	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
