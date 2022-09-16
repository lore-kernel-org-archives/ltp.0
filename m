Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A0FECAAA1
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 21:22:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CD563CACAB
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 23:22:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B8FF3CAC6F
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 23:22:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 23D3214052D2
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 23:22:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F346120DD0;
 Fri, 16 Sep 2022 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663363331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HXfPxjuH4am4u2c7IEYxhrfSRfdynig+LfS6+/BXduM=;
 b=q7F//eIvMoC8Q2nWlOu+feIw2unYTFsM2Z0mBhk266bawdvE2EC/fboLposjGOYlVxvOCb
 GfLphIIzpxKMsjOgxbDaTD+esQLEJVjnkZ/4FSW7S0R3LQSPY9q5bfbrBZhkOJ/cao1pAj
 hhKNKSa5hwy317+rfwoEdf356knnABU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663363331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HXfPxjuH4am4u2c7IEYxhrfSRfdynig+LfS6+/BXduM=;
 b=fLjY1tjwk3PwTm9e5GqPBhQnKpnQuP0lmq7uk2wwnoDboiInCU42AiXZd9E/VYkMuzeGY1
 Lg8k1oKdU1Be6mDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A74451332E;
 Fri, 16 Sep 2022 21:22:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ois6JwLpJGOQYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Sep 2022 21:22:10 +0000
Date: Fri, 16 Sep 2022 23:22:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YyTpANbITJ0cfslS@pevik>
References: <20220915093639.2261-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220915093639.2261-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/8] shell: df01.sh: $TST_ALL_FILESYSTEMS
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

