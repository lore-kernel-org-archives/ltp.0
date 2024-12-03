Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634DBD4979A
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 10:06:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CC653DDCF3
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 11:06:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D4D53DDCDD
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 11:05:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 888DE1036EA3
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 11:05:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A35802116E;
 Tue,  3 Dec 2024 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733220345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JH3u1a26LSswZ5z7w011H8YqCh9K0xo8Qys6NaL2yj4=;
 b=HlEZ8/gtOPmR2V+Qf/Zt5D6XYiFDjmId638iBB5gePCa3V7bFu2UeAr7NmmQlNkVjdTHAG
 PGQpOFz3aL0pId4YSHoUZpwJwYXkAXXebrcKXSe7JXSeM/fxJJx5IqlEvUSjR2xa9h6gcI
 NafGKL6WQ0yL6dUcqneXVPzNJk7uLVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733220345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JH3u1a26LSswZ5z7w011H8YqCh9K0xo8Qys6NaL2yj4=;
 b=RDXHBntZbE0AVxykVLDgPJ5LbqHkhmX60V6cgot2jdd7a19jLyIVhmp+lrklF+1kcwYgA5
 v7/5LUFjaDGexfCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="HlEZ8/gt";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RDXHBntZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733220345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JH3u1a26LSswZ5z7w011H8YqCh9K0xo8Qys6NaL2yj4=;
 b=HlEZ8/gtOPmR2V+Qf/Zt5D6XYiFDjmId638iBB5gePCa3V7bFu2UeAr7NmmQlNkVjdTHAG
 PGQpOFz3aL0pId4YSHoUZpwJwYXkAXXebrcKXSe7JXSeM/fxJJx5IqlEvUSjR2xa9h6gcI
 NafGKL6WQ0yL6dUcqneXVPzNJk7uLVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733220345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JH3u1a26LSswZ5z7w011H8YqCh9K0xo8Qys6NaL2yj4=;
 b=RDXHBntZbE0AVxykVLDgPJ5LbqHkhmX60V6cgot2jdd7a19jLyIVhmp+lrklF+1kcwYgA5
 v7/5LUFjaDGexfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 768F613A15;
 Tue,  3 Dec 2024 10:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qVT0GvnXTmedWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Dec 2024 10:05:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Dec 2024 11:05:40 +0100
Message-ID: <20241203100540.445098-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: A35802116E
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Subject: [LTP] [PATCH 1/1] logrotate: Remove test
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
Cc: Po-Hsu Lin <po-hsu.lin@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

logrotate is an userspace tool, which has it's own testsuite [1].
LTP is meant for kernel testing, therefore remove the test.

[1] https://github.com/logrotate/logrotate/tree/main/test

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/commands                              |   1 -
 .../commands/logrotate/00_Descriptions.txt    |   2 -
 testcases/commands/logrotate/Makefile         |  31 ----
 .../commands/logrotate/logrotate_tests.sh     | 139 ------------------
 4 files changed, 173 deletions(-)
 delete mode 100644 testcases/commands/logrotate/00_Descriptions.txt
 delete mode 100644 testcases/commands/logrotate/Makefile
 delete mode 100755 testcases/commands/logrotate/logrotate_tests.sh

diff --git a/runtest/commands b/runtest/commands
index 5ec2c3b699..cfbaf214c8 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -5,7 +5,6 @@ ldd01_sh ldd01.sh
 nm01_sh nm01.sh
 file01_sh file01.sh
 tar01_sh  tar_tests.sh
-logrotate_sh export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
 cpio01_sh cpio_tests.sh
 unzip01_sh unzip01.sh
 gzip01_sh gzip_tests.sh
