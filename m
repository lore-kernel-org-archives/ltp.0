Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D650D3B98C
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 18:57:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B82673D0324
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:57:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9A443D0326
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 19:56:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 19E901000609
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 19:56:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6144C5BE03;
 Tue,  9 Dec 2025 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765306563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/P8UQAkwsKDxj/7A3oMQW2mFBFDU2oZ5ypQ0Oe/SU58=;
 b=Swt/T1njlihtZMbxZp02dLl1U2lhsEvIA7f24rQxFtbUi2VElKPPIorH37ca0NP1c5CHoh
 70PjXJTke43CKvAUUMU3XbEBLW2xMr7BSfM5NiuZRr7QKSoDPLmZlCxRU5I0JX1fkl9307
 qVzxs2f75FGnqrkg7fqhFmWy2uLaDmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765306563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/P8UQAkwsKDxj/7A3oMQW2mFBFDU2oZ5ypQ0Oe/SU58=;
 b=3gBGTqqDkXnnG4gu25ddiUEQohtcIPX/Ga1+2LAe54WQD8MietTJe5m1ESxhBH3tNzFRNQ
 7+cV25PiuXStrdCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S55Mu65I;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6zvKynHL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765306562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/P8UQAkwsKDxj/7A3oMQW2mFBFDU2oZ5ypQ0Oe/SU58=;
 b=S55Mu65IQnigi90WcQVUMEJS03lJIA9Kt61gXQJSEHpALPxoUAFGKaoPEHDMKF25E20SMr
 OOQ9Yy3qHd4r47cCEFuFRMDe+JuLwmxk6UMEFkhqG6s+INM8p0K9Nwy8C936bkCZ8n6150
 wFAOOS4r85slL/mIO8O+wt6nf7tbfnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765306562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/P8UQAkwsKDxj/7A3oMQW2mFBFDU2oZ5ypQ0Oe/SU58=;
 b=6zvKynHLj9ng0eOnEdCk86UnorvZNqbeTLW91qBUumnaxCvfIja3qxN935ki3oyyOcqp74
 tRtc8U82fPQXcfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A1BE3EA65;
 Tue,  9 Dec 2025 18:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KJN2BcJwOGnSSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 18:56:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Dec 2025 19:55:56 +0100
Message-ID: <20251209185557.20598-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209185557.20598-1-pvorel@suse.cz>
References: <20251209185557.20598-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6144C5BE03
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] ima_{conditionals,
 measurements}.sh: Use tst_runas
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

Replace 'sudo' and 'sg' with 'tst_runas'.

This not only removes 'sudo' external dependency, but it s required
because new releases of many distros (e.g. Debian, openSUSE Tumbleweed,
SLES, ...) switched shell for 'nobody' user from /bin/bash (or /bin/sh)
to /usr/sbin/nologin. That effectively disables using 'sudo', 'su', 'sg':

    ima_conditionals 1 TINFO: verify measuring user files when requested via uid
    sudo: Account expired or PAM config lacks an "account" section for sudo, contact your system administrator
    sudo: a password is required

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_conditionals.sh         | 13 ++++++-------
 .../integrity/ima/tests/ima_measurements.sh         | 11 ++---------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index ba19176039..ae947db1e9 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -9,7 +9,7 @@
 # gid and fgroup options test kernel commit 40224c41661b ("ima: add gid
 # support") from v5.16.
 
-TST_NEEDS_CMDS="cat chgrp chown id sg sudo"
+TST_NEEDS_CMDS="cat chgrp chown"
 TST_SETUP="setup"
 TST_CNT=1
 
@@ -27,8 +27,8 @@ verify_measurement()
 	local test_file="$PWD/test.txt"
 	local cmd="cat $test_file > /dev/null"
 
-	local value="$(id -u $user)"
-	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $user)"
+	local value="$TST_USR_UID"
+	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$TST_USR_GID"
 
 	# needs to be checked each run (not in setup)
 	require_policy_writable
@@ -41,15 +41,14 @@ verify_measurement()
 
 	case "$request" in
 	fgroup)
-		chgrp $user $test_file
+		chgrp $TST_USR_GID $test_file
 		sh -c "$cmd"
 		;;
 	fowner)
-		chown $user $test_file
+		chown $TST_USR_UID $test_file
 		sh -c "$cmd"
 		;;
-	gid) sg $user "sh -c '$cmd'";;
-	uid) sudo -n -u $user sh -c "$cmd";;
+	gid|uid) tst_runas sh -c "$cmd";;
 	*) tst_brk TBROK "Invalid res type '$1'";;
 	esac
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 60350f3926..cf35e131ed 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -68,30 +68,23 @@ test2()
 
 test3()
 {
-	local user="nobody"
 	local dir="$PWD/user"
 	local file="$dir/test.txt"
 	local cmd="grep $file $ASCII_MEASUREMENTS"
 
 	# Default policy does not measure user files
 	tst_res TINFO "verify not measuring user files"
-	tst_check_cmds sudo || return
 
 	if [ "$IMA_MISSING_POLICY_CONTENT" = 1 ]; then
 		tst_res TCONF "test requires specific policy, try load it with LTP_IMA_LOAD_POLICY=1"
 		return
 	fi
 
-	if ! id $user >/dev/null 2>/dev/null; then
-		tst_res TCONF "missing system user $user (wrong installation)"
-		return
-	fi
-
 	[ -d "$dir" ] || mkdir -m 0700 $dir
-	chown $user $dir
+	chown $TST_USR_UID $dir
 	cd $dir
 	# need to read file to get updated $ASCII_MEASUREMENTS
-	sudo -n -u $user sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
+	tst_runas sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
 	cd ..
 
 	if ! tst_rod "$cmd" 2> /dev/null; then
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
