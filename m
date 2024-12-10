Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AB3E7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 23:00:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A5A03DF52D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 00:00:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B12DB3E943C
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 23:58:03 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AF490603447
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 23:58:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE97F1F445;
 Tue, 10 Dec 2024 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733871480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrUy6AfVATcKpi8usmePGKxDyjFRcHldHWF0fMVE4RM=;
 b=RCD0GVqj7uzIEufzAIpiNlRkUln+7gaDkLgyKbeecw6Kayz1OE34IkwMU+SdMLYF4rSfnb
 TxnahVNr8i7IxeYIRh1D4ZIAjNuGek3j0Xt/HeXaU0ULuGzK0A442C7Fdh+/w5sfNAEeAT
 LRuraEDoo10W+pml9zZc63xFIowo8mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733871480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrUy6AfVATcKpi8usmePGKxDyjFRcHldHWF0fMVE4RM=;
 b=ePDInrFuwg3xFVKPp0p22/ik+tCeHsIiMPk4hxSGK5za1uJquqPdyczeBCJyD/58eDHeTb
 /4F2i7S9QXnTe+CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733871479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrUy6AfVATcKpi8usmePGKxDyjFRcHldHWF0fMVE4RM=;
 b=JKRMN49tgo8bwQyvaiC2B32PNGRevMgmct2kNQMuR0cLsIUxZacFMQyD9xZJeoEWZGL+1K
 Vn949xAvjgXNRYmU2q0wrOUEV2YXmxQ6qo1o1d3UJGgGlaFl87OJFWaUaCrFf2yJTaHf6S
 OtKyIAEPQxI3mFAiNQFJgqKAVJTIsgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733871479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrUy6AfVATcKpi8usmePGKxDyjFRcHldHWF0fMVE4RM=;
 b=yHMbb78sx1kqYLh3F2Kd6+qNl6lbF7BV2V+hcnm0zwOFox0p4e8YWZjqqvCWN/HBeUkIfQ
 TPK0ZptkehRkadDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC74A13A3D;
 Tue, 10 Dec 2024 22:57:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QPK0LHfHWGd9KQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 22:57:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 Dec 2024 23:57:49 +0100
Message-ID: <20241210225753.381770-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210225753.381770-1-pvorel@suse.cz>
References: <20241210225753.381770-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/7] testcases/lib/run_tests.sh: Check expected
 results
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* GitHub Actions workaround removed (not needed)

 testcases/lib/run_tests.sh | 118 +++++++++++++++++++++++++++++++------
 1 file changed, 99 insertions(+), 19 deletions(-)

diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
index 40d415e6c4..0abca2f3ca 100755
--- a/testcases/lib/run_tests.sh
+++ b/testcases/lib/run_tests.sh
@@ -1,32 +1,112 @@
 #!/bin/sh
+# Copyright (c) 2024 Petr Vorel <pvorel@suse.cz>
 
-testdir=$(realpath $(dirname $0))
-export PATH="$PATH:$testdir:$testdir/tests/"
+TESTS_PASS="
+shell_loader.sh
+shell_loader_all_filesystems.sh
+shell_loader_c_child.sh
+shell_loader_filesystems.sh
+shell_loader_kconfigs.sh
+shell_loader_supported_archs.sh
+shell_loader_tcnt.sh
+shell_test01
+shell_test02
+shell_test03
+shell_test04
+shell_test05"
 
-for i in `seq -w 01 06`; do
-	echo
-	echo "*** Running shell_test$i ***"
-	echo
-	./tests/shell_test$i
-done
+TESTS_FAIL="shell_loader_tags.sh"
+
+TESTS_TBROK="
+shell_loader_invalid_block.sh
+shell_loader_invalid_metadata.sh
+shell_loader_no_metadata.sh
+shell_loader_wrong_metadata.sh"
+
+TESTS_TCONF="shell_test06"
+
+FAIL=
 
-for i in shell_loader.sh shell_loader_all_filesystems.sh shell_loader_no_metadata.sh \
-	 shell_loader_wrong_metadata.sh shell_loader_invalid_metadata.sh\
-	 shell_loader_supported_archs.sh shell_loader_filesystems.sh\
-	 shell_loader_tcnt.sh shell_loader_kconfigs.sh shell_loader_tags.sh \
-	 shell_loader_invalid_block.sh shell_loader_c_child.sh; do
-	echo
-	echo "*** Running $i ***"
-	echo
-	$i
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
+		printf "\n*** Running '$test' (exp: $(tst_mask2flag $exp)) ***\n"
+		$test
+		rc=$?
+		if [ "$rc" = 127 ]; then
+			echo "Test '$test' not found, maybe out-of-tree build and unset builddir?" >&2
+			exit 1
+		elif [ "$rc" != "$exp" ]; then
+			FAIL="$FAIL\n* $test ($(tst_mask2flag $rc), exp: $(tst_mask2flag $exp))"
+		fi
+	done
+}
+
+run_tests 0 $TESTS_PASS
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
