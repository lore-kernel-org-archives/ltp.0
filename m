Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0A8C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 15:30:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D17AA3CA8F6
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:30:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E4B03CA8C8
 for <ltp@lists.linux.it>; Tue,  3 May 2022 17:29:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E5E6260072C
 for <ltp@lists.linux.it>; Tue,  3 May 2022 17:29:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9607E210E5;
 Tue,  3 May 2022 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651591797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxiLAgJuw7JtDuWyZ6p5L3P+41n2fK0Kv1oJDK44H0k=;
 b=aNYYkZdtJ2wrYSIePBuAx8AflDaJWdLjC8y6QMiDE7M4iZtaWdKi6Fsw7A3OozcgsgUV3N
 WUGLA43aDe7Fq7EOxCe101h4gKMvi/u0nvJuEdrwl2eQXftsXqO49/t0N77GozpQ5tsBs/
 H0wOpbyzA6yWCylSVv7mAllUc3fnHjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651591797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxiLAgJuw7JtDuWyZ6p5L3P+41n2fK0Kv1oJDK44H0k=;
 b=RewN2mNCBGKMCl+qIhA4d4JyKea1rF+5UedLgxE9NPU27Mt4BfSUvgQLz+TLXrqMHxrhUl
 jASovOiMaQ9KE4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53A9513ABE;
 Tue,  3 May 2022 15:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8J7wEXVKcWKtBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 May 2022 15:29:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 17:29:48 +0200
Message-Id: <20220503152948.6369-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503152948.6369-1-pvorel@suse.cz>
References: <20220503152948.6369-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Remove duplicate include of <sys/mount.h>
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

<sys/mount.h> is already included by lapi/mount.h.

Fixes: c0cb5d196 ("lapi/mount.h: Include kernel/libc header")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_cgroup.c                                    | 1 -
 testcases/kernel/syscalls/open/open12.c             | 1 -
 testcases/kernel/syscalls/pivot_root/pivot_root01.c | 2 --
 testcases/kernel/syscalls/statx/statx06.c           | 1 -
 testcases/kernel/syscalls/umount2/umount2_01.c      | 1 -
 testcases/kernel/syscalls/umount2/umount2_02.c      | 1 -
 6 files changed, 7 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index feb5b3d07..081dfa9c6 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -11,7 +11,6 @@
 #include <stddef.h>
 #include <stdlib.h>
 #include <mntent.h>
-#include <sys/mount.h>
 
 #include "tst_test.h"
 #include "lapi/fcntl.h"
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 4702d08db..bdf29a9a8 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -24,7 +24,6 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <sys/mount.h>
 #include <unistd.h>
 #include <mntent.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root01.c b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
index 1fbe8c189..2d80928b7 100644
--- a/testcases/kernel/syscalls/pivot_root/pivot_root01.c
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
@@ -9,8 +9,6 @@
 #include <errno.h>
 #include <lapi/syscalls.h>
 #include <sched.h>
-
-#include <sys/mount.h>
 #include <stdlib.h>
 
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 4a0685a65..28badb038 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -20,7 +20,6 @@
 
 #define _GNU_SOURCE
 #include <stdio.h>
-#include <sys/mount.h>
 #include <time.h>
 
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index 46a6d59c3..53817bf68 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -23,7 +23,6 @@
  */
 
 #include <errno.h>
-#include <sys/mount.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index b23f37b04..f4b228f97 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -20,7 +20,6 @@
  * - succeed when target is a mount point
  */
 
-#include <sys/mount.h>
 #include "lapi/mount.h"
 #include "tst_test.h"
 
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
