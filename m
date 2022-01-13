Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34273C433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 15:37:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D62403C58A8
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 16:37:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 188A63C58A8
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 16:36:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 217E11A00919
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 16:36:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E3D8210EC;
 Thu, 13 Jan 2022 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642088212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gkIQl/AZl+lhjtgAPQzcbgnMgZ2twAhzyowoWOxUT4M=;
 b=vfaC2GS7m/WdIPraEjibkv2yzh1fZwyxgFz3LAaPpfQt1gEtsZLurvkGIo6+R69q+vrl7V
 M7OM2+NhttUfUCE13BgEVTxTBcVGs3VomSmkcKj5UcIccWM5viVyH/ScLPlosD5J3tbKJn
 Jq5wj/fAEie4Nxk3ZfETpnPih+gsEcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642088212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gkIQl/AZl+lhjtgAPQzcbgnMgZ2twAhzyowoWOxUT4M=;
 b=LZU9Lb78pdxwMaWQ/zqejRKGvB/1zbX/wozpMD4AKWycpdgVzSJMoIityC5mPV0JaVs8ZA
 B2AzrlfVEBdH8BBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DCB31330C;
 Thu, 13 Jan 2022 15:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aKe+BRRH4GHHGwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Jan 2022 15:36:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 13 Jan 2022 16:36:48 +0100
Message-Id: <20220113153648.19717-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] net: Use API function
 tst_net_use_netns()
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
Cc: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

instead of LTP_NETNS variable

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 4 ++--
 testcases/network/nfs/nfsstat01/nfsstat01   | 2 +-
 testcases/network/virt/wireguard01.sh       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index b012151363..884109890d 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -91,7 +91,7 @@ nfs_mount()
 	local host_type=rhost
 	local mount_dir
 
-	[ -n "$LTP_NETNS" ] && host_type=
+	tst_net_use_netns && host_type=
 
 	if [ $TST_IPV6 ]; then
 		mount_dir="[$(tst_ipaddr $host_type)]:$remote_dir"
@@ -102,7 +102,7 @@ nfs_mount()
 	local mnt_cmd="mount -v -t nfs $opts $mount_dir $local_dir"
 
 	tst_res TINFO "Mounting NFS: $mnt_cmd"
-	if [ -n "$LTP_NETNS" ] && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
+	if tst_net_use_netns && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
 		tst_rhost_run -c "$mnt_cmd" > mount.log
 	else
 		$mnt_cmd > mount.log
diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index b71129fd25..06844af396 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -17,7 +17,7 @@ get_calls()
 	local opt=
 	[ "$name" = "rpc" ] && opt="r" || opt="n"
 
-	if [ -n "$LTP_NETNS" -o "$nfs_f" = "nfs" ]; then
+	if tst_net_use_netns || [ "$nfs_f" = "nfs" ]; then
 		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
 		ROD nfsstat -c$opt | grep -q "$calls"
 		echo "$calls"
diff --git a/testcases/network/virt/wireguard01.sh b/testcases/network/virt/wireguard01.sh
index ff0c7e92b5..05d696a786 100755
--- a/testcases/network/virt/wireguard01.sh
+++ b/testcases/network/virt/wireguard01.sh
@@ -12,7 +12,7 @@ TST_CNT=3
 
 setup()
 {
-	if [ -n "$LTP_NETNS" -a "$VIRT_PERF_THRESHOLD" -lt 700 ]; then
+	if tst_net_use_netns && [ "$VIRT_PERF_THRESHOLD" -lt 700 ]; then
 		tst_res TINFO "Adjust threshold for veth (no encap/encrypt)"
 		VIRT_PERF_THRESHOLD=700
 	fi
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
