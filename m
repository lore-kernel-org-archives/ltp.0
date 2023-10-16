Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50B9CDB482
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 18:46:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D50E03CFD70
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 20:46:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD7DE3CFE56
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AFE4A1400BF2
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4B7421C63;
 Mon, 16 Oct 2023 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697481877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7V1U/U0PBYVeSB6eOLCThnUoElrT39xRJLLAgdVm+o=;
 b=NzLqqGLZQ8mhFxx1UMgP8xC+8kU86ze3PMYI0/efewqSMjQ+oot0IRO3D31sTGnhepEE9I
 G3ENTeKYJaki4SxSTwcAcsHNyqJCE0C0tBmB5dc0qsWiwcfo1coMUPhRcRz/bZXvIeG0mh
 ggBFEn11FVFupUhMCUte2BJk53PFGbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697481877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7V1U/U0PBYVeSB6eOLCThnUoElrT39xRJLLAgdVm+o=;
 b=iLPTTsvkPsPGhsG35vG5hKPRFPwOL1U3GGkSH+Eh/RJtrfO8LBPuxQO6moa/NRtZO0ZRqd
 14d4e6QA9ITwU9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A5F1139F9;
 Mon, 16 Oct 2023 18:44:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +Ho5F5WELWXAZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 18:44:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 20:44:08 +0200
Message-ID: <20231016184408.879977-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016184408.879977-1-pvorel@suse.cz>
References: <20231016184408.879977-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-2.99)[-0.998];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 7/7] testcases: Remove autofs{1,4}.sh scripts
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Legacy scripts from 2003, probably not used by anybody.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/autofs1.sh | 273 -----------------------------------------
 testscripts/autofs4.sh | 259 --------------------------------------
 2 files changed, 532 deletions(-)
 delete mode 100755 testscripts/autofs1.sh
 delete mode 100755 testscripts/autofs4.sh

