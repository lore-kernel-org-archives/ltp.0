Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E494EEB64DA
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 13:08:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57A983CF145
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 15:08:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ADE03CC734
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 15:07:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49DD8600909
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 15:07:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BFFDB218A8;
 Wed, 28 Jun 2023 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687957665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DELYlmIZS3dx1c/tyrSxiVcRCsFfqdr5OtFxqJsft08=;
 b=wtZ+IFlfvrhJhD8/DNaTTR5y0DD84StH/iTui9YGzQVjfFs3DDYgu/jF8eLpQog/ZYCnOq
 EzjNLAkrcNXWVbALCsBZnQbRSflKXd1k2BX5g+5a3ZPq5eS2p9FMjwPUjzuoxRJtS8XLKQ
 XqFCpYleRuXpQ9puGdhvhtwp+xgTeaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687957665;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DELYlmIZS3dx1c/tyrSxiVcRCsFfqdr5OtFxqJsft08=;
 b=haietHJgJZ3+wf6w2IZlWdXFQyACrh/gzQItEJbzzqlEw9oGa2vRdQGx1tk4fYpzVctSml
 wd2eRq4Scwv+6eDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 954AB138E8;
 Wed, 28 Jun 2023 13:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WHNDI6EwnGT/cgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 13:07:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 28 Jun 2023 15:07:40 +0200
Message-Id: <20230628130742.155724-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230628130742.155724-1-pvorel@suse.cz>
References: <20230628130742.155724-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] lapi/fcntl.h: Remove O_DIRECT definition
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
040000 is O_DIRECTORY on powerpc. Therefore it's better just to remove
the definition in lapi and define _GNU_SOURCE in the tests which need
it (so far it's not needed for the library code).

Add this hint to the lapi header.

Reported-by: NeilBrown <neilb@suse.de>
Suggested-by: NeilBrown <neilb@suse.de>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/fcntl.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 848ac7865..cb216e2dc 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2014-2023
  */
 
 #ifndef LAPI_FCNTL_H__
@@ -10,9 +11,7 @@
 #include <fcntl.h>
 #include <sys/socket.h>
 
-#ifndef O_DIRECT
-# define O_DIRECT 040000
-#endif
+/* NOTE: #define _GNU_SOURCE if you need O_DIRECT in tests */
 
 #ifndef O_CLOEXEC
 # define O_CLOEXEC 02000000
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
