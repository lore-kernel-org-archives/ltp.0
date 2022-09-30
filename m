Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D59BC433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 09:12:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D6A73CA944
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 11:12:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B61C63CA599
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:12:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7861C201109
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:12:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD26621882;
 Fri, 30 Sep 2022 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664529133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nW1BnEWbDbB1D+myiFaHZZMT/D0sLODcYdsIvtgDXco=;
 b=wUyxVldl28JbNJmZRPD0igozOIYO6EVP234DKbD7ZuYvHcnOpoGk37vv/z7WW+x1Y7ZTWm
 p5xjSfdqc+JysyFv3l/RrPx1QTY7aCN3OPN+92h6296m6rJ7nBB0HFg3CylMB/xbfjQSl/
 /VS51YFmQuNecibDHe/gOLEQY8m4Q5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664529133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nW1BnEWbDbB1D+myiFaHZZMT/D0sLODcYdsIvtgDXco=;
 b=YnHY1LXtQ/A06bJcNUzfyZIUk/Q89t7yNrzJUvZ9aiw3l6NQdRuxl+cJpNE1Q3cmCtHSww
 dW5or1ma+hv7fIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 599AE13776;
 Fri, 30 Sep 2022 09:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Rg9IFO2yNmOyVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 09:12:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 30 Sep 2022 11:12:08 +0200
Message-Id: <20220930091208.5688-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] zram01.sh: Fix minimal size for XFS on kernel
 5.19
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

mkfs.xfs for kernel 5.19 bumps minimum filesystems 300 MB. Due this we
already updated minimal filesystem size for all_filesystems /
$TST_ALL_FILESYSTEMS in 66e05c841. But zram01.sh does not use the API,
thus update it now.

Also require 1G of RAM for XFS (check originally added in f18c8fd3a for
Btrfs on ppc64le due to larger page size, likely needed for also XFS).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* add 1GB memory check also for XFS (check_space_for_fs, Cyril)

Kind regards,
Petr

 testcases/kernel/device-drivers/zram/zram01.sh | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 8b92b699f..d4e46c247 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -11,13 +11,14 @@ TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk bc dd"
 TST_SETUP="setup"
 
-check_space_for_btrfs()
+check_space_for_fs()
 {
+	local fs="$1"
 	local ram_size
 
 	ram_size=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
 	if [ "$ram_size" -lt 1048576 ]; then
-		tst_res TINFO "not enough space for Btrfs"
+		tst_res TINFO "not enough space for $fs"
 		return 1
 	fi
 	return 0
@@ -41,9 +42,15 @@ initialize_vars()
 	for fs in $(tst_supported_fs -s tmpfs); do
 		size="26214400"
 		limit="25M"
-		if [ "$fs" = "btrfs" ]; then
-			check_space_for_btrfs || continue
-			size="402653184"
+
+		if [ "$fs" = "btrfs" -o "$fs" = "xfs" ]; then
+			check_space_for_fs "$fs" || continue
+
+			if [ "$fs" = "btrfs" ]; then
+				size="402653184"
+			elif [ "$fs" = "xfs" ]; then
+				size=314572800
+			fi
 			limit="$((size/1024/1024))M"
 		fi
 
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
