Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB890C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:49:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 945B03CACCA
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:49:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C39163CA99F
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36DD6600700
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E722421875;
 Tue,  3 May 2022 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuGZn0WOL4/wZMiZL9c6xdCVqlzqPGXCMQmBNs+dy5Q=;
 b=XKhoCuw2yt+XL2OF52HGpGpB8jaADtX4rI2V/lu7vwY8KhMjfon/CKlG3FRkuC4+CKGTgZ
 gaVd7aCs+PVM+pW9ZZsNDrYHZ85hTNxpgy0bJDK3if7ZhG8qTkYjm2u+8DEBI261VF8CR1
 T8jJvR/HI3GRYM7KQk2Urk1+dxjxuHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuGZn0WOL4/wZMiZL9c6xdCVqlzqPGXCMQmBNs+dy5Q=;
 b=feN3HL8fyky0di7nZllfbqV9aeuEmVAaB9AoTxGYoOtmIxskMI5gSHDy3DBM7IGBGecsDO
 BvjxVAiLgqNG7aBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE29F13ABE;
 Tue,  3 May 2022 17:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3AgqMStqcWIlPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:47:13 +0200
Message-Id: <20220503174718.21205-26-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 25/30] ltp-aiodio/read_checkzero: Remove
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Remove leftovers that are not used anymore.

CC: Andrea Cervesato <andrea.cervesato@suse.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/ltp-aiodio.part4                      |  2 -
 testcases/kernel/io/ltp-aiodio/.gitignore     |  1 -
 .../kernel/io/ltp-aiodio/read_checkzero.c     | 84 -------------------
 3 files changed, 87 deletions(-)
 delete mode 100644 testcases/kernel/io/ltp-aiodio/read_checkzero.c

diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
index 54019d47b..d88c27a83 100644
--- a/runtest/ltp-aiodio.part4
+++ b/runtest/ltp-aiodio.part4
@@ -59,8 +59,6 @@ ADI009 dio_append
 DIT000 dio_truncate
 DIT001 dio_truncate
 DIT002 dio_truncate
-#Running read_checkzero
-#gread_checkzero
 #Running dio_read
 DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 32M
 DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 32M
diff --git a/testcases/kernel/io/ltp-aiodio/.gitignore b/testcases/kernel/io/ltp-aiodio/.gitignore
index f5f20d57e..09a49bfbf 100644
--- a/testcases/kernel/io/ltp-aiodio/.gitignore
+++ b/testcases/kernel/io/ltp-aiodio/.gitignore
@@ -7,4 +7,3 @@
 /dio_truncate
 /dio_read
 /dirty
-/read_checkzero
diff --git a/testcases/kernel/io/ltp-aiodio/read_checkzero.c b/testcases/kernel/io/ltp-aiodio/read_checkzero.c
deleted file mode 100644
index b48197a7b..000000000
--- a/testcases/kernel/io/ltp-aiodio/read_checkzero.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
- *               2004 Open Source Development Lab
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Module: .c
- */
-
-/*
- * Change History:
- *
- * 2/2004  Marty Ridgeway (mridge@us.ibm.com) Changes to adapt to LTP
- *
- */
-#define _GNU_SOURCE
-
-#include <stdlib.h>
-#include <sys/types.h>
-#include <signal.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <unistd.h>
-
-#include "common_checkzero.h"
-
-int read_eof(char *filename)
-{
-	int fd;
-	int i;
-	int r;
-	char buf[4096];
-
-	if ((fd = open(filename, O_RDWR)) < 0) {
-		fprintf(stderr, "can't open file %s \n", filename);
-		exit(1);
-	}
-
-	for (i = 0; i < 100000; i++) {
-		off_t offset;
-		char *bufoff;
-
-		offset = lseek(fd, 4096, SEEK_END);
-		r = write(fd, "A", 1);
-
-		offset = lseek(fd, offset - 4096, SEEK_SET);
-
-		r = read(fd, buf, 4096);
-		if (r > 0) {
-			if ((bufoff = check_zero(buf, r))) {
-				fprintf(stderr, "non-zero read at offset %p\n",
-					offset + bufoff);
-				exit(1);
-			}
-		}
-	}
-	fprintf(stderr, "read_checkzero done\n");
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	if (argc < 2) {
-		printf("You must pass a filename to the test \n");
-		exit(1);
-	}
-
-	char *filename = argv[1];
-
-	read_eof(filename);
-
-	return 0;
-}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
