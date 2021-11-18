Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FAC433F5
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 17:23:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C49E60EC0
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 17:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C49E60EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F6273C897C
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 18:23:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387443C5AEF
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 18:23:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9BA1D1400DAB
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 18:23:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4229218B8
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637256194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikd4Fvv1akD7xMRPGN4MgPVz+RCPF+DhmVgI9358ZFo=;
 b=Bzf26dWMe4j1p/J/dCQLhOx6cBuT+y8I92Ol+ERMFBdK2I+90dbQLnJ3Ub2cvUb1/WncZr
 w926fQsplZnmJGGAH4BTUGcQV3PL5rAn+WDG9TkLPduaY0YqVIRBDr9vn9QYDmf3vtNJp0
 V0dWmo/ZjgvlcChBbKyigO51uxdZh3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637256194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikd4Fvv1akD7xMRPGN4MgPVz+RCPF+DhmVgI9358ZFo=;
 b=ktmvSAMHysGGwVTEozzY4m/HGCa1r9RrFaJe+kInfSmNkAsFdOzEja1F41U2tkiKODZ9kU
 IbsU6A9+zEhDJLBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF94713D8C
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 17:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gIfdKQKMlmEgVAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 17:23:14 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Nov 2021 18:23:13 +0100
Message-Id: <20211118172313.20159-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118172313.20159-1-mdoucha@suse.cz>
References: <20211118172313.20159-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Add test for NFS directory listing regression
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

---
 runtest/net.nfs                           | 11 +++++
 testcases/network/nfs/nfs_stress/Makefile |  3 +-
 testcases/network/nfs/nfs_stress/nfs07.sh | 56 +++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100755 testcases/network/nfs/nfs_stress/nfs07.sh

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 3df35809a..042c14ce4 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -61,6 +61,17 @@ nfs01_06  nfs06 -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
 nfs02_06 nfs06 -v "3,4,4.1,4.2,4.2,4.2" -t "udp,tcp,tcp,tcp,tcp,tcp"
 nfs03_ipv6_06 nfs06 -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 
+nfs3_07 nfs07.sh -v 3 -t udp
+nfs3t_07 nfs07.sh -v 3 -t tcp
+nfs4_07 nfs07.sh -v 4 -t tcp
+nfs41_07 nfs07.sh -v 4.1 -t tcp
+nfs42_07 nfs07.sh -v 4.2 -t tcp
+nfs3_ipv6_07 nfs07.sh -6 -v 3 -t udp
+nfs3t_ipv6_07 nfs07.sh -6 -v 3 -t tcp
+nfs4_ipv6_07 nfs07.sh -6 -v 4 -t tcp
+nfs41_ipv6_07 nfs07.sh -6 -v 4.1 -t tcp
+nfs42_ipv6_07 nfs07.sh -6 -v 4.2 -t tcp
+
 nfslock3_01 nfslock01 -v 3 -t udp
 nfslock3t_01 nfslock01 -v 3 -t tcp
 nfslock4_01 nfslock01 -v 4 -t tcp
diff --git a/testcases/network/nfs/nfs_stress/Makefile b/testcases/network/nfs/nfs_stress/Makefile
index 856008ce2..0b7408e29 100644
--- a/testcases/network/nfs/nfs_stress/Makefile
+++ b/testcases/network/nfs/nfs_stress/Makefile
@@ -15,6 +15,7 @@ INSTALL_TARGETS		:= nfs_lib.sh \
 			   nfs03 \
 			   nfs04 \
 			   nfs05 \
-			   nfs06
+			   nfs06 \
+			   nfs07.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/nfs/nfs_stress/nfs07.sh b/testcases/network/nfs/nfs_stress/nfs07.sh
new file mode 100755
index 000000000..d8e482751
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/nfs07.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
+#
+#  DESCRIPTION: Create a large number of files and directories on NFS volume.
+#  Then check whether they can be listed via NFS.
+
+FILE_COUNT=5000
+
+TST_OPTS="n:"
+TST_PARSE_ARGS=do_parse_args
+TST_TESTFUNC="do_test"
+TST_SETUP="do_setup"
+
+do_parse_args()
+{
+	case "$1" in
+	n) FILE_COUNT="$2";;
+	esac
+}
+
+. nfs_lib.sh
+
+do_setup()
+{
+	nfs_setup
+
+	local rpath=$(nfs_get_remote_path)
+	tst_rhost_run -s -c "touch $rpath/file{1..$FILE_COUNT}"
+	tst_rhost_run -s -c "mkdir $rpath/dir{1..$FILE_COUNT}"
+}
+
+do_test()
+{
+	local count
+
+	# Pass the list of files through `sort -u` in case `ls` doesn't fitler
+	# out potential duplicate filenames returned by buggy NFS
+	count=`ls | grep '^file' | sort -u | wc -l`
+
+	if [ $count -ne $FILE_COUNT ]; then
+		tst_res TFAIL "Listing files failed: $count != $FILE_COUNT"
+		return
+	fi
+
+	count=`ls | grep '^dir' | sort -u | wc -l`
+
+	if [ $count -ne $FILE_COUNT ]; then
+		tst_res TFAIL "Listing dirs failed: $count != $FILE_COUNT"
+		return
+	fi
+
+	tst_res TPASS "All files and directories were correctly listed"
+}
+
+tst_run
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
