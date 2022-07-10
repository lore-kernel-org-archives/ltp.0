Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86334C43334
	for <ltp@archiver.kernel.org>; Sun, 10 Jul 2022 15:27:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DB8A3CA579
	for <ltp@archiver.kernel.org>; Sun, 10 Jul 2022 17:27:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F281B3CA490
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 17:27:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4624E10000C1
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 17:27:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D89020077
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657466840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6X/favgkIJjn21QPE6n6dUguQVXvPKM57dw02Bt+Cgo=;
 b=LbfkmLp70jgZiX3v2QsMpD8BTEBc02LdSeQRXDdNsh1g7g4Julwfz8XGRoSgmC5UFnlgSX
 Cq8FTK3iVVwIPiKMF6c75IJ8ONJ2XWKhIYNhToqbmfuzk946eFfVzz7havm8yU2P9lUBj0
 36cEt4JgKCX9RfLAgtyRbPOOEk9j3iU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657466840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6X/favgkIJjn21QPE6n6dUguQVXvPKM57dw02Bt+Cgo=;
 b=NToLULyJUkUw0g7uqCGUazIkoas5dBv409T3XKN30/j7H3JxbQgm3labOVGthBj8vDXgVT
 AyRl2vixUd/NsDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C07F9132FD
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 15:27:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cZlXINfvymItcwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 15:27:19 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Sun, 10 Jul 2022 20:57:16 +0530
Message-Id: <20220710152717.23849-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open02.c: remove redundant headers and a typo fix
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/open/open02.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index 67bf423ae..bc7d04797 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -13,11 +13,6 @@
 
 #define _GNU_SOURCE
 
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <pwd.h>
 #include "tst_test.h"
 
@@ -31,7 +26,7 @@ static struct tcase {
 	const char *desc;
 } tcases[] = {
 	{TEST_FILE, O_RDWR, ENOENT, "new file without O_CREAT"},
-	{TEST_FILE2, O_RDONLY | O_NOATIME, EPERM, "unpriviledget O_RDONLY | O_NOATIME"},
+	{TEST_FILE2, O_RDONLY | O_NOATIME, EPERM, "unprivileged O_RDONLY | O_NOATIME"},
 };
 
 void setup(void)
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
