Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6C8C87FDA
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 09:35:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AF133CCF31
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 11:35:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F6EC3C8D08
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 11:35:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C15A21A00718
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 11:35:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13D51218EB;
 Mon,  4 Aug 2025 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754300127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wAIjVJpqHLW1l+X+ZB1BWuKkL5XzxTlaEqgaiLaU0w=;
 b=W3qiywihj+qWhY4tKL5HLXENMjK3oSxRoJ0vuK3+qbe9Fk17TxflJELpTOcE7IdRRtowmA
 CJXuci0esZiwj+X9OtESiNuXpbB/vnRuCP19g0q7jur4VYupMdRFrPUBwP/KK25JRsg8Cq
 98DstbzEbqC7I7Y5dUotrMMB6wqMJQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754300127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wAIjVJpqHLW1l+X+ZB1BWuKkL5XzxTlaEqgaiLaU0w=;
 b=Ra1wiW5TPx4O+hDJwyq30qFTEOP5ov5u86JbDOa23JA+fXmwIXLRyti6o1uewXaYrqcwCn
 /RiQSiqiR78NFPBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754300126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wAIjVJpqHLW1l+X+ZB1BWuKkL5XzxTlaEqgaiLaU0w=;
 b=OSAzLanMtkMTZh7B0xz/0D4GOF/QUy2ECDpS4tf6iOiJnFxau3T6pDN2npVZnN1V4BSF/6
 i6R8/QhZgqnk4FFztLvI32nsn2Yc3JoomhkL+C6RrsFWTu+aDNKMLDLWrzJXx6hMn2biMr
 mqVlAKfZPTt4Wn++m3Qnwbc9fLSceJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754300126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0wAIjVJpqHLW1l+X+ZB1BWuKkL5XzxTlaEqgaiLaU0w=;
 b=PZFxfyZgSDfM87HYT0REYYYMOb11ri828sqLVMRuFfLCGI1IEIOoZImsYHcSXnBbHVrTFX
 cAoN85zdrxB5mbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 017E513695;
 Mon,  4 Aug 2025 09:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0XfNMdx+kGhCBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Aug 2025 09:35:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  4 Aug 2025 11:35:20 +0200
Message-ID: <20250804093520.212221-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] commands: Remove eject test
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

CD-ROM is not much used device nowadays. Also the test is not in
runtest/commands nor in any other runtest command.

The main reason to remove is that this mostly test user space
implementation which barely touches kernel. Test should be in the
in user space projects (e.g. util-linux or BusyBox).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

util-linux has some eject related testsuite:
https://github.com/util-linux/util-linux/tree/master/tests/ts/eject/umount
https://github.com/util-linux/util-linux/tree/master/tests/expected/eject

BusyBox does not have it
https://git.busybox.net/busybox/tree/testsuite

 testcases/commands/eject/Makefile           |  11 --
 testcases/commands/eject/eject-tests.sh     | 147 --------------------
 testcases/commands/eject/eject_check_tray.c |  53 -------
 3 files changed, 211 deletions(-)
 delete mode 100644 testcases/commands/eject/Makefile
 delete mode 100755 testcases/commands/eject/eject-tests.sh
 delete mode 100644 testcases/commands/eject/eject_check_tray.c

