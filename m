Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E2DEB64DA
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 08:19:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04D803CC724
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 10:19:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25B423C99BA
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:18:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D0AF110006B6
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:18:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D5091F8C8;
 Wed, 28 Jun 2023 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687940315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4Hgcf7ePEl707yqSWzYyaGkb+uMZ46ehINLsM9OeKY=;
 b=GMx+OY9oOSPfb8sCs6tEZaZgdksBGeb0CofL2jid0fNKM/V+b7uAn8TI/s7BtkKskpvFvU
 2/txZ7b3I58oe/P8A66TbaqoopE674iHML9WCPMRrq/qsZEjT2ubK4nFdDLhtU1jrTJ0Wm
 iqiFUGAgP/ZVxGqQQZ5tJdSszwExz/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687940315;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4Hgcf7ePEl707yqSWzYyaGkb+uMZ46ehINLsM9OeKY=;
 b=PvJuxOEBL9VUIi7YNiKzFXgfODpDKzHGVluD4prtaNWl6Aw0gXndJ9LXr0JSPT+nWQNLvd
 Yz6q62RipLcTSFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E2CD138E8;
 Wed, 28 Jun 2023 08:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EC9GAtvsm2QhVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 08:18:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 28 Jun 2023 10:18:29 +0200
Message-Id: <20230628081831.123189-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230628081831.123189-1-pvorel@suse.cz>
References: <20230628081831.123189-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lapi/fcntl.h: Fix O_DIRECT definition for various
 archs
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

O_DIRECT definitions differ a lot depending on architecture.
Because this can lead to problems (e.g. the generic value O_DIRECT
040000 is O_DIRECTORY on powerpc, address that in lapi file.

NOTE: Deliberately use correct definitions also on less common archs
(maybe LTP even cannot be compiled on m68k or mips, but better to be
safe then sorry).  But the problem would IMHO be avoided if the fallback
O_DIRECT definition would be removed everywhere and tests just define
_GNU_SOURCE (no library code is using O_DIRECT atm).

Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/fcntl.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 848ac7865..27da9f076 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2014-2023
  */
 
 #ifndef LAPI_FCNTL_H__
@@ -11,7 +12,15 @@
 #include <sys/socket.h>
 
 #ifndef O_DIRECT
-# define O_DIRECT 040000
+# if defined(__mips__)
+#  define O_DIRECT 0100000
+# elif defined(__arm__) || defined(__aarch64__) || defined(__m68k__)
+#  define O_DIRECT 0200000
+# elif defined(__powerpc__) || defined(__powerpc64__)
+#  define O_DIRECT 0400000
+# else
+#  define O_DIRECT 040000
+# endif
 #endif
 
 #ifndef O_CLOEXEC
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