I finally merged this, with diff below.
In case I overlooked something in eb47b4497 ("tst_supported_fs: Support skip
list when query single fs") or there is other problem needed to be fixed before
release, I'll try to address it next week.

Thanks a lot to all reviewers for their time and patience.

Kind regards,
Petr

diff --git lib/newlib_tests/shell/tst_all_filesystems.sh lib/newlib_tests/shell/tst_all_filesystems.sh
index 61284f4f2..7561579ff 100755
--- lib/newlib_tests/shell/tst_all_filesystems.sh
+++ lib/newlib_tests/shell/tst_all_filesystems.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 
 TST_ALL_FILESYSTEMS=1
+TST_MOUNT_DEVICE=1
 TST_NEEDS_ROOT=1
 TST_TESTFUNC=test
 TST_CNT=2
diff --git lib/newlib_tests/shell/tst_all_filesystems_skip.sh lib/newlib_tests/shell/tst_all_filesystems_skip.sh
index c2e0ba9ff..9516f38d9 100755
--- lib/newlib_tests/shell/tst_all_filesystems_skip.sh
+++ lib/newlib_tests/shell/tst_all_filesystems_skip.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 
 TST_ALL_FILESYSTEMS=1
+TST_MOUNT_DEVICE=1
 TST_NEEDS_ROOT=1
 TST_TESTFUNC=test
 TST_SKIP_FILESYSTEMS="btrfs,exfat,ext2,ext3,ext4,fuse,ntfs,vfat,tmpfs,xfs"
diff --git lib/tst_supported_fs_types.c lib/tst_supported_fs_types.c
index 52824cce9..7781f94c3 100644
--- lib/tst_supported_fs_types.c
+++ lib/tst_supported_fs_types.c
@@ -14,7 +14,10 @@
 #include "tst_test.h"
 #include "tst_fs.h"
 
-/* NOTE: new filesystem should be also added to tst_*skip*.sh */
+/*
+ * NOTE: new filesystem should be also added to
+ * lib/newlib_tests/shell/tst_{all_filesystems_skip,skip_filesystems}.sh
+ */
 static const char *const fs_type_whitelist[] = {
 	"ext2",
 	"ext3",
diff --git testcases/commands/df/df01.sh testcases/commands/df/df01.sh
index 9527da214..ae0449c3c 100755
--- testcases/commands/df/df01.sh
+++ testcases/commands/df/df01.sh
@@ -7,6 +7,7 @@
 # Test df command with some basic options.
 
 TST_ALL_FILESYSTEMS=1
+TST_MOUNT_DEVICE=1
 TST_CNT=12
 TST_SETUP=setup
 TST_TESTFUNC=test
diff --git testcases/lib/tst_supported_fs.c testcases/lib/tst_supported_fs.c
index e2261244d..70d4d38c7 100644
--- testcases/lib/tst_supported_fs.c
+++ testcases/lib/tst_supported_fs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2019-2022
  * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
@@ -16,12 +17,23 @@
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: tst_supported_fs [-s skip_list] [fs_type]\n");
-	fprintf(stderr, "   If fs_type is supported, return 0\n");
-	fprintf(stderr, "   If fs_type isn't supported, return 1\n");
-	fprintf(stderr, "   If fs_type isn't specified, print the list of supported filesystems\n");
-	fprintf(stderr, "   fs_type - a specified filesystem type\n");
-	fprintf(stderr, "   skip_list - filesystems to skip, delimiter: '%c'\n",
+	fprintf(stderr, "Usage:\n");
+	fprintf(stderr, "* all filesystems\n");
+	fprintf(stderr, "tst_supported_fs [-s skip_list]\n");
+	fprintf(stderr, "   print the list of supported filesystems\n");
+	fprintf(stderr, "   if fs_type is supported and not in skip_list (optional),\n"
+			"   print list of supported filesystems and return 0\n");
+	fprintf(stderr, "   if fs_type isn't supported or in skip_list, return 1\n\n");
+
+	fprintf(stderr, "* single filesystem\n");
+	fprintf(stderr, "tst_supported_fs fs_type\n");
+	fprintf(stderr, "   if fs_type is supported, return 0 otherwise return 1\n\n");
+
+	fprintf(stderr, "tst_supported_fs -s skip_list fs_type\n");
+	fprintf(stderr, "   if fs_type is in skip_list, return 1 otherwise return 0\n\n");
+
+	fprintf(stderr, "fs_type - a specified filesystem type\n");
+	fprintf(stderr, "skip_list - filesystems to skip, delimiter: '%c'\n",
 			SKIP_DELIMITER);
 }
 
@@ -80,15 +92,29 @@ int main(int argc, char *argv[])
 		return 2;
 	}
 
+	/* fs_type */
 	if (optind < argc) {
-		if (tst_fs_in_skiplist(argv[optind], (const char * const*)skiplist))
-			tst_brk(TCONF, "%s is not supported by the test", argv[optind]);
+		if (argv[optind][0] == '\0')
+			tst_brk(TCONF, "fs_type is empty");
 
-		tst_res(TINFO, "%s is supported by the test", argv[optind]);
+		if (skiplist) {
+			if (tst_fs_in_skiplist(argv[optind], (const char * const*)skiplist))
+				tst_brk(TCONF, "%s is skipped", argv[optind]);
+			else
+				tst_res(TINFO, "%s is not skipped", argv[optind]);
+
+			return 0;
+		}
+
+		if (tst_fs_is_supported(argv[optind]) == TST_FS_UNSUPPORTED)
+			tst_brk(TCONF, "%s is not supported", argv[optind]);
+		else
+			tst_res(TINFO, "%s is supported", argv[optind]);
 
 		return 0;
 	}
 
+	/* all filesystems */
 	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
 
 	if (!filesystems[0])
diff --git testcases/lib/tst_test.sh testcases/lib/tst_test.sh
index 5b2abb282..229317713 100644
--- testcases/lib/tst_test.sh
+++ testcases/lib/tst_test.sh
@@ -699,14 +699,13 @@ tst_run()
 
 	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
 
-	[ "$TST_ALL_FILESYSTEMS" = 1 ] && TST_MOUNT_DEVICE=1
 	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
-	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
+	[ "$TST_FORMAT_DEVICE" = 1 -o "$TST_ALL_FILESYSTEMS" = 1 ] && TST_NEEDS_DEVICE=1
 	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
 	if [ "$TST_ALL_FILESYSTEMS" != 1 ]; then
 		if ! tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE > /dev/null; then
-			tst_brk TCONF "$TST_FS_TYPE is not supported"
+			tst_brk TCONF "$TST_FS_TYPE is skipped by the test"
 		fi
 	fi
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
