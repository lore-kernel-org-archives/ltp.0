Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9C2C4829A
	for <ltp@archiver.kernel.org>; Tue, 13 Feb 2024 14:02:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0F8C3CF3A2
	for <ltp@archiver.kernel.org>; Tue, 13 Feb 2024 15:02:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 573453CAB73
 for <ltp@lists.linux.it>; Tue, 13 Feb 2024 15:02:36 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D58321A01457
 for <ltp@lists.linux.it>; Tue, 13 Feb 2024 15:02:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A90721F7EB;
 Tue, 13 Feb 2024 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707832954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eVPDY5RElfBlW64BTdRFKtA64Ekc4lvwKcunHM4lwE8=;
 b=icjtfaOxtVCLEG+L6SR9XcVMUtxjFzmU2jYIaSy2RoWGmfAwQ4d7nEd9oBvQeylfxMTFwO
 atLfpVOTnvYiEGEx4Aaok7O/+DPxIze5Q9E4sdVY9vH3B6Q0ecoULHERKB83+qkFAO6NuO
 w7IrnVSWRXm4NBVqcoW0jl91Yxhn12U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707832954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eVPDY5RElfBlW64BTdRFKtA64Ekc4lvwKcunHM4lwE8=;
 b=5JuzIXEoM8dUDO/qhJO5Njtvwm2/a9PViTmsP5wi0MO7woyio30lwSh4htjsJ2z6U65ql3
 WIu1Eqtd6tLkFqCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707832954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eVPDY5RElfBlW64BTdRFKtA64Ekc4lvwKcunHM4lwE8=;
 b=icjtfaOxtVCLEG+L6SR9XcVMUtxjFzmU2jYIaSy2RoWGmfAwQ4d7nEd9oBvQeylfxMTFwO
 atLfpVOTnvYiEGEx4Aaok7O/+DPxIze5Q9E4sdVY9vH3B6Q0ecoULHERKB83+qkFAO6NuO
 w7IrnVSWRXm4NBVqcoW0jl91Yxhn12U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707832954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eVPDY5RElfBlW64BTdRFKtA64Ekc4lvwKcunHM4lwE8=;
 b=5JuzIXEoM8dUDO/qhJO5Njtvwm2/a9PViTmsP5wi0MO7woyio30lwSh4htjsJ2z6U65ql3
 WIu1Eqtd6tLkFqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C6571370C;
 Tue, 13 Feb 2024 14:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y8vJJXp2y2WWIgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 13 Feb 2024 14:02:34 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Petr Vorel <pvorel@suse.cz>,
	ltp@lists.linux.it
Date: Tue, 13 Feb 2024 15:02:11 +0100
Message-ID: <20240213140233.14445-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=icjtfaOx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5JuzIXEo
X-Spamd-Result: default: False [3.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A90721F7EB
X-Spamd-Bar: +++
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add test for file truncation over NFS
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

Some older kernels have a bug in NFS where the client caches that
a file does not exist after unsuccessful access to it and then
does not pass O_TRUNC flag to the server even though the file may
have been created by another client in the mean time. This may result
in new data being merged with old file contents instead of replacing
them.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/net.nfs                           | 11 ++++++++
 testcases/network/nfs/nfs_stress/nfs09.sh | 34 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100755 testcases/network/nfs/nfs_stress/nfs09.sh

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 9c1c5c63e..af2a64174 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -83,6 +83,17 @@ nfs08_v40_ip6t nfs08.sh -6 -v 4 -t tcp
 nfs08_v41_ip6t nfs08.sh -6 -v 4.1 -t tcp
 nfs08_v42_ip6t nfs08.sh -6 -v 4.2 -t tcp
 
+nfs09_v30_ip4u nfs09.sh -v 3 -t udp
+nfs09_v30_ip4t nfs09.sh -v 3 -t tcp
+nfs09_v40_ip4t nfs09.sh -v 4 -t tcp
+nfs09_v41_ip4t nfs09.sh -v 4.1 -t tcp
+nfs09_v42_ip4t nfs09.sh -v 4.2 -t tcp
+nfs09_v30_ip6u nfs09.sh -6 -v 3 -t udp
+nfs09_v30_ip6t nfs09.sh -6 -v 3 -t tcp
+nfs09_v40_ip6t nfs09.sh -6 -v 4 -t tcp
+nfs09_v41_ip6t nfs09.sh -6 -v 4.1 -t tcp
+nfs09_v42_ip6t nfs09.sh -6 -v 4.2 -t tcp
+
 nfslock01_v30_ip4u nfslock01.sh -v 3 -t udp
 nfslock01_v30_ip4t nfslock01.sh -v 3 -t tcp
 nfslock01_v40_ip4t nfslock01.sh -v 4 -t tcp
diff --git a/testcases/network/nfs/nfs_stress/nfs09.sh b/testcases/network/nfs/nfs_stress/nfs09.sh
new file mode 100755
index 000000000..88c1a1ec5
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/nfs09.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
+#
+# DESCRIPTION: Check that stale NFS client cache does not prevent file
+# truncation.
+#
+# 1. Through NFS, access metadata of a file that does not exist
+# 2. Create the file on the remote end (bypassing NFS)
+# 3. Through NFS, try to overwrite the file with shorter data
+
+TST_TESTFUNC="do_test"
+
+do_test()
+{
+	local local_file="testfile"
+	local remote_file="$(nfs_get_remote_path)/$local_file"
+	local testmsg='File truncated'
+	local data
+
+	EXPECT_FAIL "ls -l '$local_file'"
+	tst_rhost_run -c "echo -n 'File rewritten not' >'$remote_file'"
+	echo -n "$testmsg" >"$local_file"
+	data=$(tst_rhost_run -c "cat '$remote_file'")
+
+	if [ "$data" != "$testmsg" ]; then
+		tst_res TFAIL "Wrong file contents, expected '$testmsg', got '$data'"
+	else
+		tst_res TPASS "File was truncated correctly"
+	fi
+}
+
+. nfs_lib.sh
+tst_run
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
