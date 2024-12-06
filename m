Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7EAE77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 09:51:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43FBA3E687D
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 10:51:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 335DC3E65F4
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:49:59 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F7CE204732
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:49:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56E8B21193;
 Fri,  6 Dec 2024 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733478597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BC4dHMhL1Rs0cforGD3TawUyIAKubm1dPDNVkj3b9qk=;
 b=Qq3xj84nh4qQ3OTI9ZUHztRCB3eCrwbrgqwTqoWPvWx6sKVxIcBTZ9pFRNstn4PtEeY7aR
 4u14unxhffyKx268FVCtQq0Q7A2H7mFlKVTxs5QcWPOfYii3g8E8P/6Q/CFxCGbCxJeh8N
 quTV74rq+GtyyLYE/RGmNHQwz02tkjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733478597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BC4dHMhL1Rs0cforGD3TawUyIAKubm1dPDNVkj3b9qk=;
 b=uo5v9jp8JuLjZEImFFOONV9bZcyyljZ0v7pDoCDHKR8EKCEImwjyj3vjlsRKoYnOoiPOv4
 lPAyc3KIMdVn8MAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733478597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BC4dHMhL1Rs0cforGD3TawUyIAKubm1dPDNVkj3b9qk=;
 b=Qq3xj84nh4qQ3OTI9ZUHztRCB3eCrwbrgqwTqoWPvWx6sKVxIcBTZ9pFRNstn4PtEeY7aR
 4u14unxhffyKx268FVCtQq0Q7A2H7mFlKVTxs5QcWPOfYii3g8E8P/6Q/CFxCGbCxJeh8N
 quTV74rq+GtyyLYE/RGmNHQwz02tkjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733478597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BC4dHMhL1Rs0cforGD3TawUyIAKubm1dPDNVkj3b9qk=;
 b=uo5v9jp8JuLjZEImFFOONV9bZcyyljZ0v7pDoCDHKR8EKCEImwjyj3vjlsRKoYnOoiPOv4
 lPAyc3KIMdVn8MAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B53513A15;
 Fri,  6 Dec 2024 09:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wMD4CMXIUmehEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Dec 2024 09:49:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  6 Dec 2024 10:49:35 +0100
Message-ID: <20241206094938.92895-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206094938.92895-1-pvorel@suse.cz>
References: <20241206094938.92895-1-pvorel@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] testcases/lib/run_tests.sh: Check expected results
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

This verification helps 1) see if anything broke 2) be able to run in CI.

Also:
1) Allow to run tests outside of the test directory (call just by
relative PATH).
2) Allow to pass build directory (useful for out of tree build).
3) Allow to skip tests (useful for github CI).

shell_loader_all_filesystems.sh shell_loader_supported_archs.sh
shell_loader_filesystems.sh fails on Github Actions due broken loop
device therefore skip them:

tst_tmpdir.c:317: TINFO: Using /tmp/LTP_sheHtNv5R as tmpdir (overlayfs filesystem)
tst_device.c:147: TINFO: No free devices found
tst_device.c:360: TBROK: Failed to acquire device

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: it's not perfect (we could finally add check which compares whole
output), but checking exit code is better than nothing.

lib/newlib_tests/runtest.sh uses a different approach, but I did not
bother trying to unify them. But it would be worth to add support for
tests which TBROK on GitHub also to lib/newlib_tests/runtest.sh. That
allows us to easily run 'make test' locally to get higher coverage (e.g.
before the release).

 testcases/lib/run_tests.sh | 115 ++++++++++++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 20 deletions(-)

diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
index 40d415e6c4..380870ae55 100755
--- a/testcases/lib/run_tests.sh
+++ b/testcases/lib/run_tests.sh
@@ -1,32 +1,107 @@
 #!/bin/sh
 
