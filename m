Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61297C4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 09:01:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4EBC3CF547
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:01:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 564723CF542
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:48 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 802421400998
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8305622389;
 Thu,  8 Feb 2024 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yy6TdfeN5UJ7G/BuI8eAAetwGU03TNC6jPVYJ31S0lA=;
 b=zFc5Q+FXYbugvlgbo43p60PQoUMT0/vQrjB5sAnts1sxdVzziF8la1mKH9TBS9O3PZu4AS
 fsVHqLRIJMVQeLKLxf2XZjNjd7siTYNSXuFQ9D2SaQGjHixgQYqOq7vOC6w3uJkPAdw31Z
 tvAdBwxpY0KvqLj5xbM2X4bhJTBIKKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yy6TdfeN5UJ7G/BuI8eAAetwGU03TNC6jPVYJ31S0lA=;
 b=V85CudOtBB0p9IjRP1mhBLuHAf03tMZAtHXpaIeMc9NfBRbkngWWmZrB/JOnECQ8QKmijP
 1G3thyM80zfH5kAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yy6TdfeN5UJ7G/BuI8eAAetwGU03TNC6jPVYJ31S0lA=;
 b=zFc5Q+FXYbugvlgbo43p60PQoUMT0/vQrjB5sAnts1sxdVzziF8la1mKH9TBS9O3PZu4AS
 fsVHqLRIJMVQeLKLxf2XZjNjd7siTYNSXuFQ9D2SaQGjHixgQYqOq7vOC6w3uJkPAdw31Z
 tvAdBwxpY0KvqLj5xbM2X4bhJTBIKKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yy6TdfeN5UJ7G/BuI8eAAetwGU03TNC6jPVYJ31S0lA=;
 b=V85CudOtBB0p9IjRP1mhBLuHAf03tMZAtHXpaIeMc9NfBRbkngWWmZrB/JOnECQ8QKmijP
 1G3thyM80zfH5kAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30CEF13A29;
 Thu,  8 Feb 2024 08:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GG8TC/qXxGUoDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Feb 2024 08:59:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 09:59:29 +0100
Message-ID: <20240208085932.182167-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208085932.182167-1-pvorel@suse.cz>
References: <20240208085932.182167-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(5.10)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] network: Remove telnet01.sh test
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

login via telnet has been obsolete for ages. Testing it nowadays does
not make sense, remove it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                          |  1 -
 testcases/network/tcp_cmds/telnet/Makefile    | 29 ------
 testcases/network/tcp_cmds/telnet/telnet01.sh | 96 -------------------
 3 files changed, 126 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/telnet/Makefile
 delete mode 100755 testcases/network/tcp_cmds/telnet/telnet01.sh

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 83f7c5b78..d6ba49e07 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -13,7 +13,6 @@ ping02 ping02.sh
 sendfile sendfile01.sh
 tc01 tc01.sh
 tcpdump tcpdump01.sh
-telnet telnet01.sh
 iptables iptables01.sh
 nft nft01.sh
 dhcpd dhcpd_tests.sh
diff --git a/testcases/network/tcp_cmds/telnet/Makefile b/testcases/network/tcp_cmds/telnet/Makefile
deleted file mode 100644
index 90e879de2..000000000
--- a/testcases/network/tcp_cmds/telnet/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/tcp_cmds/telnet testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= telnet01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/telnet/telnet01.sh b/testcases/network/tcp_cmds/telnet/telnet01.sh
deleted file mode 100755
index 93343b995..000000000
--- a/testcases/network/tcp_cmds/telnet/telnet01.sh
+++ /dev/null
@@ -1,96 +0,0 @@
-#!/bin/sh
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-
-TCID="telnet01"
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-
-setup()
-{
-	tst_require_cmds telnet expect
-
-	if [ -z $RUSER ]; then
-		RUSER=root
-	fi
-
-	if [ -z $PASSWD ]; then
-		tst_brkm TCONF "Please set PASSWD for $RUSER."
-	fi
-
-	if [ -z $RHOST ]; then
-		tst_brkm TCONF "Please set RHOST."
-	fi
-
-	if [ -z $LOOPCOUNT ]; then
-		LOOPCOUNT=25
-	fi
-}
-
-do_test()
-{
-	tst_resm TINFO "Starting"
-
-	for i in $(seq 1 ${LOOPCOUNT})
-	do
-		telnet_test || return 1
-	done
-}
-
-telnet_test()
-{
-	tst_resm TINFO "login with telnet($i/$LOOPCOUNT)"
-
-	expect -c "
-		spawn telnet $RHOST
-
-		expect -re \"login:\"
-		send \"$RUSER\r\"
-
-		expect -re \"Password:\"
-		send \"$PASSWD\r\"
-
-		expect {
-			\"incorrect\" {
-				exit 1
-			} \"$RUSER@\" {
-				send \"LC_ALL=C ls -l /etc/hosts | \\
-				       wc -w > $RUSER.$RHOST\rexit\r\";
-				exp_continue}
-		}
-
-	" > /dev/null || return 1
-
-	tst_resm TINFO "checking telnet status($i/$LOOPCOUNT)"
-	tst_rhost_run -u $RUSER -c "grep -q 9 $RUSER.$RHOST" || return 1
-	tst_rhost_run -u $RUSER -c "rm -f $RUSER.$RHOST"
-}
-
-. tst_net.sh
-
-setup
-
-do_test
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID failed."
-else
-	tst_resm TPASS "Test $TCID succeeded."
-fi
-
-tst_exit
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
