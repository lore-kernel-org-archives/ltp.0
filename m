Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8A2CAC5B8
	for <ltp@archiver.kernel.org>; Thu,  2 Oct 2025 08:38:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80BC93CE3F4
	for <ltp@archiver.kernel.org>; Thu,  2 Oct 2025 10:38:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A1523CE447
 for <ltp@lists.linux.it>; Thu,  2 Oct 2025 10:37:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1E1F910006B8
 for <ltp@lists.linux.it>; Thu,  2 Oct 2025 10:37:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEF0833826;
 Thu,  2 Oct 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F3AE13AA1;
 Thu,  2 Oct 2025 08:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iBadBbE53miCWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Oct 2025 08:37:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Oct 2025 10:36:59 +0200
Message-ID: <20251002083701.315334-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002083701.315334-1-pvorel@suse.cz>
References: <20251002083701.315334-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: AEF0833826
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
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

This helps to run all testcases on systems without CONFIG_IMA_WRITE_POLICY=y
(disabled by default in mainline, therefore disabled for some distros,
e.g. openSUSE Tumbleweed), if SUT reboots.

The downside is creating user account 4x instead just once.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 67 ++++++++++++-------
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/runtest/ima b/runtest/ima
index 01942eefa3..c8d0c6801e 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -6,5 +6,8 @@ ima_violations ima_violations.sh
 ima_keys ima_keys.sh
 ima_kexec ima_kexec.sh
 ima_selinux ima_selinux.sh
-ima_conditionals ima_conditionals.sh
+ima_conditionals_uid ima_conditionals.sh -r uid
+ima_conditionals_fowner ima_conditionals.sh -r fowner
+ima_conditionals_gid ima_conditionals.sh -r gid
+ima_conditionals_fgroup ima_conditionals.sh -r fgroup
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index a8b2e1015a..afa2ae05da 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -11,35 +11,68 @@
 
 TST_NEEDS_CMDS="cat chgrp chown id sg sudo useradd userdel"
 TST_SETUP="setup"
-TST_CNT=1
+TST_TESTFUNC="test"
 REQUIRE_TMP_USER=1
+TST_OPTS="r:"
+TST_USAGE="usage"
+TST_PARSE_ARGS="parse_args"
+REQUEST="uid"
+
+parse_args()
+{
+	REQUEST="$2"
+}
+
+usage()
+{
+	cat << EOF
+usage: $0 [-r <uid|fowner|gid|fgroup>]
+
+OPTIONS
+-r	Specify the request to be measured. One of:
+	uid, fowner, gid, fgroup
+	Default: uid
+EOF
+}
 
 setup()
 {
+	case "$REQUEST" in
+	fgroup|fowner|gid|uid)
+		tst_res TINFO "request '$REQUEST'"
+		;;
+	*) tst_brk TBROK "Invalid -r '$REQUEST', use: -r <uid|fowner|gid|fgroup>";;
+	esac
+
 	if check_need_signed_policy; then
 		tst_brk TCONF "policy have to be signed"
 	fi
 }
 
-verify_measurement()
+test()
 {
+	# needs to be checked each run (not in setup)
+	require_policy_writable
+
 	local request="$1"
 	local test_file="$PWD/test.txt"
 	local cmd="cat $test_file > /dev/null"
-
 	local value="$(id -u $IMA_USER)"
-	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $IMA_USER)"
 
-	# needs to be checked each run (not in setup)
-	require_policy_writable
+	if [ "$REQUEST" = 'gid' -o "$REQUEST" = 'fgroup' ]; then
+		if tst_kvcmp -lt 5.16; then
+			tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
+		fi
+		value="$(id -g $IMA_USER)"
+	fi
 
 	ROD rm -f $test_file
 
-	tst_res TINFO "verify measuring user files when requested via $request"
-	ROD echo "measure $request=$value" \> $IMA_POLICY
-	ROD echo "$(cat /proc/uptime) $request test" \> $test_file
+	tst_res TINFO "verify measuring user files when requested via $REQUEST"
+	ROD echo "measure $REQUEST=$value" \> $IMA_POLICY
+	ROD echo "$(cat /proc/uptime) $REQUEST test" \> $test_file
 
-	case "$request" in
+	case "$REQUEST" in
 	fgroup)
 		chgrp $IMA_USER $test_file
 		sh -c "$cmd"
@@ -50,24 +83,10 @@ verify_measurement()
 		;;
 	gid) sudo sg $IMA_USER "sh -c '$cmd'";;
 	uid) sudo -n -u $IMA_USER sh -c "$cmd";;
-	*) tst_brk TBROK "Invalid res type '$1'";;
 	esac
 
 	ima_check $test_file
 }
 
-test1()
-{
-	verify_measurement uid
-	verify_measurement fowner
-
-	if tst_kvcmp -lt 5.16; then
-		tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
-	fi
-
-	verify_measurement gid
-	verify_measurement fgroup
-}
-
 . ima_setup.sh
 tst_run
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
