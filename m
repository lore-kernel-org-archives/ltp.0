Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FDBC433F5
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 11:24:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB2943CA9A2
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 13:24:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2DCA3C092F
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 13:24:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9EB8600783
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 13:24:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 943F01F8E7;
 Fri, 30 Sep 2022 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664537081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9tCr+x/zJ84OO2NLyuJDa2Jg0UgguNublWp71J3xfrs=;
 b=1OoucpDMLZpt1obEG8M7H9qDwJgTrNPeNjTEPISsVbfm+CpSgvRRaBimVYZLQAdD67Q3il
 rOA4MlUs18YhOurxGPLGiMMPGmK67QLB2+8iLsMidVVNORWiDqBp4Xqcawq55ymyLx3tyb
 s6V14Qk7g55P8nYrX1uiofUFhddWI90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664537081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9tCr+x/zJ84OO2NLyuJDa2Jg0UgguNublWp71J3xfrs=;
 b=AWTMu20qcrfpj958DIJk5fZyPxUZQhTlcn0Bd4KFiGgiDfVDVVZakwTLUY0c5u3p9uM2Yx
 1GZxrJSJsl2tAZCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CF7913776;
 Fri, 30 Sep 2022 11:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id siz3AvnRNmMMDQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 11:24:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 30 Sep 2022 13:24:34 +0200
Message-Id: <20220930112434.13038-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix missing cleanup run from setup
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

There was a regression on tests which don't use TST_ALL_FILESYSTEMS=1
when the cleanup function was not run when test called tst_brk in the
setup function. This broke DCCP tests on kernels without dccp_ipv6
module:

./dccp_ipsec_vti.sh; ltp_file -p esp -m tunnel -s 100:500:1000:R1000
dccp_ipsec_vti 1 TINFO: Test vti + IPsec[esp/tunnel]
...
netstress.c:970: TCONF: Failed to load dccp_ipv6 module

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
netstress.c:970: TCONF: Failed to load dccp_ipv6 module
dccp_ipsec_vti 1 TCONF: server failed

./dccp4_ipsec02 dccp_ipsec.sh -p ah -m transport -s 100:500:1000:R1000
...
dccp_ipsec_vti 1 TINFO: Test vti + IPsec[esp/tunnel]
dccp_ipsec_vti 1 TBROK: ip link add ltp_vti0 type vti local 10.0.0.2 remote 10.0.0.1 key 10 dev ltp_ns_veth2 failed: RTNETLINK answers: File exists

The reason was that cleanup function call was moved from _tst_do_exit()
to _tst_run_iterations() created for TST_ALL_FILESYSTEMS. But cleanup
function still needs to be run in _tst_do_exit() (but only) if it
weren't called before.

Fixes: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

It'd be nice to get this to the release.

FYI tested on following tests (probably not worth to add to git)
+ other tests in the shell API.

Kind regards,
Petr

=== /tmp/xx/tst_all_filesystems_cleanup.sh ===
#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>

TST_ALL_FILESYSTEMS=1
TST_MOUNT_DEVICE=1
TST_NEEDS_ROOT=1
TST_TESTFUNC=test
TST_SETUP=do_setup
TST_CLEANUP=do_cleanup
TST_CNT=2

do_setup()
{
	tst_brk TCONF "required TCONF"
}

do_cleanup()
{
	tst_res TINFO "run cleanup"
}


test1()
{
	tst_res TPASS "device using filesystem"
}

test2()
{
	EXPECT_PASS "grep -E '$TST_MNTPOINT ($TST_FS_TYPE|fuseblk)' /proc/mounts"
}

. tst_test.sh
tst_run

=== /tmp/xx/tst_net_cleanup.sh ===
#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>

TST_CLEANUP=do_cleanup
TST_TESTFUNC=test

do_cleanup()
{
	tst_res TINFO "run cleanup"
}

test()
{
	tst_res TPASS "pass"
}

. tst_net.sh
tst_run

=== /tmp/xx/tst_net_tconf_cleanup.sh ===
#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>

TST_SETUP=do_setup
TST_CLEANUP=do_cleanup
TST_TESTFUNC=test

do_setup()
{
	tst_brk TCONF "required TCONF"
}

do_cleanup()
{
	tst_res TINFO "run cleanup"
}

test()
{
	tst_res TPASS "pass"
}

. tst_net.sh
tst_run



 testcases/lib/tst_test.sh | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 7ec744cac..033491b08 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -24,11 +24,25 @@ export TST_LIB_LOADED=1
 trap "tst_brk TBROK 'test interrupted'" INT
 trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
 
+_tst_do_cleanup()
+{
+	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
+		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
+			$TST_CLEANUP
+		else
+			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
+		fi
+	fi
+	TST_DO_CLEANUP=
+}
+
 _tst_do_exit()
 {
 	local ret=0
 	TST_DO_EXIT=1
 
+	_tst_do_cleanup
+
 	cd "$LTPROOT"
 	[ "$TST_MOUNT_FLAG" = 1 ] && tst_umount
 
@@ -785,13 +799,7 @@ _tst_run_iterations()
 		_tst_i=$((_tst_i-1))
 	done
 
-	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
-		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
-			$TST_CLEANUP
-		else
-			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
-		fi
-	fi
+	_tst_do_cleanup
 
 	if [ "$TST_MOUNT_FLAG" = 1 ]; then
 		cd "$LTPROOT"
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