-testdir=$(realpath $(dirname $0))
-export PATH="$PATH:$testdir:$testdir/tests/"
-
-for i in `seq -w 01 06`; do
-	echo
-	echo "*** Running shell_test$i ***"
-	echo
-	./tests/shell_test$i
-done
+TESTS_PASS="shell_test01 shell_test02 shell_test03 shell_test04 shell_test05
+shell_loader.sh shell_loader_tcnt.sh shell_loader_c_child.sh"
+
+TESTS_PASS_GITHUB_TBROK="shell_loader_all_filesystems.sh shell_loader_supported_archs.sh shell_loader_filesystems.sh shell_loader_kconfigs.sh"
+
+TESTS_FAIL="shell_loader_tags.sh"
+
+TESTS_TBROK="shell_loader_wrong_metadata.sh shell_loader_no_metadata.sh
+shell_loader_invalid_metadata.sh shell_loader_invalid_block.sh"
+
+TESTS_TCONF="shell_test06"
 
-for i in shell_loader.sh shell_loader_all_filesystems.sh shell_loader_no_metadata.sh \
-	 shell_loader_wrong_metadata.sh shell_loader_invalid_metadata.sh\
-	 shell_loader_supported_archs.sh shell_loader_filesystems.sh\
-	 shell_loader_tcnt.sh shell_loader_kconfigs.sh shell_loader_tags.sh \
-	 shell_loader_invalid_block.sh shell_loader_c_child.sh; do
-	echo
-	echo "*** Running $i ***"
-	echo
-	$i
+SKIP_GITHUB=
+FAIL=
+
+srcdir="$(realpath $(dirname $0))"
+builddir="$srcdir"
+
+usage()
+{
+	cat << EOF
+Usage: $0 [-b DIR ] [-s TESTS]
+-b DIR   build directory (required for out-of-tree build)
+-h       print this help
+EOF
+}
+
+while getopts b:h opt; do
+	case $opt in
+		'h') usage; exit 0;;
+		'b')
+			builddir="$OPTARG/testcases/lib/"
+			if [ ! -d "$builddir" ]; then
+				echo "directory '$builddir' does not exist!" >&2
+				exit 1
+			fi
+			;;
+		*) usage; runtest_brk TBROK "Error: invalid option";;
+	esac
 done
 
+# srcdir is for *.sh, builddir for *.c
+export PATH="$PATH:$srcdir:$builddir:$srcdir/tests/:$builddir/tests/"
+
+
+tst_mask2flag()
+{
+	case "$1" in
+	0) echo TPASS;;
+	1) echo TFAIL;;
+	2) echo TBROK;;
+	4) echo TWARN;;
+	16) echo TINFO;;
+	32) echo TCONF;;
+	esac
+}
+
+run_tests()
+{
+	local exp="$1"
+	local test rc
+	shift
+
+	for test in "$@"; do
+		echo "*** Running '$test' (exp: $(tst_mask2flag $exp)) ***"
+		$test
+		rc=$?
+		if [ $rc = 127 ]; then
+			echo "Test '$test' not found, maybe out-of-tree build and unset builddir?" >&2
+			exit 1
+		elif [ $rc = 2 -a $WHITELIST_GITHUB = 1 -a "$GITHUB_ACTIONS" ]; then
+			SKIP_GITHUB="$SKIP_GITHUB\n*$test"
+		elif [ $rc != $exp ]; then
+			FAIL="$FAIL\n* $test ($(tst_mask2flag $rc), exp: $(tst_mask2flag $exp))"
+		fi
+	done
+}
+
+run_tests 0 $TESTS_PASS
+WHITELIST_GITHUB=1 run_tests 0 $TESTS_PASS_GITHUB_TBROK
+run_tests 32 $TESTS_TCONF
+
 echo
 echo "*** Testing LTP test -h option ***"
 echo
-shell_loader.sh -h
+run_tests 0 "shell_loader.sh -h"
 
 echo
 echo "*** Testing LTP test -i option ***"
 echo
-shell_loader.sh -i 2
+run_tests 0 "shell_loader.sh -i 2"
+
+echo
+echo "***** RESULTS *****"
+
+if [ "$SKIP_GITHUB" ]; then
+	printf "Test skipped on GitHub Actions:$SKIP_GITHUB\n"
+fi
+
+if [ "$FAIL" ]; then
+	printf "Failed tests:$FAIL\n"
+	exit 1
+fi
+
+echo "All tests passed"
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
