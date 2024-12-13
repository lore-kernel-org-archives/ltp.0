Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22446E7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 22:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD8043EB884
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 23:22:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62D643EB889
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:22 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 92F5361860C
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8E261F442;
 Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuiiUtJ1LIssrkXNjvaHrB/KOqTnvtCiuvZnB1bzDN0=;
 b=NEGP9VdUj0w+mMwgt9PlRrfV4U7PGMkeHA8K8lu/WqilLUsEkmBE61B4dkX3evrsz5Kf/5
 K+XuTCmNL01dQfnyATxOZEu3S5q8avAealNQs8xgnWiOL16I3JGEaVJMqoVU5JWZuNQDfk
 YPFYSifoAN9SzZ1SP4n7wNm79JmRjks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuiiUtJ1LIssrkXNjvaHrB/KOqTnvtCiuvZnB1bzDN0=;
 b=D4Arjtvi3PYkklusRyvADw1BodlallmbdGyxfV8XGUpZvqnVE1OGcFOuTW/dDLhjOTDxd/
 djk4yRvYDWFCdcDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuiiUtJ1LIssrkXNjvaHrB/KOqTnvtCiuvZnB1bzDN0=;
 b=qdXnf2Qm8EGlqjDCmCI44pC4hZzx+YHgs9+ppZDTtrDM/oFaPvc1bKOVA+nFkFORRea6dB
 kUACUa/v74p0LiQCqLf1bpiYpB5bQwfRPthIr7KTn62mE2HGRZvoFsYyINrzs2Fdww9Jyl
 kPRFQgz8qQHOyEEh9JRQydaDA7ZQtKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuiiUtJ1LIssrkXNjvaHrB/KOqTnvtCiuvZnB1bzDN0=;
 b=AP4jDfkDOaxX0/IW/odjqu3QVRrLQotPgOB+y6qT4fiqWaeJ8CATRIE4VsAfcFgeTHWn3m
 DfTwiqtx3u/TUrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DF1613A52;
 Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4FHYHSGzXGf5QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Dec 2024 23:20:08 +0100
Message-ID: <20241213222014.1580991-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213222014.1580991-1-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/8] ima_setup.sh: Allow to load predefined policy
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

environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
if available. This should be used only if tooling running LTP tests
allows to reboot afterwards because policy may be writable only once,
e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
other.

Loading may fail due various reasons (e.g. previously mentioned missing
CONFIG_IMA_WRITE_POLICY=y and policy already loaded or when secure boot is
enabled and the kernel is configured with CONFIG_IMA_ARCH_POLICY enabled, an
appraise func=POLICY_CHECK appraise_type=imasig rule is loaded, requiring the
IMA policy itself to be signed).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/README.md   | 12 +++++
 .../integrity/ima/tests/ima_measurements.sh   | 17 +++++-
 .../security/integrity/ima/tests/ima_setup.sh | 54 ++++++++++++++++---
 3 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 5b261a1914..c5b3db1a5a 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -8,6 +8,18 @@ CONFIG_INTEGRITY=y
 CONFIG_IMA=y
 ```
 
+### Loading policy for testing (optional)
+Setting environment variable `LTP_IMA_LOAD_POLICY=1` tries to load example
+policy if available. This should be used only if tooling running LTP tests
+allows to reboot afterwards because policy may be writable only once, e.g.
+missing `CONFIG_IMA_WRITE_POLICY=y`, or policies can influence each other.
+
+Loading may fail due various reasons (e.g. previously mentioned missing
+`CONFIG_IMA_WRITE_POLICY=y` and policy already loaded or when secure boot is
+enabled and the kernel is configured with `CONFIG_IMA_ARCH_POLICY` enabled, an
+`appraise func=POLICY_CHECK appraise_type=imasig` rule is loaded, requiring the
+IMA policy itself to be signed).
+
 ### IMA measurement tests
 `ima_measurements.sh` require builtin IMA tcb policy to be loaded
 (`ima_policy=tcb` kernel parameter).
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1da2aa6a51..2c95aeb990 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Verify that measurements are added to the measurement list based on policy.
@@ -12,10 +12,23 @@ TST_CNT=3
 
 setup()
 {
-	require_ima_policy_cmdline "tcb"
+	local policy="tcb"
 
 	TEST_FILE="$PWD/test.txt"
 	[ -f "$IMA_POLICY" ] || tst_res TINFO "not using default policy"
+
+	if [ "$LTP_IMA_LOAD_POLICY" != 1 ]; then
+		require_ima_policy_cmdline $policy
+		return
+	elif check_ima_policy_cmdline $policy; then
+		return
+	fi
+
+	if ! check_ima_policy_cmdline $policy &&
+		! require_ima_policy_content '^measure func=FILE_CHECK mask=^MAY_READ uid=0' &&
+		! require_ima_policy_content 'measure func=POLICY_CHECK'; then
+			tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter) or it's equivalent (try LTP_IMA_LOAD_POLICY=1)"
+	fi
 }
 
 check_iversion_support()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index df3fc5603f..7afb1a0967 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 
 TST_TESTFUNC="test"
@@ -72,14 +72,20 @@ require_policy_readable()
 	fi
 }
 
-require_policy_writable()
+check_policy_writable()
 {
-	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
-
-	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
-	# CONFIG_IMA_READ_POLICY
+	[ -f $IMA_POLICY ] || return 1
+	# workaround for kernels < v4.18 without fix
+	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
 	echo "" 2> log > $IMA_POLICY
-	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
+	grep -q "Device or resource busy" log && return 1
+	return 0
+}
+
+require_policy_writable()
+{
+	check_policy_writable || tst_brk TCONF \
+		"IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
 }
 
 check_ima_policy_content()
@@ -158,6 +164,34 @@ print_ima_config()
 	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
 }
 
+load_ima_policy()
+{
+	local policy="$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
+
+	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$policy" -a -f "$policy" ]; then
+		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=1 to load policy for this test"
+		return
+	fi
+
+	if [ -z "$policy" -o ! -f "$policy" ]; then
+		tst_res TINFO "no policy for this test"
+		LTP_IMA_LOAD_POLICY=
+		return
+	fi
+
+	tst_res TINFO "trying to load '$policy' policy:"
+	cat $policy
+	if ! check_policy_writable; then
+		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
+		LTP_IMA_LOAD_POLICY=
+		return
+	fi
+
+	cat "$policy" 2> log > $IMA_POLICY
+	if grep -q "Device or resource busy" log; then
+		tst_brk TBROK "Loading policy failed"
+	fi
+}
 ima_setup()
 {
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
@@ -180,6 +214,8 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
+	load_ima_policy
+
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
@@ -192,6 +228,10 @@ ima_cleanup()
 	for dir in $UMOUNT; do
 		umount $dir
 	done
+
+	if [ "$LTP_IMA_LOAD_POLICY" = 1 ]; then
+		tst_res TINFO "WARNING: policy loaded via LTP_IMA_LOAD_POLICY=1, reboot recommended"
+	fi
 }
 
 set_digest_index()
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
