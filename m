Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F33C77B61
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 21:09:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 249B13CEA3B
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 23:09:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 439203CBCCB
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 23:08:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CBCFF2000AF
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 23:08:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 443EE2197E;
 Mon, 24 Apr 2023 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682370492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewYSS6/K3VhhpPZUmvT8hvwvjLF4gKgkfo/wRmB4X9g=;
 b=xlT7Bg/Cf3/i+UbwgR91qSyM+0L9fHTBEh0U+zN8oZyc5PzX4YJ+qgTJAxHbMbMp0AiB4q
 UF7/aThlT1IUYzTOPgGo09avND1bwGJ5/pG+ObBqc43KkVY2riMGS651LD8iYymGaXtzn1
 wQYrSzlkKjmsB82Omsf4th53Szf3BPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682370492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewYSS6/K3VhhpPZUmvT8hvwvjLF4gKgkfo/wRmB4X9g=;
 b=FicrRFrffoJrGjsaBGE2xi0QnSheBtJUCeo77JpYpEMyqytHTKbx5C6dDRaNd1sRLa5kt3
 8J4AoIJ1GxzRN2BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFAA01390E;
 Mon, 24 Apr 2023 21:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uCTxJ7vvRmSzIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 21:08:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Apr 2023 23:08:16 +0200
Message-Id: <20230424210818.2885479-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424210818.2885479-1-pvorel@suse.cz>
References: <20230424210818.2885479-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] nfs_lib.sh: Cleanup local and remote
 directories setup
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Logic for creating local and remote directories was on more places.
Create get_local_dir() and get_remote_dir() functions to keep it on
single place.

local dir is needed in nfs_mount(), but was defined in nfs_setup()
and reused local variable with shell inheritance (ugly!), because there
were all parameters from loop.  Similarly, remote dir is needed in
both nfs_mount() and nfs_setup_server(), but created with shell
inheritance in nfs_setup().  Pass these params to nfs_mount() and
nfs_setup_server() and define variables with new functions
get_local_dir() and get_remote_dir().

Use get_remote_dir() in nfs_get_remote_path().

Move cd to local directory to the end of nfs_mount() (it used to cd
after nfs_mount(), but only if -v parameter contained single version,
but it does not harm to always cd).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 52 ++++++++++++++-------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index af7d46a21..1b5604ab5 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2016-2022
+# Copyright (c) Linux Test Project, 2016-2023
 # Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 
@@ -53,6 +53,24 @@ get_socket_type()
 	done
 }
 
+# directory mounted by NFS client
+get_local_dir()
+{
+	local v="$1"
+	local n="$2"
+
+	echo "$TST_TMPDIR/$v/$n"
+}
+
+# directory on NFS server
+get_remote_dir()
+{
+	local v="$1"
+	local n="$2"
+
+	echo "$TST_TMPDIR/$v/$n"
+}
+
 nfs_get_remote_path()
 {
 	local v
@@ -63,7 +81,7 @@ nfs_get_remote_path()
 	done
 
 	v=${1:-$v}
-	echo "$TST_TMPDIR/$v/$type"
+	echo "$(get_remote_dir $v $type)"
 }
 
 nfs_server_udp_enabled()
@@ -78,8 +96,8 @@ nfs_server_udp_enabled()
 
 nfs_setup_server()
 {
-
-	local fsid="$1"
+	local remote_dir="$1"
+	local fsid="$2"
 	local export_cmd="exportfs -i -o fsid=$fsid,no_root_squash,rw *:$remote_dir"
 
 	[ -z "$fsid" ] && tst_brk TBROK "empty fsid"
@@ -97,10 +115,14 @@ nfs_setup_server()
 
 nfs_mount()
 {
-	local opts="$1"
+	local local_dir="$1"
+	local remote_dir="$2"
+	local opts="$3"
 	local host_type=rhost
 	local mount_dir
 
+	mkdir -p "$local_dir"
+
 	tst_net_use_netns && host_type=
 
 	if [ $TST_IPV6 ]; then
@@ -131,6 +153,8 @@ nfs_mount()
 
 		tst_brk TBROK "mount command failed"
 	fi
+
+	cd "$local_dir"
 }
 
 nfs_setup()
@@ -162,20 +186,12 @@ nfs_setup()
 			tst_brk TCONF "UDP support disabled on NFS server"
 		fi
 
-		local_dir="$TST_TMPDIR/$i/$n"
-		remote_dir="$TST_TMPDIR/$i/$type"
-		mkdir -p $local_dir
-
-		nfs_setup_server $(($$ + n))
-
-		nfs_mount "-o proto=$type,vers=$i"
+		remote_dir="$(get_remote_dir $i $type)"
+		nfs_setup_server "$remote_dir" "$(($$ + n))"
+		nfs_mount "$(get_local_dir $i $n)" "$remote_dir" "-o proto=$type,vers=$i"
 
 		n=$(( n + 1 ))
 	done
-
-	if [ "$n" -eq 1 ]; then
-		cd ${VERSION}/0
-	fi
 }
 
 nfs_cleanup()
@@ -190,7 +206,7 @@ nfs_cleanup()
 
 	local n=0
 	for i in $VERSION; do
-		local_dir="$TST_TMPDIR/$i/$n"
+		local_dir="$(get_local_dir $i $n)"
 		grep -q "$local_dir" /proc/mounts && umount $local_dir
 		n=$(( n + 1 ))
 	done
@@ -198,7 +214,7 @@ nfs_cleanup()
 	n=0
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
-		remote_dir="$TST_TMPDIR/$i/$type"
+		remote_dir="$(get_remote_dir $i $type)"
 		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
 		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
 		n=$(( n + 1 ))
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