diff --git a/testcases/commands/logrotate/00_Descriptions.txt b/testcases/commands/logrotate/00_Descriptions.txt
deleted file mode 100644
index 07ffcd3e6a..0000000000
--- a/testcases/commands/logrotate/00_Descriptions.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-logrotate01
-	test basic functionality of logrotate. use logrotate -f <config> to force rotation. 1. rotate /var/log/tst_logfile file. 2. compresses it.
diff --git a/testcases/commands/logrotate/Makefile b/testcases/commands/logrotate/Makefile
deleted file mode 100644
index c3a701b87d..0000000000
--- a/testcases/commands/logrotate/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    commands/logrotate testcases Makefile.
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
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= logrotate_tests.sh
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
deleted file mode 100755
index 0aa9f12e12..0000000000
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ /dev/null
@@ -1,139 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines Corp., 2001
-# Copyright (c) Linux Test Project, 2002-2024
-# Author: Manoj Iyer <manjo@mail.utexas.edu>
-#
-# Test Basic functionality of logrotate command.
-#
-# Test #1
-# Test that logrotate logrotate will rotate the logfile according to the
-# specifications in the config file.
-# - Create a config file that will rotate the /var/log/tst_logfile file.
-# - Use force option to force logrotate to cause the log file to be rotated.
-# - Compress the file after rotation.
-#
-# Test #2
-# Test that logrotate logrotate will rotate the logfile if the logfile
-# exceeds a certain size.
-# - Create a config file that will rotate the /var/log/tst_largelogfile.
-# - Run logrotate in a cron job that runs every minute.
-# - Add messages to the logfile until it gets rotated when a re-dittermined size
-#   is reached.
-
-TST_NEEDS_CMDS="crontab file grep logrotate"
-TST_TESTFUNC=test
-TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
-TST_CNT=2
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-
-PERMISSION=
-
-setup()
-{
-	local group="syslog"
-
-	grep -q $group /etc/group || group="root"
-	PERMISSION="su root $group"
-}
-
-cleanup()
-{
-	(crontab -l | grep -v tst_largelog) | crontab -
-	rm -rf /var/log/tst_logfile*
-	rm -rf /var/log/tst_largelogfile*
-}
-
-check_log()
-{
-	local file="$1"
-
-	EXPECT_PASS [ -f "$file" ]
-
-	if ! file "$file" | grep -q "gzip compressed data"; then
-		tst_res TFAIL "Failed to create a compressed file"
-	fi
-}
-
-test1()
-{
-	cat >tst_logrotate.conf <<-EOF
-        #****** Begin Config file *******
-        # create new (empty) log files after rotating old ones
-        create
-
-        # compress the log files
-        compress
-
-        /var/log/tst_logfile {
-                $PERMISSION
-                rotate 5
-                weekly
-        }
-        #****** End Config file *******
-	EOF
-
-	cat >/var/log/tst_logfile <<-EOF
-        #****** Begin Log File ********
-        # This is a dummy log file.
-        #****** End Log File ********
-	EOF
-
-	for i in $(seq 10); do
-		echo "This a dummy log file used to test logrotate command." >> /var/log/tst_logfile
-	done
-
-	ROD rm -f /var/log/tst_logfile.*
-	ROD chmod 644 tst_logrotate.conf
-	ROD logrotate -fv tst_logrotate.conf > tst_logrotate.out 2>&1
-
-	EXPECT_PASS grep -q "reading config file tst_logrotate.conf" tst_logrotate.out
-	EXPECT_PASS grep -q "forced from command line (5 rotations)" tst_logrotate.out
-	EXPECT_PASS grep -E -q "compressing new|log with" tst_logrotate.out
-
-	check_log /var/log/tst_logfile.1.gz
-}
-
-test2()
-{
-	cat >tst_largelog.conf <<-EOF
-        # create new (empty) log files after rotating old ones
-        create
-        # compress the log files
-        compress
-        /var/log/tst_largelogfile {
-            $PERMISSION
-            rotate 5
-            size=2k
-        }
-	EOF
-
-	ROD chmod 644 tst_largelog.conf
-
-	cat >/var/log/tst_largelogfile <<-EOF
-        # This is a psuedo-log file. This file will grow to a 2k size before
-        # getting rotated.
-	EOF
-
-	for i in $(seq 75); do
-		echo "Some text for testing rotation" >> /var/log/tst_largelogfile
-	done
-
-	# cron job for logrotating
-	(crontab -l 2>/dev/null; echo \
-		"* * * * * $(command -v logrotate) $(pwd)/tst_largelog.conf") | crontab -
-	if [ $? -ne 0 ]; then
-		tst_brk TBROK "Failed to create a cron job"
-	fi
-
-	# 5 sec for cron job to start, 1 min for logrotate to rotate the logs
-	tst_res TINFO "sleep 1 min to wait for rotating logs"
-	tst_sleep 65s
-
-	check_log /var/log/tst_largelogfile.1.gz
-}
-
-. tst_test.sh
-tst_run
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
