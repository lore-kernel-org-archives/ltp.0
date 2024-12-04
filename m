Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED69E7716D
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 17:23:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED9AF3DF298
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 18:23:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5845A3DF250
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 18:23:21 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AE26764AD3B
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 18:23:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 858FC21264
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733332998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qn1zXNeUMqCXvBbNFTPRWMT4UWkd8qWdyphBnImPhp4=;
 b=e6/6iFhH29Ylxj2wpcx0T3lMjoAJI7Crz9eqZNjh2azCJaBDkhK2RvpRmgaRUPfnD0vyfT
 SR9Bpbedrok0l4YDnJ9dYyUdbwPv3HVWtbigQHMJud82HAhFk+88JspCMdT3mcy2g+KXP/
 swNWtkR+TTheF/TILRCl2r1cdW7FCuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733332998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qn1zXNeUMqCXvBbNFTPRWMT4UWkd8qWdyphBnImPhp4=;
 b=Ia65M2/Ln/Lzlc2PFXDULC+BKM4DHzVt7r9MtgoEW28CD1joIpJf1JOzE9AU2U6+s1RceX
 WMjzREtbDxhsuvAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733332998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qn1zXNeUMqCXvBbNFTPRWMT4UWkd8qWdyphBnImPhp4=;
 b=e6/6iFhH29Ylxj2wpcx0T3lMjoAJI7Crz9eqZNjh2azCJaBDkhK2RvpRmgaRUPfnD0vyfT
 SR9Bpbedrok0l4YDnJ9dYyUdbwPv3HVWtbigQHMJud82HAhFk+88JspCMdT3mcy2g+KXP/
 swNWtkR+TTheF/TILRCl2r1cdW7FCuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733332998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Qn1zXNeUMqCXvBbNFTPRWMT4UWkd8qWdyphBnImPhp4=;
 b=Ia65M2/Ln/Lzlc2PFXDULC+BKM4DHzVt7r9MtgoEW28CD1joIpJf1JOzE9AU2U6+s1RceX
 WMjzREtbDxhsuvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C7CB13974
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 17:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p7kLHgaQUGe/GAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 04 Dec 2024 17:23:18 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Dec 2024 18:23:09 +0100
Message-ID: <20241204172312.34099-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] nfs_lib.sh: Add support for extra NFS mount
 options
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

Changes since v2: New patch

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index d3de3b7f1..f0da1fc99 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -168,6 +168,7 @@ nfs_setup()
 	local local_dir
 	local remote_dir
 	local mount_dir
+	local nfs_opts
 
 	if [ "$(stat -f . | grep "Type: nfs")" ]; then
 		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
@@ -192,8 +193,14 @@ nfs_setup()
 		remote_dir="$(get_remote_dir $i $type)"
 		nfs_setup_server "$remote_dir" "$(($$ + n))"
 		local_dir="$(get_local_dir $i $n)"
+		nfs_opts="-o proto=$type,vers=$i"
+
+		if [ ! -z "$NFS_MOUNT_OPTS" ]; then
+			nfs_opts="$nfs_opts,$NFS_MOUNT_OPTS"
+		fi
+
 		tst_res TINFO "Mounting $local_dir"
-		nfs_mount "$local_dir" "$remote_dir" "-o proto=$type,vers=$i"
+		nfs_mount "$local_dir" "$remote_dir" "$nfs_opts"
 
 		n=$(( n + 1 ))
 	done
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
