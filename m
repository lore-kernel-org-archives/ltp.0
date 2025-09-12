Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D68ACA101F
	for <ltp@archiver.kernel.org>; Fri, 12 Sep 2025 07:33:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 843C53C22A2
	for <ltp@archiver.kernel.org>; Fri, 12 Sep 2025 09:33:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7637C3CD8B3
 for <ltp@lists.linux.it>; Fri, 12 Sep 2025 09:32:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D38B21400508
 for <ltp@lists.linux.it>; Fri, 12 Sep 2025 09:32:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBE593F692;
 Fri, 12 Sep 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EE18136DB;
 Fri, 12 Sep 2025 07:32:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IIQrIX3Mw2g7GgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Sep 2025 07:32:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 12 Sep 2025 09:32:09 +0200
Message-ID: <20250912073210.47637-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912073210.47637-1-pvorel@suse.cz>
References: <20250912073210.47637-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DBE593F692
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ima_{conditionals,
 policy}: Handle policy required to be signed
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
Cc: Coiby Xu <coxu@redhat.com>, selinux@vger.kernel.org,
 linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since kernel 6.6 policy needs to be signed on enabled UEFI secure boot.
Skip testing in that case.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56dc986a6b20b

This fixes errors:

    ima_policy 2 TINFO: verify that policy file is not opened concurrently and able to loaded multiple times
    ima_policy 2 TFAIL: problem loading or extending policy (may require policy to be signed)
    https://openqa.suse.de/tests/18723792#step/ima_conditionals/6

    ima_conditionals 1 TINFO: verify measuring user files when requested via uid
    echo: write error: Permission denied
    ima_conditionals 1 TBROK: echo measure uid=65534 > /sys/kernel/security/ima/policy failed

Ideally there would be test which check that unsigned policy cannot be
written.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_conditionals.sh  | 11 ++++++++++-
 .../kernel/security/integrity/ima/tests/ima_policy.sh |  5 ++++-
 .../kernel/security/integrity/ima/tests/ima_setup.sh  |  7 +++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index b59f330cac..9125616890 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2021 VPI Engineering
-# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2021-2025 Petr Vorel <pvorel@suse.cz>
 # Author: Alex Henrie <alexh@vpitech.com>
 #
 # Verify that conditional rules work.
@@ -10,8 +10,16 @@
 # support") from v5.16.
 
 TST_NEEDS_CMDS="cat chgrp chown id sg sudo"
+TST_SETUP="setup"
 TST_CNT=1
 
+setup()
+{
+	if check_need_signed_policy; then
+		tst_brk TCONF "policy have to be signed"
+	fi
+}
+
 verify_measurement()
 {
 	local request="$1"
@@ -22,6 +30,7 @@ verify_measurement()
 	local value="$(id -u $user)"
 	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $user)"
 
+	# needs to be checked each run (not in setup)
 	require_policy_writable
 
 	ROD rm -f $test_file
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 1c4763d838..490c8b6c2e 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -61,12 +61,15 @@ test2()
 	load_policy $VALID_POLICY & p2=$!
 	wait "$p1"; rc1=$?
 	wait "$p2"; rc2=$?
+
 	if [ $rc1 -eq 0 ] && [ $rc2 -eq 0 ]; then
 		tst_res TFAIL "policy opened concurrently"
 	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
 		tst_res TPASS "policy was loaded just by one process and able to loaded multiple times"
+	elif check_need_signed_policy; then
+		tst_res TCONF "policy have to be signed"
 	else
-		tst_res TFAIL "problem loading or extending policy (may require policy to be signed)"
+		tst_res TFAIL "problem loading or extending policy"
 	fi
 }
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 83fcefb4fc..2a7d651818 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -449,6 +449,13 @@ require_evmctl()
 	fi
 }
 
+# 56dc986a6b20b ("ima: require signed IMA policy when UEFI secure boot is enabled") # v6.5-rc4
+check_need_signed_policy()
+{
+	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
+		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY'
+}
+
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if tst_supported_fs -d $TMPDIR -s "tmpfs"; then
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
