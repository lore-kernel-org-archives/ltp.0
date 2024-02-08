Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ABDC48260
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 09:00:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0452A3CC497
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:00:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A0FF3CC4AD
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B6D160010F
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 298EB1FD8B;
 Thu,  8 Feb 2024 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6Q4tdoTvsv3FVK5xSRRuyZzLLHWGd3/RJcNHbIfKU0=;
 b=EX6ewzg1GbXrf/DrsvcGvxu3FVMdX8QOakNhr+ga49ywag++4nnc9z+Na+pyGtaHEMA9rg
 A/SUvIALR7g71Q2r1HRwpI3qtGKqC6n2/FDI56n5aVnYBTpGpNw+j/B8V0vGONM2Avr4Jc
 S2DMKQBcsZpS/FuZwxJoUOq+qmMwapE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6Q4tdoTvsv3FVK5xSRRuyZzLLHWGd3/RJcNHbIfKU0=;
 b=sEz+egaX7GVK/e264016bpZc/6L978YFnd/rxf+XYaSw4fhEh+F5qGMN0bWSxQSvQIzF5L
 Ffa8RP0CWOdRM4Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6Q4tdoTvsv3FVK5xSRRuyZzLLHWGd3/RJcNHbIfKU0=;
 b=EX6ewzg1GbXrf/DrsvcGvxu3FVMdX8QOakNhr+ga49ywag++4nnc9z+Na+pyGtaHEMA9rg
 A/SUvIALR7g71Q2r1HRwpI3qtGKqC6n2/FDI56n5aVnYBTpGpNw+j/B8V0vGONM2Avr4Jc
 S2DMKQBcsZpS/FuZwxJoUOq+qmMwapE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6Q4tdoTvsv3FVK5xSRRuyZzLLHWGd3/RJcNHbIfKU0=;
 b=sEz+egaX7GVK/e264016bpZc/6L978YFnd/rxf+XYaSw4fhEh+F5qGMN0bWSxQSvQIzF5L
 Ffa8RP0CWOdRM4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 129791398A;
 Thu,  8 Feb 2024 08:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wMWtA/qXxGUoDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Feb 2024 08:59:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 09:59:28 +0100
Message-ID: <20240208085932.182167-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208085932.182167-1-pvorel@suse.cz>
References: <20240208085932.182167-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EX6ewzg1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sEz+egaX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.52 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.17)[-0.859];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 298EB1FD8B
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] network: remove xinetd_tests.sh
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

xinetd is nowadays replaced with systemd socket activation.
Therefore remove the test.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                     |   1 -
 testcases/network/xinetd/Makefile        |  11 ---
 testcases/network/xinetd/xinetd_tests.sh | 113 -----------------------
 3 files changed, 125 deletions(-)
 delete mode 100644 testcases/network/xinetd/Makefile
 delete mode 100755 testcases/network/xinetd/xinetd_tests.sh

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index c63223763..83f7c5b78 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -21,4 +21,3 @@ dnsmasq dnsmasq_tests.sh
 iproute ip_tests.sh
 tracepath01 tracepath01.sh
 traceroute01 traceroute01.sh
-xinetd xinetd_tests.sh
diff --git a/testcases/network/xinetd/Makefile b/testcases/network/xinetd/Makefile
deleted file mode 100644
index b789b2a3a..000000000
--- a/testcases/network/xinetd/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (C) 2009, Cisco Systems Inc.
-# Ngie Cooper, July 2009
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= xinetd_tests.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
deleted file mode 100755
index 25ec91d26..000000000
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
-# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2001
-
-TST_SETUP="setup"
-TST_CLEANUP="cleanup"
-TST_NEEDS_CMDS="diff telnet in.telnetd xinetd"
-TST_NEEDS_TMPDIR=1
-TST_TESTFUNC="do_test"
-TST_CNT=2
-
-. daemonlib.sh
-
-setup()
-{
-	[ -f "/usr/lib/systemd/system/telnet.socket" ] && \
-		tst_brk TCONF "xinetd doesn't manage telnet"
-
-	check_addr="127.0.0.1"
-	ip a | grep -q inet6 && check_addr="$check_addr ::1"
-
-	cat > tst_xinetd.conf.1 <<-EOF
-defaults
-{
-    instances      = 25
-    log_type       = FILE /var/log/servicelog
-    log_on_success = HOST PID
-    log_on_failure = HOST
-    disabled       = telnet
-}
-EOF
-
-	cat > tst_xinetd.conf.2 <<-EOF
-defaults
-{
-    instances      = 25
-    log_type       = FILE /var/log/servicelog
-    log_on_success = HOST PID
-    log_on_failure = HOST
-    # disabled       = telnet
-}
-
-service telnet
-{
-    socket_type     = stream
-    protocol        = tcp
-    wait            = no
-    user            = root
-    server          = /usr/sbin/in.telnetd
-    server_args     = -n
-    no_access       =
-    flags           = IPv6
-}
-EOF
-	ROD mv /etc/xinetd.conf xinetd.conf.orig
-}
-
-cleanup()
-{
-	[ -f xinetd.conf.orig ] && \
-		mv xinetd.conf.orig /etc/xinetd.conf
-
-	restart_daemon xinetd
-}
-
-restart_xinetd()
-{
-	tst_res TINFO "restart xinetd"
-	restart_daemon xinetd > tst_xinetd.out 2>&1
-	if [ $? -ne 0 ]; then
-		cat tst_xinetd.out
-		tst_brk TBROK "unable to restart service with telnet disabled"
-	fi
-
-	grep -qi "fail" tst_xinetd.out && \
-		tst_brk TBROK "xinetd failed to restart"
-}
-
-xinetd_test()
-{
-	local cnt=$1
-	local desc="$2"
-	local pattern="$3"
-	local a p
-
-	tst_res TINFO "install the new config file with telnet $desc"
-	ROD mv tst_xinetd.conf.$cnt /etc/xinetd.conf
-	restart_xinetd
-
-	for a in $check_addr; do
-		p=$(echo $pattern | sed "s/ADDR/$a/")
-		if ! echo '' | telnet $a 2>&1 | grep -qiE "$p"; then
-			tst_res TFAIL "not expected output for 'telnet $a'"
-			return
-		fi
-	done
-	tst_res TPASS "expected output with telnet $desc"
-}
-
-do_test()
-{
-	case $1 in
-	1) xinetd_test $1 "disabled" \
-			"telnet: (connect to address ADDR|Unable to connect to remote host): Connection refused";;
-	2) xinetd_test $1 "enabled" \
-			"Connection closed by foreign host";;
-	esac
-}
-
-. tst_net.sh
-tst_run
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
