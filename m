Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8F6CFD2F6
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 08:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27F443CB39B
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 09:28:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7E413CB635
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:26:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC6AE60085C
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:26:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5AD665BCD0;
 Thu, 27 Nov 2025 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764232006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44PQYSarwQ70kFnpNKxwf8Ea202qaPQUdfXBtkV9La0=;
 b=oFSbET6+KY7ojFpPIjhYdMUPDPdvHCnBkCKhdVArtUcAyM3ehZPXxHHRdjOVeY+pjAwEvn
 y3ads3JZvEz2qXBFdoPZOKvth9/BUigvmOm0THMWvdNYsYlMgI5hNHAynKgWxz3+QTW9Bs
 36N8gFaHLt6imevEqB0i03zn+8kBrzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764232006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44PQYSarwQ70kFnpNKxwf8Ea202qaPQUdfXBtkV9La0=;
 b=z3DtPwX62c/mYydZVrGKBSH26D18EY7YXxlWzLlL7WCcrveHKhF8kgUGggX39IJz2IAz50
 GMZ91HIvQMcp9KCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44PQYSarwQ70kFnpNKxwf8Ea202qaPQUdfXBtkV9La0=;
 b=yic4SqC5nhjkLjpBuG3m2+KFXCffDkumGlBmVLYnlXxRCZHabgpuvdpcbGxLys02jg/QS8
 zpTevFJMHEoCsYAtPCBmRDjwX9Z+upihN0poTx6aRWbixT35SFSNRfJVHa2BLZ/zW6sJx+
 PkSMDa1FW2kIAL+ayyE6yVTrpm3mF4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764232005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44PQYSarwQ70kFnpNKxwf8Ea202qaPQUdfXBtkV9La0=;
 b=uwrv650Kvrf2cQw4UCdFwIV8NzrGm6akeMgUsJsQ5MbEVWBcmG7TO30ZR7oBNXuu7iJhmG
 6s1WVf0usjHeO0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23C523EA68;
 Thu, 27 Nov 2025 08:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJvyB0ULKGmNJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:26:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Nov 2025 09:26:38 +0100
Message-ID: <20251127082638.224110-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127082638.224110-1-pvorel@suse.cz>
References: <20251127082638.224110-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ima_keys.sh:url,ima_selinux.sh:url,imap1.dmz-prg2.suse.org:helo,ima_violations.sh:url,suse.cz:mid,suse.cz:email,ima_conditionals.sh:url];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] ima_conditionals.sh: Split test by request
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This helps to run all testcases on systems without CONFIG_IMA_WRITE_POLICY=y
(disabled by default in mainline, therefore disabled for some distros,
e.g. openSUSE Tumbleweed), if SUT reboots.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 67 ++++++++++++-------
 2 files changed, 46 insertions(+), 26 deletions(-)

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
index e290dcdaaa..8eed0b6a9d 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -11,35 +11,66 @@
 
 TST_NEEDS_CMDS="cat chgrp chown"
 TST_SETUP="setup"
-TST_CNT=1
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
-	local user="nobody"
 	local test_file="$PWD/test.txt"
 	local cmd="cat $test_file > /dev/null"
-
 	local value="$TST_USR_UID"
-	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$TST_USR_GID"
 
-	# needs to be checked each run (not in setup)
-	require_policy_writable
+	if [ "$REQUEST" = 'gid' -o "$REQUEST" = 'fgroup' ]; then
+		if tst_kvcmp -lt 5.16; then
+			tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
+		fi
+		value="$TST_USR_GID"
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
 		chgrp $TST_USR_GID $test_file
 		sh -c "$cmd"
@@ -49,24 +80,10 @@ verify_measurement()
 		sh -c "$cmd"
 		;;
 	gid|uid) tst_sudo sh -c "$cmd";;
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
