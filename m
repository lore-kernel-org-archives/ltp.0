Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5E8C7EE21
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 13:14:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C74323CD8BF
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 15:14:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF9D73CB7BB
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:14:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 420DE200B03
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:14:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F26E1FF73;
 Thu,  4 May 2023 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683206046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akIoO/Oc1cHzyjDxWGHLqsPOi6W/co79Mdb3DCW+ZE0=;
 b=toujx3QUynVly1TxHkF2wc25tiQYgJ82ucdSDpMZJqJ3DbSZcChJptO6LQGZJAIMoGubvy
 xwp6lucR4YzYV9UcyEB6DPOet7Q2ZHkVgR3RCDmMQjTyCFH1JQ+r7fubryucDF8N3niKK/
 bRBY1A3NvcOc6BzuUaPtXLWoMgTpiWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683206046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akIoO/Oc1cHzyjDxWGHLqsPOi6W/co79Mdb3DCW+ZE0=;
 b=rXxfh9TujK2VZ8n+y8Q5Ib1tD1VTcnMtibg9lOSsJpEXcbbpF1/25Z3RY1aNdE/zWVs6BU
 RE3SltDt1gNrB7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0E9F13444;
 Thu,  4 May 2023 13:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OKyCNJ2vU2TXVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 13:14:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 May 2023 15:14:14 +0200
Message-Id: <20230504131414.3826283-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504131414.3826283-1-pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/5] nfs: Run on btrfs, ext4, xfs
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

because there are some problems with at least vfat, exfat and tmpfs (on
nfs-utils < 2) instead of testing on all available filesystems, test
just on modern Linux filesystems btrfs, ext4, xfs.

Use variables:
* TST_ALL_FILESYSTEMS=1 to run on all filesystems
* TST_FORMAT_DEVICE=1 to get loop device formatted
* TST_MOUNT_DEVICE=1 to get it mounted

Filesystems (tested the usual LTP way on loop device) are used for
server side (exportfs), client side (NFS mount) is kept outside of it.

For some reason umounting needs some time before NFS server stops using
underlying loop device. Also exportfs needs time before files can be
removed. Otherwise second umounting fails:

nfs07 4 TINFO: Cleaning up testcase
umount: /var/tmp/LTP_nfs07.FNZ7yCbqZe/mntpoint: target is busy.
nfs07 4 TINFO: umount(/var/tmp/LTP_nfs07.FNZ7yCbqZe/mntpoint) failed, try 1 ...
nfs07 4 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
umount: /var/tmp/LTP_nfs07.FNZ7yCbqZe/mntpoint: target is busy.

Solved with adding sleep for 2 sec after first umount and sleeps for 1 sec after exportfs.
Second umount of the loop device in tst_test.sh works without any extra
sleep.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 042fea5e4..abf7ba5a2 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -28,7 +28,10 @@ NFS_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
 TST_OPTS="v:t:$TST_OPTS"
 TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
-TST_NEEDS_TMPDIR=1
+TST_ALL_FILESYSTEMS=1
+TST_SKIP_FILESYSTEMS="exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs"
+TST_MOUNT_DEVICE=1
+TST_FORMAT_DEVICE=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
@@ -68,7 +71,7 @@ get_remote_dir()
 	local v="$1"
 	local n="$2"
 
-	echo "$TST_TMPDIR/$v/$n"
+	echo "$TST_MNTPOINT/$v/$n"
 }
 
 nfs_get_remote_path()
@@ -210,6 +213,7 @@ nfs_cleanup()
 		grep -q "$local_dir" /proc/mounts && umount $local_dir
 		n=$(( n + 1 ))
 	done
+	sleep 2
 
 	n=0
 	for i in $VERSION; do
@@ -219,12 +223,15 @@ nfs_cleanup()
 		if tst_net_use_netns; then
 			if test -d $remote_dir; then
 				exportfs -u *:$remote_dir
+				sleep 1
 				rm -rf $remote_dir
 			fi
 		else
 			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
+			sleep 1
 			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
 		fi
+
 		n=$(( n + 1 ))
 	done
 }
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