diff --git a/testscripts/autofs1.sh b/testscripts/autofs1.sh
deleted file mode 100755
index 324c4db93..000000000
--- a/testscripts/autofs1.sh
+++ /dev/null
@@ -1,273 +0,0 @@
-#!/bin/bash
-
-
-##############################################################
-#
-#  Copyright (c) International Business Machines  Corp., 2003
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE        : autofs1.sh
-#  USAGE       : autofs1.sh <disk_partition>
-#
-#  DESCRIPTION : A script that will test autofs on Linux system.
-#  REQUIREMENTS:
-#                1) System with a floppy device with a floppy disk in it.
-#                2) A spare (scratch) disk partition of 100MB or larger.
-#
-#  HISTORY     :
-#      06/11/2003 Prakash Narayana (prakashn@us.ibm.com)
-#      08/01/2005 Michael Reed (mreed10@us.ibm.com)
-#      - Added an check to see if a directory exists
-#      - This prevents unnessary failures
-#      - Correction to an echo statement
-#      - Added an additional error message if a floppy disk is not present
-#
-#  CODE COVERAGE:
-#                41.46% - fs/autofs/dirhash.c
-#                33.33% - fs/autofs/init.c
-#                27.70% - fs/autofs/inode.c
-#                38.16% - fs/autofs/root.c
-#                 0.00% - fs/autofs/symlink.c
-#                43.40% - fs/autofs/waitq.c
-#
-##############################################################
-
-
-##############################################################
-#
-# Make sure that uid=root is running this script.
-# Validate the command line argument as a block special device.
-# Make sure that autofs package has been installed.
-# Make sure that autofs module is built into the kernel or loaded.
-#
-##############################################################
-
-if [ $UID != 0 ]
-then
-	echo "FAILED: Must have root access to execute this script"
-	exit 1
-fi
-
-if [ $# != 1 ]
-then
-	echo "FAILED: Usage $0 <disk_partition>"
-        echo "Example: $0 /dev/hdc1"
-	exit 1
-else
-	disk_partition=$1
-	if [ ! -b $disk_partition ]
-	then
-		echo "FAILED: Usage $0 <block special disk_partition>"
-		exit 1
-	fi
-	mkfs -t ext2 $disk_partition
-fi
-
-rpm -q -a | grep autofs
-if [ $? != 0 ]
-then
-	echo "FAILED: autofs package is not installed"
-	exit 1
-fi
-
-grep autofs /proc/filesystems
-if [ $? != 0 ]
-then
-	echo "FAILED: autofs module is not built into the kernel or loaded"
-	exit 1
-fi
-
-
-##############################################################
-#
-# Pick the floppy device name from /etc/fstab
-# Format (mkfs -t ext2) the floppy to ext2 file system
-# Create the /etc/auto.master
-# Create the /etc/auto.media
-# Create /AUTOFS directory.
-#
-##############################################################
-
-floppy_dev=`grep floppy /etc/fstab | awk '{print $1}'`
-
-echo "Found floppy device:$floppy_dev"
-
-if [ $floppy_dev != "" ]
-then
-	/sbin/mkfs -t ext2 $floppy_dev
-	if [ $? != 0 ]
-	then
-		echo "FAILED: mkfs -t ext2 $floppy_dev failed"
-		echo "Insert a disk into the floppy drive"
-		exit 1
-	fi
-fi
-
-if [ ! -d /AUTOFS ]
-then
-	mkdir -m 777 /AUTOFS
-fi
-
-echo "/AUTOFS/MEDIA	/etc/auto.media" > /etc/auto.master
-echo "floppy	-fstype=ext2	:$floppy_dev" > /etc/auto.media
-
-
-##############################################################
-#
-# Verify that "/etc/init.d/autofs start|restart|stop|status|reload"
-# command works.
-#
-# If fails, cleanup and exit.
-#
-##############################################################
-
-/etc/init.d/autofs start
-if [ $? != 0 ]
-then
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs start""
-	exit 1
-fi
-echo "Resuming test, please wait..."
-sleep 15
-
-/etc/init.d/autofs stop
-if [ $? != 0 ]
-then
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs stop""
-	exit 1
-else
-	/etc/init.d/autofs start
-fi
-echo "Resuming test, please wait..."
-sleep 15
-
-/etc/init.d/autofs restart
-if [ $? != 0 ]
-then
-	/etc/init.d/autofs stop
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs restart""
-	exit 1
-fi
-echo "Resuming test, please wait..."
-sleep 15
-
-/etc/init.d/autofs status
-if [ $? != 0 ]
-then
-	/etc/init.d/autofs stop
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs status""
-	exit 1
-fi
-
-/etc/init.d/autofs reload
-if [ $? != 0 ]
-then
-	/etc/init.d/autofs stop
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs reload""
-	exit 1
-fi
-
-
-##############################################################
-#
-# Tryout some error code paths by:
-# (1) Write into automount directory
-# (2) Remove automount parent directory
-# (3) Automount the floppy disk
-# (4) Hit automounter timeout by sleep 60; then wakeup with error
-#     condition.
-#
-##############################################################
-
-echo "forcing error paths and conditions..."
-
-mkdir /AUTOFS/MEDIA/mydir >/dev/null 2>&1
-rm -rf /AUTOFS >/dev/null 2>&1
-
-mkdir /AUTOFS/MEDIA/floppy/test
-cp /etc/auto.master /etc/auto.media /AUTOFS/MEDIA/floppy/test
-sync; sync
-echo "Resuming test, please wait..."
-sleep 60
-mkdir /AUTOFS/MEDIA/mydir >/dev/null 2>&1
-rm -rf /AUTOFS >/dev/null 2>&1
-
-
-##############################################################
-#
-# Add an entry to the /etc/auto.master and reload.
-#
-##############################################################
-
-echo "/AUTOFS/DISK	/etc/auto.disk" >> /etc/auto.master
-echo "disk		-fstype=auto,rw,sync	:$disk_partition " > /etc/auto.disk
-/etc/init.d/autofs reload
-echo "Resuming test, please wait..."
-sleep 30
-
-
-
-mkdir /AUTOFS/DISK/disk/test
-cp /etc/auto.master /etc/auto.media /AUTOFS/DISK/disk/test
-sync; sync
-echo "Resuming test, please wait..."
-sleep 60
-
-
-if [ -e  /AUTOFS/DISK/disk/test ]; then
-  cd /AUTOFS/DISK/disk/test
-  umount /AUTOFS/DISK/disk/ >/dev/null 2>&1
-  if [ $? = 0 ]
-    then
-	/etc/init.d/autofs stop
-	rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
-	echo "FAILED: unmounted a busy file system!"
-	exit 1
-  fi
-  cd
-  umount /AUTOFS/DISK/disk/
-if [ $? != 0 ]
-  then
-	/etc/init.d/autofs stop
-	rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
-	echo "FAILED: Could not unmount automounted file system"
-	exit 1
-  fi
-fi
-#
-# Mount the disk partition somewhere else and then reference automount
-# point for disk partition.
-#
-mount -t ext2 $disk_partition /mnt/
-ls -l /AUTOFS/DISK/disk
-umount /mnt
-
-
-#######################################################
-#
-# Just before exit, stop autofs and cleanup.
-#
-#######################################################
-
-/etc/init.d/autofs stop
-rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
-echo "PASSED: $0 passed!"
-exit 0
diff --git a/testscripts/autofs4.sh b/testscripts/autofs4.sh
deleted file mode 100755
index 00119a604..000000000
--- a/testscripts/autofs4.sh
+++ /dev/null
@@ -1,259 +0,0 @@
-#!/bin/bash
-
-
-##############################################################
-#
-#  Copyright (c) International Business Machines  Corp., 2003
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE        : autofs4.sh
-#  USAGE       : autofs4.sh <disk_partition>
-#
-#  DESCRIPTION : A script that will test autofs on Linux system.
-#  REQUIREMENTS:
-#                1) System with a floppy device with a floppy disk in it.
-#                2) A spare (scratch) disk partition of 100MB or larger.
-#
-#  HISTORY     :
-#      06/11/2003 Prakash Narayana (prakashn@us.ibm.com)
-#
-#  CODE COVERAGE: 26.8% - fs/autofs4 (Total Coverage)
-#
-#                 24.1% - fs/autofs4/expire.c
-#                 33.3% - fs/autofs4/init.c
-#                 24.0% - fs/autofs4/inode.c
-#                 29.9% - fs/autofs4/root.c
-#                  0.0% - fs/autofs4/symlink.c
-#                 29.1% - fs/autofs4/waitq.c
-#
-##############################################################
-
-
-##############################################################
-#
-# Make sure that uid=root is running this script.
-# Validate the command line argument as a block special device.
-# Make sure that autofs package has been installed.
-# Make sure that autofs module is built into the kernel or loaded.
-#
-##############################################################
-
-if [ $UID != 0 ]
-then
-	echo "FAILED: Must have root access to execute this script"
-	exit 1
-fi
-
-if [ $# != 1 ]
-then
-	echo "FAILED: Usage $0 <disk_partition>"
-	exit 1
-else
-	disk_partition=$1
-	if [ ! -b $disk_partition ]
-	then
-		echo "FAILED: Usage $0 <block special disk_partition>"
-		exit 1
-	fi
-	mkfs -t ext2 $disk_partition >/dev/null 2>&1
-fi
-
-rpm -q -a | grep autofs >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	echo "FAILED: autofs package is not installed"
-	exit 1
-fi
-
-grep autofs /proc/filesystems >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	echo "FAILED: autofs module is not built into the kernel or loaded"
-	exit 1
-fi
-
-
-##############################################################
-#
-# Pick the floppy device name from /etc/fstab
-# Format (mkfs -t ext2) the floppy to ext2 file system
-# Create the /etc/auto.master
-# Create the /etc/auto.media
-# Create /AUTOFS directory.
-#
-##############################################################
-
-floppy_dev=`grep floppy /etc/fstab | awk '{print $1}'`
-
-if [ $floppy_dev != "" ]
-then
-	/sbin/mkfs -t ext2 $floppy_dev >/dev/null 2>&1
-	if [ $? != 0 ]
-	then
-		echo "FAILED: mkfs -t ext2 $floppy_dev failed"
-		exit 1
-	fi
-fi
-
-if [ ! -d /AUTOFS ]
-then
-	mkdir -m 755 /AUTOFS
-fi
-
-echo "/AUTOFS/MEDIA	/etc/auto.media		" > /etc/auto.master
-echo "floppy	-fstype=ext2					:$floppy_dev" > /etc/auto.media
-
-
-##############################################################
-#
-# Verify that "/etc/init.d/autofs start|restart|stop|status|reload"
-# command works.
-#
-# If fails, cleanup and exit.
-#
-##############################################################
-
-/etc/init.d/autofs start >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs start""
-	exit 1
-fi
-echo "Resuming test, please wait..."
-sleep 15
-
-/etc/init.d/autofs stop >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs stop""
-	exit 1
-else
-	/etc/init.d/autofs start >/dev/null 2>&1
-fi
-sleep 15
-
-/etc/init.d/autofs restart >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	/etc/init.d/autofs stop >/dev/null 2>&1
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs restart""
-	exit 1
-fi
-echo "Resuming test, please wait..."
-sleep 15
-
-/etc/init.d/autofs status >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	/etc/init.d/autofs stop >/dev/null 2>&1
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs status""
-	exit 1
-fi
-
-/etc/init.d/autofs reload >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	/etc/init.d/autofs stop >/dev/null 2>&1
-	rm -rf /etc/auto.master /etc/auto.media /AUTOFS
-	echo "FAILED: "/etc/init.d/autofs reload""
-	exit 1
-fi
-
-
-##############################################################
-#
-# Tryout some error code paths by:
-# (1) Write into automount directory
-# (2) Remove automount parent directory
-# (3) Automount the floppy disk
-# (4) Hit automounter timeout by sleep 60; then wakeup with error
-#     condition.
-#
-##############################################################
-
-mkdir /AUTOFS/MEDIA/mydir >/dev/null 2>&1
-rm -rf /AUTOFS >/dev/null 2>&1
-
-mkdir /AUTOFS/MEDIA/floppy/test
-cp /etc/auto.master /etc/auto.media /AUTOFS/MEDIA/floppy/test
-sync; sync
-echo "Resuming test, please wait..."
-sleep 60
-mkdir /AUTOFS/MEDIA/mydir >/dev/null 2>&1
-rm -rf /AUTOFS >/dev/null 2>&1
-
-
-##############################################################
-#
-# Add an entry to the /etc/auto.master and reload.
-#
-##############################################################
-
-echo "/AUTOFS/DISK	/etc/auto.disk		" >> /etc/auto.master
-echo "disk		-fstype=ext2					:$disk_partition " > /etc/auto.disk
-/etc/init.d/autofs reload >/dev/null 2>&1
-echo "Resuming test, please wait..."
-sleep 30
-
-mkdir /AUTOFS/DISK/disk/test
-cp /etc/auto.master /etc/auto.media /AUTOFS/DISK/disk/test
-sync; sync
-echo "Resuming test, please wait..."
-sleep 60
-
-cd /AUTOFS/DISK/disk/test
-umount /AUTOFS/DISK/disk/ >/dev/null 2>&1
-if [ $? = 0 ]
-then
-	/etc/init.d/autofs stop >/dev/null 2>&1
-	rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
-	echo "FAILED: unmounted a busy file system!"
-	exit 1
-fi
-cd
-
-umount /AUTOFS/DISK/disk/ >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	/etc/init.d/autofs stop >/dev/null 2>&1
-	rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
-	echo "FAILED: Could not unmount automounted file system"
-	exit 1
-fi
-
-#
-# Mount the disk partition somewhere else and then reference automount
-# point for disk partition.
-#
-mount -t ext2 $disk_partition /mnt/
-ls -l /AUTOFS/DISK/disk
-umount /mnt
-
-
-#######################################################
-#
-# Just before exit, stop autofs and cleanup.
-#
-#######################################################
-
-/etc/init.d/autofs stop >/dev/null 2>&1
-rm -rf /etc/auto.master /etc/auto.media /etc/auto.disk /AUTOFS
-echo "PASSED: $0 passed!"
-exit 0
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
