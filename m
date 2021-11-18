Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F26C433F5
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 17:23:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A118461284
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 17:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A118461284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E99A3C896C
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 18:23:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE7243C891E
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 18:23:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 893616018C0
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 18:23:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89FB2218B0
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637256194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=flKnf9pC8/5PgvMQltRD+eu2dLSHikCvu/wKmsopIes=;
 b=L6Prj4HsIXOPSfEwza3AVc5pkt14z8PJCXdjEo7g5tt8EWAZtvcGLTl0qxfvBMPfsf+K+x
 GRQLuqUfy/NE38OvdDAKztpQsRNnmDz6mccKRyI1RnV1egY3RCF7JUAmungaJEZb1VfvWN
 xuqYhKYMGJGhLnu6L+PwGVhMS48IqoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637256194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=flKnf9pC8/5PgvMQltRD+eu2dLSHikCvu/wKmsopIes=;
 b=FJNw5L6NQUVouViEKa2yhpL/k7msgC1IfO7Wcu36AbQqppoNZ2otVIi9VQO+6lHEeWG87U
 /guqw6jxlMPbD+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7750713D8C
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 17:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sAb1GwKMlmEgVAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 17:23:14 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Nov 2021 18:23:11 +0100
Message-Id: <20211118172313.20159-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] nfs_lib.sh: Add nfs_get_remote_path()
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
