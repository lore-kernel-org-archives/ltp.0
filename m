Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEABD6EC0A
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 13:34:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC17C3DC0D8
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 14:34:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF0713DC0C9
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 14:34:33 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 91BF061118A
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 14:34:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70ABE2115E
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732887271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YTyYs62hGBXodW/gWUhFCfTwz+YzJlEVDu+9RVEB8cI=;
 b=kMNDx0ciovR6uBlm9nscmyM4r6Vppy8Atb4XoB/aG6Gi032UU7+n0lRvzuaV1g1vnlN1EJ
 MAb2vtye7LzS5I5YbsbfvLdF7Fi5gUmPNUAE6xluN9vUDwyS8SShCYSm/593BO7vPOb6EU
 1Yrksu1000Oyba0cC7wiX3wxflDlWug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732887271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YTyYs62hGBXodW/gWUhFCfTwz+YzJlEVDu+9RVEB8cI=;
 b=nkc1cTyy+PqglG376LKzKSXAmS0hkTgwUcJfwQ3YTtGLFfqPWAoOtGwaRmEyO04tFmQWF0
 Re8zNlyX9uNB3DBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732887271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YTyYs62hGBXodW/gWUhFCfTwz+YzJlEVDu+9RVEB8cI=;
 b=kMNDx0ciovR6uBlm9nscmyM4r6Vppy8Atb4XoB/aG6Gi032UU7+n0lRvzuaV1g1vnlN1EJ
 MAb2vtye7LzS5I5YbsbfvLdF7Fi5gUmPNUAE6xluN9vUDwyS8SShCYSm/593BO7vPOb6EU
 1Yrksu1000Oyba0cC7wiX3wxflDlWug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732887271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YTyYs62hGBXodW/gWUhFCfTwz+YzJlEVDu+9RVEB8cI=;
 b=nkc1cTyy+PqglG376LKzKSXAmS0hkTgwUcJfwQ3YTtGLFfqPWAoOtGwaRmEyO04tFmQWF0
 Re8zNlyX9uNB3DBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57EFB139AA
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 13:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nIDoFOfCSWftIQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 13:34:31 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 29 Nov 2024 14:34:20 +0100
Message-ID: <20241129133421.24349-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add test for data integrity over NFS
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

The lower loop count is necessary because NFS has very large block size,
up to 256KB on x86_64. The new tests take ~50 minutes to complete in total
on my laptop. With the default loop count, the TCP tests would all time out.

The subtest timeout is fully determined by NFS block size and hardcoded
command line arguments. For TCP tests, it's exactly 8 minutes 32 seconds
so the whole test script will take no more than 34 minutes 8 seconds.
The TST_TIMEOUT value is rounded up to 40 minutes to add some margin
for setup and cleanup.

 runtest/net.nfs                           | 11 +++++++
 testcases/network/nfs/nfs_stress/nfs10.sh | 37 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)
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
index 000000000..79a5ddb17
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/nfs10.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
+#
+# DESCRIPTION: Verify data integrity over NFS, with and without O_DIRECT
+
+TST_CNT=4
+TST_TESTFUNC="do_test"
+TST_DEVICE_SIZE=1024
+TST_TIMEOUT=2400
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
