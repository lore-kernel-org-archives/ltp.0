Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17476CDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 18:46:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68A9D3CFE58
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 20:45:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1425D3CFD3D
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF5401400BDF
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 595901FECD;
 Mon, 16 Oct 2023 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697481877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBbhhk/nA77J/A7EO8PcTjA3tyRMTk/91gN5USruCE0=;
 b=YEUH9kbX1kvXrp1q8IkdbbAPvTwQKCOl/dN4QpAI5yBXTTkAUuu14I2yrrgAQrqUlUAtIU
 S7QTHJ11FwTH2tMyxFwT1tjcx78wH3wpDLbD6hK/ZfQyytWJcDEWDi3l9xlkMawsggCkT5
 Yi7xA++FuEQnHzl6LwRPoePwuUxJw/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697481877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBbhhk/nA77J/A7EO8PcTjA3tyRMTk/91gN5USruCE0=;
 b=ApQ88Nlu/YjpcefRF3/c1N2ncQMzvf95kf9exIHJNSHy+N7mj/wY0dej1Eh/KMGegjniMW
 HzvlEwPW0WinGmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 040DD138EF;
 Mon, 16 Oct 2023 18:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oL2TNpSELWXAZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 18:44:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 20:44:07 +0200
Message-ID: <20231016184408.879977-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016184408.879977-1-pvorel@suse.cz>
References: <20231016184408.879977-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
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
Subject: [LTP] [RFC PATCH 6/7] testscripts: Remove sysfs.sh
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

Legacy script from 2003, useless nowadays (sysfs is being mounted by
all linux distros).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/sysfs.sh | 121 -------------------------------------------
 1 file changed, 121 deletions(-)
 delete mode 100755 testscripts/sysfs.sh

diff --git a/testscripts/sysfs.sh b/testscripts/sysfs.sh
deleted file mode 100755
index e22f36fa2..000000000
--- a/testscripts/sysfs.sh
+++ /dev/null
@@ -1,121 +0,0 @@
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
-#  FILE        : sysfs.sh
-#  USAGE       : sysfs.sh [ -k <kernel_module> ]
-#
-#  DESCRIPTION : A script that will test sysfs on Linux system.
-#  REQUIREMENTS: CONFIG_DUMMY must have been used to build kernel, and the
-#		 dummy network module must exist.
-#
-#  HISTORY     :
-#      06/24/2003 Prakash Narayana (prakashn@us.ibm.com)
-#
-#  CODE COVERAGE: 31.3% - fs/sysfs (Total Coverage)
-#
-#                  0.0% - fs/sysfs/bin.c
-#                 61.8% - fs/sysfs/dir.c
-#                 27.5% - fs/sysfs/file.c
-#                 40.4% - fs/sysfs/inode.c
-#                 41.2% - fs/sysfs/mount.c
-#                 58.1% - fs/sysfs/symlink.c
-#
-##############################################################
-
-
-MNT_POINT="/tmp/sysfs_$$"
-
-KERNEL_NAME=`uname -a | awk ' { print $3 } '`
-KERN_MODULE=/lib/modules/$KERNEL_NAME/kernel/drivers/net/dummy.ko
-USAGE="$0 [ -k <kernel_module> ]"
-
-
-##############################################################
-#
-# Make sure that uid=root is running this script.
-# Validate the command line arguments.
-#
-##############################################################
-
-if [ $UID != 0 ]
-then
-	echo "FAILED: Must have root access to execute this script"
-	exit 1
-fi
-
-while getopts k: args
-do
-	case $args in
-	k)	KERN_MODULE=$OPTARG ;;
-	\?)	echo $USAGE ; exit 1 ;;
-	esac
-done
-
-if [ -z "$KERN_MODULE" ]
-then
-	echo $USAGE
-	echo "FAILED: kernel module to insert not specified"
-	exit 1
-fi
-
-# Here is the code coverage for fs/sysfs
-# insmod/rmmod net/dummy.ko creates and deletes a directory
-# under sysfs.
-# In kernel, 2.5.73 or higher, insert/delete base/firmware_class.ko
-
-mkdir -p -m 777 $MNT_POINT
-mount -t sysfs sysfs $MNT_POINT
-if [ $? != 0 ]
-then
-	echo "FAILED: sysfs mount failed"
-	exit 1
-fi
-
-insmod $KERN_MODULE
-if [ $? != 0 ]
-then
-	umount $MNT_POINT
-	rm -rf $MNT_POINT
-	echo "FAILED: insmod failed"
-	exit 1
-fi
-
-rmmod $KERN_MODULE
-if [ $? != 0 ]
-then
-	umount $MNT_POINT
-	rm -rf $MNT_POINT
-	echo "FAILED: rmmod failed"
-	exit 1
-fi
-
-
-#######################################################
-#
-# Just before exit, perform the cleanup.
-#
-#######################################################
-
-umount $MNT_POINT
-rm -rf $MNT_POINT
-
-echo "PASSED: $0 passed!"
-exit 0
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
