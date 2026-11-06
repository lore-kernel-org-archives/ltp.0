Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61522606A329
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MxIiZkUn;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gb0VCvbk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MxIiZkUn;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gb0VCvbk
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AD1F3CD9F8
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 17:41:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C2D03C2037
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 17:41:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8DE460232D
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 17:41:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0FBE21FE6;
 Fri,  6 Nov 2026 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793983271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6q9wvPLkxkwFL23oMabhR2ilWJXjt0XTp9bUGgohWto=;
 b=MxIiZkUnF44l0LtH30eYyyJwJuTqZPYqSyG3WmLp84QbbyDWKD5IcQ+BadSEWwLEc51LHu
 erW11nBNG0Dsb3DF/2jot147Cwm8r2YjZDh5naA/6EgAWz8It4wwo2Hs4aRST553DXHll6
 0+wPx7qYJ9GC8BwtkSz2iqqL5heFjJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793983271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6q9wvPLkxkwFL23oMabhR2ilWJXjt0XTp9bUGgohWto=;
 b=gb0VCvbk4PvRoZeXQ3TRH2HlUtN2jLDhTJv+91bVytzgUf1J2EscHv10cP3931Tpz8Q+Lm
 hnAm5WvaVZRC0pDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MxIiZkUn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gb0VCvbk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793983271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6q9wvPLkxkwFL23oMabhR2ilWJXjt0XTp9bUGgohWto=;
 b=MxIiZkUnF44l0LtH30eYyyJwJuTqZPYqSyG3WmLp84QbbyDWKD5IcQ+BadSEWwLEc51LHu
 erW11nBNG0Dsb3DF/2jot147Cwm8r2YjZDh5naA/6EgAWz8It4wwo2Hs4aRST553DXHll6
 0+wPx7qYJ9GC8BwtkSz2iqqL5heFjJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793983271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6q9wvPLkxkwFL23oMabhR2ilWJXjt0XTp9bUGgohWto=;
 b=gb0VCvbk4PvRoZeXQ3TRH2HlUtN2jLDhTJv+91bVytzgUf1J2EscHv10cP3931Tpz8Q+Lm
 hnAm5WvaVZRC0pDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 623F4132C9;
 Fri,  6 Nov 2026 16:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id evP2ECcD7mrOfAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Nov 2026 16:41:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  6 Nov 2026 17:41:05 +0100
Message-ID: <20261106164105.615423-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B0FBE21FE6
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -12.01
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] zram01.sh: Rewrite to run by single filesystem
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

That allows:

1) test only particular filesystem
2) easily identify which filesystem is slow or fails

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/kernel_misc                           |  9 +++
 .../kernel/device-drivers/zram/zram01.sh      | 75 +++++++++++--------
 2 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index ac14f633e2..05ec709422 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -13,6 +13,15 @@ uaccess uaccess
 rcu_torture rcu_torture.sh
 lock_torture lock_torture.sh
 zram01 zram01.sh
+zram01_ext2 zram01.sh -f ext2
+zram01_ext3 zram01.sh -f ext3
+zram01_ext4 zram01.sh -f ext4
+zram01_xfs zram01.sh -f xfs
+zram01_btrfs zram01.sh -f btrfs
+zram01_bcachefs zram01.sh -f bcachefs
+zram01_vfat zram01.sh -f vfat
+zram01_exfat zram01.sh -f exfat
+zram01_ntfs zram01.sh -f ntfs
 zram02 zram02.sh
 zram03 zram03
 umip_basic_test umip_basic_test
diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 4b7f2a753f..3c3e0eec0b 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -1,15 +1,34 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2026 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
-# Test creates several zram devices with different filesystems on them.
-# It fills each device with zeros and checks that compression works.
+# Test creates zram device with a filesystem on it.
+# It fills the device with zeros and checks that compression works.
 
 TST_CNT=7
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk bc dd"
 TST_SETUP="setup"
+TST_OPTS="f:"
+TST_USAGE="usage"
+TST_PARSE_ARGS="parse_args"
+
+usage()
+{
+	cat << EOF
+usage: $0 [-f <ext2|ext3|ext4|xfs|btrfs|...>]
+
+OPTIONS
+-f	Specify the filesystem to be tested. If not specified,
+	\$LTP_DEV_FS_TYPE or ext2 is used.
+EOF
+}
+
+parse_args()
+{
+	TST_FS_TYPE="$2"
+}
 
 check_space_for_fs()
 {
@@ -18,14 +37,11 @@ check_space_for_fs()
 
 	ram_size=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
 	if [ "$ram_size" -lt 1048576 ]; then
-		tst_res TINFO "not enough space for $fs"
-		return 1
+		tst_brk TCONF "not enough space for $fs"
 	fi
-	return 0
 }
 
-# List of parameters for zram devices.
-# For each number the test creates own zram device.
+# Parameters for zram device.
 # NOTE about size:
 # The zram sysfs node 'disksize' value can be either in bytes,
 # or you can use mem suffixes. But in some old kernels, mem
@@ -36,34 +52,33 @@ check_space_for_fs()
 # bytes to make sure everything works correctly.
 initialize_vars()
 {
-	local fs limit size stream=-1
-	dev_num=0
+	local fs="${TST_FS_TYPE:-${LTP_DEV_FS_TYPE:-ext2}}"
+	local size="26214400"
+	local limit="25M"
 
-	for fs in $(tst_supported_fs -s tmpfs); do
-		size="26214400"
-		limit="25M"
+	[ "$fs" = "tmpfs" ] && tst_brk TCONF "tmpfs is not supported"
 
-		if [ "$fs" = "btrfs" -o "$fs" = "xfs" ]; then
-			check_space_for_fs "$fs" || continue
+	tst_supported_fs "$fs" || \
+		tst_brk TCONF "filesystem $fs is not supported"
 
-			if [ "$fs" = "btrfs" ]; then
-				size="402653184"
-			elif [ "$fs" = "xfs" ]; then
-				size=314572800
-			fi
-			limit="$((size/1024/1024))M"
+	if [ "$fs" = "btrfs" -o "$fs" = "xfs" ]; then
+		check_space_for_fs "$fs"
+
+		if [ "$fs" = "btrfs" ]; then
+			size="402653184"
+		elif [ "$fs" = "xfs" ]; then
+			size=314572800
 		fi
+		limit="$((size/1024/1024))M"
+	fi
 
-		stream=$((stream+3))
-		dev_num=$((dev_num+1))
-		zram_filesystems="$zram_filesystems $fs"
-		zram_mem_limits="$zram_mem_limits $limit"
-		zram_sizes="$zram_sizes $size"
-		zram_max_streams="$zram_max_streams $stream"
-	done
+	tst_res TINFO "testing $fs filesystem"
 
-	[ $dev_num -eq 0 ] && \
-		tst_brk TCONF "no suitable filesystem"
+	dev_num=1
+	zram_filesystems="$fs"
+	zram_mem_limits="$limit"
+	zram_sizes="$size"
+	zram_max_streams="2"
 }
 
 setup()
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
