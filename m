Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC3DC19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:21:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66C763C9413
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 14:21:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26DC83C9423
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 709681400995
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA41620FB0;
 Thu,  4 Aug 2022 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659615596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ganAk8Biqarzg14uiXeLH2Z9aMYAKLnAxtmJQDbKiyc=;
 b=DAX2VrjElcjJExZRMwZoWYMXR4EfqZNSzL5h6M7RJPhyNGqHeayYVKmLe5fUU6TL2/Nr3u
 hUqXx7AClrfJoHxA2LBzkDIowTklO2ccZ5LaT5sJTMSouqgpgFcYOp72jvspK12hF616jf
 6rbEfroOYg1GQOSb8TMsZfGQ4jBHciA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659615596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ganAk8Biqarzg14uiXeLH2Z9aMYAKLnAxtmJQDbKiyc=;
 b=HPXpnSvxhmQF9GvLgJRX7+TvHpOLHow2RMX4ggTS8oI9fgFafkrKmdzOLFB86PiADCY1Eb
 CnN2ByW1SBLlHJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FC2D13A94;
 Thu,  4 Aug 2022 12:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CI/IGGy562L2PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 12:19:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 14:19:46 +0200
Message-Id: <20220804121946.19564-11-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804121946.19564-1-pvorel@suse.cz>
References: <20220804121946.19564-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH v3 10/10] nfs: Use TST_ALL_FILESYSTEMS=1
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
Cc: "J . Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org,
 NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
 automated-testing@yoctoproject.org, Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* restart_daemon nfs-server + tst_sleep 500ms
  But still sometimes last test TCONF due server not being ready
  (restart is not reliable) :(
* Skip NTFS and vfat (NTFS is problematic, vfat IMHO does not make sense
  to test).

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 28 +++++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index af7d46a21..b9872bb31 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -8,6 +8,7 @@ VERSION=${VERSION:=3}
 NFILES=${NFILES:=1000}
 SOCKET_TYPE="${SOCKET_TYPE:-udp}"
 NFS_TYPE=${NFS_TYPE:=nfs}
+TST_SKIP_FILESYSTEMS="ntfs,vfat"
 
 nfs_usage()
 {
@@ -28,7 +29,7 @@ NFS_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
 TST_OPTS="v:t:$TST_OPTS"
 TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
-TST_NEEDS_TMPDIR=1
+TST_ALL_FILESYSTEMS=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
@@ -63,7 +64,7 @@ nfs_get_remote_path()
 	done
 
 	v=${1:-$v}
-	echo "$TST_TMPDIR/$v/$type"
+	echo "$TST_MNTPOINT/$v/$type"
 }
 
 nfs_server_udp_enabled()
@@ -162,8 +163,8 @@ nfs_setup()
 			tst_brk TCONF "UDP support disabled on NFS server"
 		fi
 
-		local_dir="$TST_TMPDIR/$i/$n"
-		remote_dir="$TST_TMPDIR/$i/$type"
+		local_dir="$TST_MNTPOINT/$i/$n"
+		remote_dir="$TST_MNTPOINT/$i/$type"
 		mkdir -p $local_dir
 
 		nfs_setup_server $(($$ + n))
@@ -174,7 +175,7 @@ nfs_setup()
 	done
 
 	if [ "$n" -eq 1 ]; then
-		cd ${VERSION}/0
+		cd $TST_MNTPOINT/$VERSION/0
 	fi
 }
 
@@ -190,19 +191,24 @@ nfs_cleanup()
 
 	local n=0
 	for i in $VERSION; do
-		local_dir="$TST_TMPDIR/$i/$n"
-		grep -q "$local_dir" /proc/mounts && umount $local_dir
+		type=$(get_socket_type $n)
+		remote_dir="$TST_MNTPOINT/$i/$type"
+		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
+		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
 		n=$(( n + 1 ))
 	done
 
 	n=0
 	for i in $VERSION; do
-		type=$(get_socket_type $n)
-		remote_dir="$TST_TMPDIR/$i/$type"
-		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
-		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
+		local_dir="$TST_MNTPOINT/$i/$n"
+
+		grep -q "$local_dir" /proc/mounts && umount $local_dir
 		n=$(( n + 1 ))
 	done
+
+	restart_daemon nfs-server
+	tst_sleep 500ms
 }
 
+. daemonlib.sh
 . tst_net.sh
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
