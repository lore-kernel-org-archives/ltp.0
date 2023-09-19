Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B790CCD54B8
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 11:47:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED58B3CE471
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 13:47:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EA4F3CA6BC
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 13:47:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9F6FD60083F
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 13:47:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF68B1FE89
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695124022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqbQ9UnKMbSLwxinHSdFpByEdfe0Mj4neZ5SvlBNUcI=;
 b=P3ZR9Q60s3aVz9ENkU7nfZdcqOO+if1DfFIJBLGyXFDQ82sDtPUqjiaxP901bO66H0erJ/
 Xt3dtyluv9vW4nTBqCwWEb0AJKCyI4WrTDtHaYNxiPJzcm6g64OrVOMY34a6dXSoU1p4Ps
 X+TttvAtMW+qI4fmOzif8eUsWNyDqX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695124022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqbQ9UnKMbSLwxinHSdFpByEdfe0Mj4neZ5SvlBNUcI=;
 b=GHHE0tCF9Tqb0QUFUE7kJSRzQmTMP+YgZsQIV5VD0jUoXauLG8DNYvIBk7S0ckkYYZhWHQ
 qeRoS+3pKtvw5GBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFCA113A49
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QKAnKjaKCWX8eAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:47:02 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 13:46:57 +0200
Message-ID: <20230919114701.15327-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919114701.15327-1-mdoucha@suse.cz>
References: <20230919114701.15327-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] nfs_lib.sh: Log NFS mount and unmount
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index abf7ba5a2..a996f7cc8 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -191,7 +191,9 @@ nfs_setup()
 
 		remote_dir="$(get_remote_dir $i $type)"
 		nfs_setup_server "$remote_dir" "$(($$ + n))"
-		nfs_mount "$(get_local_dir $i $n)" "$remote_dir" "-o proto=$type,vers=$i"
+		local_dir="$(get_local_dir $i $n)"
+		tst_res TINFO "Mounting $local_dir"
+		nfs_mount "$local_dir" "$remote_dir" "-o proto=$type,vers=$i"
 
 		n=$(( n + 1 ))
 	done
@@ -210,7 +212,10 @@ nfs_cleanup()
 	local n=0
 	for i in $VERSION; do
 		local_dir="$(get_local_dir $i $n)"
-		grep -q "$local_dir" /proc/mounts && umount $local_dir
+		if grep -q "$local_dir" /proc/mounts; then
+			tst_res TINFO "Unmounting $local_dir"
+			umount $local_dir
+		fi
 		n=$(( n + 1 ))
 	done
 	sleep 2
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
