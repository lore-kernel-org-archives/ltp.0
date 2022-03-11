Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24730C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 12:49:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9291C3C8CA9
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 13:49:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1D813C0209
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 13:49:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73B0A1A014AC
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 13:49:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99C6A210F4;
 Fri, 11 Mar 2022 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647002967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ei3+js6hq/sVxvJHFVLD4pcMa6xjg3IxHSjqzNfCrUA=;
 b=zbtTY6SyuMV6gotsikbrrLKy7VUJyMr46XibDPd4Cm9UEoJVHRoTE+Xqqvf+PHESCYQ5JE
 bfmkEM6nGoK4STO7GCG1kdoaipVzfrsQy5zU4+5F/tstAhitW/KRK7QMOt+Zs7OPSH3/PS
 hn/wqxgjTPvNMaHV8VTnOSw6ysnVwTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647002967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ei3+js6hq/sVxvJHFVLD4pcMa6xjg3IxHSjqzNfCrUA=;
 b=8Flv53TTMupmkPbnWL8VTT2fFeq2HZfO2sst6/2fIfsDiQmjaI8iBpN355BwzY6WzRXSTH
 WDtw+/bXfT0RbwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FAE413A85;
 Fri, 11 Mar 2022 12:49:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gLCYFVdFK2LOPwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Mar 2022 12:49:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Mar 2022 13:49:23 +0100
Message-Id: <20220311124923.6504-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] nfs_lib: Fix fsid randomisation
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
Cc: Neil Brown <neilb@suse.de>, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Testing nfs with multiple versions (-v, i.e. nfs0*_06 - testing with
nfs06.sh) nfs_lib.sh exports multiple different directories all with the
same fsid= value, which is not supposed to work (and breaks on older
nfs-utils).

Therefore increase fsid value for each loop.

Reported-by: Neil Brown <neilb@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

fsid check is not required, but added to prevent another false positive
in the future.

Thanks Neil!

Kind regards,
Petr

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 7a7cd9925b..ad96bb4438 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -79,7 +79,11 @@ nfs_server_udp_enabled()
 
 nfs_setup_server()
 {
-	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"
+
+	local fsid="$1"
+	local export_cmd="exportfs -i -o fsid=$fsid,no_root_squash,rw *:$remote_dir"
+
+	[ -z "$fsid" ] && tst_brk TBROK "empty fsid"
 
 	if tst_net_use_netns; then
 		if ! test -d $remote_dir; then
@@ -161,7 +165,7 @@ nfs_setup()
 		remote_dir="$TST_TMPDIR/$i/$type"
 		mkdir -p $local_dir
 
-		nfs_setup_server
+		nfs_setup_server $(($$ + n))
 
 		opts="-o proto=$type,vers=$i"
 		nfs_mount
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
