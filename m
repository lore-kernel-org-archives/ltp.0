Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB601ECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:20:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AAF23CAA0B
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:20:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2B013CAA89
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5EEAF100119F
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 08AB21F943;
 Fri,  9 Sep 2022 14:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662733134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUyjrMghggyvhcASm6/GN83YNPeS5wEjrIL6nGsTYyk=;
 b=Z6fw5kzNKXOUs05IifZV1fJgjOc0arEjlNudEAgWA5I9MIAVsGXOWywnGtFs4jUtvMQNEq
 g8LObkw8QVBkqG3yZFmS5EceHCFq6P8wbmnNCGPyP4xZe3go/OdF0wPZM6DX7LI44IBp4B
 MljLrRnBkCsAu5fuZnHa9tACOEJHzao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662733134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUyjrMghggyvhcASm6/GN83YNPeS5wEjrIL6nGsTYyk=;
 b=zJdl+rCaW74oP/tavc3A95CUibvXjhKRd3LdFy21z4VLoHgwntOdQQiHDng1tJ3xpDZOrm
 IgOUmsuQi2aUSjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CA5113A93;
 Fri,  9 Sep 2022 14:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EFaPFE1LG2NmWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:18:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Sep 2022 16:18:40 +0200
Message-Id: <20220909141840.18327-11-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909141840.18327-1-pvorel@suse.cz>
References: <20220909141840.18327-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 10/10] df01.sh: Convert to TST_ALL_FILESYSTEMS=1
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v4

 runtest/commands              |  8 +-------
 runtest/smoketest             |  2 +-
 testcases/commands/df/df01.sh | 32 +++++++++-----------------------
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/runtest/commands b/runtest/commands
index 8cfad0449..5ec2c3b69 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -14,13 +14,7 @@ ln01_sh ln_tests.sh
 mkdir01_sh mkdir_tests.sh
 mv01_sh mv_tests.sh
 du01_sh du01.sh
-df01_ext2_sh df01.sh -f ext2
-df01_ext3_sh df01.sh -f ext3
-df01_ext4_sh df01.sh -f ext4
-df01_xfs_sh df01.sh -f xfs
-df01_vfat_sh df01.sh -f vfat
-df01_exfat_sh df01.sh -f exfat
-df01_ntfs_sh df01.sh -f ntfs
+df01_sh df01.sh
 mkfs01_sh mkfs01.sh
 mkfs01_ext2_sh mkfs01.sh -f ext2
 mkfs01_ext3_sh mkfs01.sh -f ext3
diff --git a/runtest/smoketest b/runtest/smoketest
index 485f211fb..83eebfe7b 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -12,7 +12,7 @@ stat04 symlink01 -T stat04
 utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
-df01_ext4_sh df01.sh -f ext4
+df01_sh df01.sh
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
 ping602 ping02.sh -6
 macsec02 macsec02.sh
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 1e86d1c40..ddfa9d9a7 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -6,35 +6,19 @@
 #
 # Test df command with some basic options.
 
+TST_ALL_FILESYSTEMS=1
 TST_CNT=12
 TST_SETUP=setup
 TST_TESTFUNC=test
-TST_OPTS="f:"
-TST_USAGE=usage
-TST_PARSE_ARGS=parse_args
 TST_NEEDS_ROOT=1
-TST_MOUNT_DEVICE=1
-
-usage()
-{
-	cat << EOF
-usage: $0 [-f <ext2|ext3|ext4|vfat|...>]
-
-OPTIONS
--f	Specify the type of filesystem to be built.  If not
-	specified, the default filesystem type (currently ext2)
-	is used.
-EOF
-}
-
-parse_args()
-{
-	TST_FS_TYPE="$2"
-}
 
 setup()
 {
-	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk 'NR==1{print $5}')
+	DF_FS_TYPE="$TST_FS_TYPE"
+
+	if [ "$TST_FS_TYPE_FUSE" = 1 ]; then
+		DF_FS_TYPE="fuseblk"
+	fi
 }
 
 df_test()
@@ -180,7 +164,9 @@ test11()
 
 test12()
 {
-	local cmd="df -x $DF_FS_TYPE -P"
+	local fs="$DF_FS_TYPE"
+
+	local cmd="df -x $fs -P"
 
 	df_verify $cmd
 	if [ $? -ne 0 ]; then
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