diff --git a/testcases/commands/eject/Makefile b/testcases/commands/eject/Makefile
deleted file mode 100644
index f33b5117f9..0000000000
--- a/testcases/commands/eject/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (C) 2009, Cisco Systems Inc.
-# Ngie Cooper, July 2009
-
-top_srcdir		?= ../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-INSTALL_TARGETS		:= eject-tests.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/eject/eject-tests.sh b/testcases/commands/eject/eject-tests.sh
deleted file mode 100755
index 76a667aa33..0000000000
--- a/testcases/commands/eject/eject-tests.sh
+++ /dev/null
@@ -1,147 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines Corp., 2001
-# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
-# Author: Manoj Iyer <manjo@mail.utexas.edu>
-#
-# Tests basic functionality of eject command.
-
-TST_CNT=4
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-TST_TESTFUNC=test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="eject"
-
-setup()
-{
-	CD_DRIVE="/dev/cdrom"
-
-	if ! [ -e "$CD_DRIVE" ]; then
-		tst_brk TCONF "There is no "$CD_DRIVE""
-	fi
-
-	if grep -q "$CD_DRIVE" /proc/mounts; then
-		tst_brk TCONF "$CD_DRIVE is already mounted"
-	fi
-
-	ROD mkdir "cdrom"
-}
-
-cleanup()
-{
-	# We have to use the mount point since /dev/cdrom may be link to
-	# /dev/sr0 and because of that /dev/cdrom is not listed in /proc/mounts
-	tst_umount "$PWD/cdrom"
-}
-
-test1()
-{
-	EXPECT_PASS eject -d \> eject.out
-
-	if grep -q "eject: default device:" eject.out; then
-		tst_res TPASS "Eject listed default device"
-	else
-		tst_res TFAIL "Eject failed to list default device"
-		cat eject.out
-	fi
-}
-
-test2()
-{
-	EXPECT_PASS eject -v $CD_DRIVE \> eject.out
-
-	if grep -q "CD-ROM eject command succeeded" eject.out; then
-		# Close the tray if it is supported.
-	        eject -t $CD_DRIVE > /dev/null 2>&1
-		tst_res TPASS "Drive successfully ejected"
-	else
-		tst_res TFAIL "Eject failed"
-		cat eject.out
-	fi
-}
-
-mount_cdrom()
-{
-	local tries=100
-
-	# Wait for the drive to spin up the disk
-	while [ $tries -gt 0 ]; do
-		eject_check_tray $CD_DRIVE
-		if [ $? -eq 4 ]; then
-			break
-		fi
-		tst_sleep 100ms
-		tries=$((tries-1))
-	done
-
-	mount "$CD_DRIVE" cdrom/ > mount.out 2>&1
-	if [ $? -eq 32 ]; then
-		tst_res TCONF "Failed to mount $CD_DRIVE, no disk in drive?"
-		cat mount.out
-		return 0
-	fi
-
-	tst_res TINFO "$CD_DRIVE mounted sucessfully"
-
-	return 1
-}
-
-test3()
-{
-	if mount_cdrom; then
-		return
-	fi
-
-	test2
-
-	if grep -q "$CD_DRIVE" /proc/mounts; then
-		tst_res TFAIL "$CD_DRIVE is stil moutned"
-	else
-		tst_res TPASS "$CD_DRIVE umounted successfully"
-	fi
-}
-
-test4()
-{
-	if mount_cdrom; then
-		return
-	fi
-
-	EXPECT_PASS eject -a on $CD_DRIVE
-
-	eject_check_tray $CD_DRIVE
-	if [ $? -eq 2 ]; then
-		tst_brk TBROK "$CD_DRIVE is mounted but tray is open"
-	fi
-
-	EXPECT_PASS umount $CD_DRIVE
-
-	eject_check_tray $CD_DRIVE
-	if [ $? -eq 2 ]; then
-		tst_res TPASS "$CD_DRIVE was auto-ejected"
-	else
-		tst_res TFAIL "$CD_DRIVE was not auto-ejected"
-	fi
-
-	EXPECT_PASS eject -a off $CD_DRIVE
-
-	eject -t $CD_DRIVE > /dev/null 2>&1
-
-	if mount_cdrom; then
-		return
-	fi
-
-	EXPECT_PASS umount $CD_DRIVE
-
-	eject_check_tray $CD_DRIVE
-	if [ $? -eq 2 ]; then
-		tst_res TFAIL "$CD_DRIVE was auto-ejected"
-	else
-		tst_res TPASS "$CD_DRIVE was not auto-ejected"
-	fi
-}
-
-. tst_test.sh
-tst_run
diff --git a/testcases/commands/eject/eject_check_tray.c b/testcases/commands/eject/eject_check_tray.c
deleted file mode 100644
index 07e81534bb..0000000000
--- a/testcases/commands/eject/eject_check_tray.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2001                 */
-/*  Jan 8 2003 - Created - Manoj Iyer manjo@mail.utexas.edu                   */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful, but        */
-/* WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY */
-/* or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   */
-/* for more details.                                                          */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software Foundation,   */
-/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
-/******************************************************************************/
-
-/*
- *
- * Description: This program checks the status of the cdrom drive, it will
- *              return the status as to if the cdrom device is open or is
- *              ready for use.
- */
-
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <linux/cdrom.h>
-#include <sys/ioctl.h>
-#include <stdlib.h>
-
-/*
- * Exit Vaules:
- * 0 - No information.
- * 1 - No disk in the drive.
- * 2 - CD tray is open.
- * 3 - CD drive not ready.
- * 4 - CD disk in drive & drive closed.
- */
-int main(int argc, char *argv[])
-{
-	int fd;
-
-	if (argc != 2)
-		exit(-1);
-
-	if ((fd = open(argv[1], O_RDONLY | O_NONBLOCK)) == -1)
-		exit(-2);
-
-	exit(ioctl(fd, CDROM_DRIVE_STATUS));
-}
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
