Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8FCC2BA4C
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 12:36:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6CFE3C9696
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 13:36:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B88F23C0C9F
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 369CE1A00445
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEFFF218EB;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643200556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6/C/c4axnouW1nL8x/bfNXJEvhZwRKGKlj8DaMcvCM=;
 b=QI3+DDUesW3FInudktos8qR8mAZm0HVuxRkcsQ7RU4bCDmplvi4neXv0DH6XQ2mmLXYDca
 oU9QuVtGoA2dj5VJYHIvRbljzC72xbj0V2kLA3ZHaEra+hUuhOhfeb1dABaTwAZbOfISnU
 PMuEkzVIvwWJ4rRzll+TrQSzz7J+pGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643200556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6/C/c4axnouW1nL8x/bfNXJEvhZwRKGKlj8DaMcvCM=;
 b=i0VMb3pm4z0OzdUIULoXHsl88fe6kftjwrCUhIympvt1P8DC51Pq3bCTp/N13g61Nt2FTz
 JYy3lTwdbsFSd4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A85CF13BB5;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CPE0JyxA8WGkOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 12:35:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 13:35:45 +0100
Message-Id: <20220126123547.13298-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126123547.13298-1-pvorel@suse.cz>
References: <20220126123547.13298-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 5/7] m4: Remove check for MREMAP_FIXED
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

glibc and uclibc added it in 2005, musl at 2011.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 configure.ac                                |  1 -
 m4/ltp-mremap_fixed.m4                      | 12 ------------
 testcases/kernel/mem/thp/thp02.c            |  5 -----
 testcases/kernel/syscalls/mremap/mremap05.c | 11 -----------
 4 files changed, 29 deletions(-)
 delete mode 100644 m4/ltp-mremap_fixed.m4

diff --git a/configure.ac b/configure.ac
index 6ff761837a..41c385edcb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -360,7 +360,6 @@ LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_LIBMNL
 LTP_CHECK_LINUX_PTRACE
 LTP_CHECK_LINUXRANDOM
-LTP_CHECK_MREMAP_FIXED
 LTP_CHECK_NOMMU_LINUX
 LTP_CHECK_SELINUX
 LTP_CHECK_SYNC_ADD_AND_FETCH
diff --git a/m4/ltp-mremap_fixed.m4 b/m4/ltp-mremap_fixed.m4
deleted file mode 100644
index 66548b82b3..0000000000
--- a/m4/ltp-mremap_fixed.m4
+++ /dev/null
@@ -1,12 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2012
-dnl Author: Cyril Hrubis <chrubis@suse.cz>
-
-AC_DEFUN([LTP_CHECK_MREMAP_FIXED],[
-AH_TEMPLATE(HAVE_MREMAP_FIXED,
-[Define to 1 if you have MREMAP_FIXED in <sys/mman.h>.])
-AC_MSG_CHECKING([for MREMAP_FIXED in <sys/mman.h>])
-AC_TRY_COMPILE([#define _GNU_SOURCE
-                #include <sys/mman.h>], [int flags = MREMAP_FIXED;],
-               AC_DEFINE(HAVE_MREMAP_FIXED) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
-])
diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
index a1b0ee0ab1..56568d1d18 100644
--- a/testcases/kernel/mem/thp/thp02.c
+++ b/testcases/kernel/mem/thp/thp02.c
@@ -40,7 +40,6 @@
 #include <unistd.h>
 #include "mem.h"
 
-#ifdef HAVE_MREMAP_FIXED
 static int ps;
 static long hps, size;
 
@@ -119,7 +118,3 @@ static struct tst_test test = {
 	.test_all = do_mremap,
 	.forks_child = 1,
 };
-
-#else
-	TST_TEST_TCONF("MREMAP_FIXED not present in <sys/mman.h>");
-#endif /* HAVE_MREMAP_FIXED */
diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
index 5e8cda5d78..d85ebb068d 100644
--- a/testcases/kernel/syscalls/mremap/mremap05.c
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -45,8 +45,6 @@
 
 char *TCID = "mremap05";
 
-#ifdef HAVE_MREMAP_FIXED
-
 struct test_case_t {
 	char *old_address;
 	char *new_address;
@@ -239,12 +237,3 @@ static void setup(void)
 static void cleanup(void)
 {
 }
-
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "MREMAP_FIXED not present in <sys/mman.h>");
-}
-
-#endif /* HAVE_MREMAP_FIXED */
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
