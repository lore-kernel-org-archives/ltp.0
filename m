Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8EACA0FFA
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 14:15:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92E803D2859
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 16:15:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A078C3D26BF
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 16:14:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5C44B6068C8
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 16:14:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A4441F7D4;
 Fri, 30 Aug 2024 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725027296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8Cf0dVpPrEozGanIAWnSCkxdM0PU3uf6MXC6/A9ZDfs=;
 b=h/8sgmyMEoHnNO6gH8hix+7ZCAO900VY5KWA60EjsNzu3Za3mDlyPnGiESaeUOoJknRz2V
 TMF6t15scJRVbfyVOu6EiVPm8mDsdePj/Hofxfq7IyM9FsB4mBAFUKLfk9F8Z7qjCdMwAN
 1NIGBtZuDzAi28f+5q4S++fk8hG7ZcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725027296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8Cf0dVpPrEozGanIAWnSCkxdM0PU3uf6MXC6/A9ZDfs=;
 b=9tOY/T2G98/Etv/ubVMe6DDuhv7qlQx2ao4H7wDyRDnNXlggT+TtmfeeKpJVeXHml7Ty8f
 Xd+4+u6cOCUIExDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725027296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8Cf0dVpPrEozGanIAWnSCkxdM0PU3uf6MXC6/A9ZDfs=;
 b=h/8sgmyMEoHnNO6gH8hix+7ZCAO900VY5KWA60EjsNzu3Za3mDlyPnGiESaeUOoJknRz2V
 TMF6t15scJRVbfyVOu6EiVPm8mDsdePj/Hofxfq7IyM9FsB4mBAFUKLfk9F8Z7qjCdMwAN
 1NIGBtZuDzAi28f+5q4S++fk8hG7ZcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725027296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8Cf0dVpPrEozGanIAWnSCkxdM0PU3uf6MXC6/A9ZDfs=;
 b=9tOY/T2G98/Etv/ubVMe6DDuhv7qlQx2ao4H7wDyRDnNXlggT+TtmfeeKpJVeXHml7Ty8f
 Xd+4+u6cOCUIExDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F90B13A44;
 Fri, 30 Aug 2024 14:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QyozE+DT0WaXZQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 30 Aug 2024 14:14:56 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>,
 Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Fri, 30 Aug 2024 16:13:39 +0200
Message-ID: <20240830141453.28379-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add test for per-NS NFS client statistics
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

Check that /proc/net/rpc/nfs file exists in nested network namespaces.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Only do the minimal check here. If the file exists in namespaces,
nfsstat01.sh will take care of functional testing.

 runtest/net.nfs                              |  2 ++
 testcases/network/nfs/nfsstat01/nfsstat02.sh | 23 ++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100755 testcases/network/nfs/nfsstat01/nfsstat02.sh

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 929868a7b..7f84457bc 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -116,6 +116,8 @@ nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4 -t tcp
 nfsstat01_v41_ip6t nfsstat01.sh -6 -v 4.1 -t tcp
 nfsstat01_v42_ip6t nfsstat01.sh -6 -v 4.2 -t tcp
 
+nfsstat02 nfsstat02.sh
+
 fsx_v30_ip4u fsx.sh -v 3 -t udp
 fsx_v30_ip4t fsx.sh -v 3 -t tcp
 fsx_v40_ip4t fsx.sh -v 4 -t tcp
diff --git a/testcases/network/nfs/nfsstat01/nfsstat02.sh b/testcases/network/nfs/nfsstat01/nfsstat02.sh
new file mode 100755
index 000000000..1e1bebe97
--- /dev/null
+++ b/testcases/network/nfs/nfsstat01/nfsstat02.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024 SUSE LLC <mdoucha@suse.cz>
+
+TST_TESTFUNC="do_test"
+
+# PURPOSE:  Check that /proc/net/rpc/nfs exists in nested network namespaces
+do_test()
+{
+	local procfile="/proc/net/rpc/nfs"
+
+	if tst_rhost_run -c "test -e '$procfile'"; then
+		tst_res TPASS "$procfile exists in net namespaces"
+	else
+		tst_res TFAIL "$procfile missing in net namespaces"
+	fi
+}
+
+# Force use of nested net namespace
+unset RHOST
+
+. nfs_lib.sh
+tst_run
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
