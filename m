Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB53E7716D
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 17:23:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153A83DF28E
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 18:23:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63D503DF281
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 18:23:21 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AAB78143B8DF
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 18:23:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A7451F805
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733332998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhNKLH2K7G3DVKglye8ouL3pU8UF8+H/Fil5vNHeniw=;
 b=yMigiWxFKOtDL+t3yfyb2fzZKzDmq0avFPrVgCG69Ool4SBoprvjHjVMR96QEMFnqb42xn
 SRMGCeCp4rcrB0Hay89MsTEmG8hZgpVFYKh2a1TSUfXJS0AaYgIbIE9S4C7l2S2jVdxj/P
 booYRTSdR382g/iBhy+lvqqDxbYVMF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733332998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhNKLH2K7G3DVKglye8ouL3pU8UF8+H/Fil5vNHeniw=;
 b=R6PTpr5hZyviiI7xRFSFJjRGUiHnLtkknyCam9WfjoySGS/Oak5WcSwbvq9pQhHg8PE1Zv
 fKpJY5sTAntnQoCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yMigiWxF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R6PTpr5h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733332998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhNKLH2K7G3DVKglye8ouL3pU8UF8+H/Fil5vNHeniw=;
 b=yMigiWxFKOtDL+t3yfyb2fzZKzDmq0avFPrVgCG69Ool4SBoprvjHjVMR96QEMFnqb42xn
 SRMGCeCp4rcrB0Hay89MsTEmG8hZgpVFYKh2a1TSUfXJS0AaYgIbIE9S4C7l2S2jVdxj/P
 booYRTSdR382g/iBhy+lvqqDxbYVMF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733332998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhNKLH2K7G3DVKglye8ouL3pU8UF8+H/Fil5vNHeniw=;
 b=R6PTpr5hZyviiI7xRFSFJjRGUiHnLtkknyCam9WfjoySGS/Oak5WcSwbvq9pQhHg8PE1Zv
 fKpJY5sTAntnQoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83988139C2
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 17:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aL3nHwaQUGe/GAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 04 Dec 2024 17:23:18 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Dec 2024 18:23:10 +0100
Message-ID: <20241204172312.34099-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204172312.34099-1-mdoucha@suse.cz>
References: <20241204172312.34099-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9A7451F805
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add test for data integrity over NFS
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

Add NFS test which checks data integrity of random writes into a file,
with both buffered and direct I/O.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Added TST_TIMEOUT

Changes since v2: Force NFS blocksize to the underlying FS blocksize

By default, NFS uses very large blocksize (up to 1MB) to optimize network
communication. For the FS integrity test this means a significant slowdown
because the size of the test file and I/O operations increase with
blocksize. Autodetect the blocksize of the underlying filesystem and force
the same value during NFS mount to speed things up.

The TST_TIMEOUT value is calculated as worst-case scenario for 64KB
blocksize. On reasonably modern x86_64 machines, the new tests take about
6 minutes to complete in total (with Btrfs, Ext4 and XFS being tested).

 runtest/net.nfs                           | 11 ++++++
 testcases/network/nfs/nfs_stress/nfs10.sh | 47 +++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100755 testcases/network/nfs/nfs_stress/nfs10.sh

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 7f84457bc..fef993da8 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -94,6 +94,17 @@ nfs09_v40_ip6t nfs09.sh -6 -v 4 -t tcp
 nfs09_v41_ip6t nfs09.sh -6 -v 4.1 -t tcp
 nfs09_v42_ip6t nfs09.sh -6 -v 4.2 -t tcp
 
+nfs10_v30_ip4u nfs10.sh -v 3 -t udp
+nfs10_v30_ip4t nfs10.sh -v 3 -t tcp
+nfs10_v40_ip4t nfs10.sh -v 4 -t tcp
+nfs10_v41_ip4t nfs10.sh -v 4.1 -t tcp
+nfs10_v42_ip4t nfs10.sh -v 4.2 -t tcp
+nfs10_v30_ip6u nfs10.sh -6 -v 3 -t udp
+nfs10_v30_ip6t nfs10.sh -6 -v 3 -t tcp
+nfs10_v40_ip6t nfs10.sh -6 -v 4 -t tcp
+nfs10_v41_ip6t nfs10.sh -6 -v 4.1 -t tcp
+nfs10_v42_ip6t nfs10.sh -6 -v 4.2 -t tcp
+
 nfslock01_v30_ip4u nfslock01.sh -v 3 -t udp
 nfslock01_v30_ip4t nfslock01.sh -v 3 -t tcp
 nfslock01_v40_ip4t nfslock01.sh -v 4 -t tcp
diff --git a/testcases/network/nfs/nfs_stress/nfs10.sh b/testcases/network/nfs/nfs_stress/nfs10.sh
new file mode 100755
index 000000000..2fca4f916
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/nfs10.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
+#
+# DESCRIPTION: Verify data integrity over NFS, with and without O_DIRECT
+
+TST_CNT=4
+TST_SETUP="nfs10_setup"
+TST_TESTFUNC="do_test"
+TST_DEVICE_SIZE=1024
+TST_TIMEOUT=660
+
+nfs10_setup()
+{
+	local bsize=$(stat -f -c %s .)
+
+	bsize=$(( $bsize < 1024 ? 1024 : $bsize ))
+	NFS_MOUNT_OPTS="rsize=$bsize,wsize=$bsize"
+	nfs_setup
+}
+
+do_test1()
+{
+	tst_res TINFO "Testing buffered write, buffered read"
+	EXPECT_PASS fsplough -c 512 -d "$PWD"
+}
+
+do_test2()
+{
+	tst_res TINFO "Testing buffered write, direct read"
+	EXPECT_PASS fsplough -c 512 -R -d "$PWD"
+}
+
+do_test3()
+{
+	tst_res TINFO "Testing direct write, buffered read"
+	EXPECT_PASS fsplough -c 512 -W -d "$PWD"
+}
+
+do_test4()
+{
+	tst_res TINFO "Testing direct write, direct read"
+	EXPECT_PASS fsplough -c 512 -RW -d "$PWD"
+}
+
+. nfs_lib.sh
+tst_run
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
