Return-Path: <SRS0=CJzs=O2=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D126C433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 10:31:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D3161019
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 10:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01D3161019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 692883C7F48
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 12:31:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D81EB3C6646
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 12:31:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 721A81001170
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 12:31:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D63DB224F4;
 Wed,  6 Oct 2021 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633516267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+en3ZuUsBHZlVQNahZku78kNuNJSgkqqBay6AsX4tY=;
 b=0rXcyq3jSeT1ZCiQiP1Cmt2hlr+njphT9HOSMfy61EmvvvrgsnNe4za9c/sHE83Ay4bEhM
 iX1VGJoKx5WyX+jy+6n6joDNALO8FWEPXvPLPibJ9tDMICmr/jr8+SReBbyLjExGXBDu8h
 juH5EbEK9Dt/q5c4vAOoiFnyPFX3aC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633516267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+en3ZuUsBHZlVQNahZku78kNuNJSgkqqBay6AsX4tY=;
 b=wV+L1QTE88Dj1HJ2ILFck6GTg8SRO8r0u6/c3kAifjWoMiLK6BAS50c/j5r4EH6nHRpdyb
 VsTVfyC7MUj76cBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EFEC13E19;
 Wed,  6 Oct 2021 10:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sIZiJet6XWF/dAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 06 Oct 2021 10:31:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  6 Oct 2021 12:30:59 +0200
Message-Id: <20211006103059.9617-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006103059.9617-1-pvorel@suse.cz>
References: <20211006103059.9617-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 3/3] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Alex Henrie <alexh@vpitech.com>

Requires "ima: add gid support".

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
[ pvorel: add test_file parameter to ima_check(), add
verify_measurement() (DRY) ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ima                                   |  1 +
 .../integrity/ima/tests/ima_conditionals.sh   | 63 +++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh

diff --git a/runtest/ima b/runtest/ima
index 29caa034a..01942eefa 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -6,4 +6,5 @@ ima_violations ima_violations.sh
 ima_keys ima_keys.sh
 ima_kexec ima_kexec.sh
 ima_selinux ima_selinux.sh
+ima_conditionals ima_conditionals.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
new file mode 100755
index 000000000..c83006f6d
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 VPI Engineering
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+# Author: Alex Henrie <alexh@vpitech.com>
+#
+# Verify that conditional rules work.
+
+TST_NEEDS_CMDS="chgrp chown id sg sudo"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+
+verify_measurement()
+{
+	local request="$1"
+	local user="nobody"
+	local test_file="$PWD/test.txt"
+	local cmd="cat $test_file > /dev/null"
+
+	local value="$(id -u $user)"
+	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $user)"
+
+	require_policy_writable
+
+	ROD rm -f $test_file
+
+	tst_res TINFO "verify measuring user files when requested via $request"
+	ROD echo "measure $request=$value" \> $IMA_POLICY
+	ROD echo "$(date) $request test" \> $test_file
+
+	case "$request" in
+	fgroup)
+		chgrp $user $test_file
+		$cmd
+		;;
+	fowner)
+		chown $user $test_file
+		$cmd
+		;;
+	gid) sudo sg $user "sh -c '$cmd'";;
+	uid) sudo -n -u $user sh -c "$cmd";;
+	*) tst_brk TBROK "Invalid res type '$1'";;
+	esac
+
+	ima_check $test_file
+}
+
+test1()
+{
+	verify_measurement uid
+	verify_measurement fowner
+
+	if tst_kvcmp -lt 5.16; then
+		tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
+	fi
+
+	verify_measurement gid
+	verify_measurement fgroup
+}
+
+tst_run
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
