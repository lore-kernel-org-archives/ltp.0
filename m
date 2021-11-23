Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC866C433F5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 15:15:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D6653C8EB5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 16:15:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05A013C25EC
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 16:15:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E569600FA5
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 16:15:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9876D1FD35
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637680538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bRUZZvUOmhPBuNW+psE1TQA/CGArMtrzLDdgmLW9k8Y=;
 b=KikdeH+/bKO/fks7Ym5zZIklaauuhXHoBT2OyK4Zt7TfMCHRLVkU5bpk73sN1ZP9/XZdlB
 HWSO9YbKzzJU7ZD4ZJuHOMI0LtLqgK+gw+iondgwBKPhrWKvBvtK/zt/0/wGO9kBiZibny
 m1X93iYKqqyHSEBcy+MKkCrxhNIe2pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637680538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bRUZZvUOmhPBuNW+psE1TQA/CGArMtrzLDdgmLW9k8Y=;
 b=+QBBxA7KkWeeK/7isEvzpKBk5QXmHA5wmxQM40BuxaBhy/2uWAoSpEY0qfLfCOOHJ0gfId
 ZllKAcXaOhBixyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85AB413E20
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1RZwH5oFnWHqQwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:15:38 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Nov 2021 16:15:35 +0100
Message-Id: <20211123151537.14913-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] nfs_lib.sh: Add nfs_get_remote_path()
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

Sometimes it's necessary to manipulate remote NFS directory directly e.g.
to simulate external server activity. nfs_get_remote_path() will print
the remote path so that it can then be used by tst_rhost_run().

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 206f11fdd..790655643 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -52,6 +52,19 @@ get_socket_type()
 	done
 }
 
+nfs_get_remote_path()
+{
+	local v
+	local type=$(get_socket_type ${2:-0})
+
+	for v in $VERSION; do
+		break;
+	done
+
+	v=${1:-$v}
+	echo "$TST_TMPDIR/$v/$type"
+}
+
 nfs_server_udp_enabled()
 {
 	local config f
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
