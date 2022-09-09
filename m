Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA11BC6FA82
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:20:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1786C3CAA52
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:20:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD15F3CAA0E
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3BD5E6019B2
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABFD51F913;
 Fri,  9 Sep 2022 14:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662733130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4U8RPbmepC6zWJaGqaLLHmtY8bzYHT28T96+HDAcl4=;
 b=OOrpJJ0qD+lzM4uu1GiDNldvbB5J3x/LvQNSXNsnXovT7DwpIiq+P0qwmTT9m8EEKldrja
 rlGT3rQsHGguYPcKLymYHy9se5bdhwsOuZ4eN5fXrLxifmXrwM3c3ywI20RXT3A6G8XHeO
 NmcTrIX9geH8Y7CqtRjHIO1qpyVRoas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662733130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4U8RPbmepC6zWJaGqaLLHmtY8bzYHT28T96+HDAcl4=;
 b=SfNYNNy1sXriiJY+SCDwqQT+8sTs0Q15jUubQJZV0Ul3xCuppcyYcSspiU/LjTvOuD7nZl
 l8t5wzapjSg9zIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8222113A93;
 Fri,  9 Sep 2022 14:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YI4UG0lLG2NmWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:18:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Sep 2022 16:18:37 +0200
Message-Id: <20220909141840.18327-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909141840.18327-1-pvorel@suse.cz>
References: <20220909141840.18327-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 07/10] tst_test.sh: Introduce TST_FS_TYPE_FUSE
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Useful if tests need to grep on mount output (there is fuseblk instead
of expected filesystem).

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt    |  2 ++
 testcases/lib/tst_test.sh | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 18ed144a9..e16080061 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -210,6 +210,8 @@ simply by setting right '$TST_FOO'.
 | 'TST_DEVICE'             | Block device name for 'tst_mount' and 'tst_mkfs', see
                              https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem].
 | 'TST_FS_TYPE'            | Override the default filesystem to be used.
+| 'TST_FS_TYPE_FUSE'       | 1 if mounted 'TST_FS_TYPE' filesystem on
+                             'TST_DEVICE' device is FUSE.
 | 'TST_MNTPOINT'           | Holds path to mountpoint used in 'tst_mount', see
                              https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem].
 | 'TST_MNT_PARAMS'         | Extra mount params for 'tst_mount', see
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2937bd80c..78dbfc1ce 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -307,6 +307,18 @@ tst_mount()
 	if [ $ret -ne 0 ]; then
 		tst_brk TBROK "Failed to mount device${mnt_err}: mount exit = $ret"
 	fi
+
+	mnt_real="$(grep -E "$TST_MNTPOINT ($TST_FS_TYPE|fuseblk)" /proc/mounts | awk 'NR==1{print $3}')"
+	case $mnt_real in
+		'') tst_brk TBROK 'Failed to found filesystem type in /proc/mounts';;
+		'fuseblk') TST_FS_TYPE_FUSE=1;;
+		*)
+			if [ "$mnt_real" != "$TST_FS_TYPE" ]; then
+				tst_brk TBROK "$mnt_real: unsupported type in /proc/mounts"
+			fi
+			TST_FS_TYPE_FUSE=
+		;;
+		esac
 }
 
 tst_umount()
@@ -636,7 +648,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
-			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
+			NEEDS_DRIVERS|FS_TYPE|FS_TYPE_FUSE|MNTPOINT|MNT_PARAMS);;
 			NEEDS_KCONFIGS|NEEDS_KCONFIGS_IFS);;
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
