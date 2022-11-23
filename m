Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CF6C4332F
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 11:56:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0645D3CCA10
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 12:56:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 267963C0123
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 12:55:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5CFB1400429
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 12:55:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 896D921BB7;
 Wed, 23 Nov 2022 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669204552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AhiemLxWihNPkD/762cl8A423UOlLpPsDzHknQ2Hjts=;
 b=zPCobpWPX4cXS9iC29MvsV7h1PwtPrIH8M6QP9s/lbxHgrdDNRmIpBjiF2B7HqC8xTQmQb
 cp4IcFxVLJt9PdzEPYzsK2ZxmmT0acUY2Z1Xu/v3FhjALPs3SubPXl7RC9UWCGhcB3G2Ft
 HDlWVZkHmPL+FqgvUps8PDNkz5qW1Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669204552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AhiemLxWihNPkD/762cl8A423UOlLpPsDzHknQ2Hjts=;
 b=OqMybVsU7koEYnak8CpDxP7l9Qio8tPbnVUrbIH/xWET4TBdLjSeCBDq2Ba0dRBCaSMpFE
 NlJQfI2CNw3XBLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07ABD13AE7;
 Wed, 23 Nov 2022 11:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1LNcAEgKfmMEWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Nov 2022 11:55:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 23 Nov 2022 12:55:46 +0100
Message-Id: <20221123115546.786-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] Remove fs-bench
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

fs-bench is horribly broken and there does not seem to be a lot of value
in keeping it.

Closes: https://github.com/linux-test-project/ltp/issues/994

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/fs-bench/.gitignore       |   3 -
 testcases/kernel/fs/fs-bench/Makefile         |  41 ------
 testcases/kernel/fs/fs-bench/README           |  45 ------
 testcases/kernel/fs/fs-bench/boxmuler.c       |  28 ----
 testcases/kernel/fs/fs-bench/create-files.c   | 119 ---------------
 testcases/kernel/fs/fs-bench/fs-bench-test.sh |  50 -------
 .../kernel/fs/fs-bench/fs-bench-test2.sh      |  63 --------
 testcases/kernel/fs/fs-bench/modaltr.sh       | 124 ----------------
 .../fs/fs-bench/random-access-del-create.c    | 136 ------------------
 testcases/kernel/fs/fs-bench/random-access.c  |  92 ------------
 .../kernel/fs/fs-bench/random-del-create.c    | 134 -----------------
 11 files changed, 835 deletions(-)
 delete mode 100644 testcases/kernel/fs/fs-bench/.gitignore
 delete mode 100644 testcases/kernel/fs/fs-bench/Makefile
 delete mode 100644 testcases/kernel/fs/fs-bench/README
 delete mode 100644 testcases/kernel/fs/fs-bench/boxmuler.c
 delete mode 100644 testcases/kernel/fs/fs-bench/create-files.c
 delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test.sh
 delete mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test2.sh
 delete mode 100755 testcases/kernel/fs/fs-bench/modaltr.sh
 delete mode 100644 testcases/kernel/fs/fs-bench/random-access-del-create.c
 delete mode 100644 testcases/kernel/fs/fs-bench/random-access.c
 delete mode 100644 testcases/kernel/fs/fs-bench/random-del-create.c

diff --git a/testcases/kernel/fs/fs-bench/.gitignore b/testcases/kernel/fs/fs-bench/.gitignore
deleted file mode 100644
index 5824a4002..000000000
--- a/testcases/kernel/fs/fs-bench/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-/create-files
-/random-access
-/random-access-del-create
diff --git a/testcases/kernel/fs/fs-bench/Makefile b/testcases/kernel/fs/fs-bench/Makefile
deleted file mode 100644
index bc570f7eb..000000000
--- a/testcases/kernel/fs/fs-bench/Makefile
+++ /dev/null
@@ -1,41 +0,0 @@
-#
-#    kernel/fs/fs-bench testcases Makefile.
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
-top_srcdir			?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS			:= modaltr.sh fs-bench-test.sh fs-bench-test2.sh
-
-LDLIBS				+= -lm
-
-create-files: boxmuler.o create-files.o
-
-random-access-del-create: boxmuler.o random-access-del-create.o
-
-MAKE_TARGETS			:= create-files random-access\
-				   random-access-del-create
-
-dist: clean
-	(cd $(abs_srcdir); tar zcvf fs-bench.tar.gz $(abs_srcdir))
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs-bench/README b/testcases/kernel/fs/fs-bench/README
deleted file mode 100644
index 20d49a951..000000000
--- a/testcases/kernel/fs/fs-bench/README
+++ /dev/null
@@ -1,45 +0,0 @@
-Programs for File system stress test.
-
-All of programs are distributed under GPL 2 license
-by Hironobu SUZUKI <hironobu@h2np.net>
-
-HOW TO TEST
-------------
-
-1: Type "make"
-
-	# cd
-	# tar zxvf fs-bench.tar.gz
-	# cd fs-bench
-	# make
-
-2: Change directory to terget file system and do-it!
-	(I always use one-HDD/one-partition for fs stress test.)
-
-	# mount -t jfs /dev/hdc1 /jfs
-	# cd /jfs
-	# ~/fs-bench/test.sh 2>&1 | tee ~/fs-bench/jfs-test
-
-
-NOTE
------
-
-The size of files that are created for stress test is not fixed.  The
-file size are determined by probabilistic algorithm, box-muler
-algorithm.
-
-number
-of files
-  ^
-  |       ****
-  |      *    *
-  |     *      *
-  |    *        *
-  |  **          **
-  |**              **
-  +-------------------> file size
-  min               max
-
-
-------
-$Id: README,v 1.1 2004/11/18 20:23:05 robbiew Exp $
diff --git a/testcases/kernel/fs/fs-bench/boxmuler.c b/testcases/kernel/fs/fs-bench/boxmuler.c
deleted file mode 100644
index e923a1617..000000000
--- a/testcases/kernel/fs/fs-bench/boxmuler.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include <math.h>
-#include <stdlib.h>
-
-#define M_2PI (M_PI*2)
-
-int box_muler(int min, int max)
-{
-	double u1, u2, z;
-	int i;
-	int ave;
-	int range;
-	int ZZ;
-	if (min >= max) {
-		return (-1);
-	}
-	range = max - min;
-	ave = range / 2;
-	for (i = 0; i < 10; i++) {
-		u1 = ((double)(random() % 1000000)) / 1000000;
-		u2 = ((double)(random() % 1000000)) / 1000000;
-		z = sqrt(-2.0 * log(u1)) * cos(M_2PI * u2);
-		ZZ = min + (ave + (z * (ave / 4)));
-		if (ZZ >= min && ZZ < max) {
-			return (ZZ);
-		}
-	}
-	return (-1);
-}
diff --git a/testcases/kernel/fs/fs-bench/create-files.c b/testcases/kernel/fs/fs-bench/create-files.c
deleted file mode 100644
index c6cba6f69..000000000
--- a/testcases/kernel/fs/fs-bench/create-files.c
+++ /dev/null
@@ -1,119 +0,0 @@
-/* create.c (GPL)*/
-/* Hironobu SUZUKI <hironobu@h2np.net> */
-#include <stdio.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <time.h>
-#include <stdlib.h>
-
-#define MAXN 4096
-
-#define MAXFSIZE 1024 * 192
-
-char wbuf[MAXFSIZE];
-static int filecount = 0;
-
-void makedir(char *dir1);
-void changedir(char *dir);
-void create_file(char *filename);
-
-extern int box_muler(int, int);
-
-int startc = 0;
-int main(int ac, char *av[])
-{
-	int i = 0;
-	int j = 0;
-	int k = 0;
-	int l = 0;
-	char dir1[MAXN];
-	char dir2[MAXN];
-	char dir3[MAXN];
-	char filename[MAXN];
-	time_t t;
-	int maxfiles = 0xFFFFFF;
-	int createfiles = 0;
-
-	if (ac > 1) {
-		sscanf(av[1], "%x", &maxfiles);
-		if (maxfiles == 0) {
-			printf("maxfile argument error (0 value)\n");
-			exit(1);
-		}
-	}
-	time(&t);
-	srandom((unsigned int)getpid() ^
-		(((unsigned int)t << 16) | (unsigned int)t >> 16));
-	printf("Create files\n");
-	for (i = 0; i < 0xFF; i++) {
-		sprintf(dir1, "%2.2x", i);
-		makedir(dir1);
-		changedir(dir1);
-		for (j = 0; j < 0xFF; j++) {
-			sprintf(dir2, "%2.2x", j);
-			makedir(dir2);
-			changedir(dir2);
-			for (k = 0; k < 0xFF; k++) {
-				sprintf(dir3, "%2.2x", k);
-				makedir(dir3);
-				changedir(dir3);
-				for (l = 0; l < 0xFF; l++) {
-					sprintf(filename, "%s%s%s%2.2x", dir1,
-						dir2, dir3, l);
-					create_file(filename);
-					if (maxfiles < createfiles++) {
-						goto end;
-					}
-				}
-				changedir("../");
-			}
-			changedir("../");
-		}
-		changedir("../");
-	}
-end:
-	fprintf(stderr, "\nTotal create files: %d\n", filecount);
-	printf("Done\n");
-	return 0;
-}
-
-int showchar[] = { 124, 47, 45, 92, 124, 47, 45, 92 };
-
-void makedir(char *dir1)
-{
-	if (mkdir(dir1, S_IRWXU) < 0) {
-		perror(dir1);
-		exit(1);
-	}
-}
-
-void changedir(char *dir)
-{
-	if (chdir(dir) < 0) {
-		perror(dir);
-		exit(1);
-	}
-}
-
-void create_file(char *filename)
-{
-	int fd;
-	int randomsize;
-	if ((fd = creat(filename, S_IRWXU)) < 0) {
-		fprintf(stderr, "\nTotal create files: %d\n", filecount);
-		perror(filename);
-		exit(1);
-	}
-	if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
-		randomsize = MAXFSIZE;
-	}
-	if (write(fd, wbuf, randomsize) < 0) {
-		fprintf(stderr, "\nTotal create files: %d\n", filecount);
-		perror(filename);
-		exit(1);
-	}
-	filecount++;
-	close(fd);
-}
diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test.sh b/testcases/kernel/fs/fs-bench/fs-bench-test.sh
deleted file mode 100755
index c2ca767f0..000000000
--- a/testcases/kernel/fs/fs-bench/fs-bench-test.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#! /bin/bash
-
-echo "## Start Test"
-date
-if [ -d ./00 ] ; then
-    echo -n "Clear old files..."
-    /bin/rm -fr ./00 >& /dev/null
-    echo "done"
-fi
-STARTT=`date +%s`
-echo $STARTT
-echo ""
-echo "## Create files "
-time ~/fs-bench/cr
-
-echo ""
-echo "## tar all "
-MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'| awk -F'/' '{print $4;}'`
-
-echo ""
-echo "## Change owner"
-time chown -R $USER  ./00
-
-echo ""
-echo "## random access"
-time ~/fs-bench/ra  $MAXFILE
-
-echo ""
-echo "## Change mode "
-time chmod -R go+rw  ./00
-
-echo ""
-echo "## Random delete and create"
-time ~/fs-bench/radc  $MAXFILE
-
-echo ""
-echo "## Change mode again"
-time chmod -R go-rw  ./00
-
-echo ""
-echo "## Remove all files and directories"
-time /bin/rm -fr ./00
-echo ""
-echo "## Finish test"
-ENDT=`date +%s`
-echo $ENDT
-date
-
-echo -n 'TOTAL(seconds): '
-expr $ENDT - $STARTT
diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh b/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
deleted file mode 100755
index 25c67afe0..000000000
--- a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
+++ /dev/null
@@ -1,63 +0,0 @@
-#! /bin/bash
-
-echo "## Start Test"
-date
-date +%s
-if [ -d ./00 ] ; then
-/bin/rm -fr ./00 >& /dev/null
-fi
-STARTT=`date +%s`
-echo $STARTT
-
-echo ""
-echo "## Create files "
-time ~/fs-bench/cr
-
-echo ""
-echo "## tar all "
-MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'| awk -F'/' '{print $4;}'`
-HALFFILE=`echo "obase=F;ibase=F;$MAXFILE/2" | bc`
-
-echo ""
-echo "## Remove all files and directories"
-/bin/rm -fr ./00 >& /dev/null
-
-echo ""
-echo "## Create half files"
-echo create half files
-time ~/fs-bench/cr  $HALFFILE
-
-echo ""
-echo "## Change owner"
-time chown -R $USER  ./00
-
-echo ""
-echo "## random access"
-time ~/fs-bench/ra  $HALFFILE
-
-
-echo ""
-echo "## Change mode "
-time chmod -R go+rw  ./00
-
-echo ""
-echo "## Random delete and create"
-time ~/fs-bench/radc  $HALFFILE
-
-echo ""
-echo "## Change mode again"
-time chmod -R go-rw  ./00
-
-echo ""
-echo "## Remove all files and directories"
-time /bin/rm -fr ./00
-
-echo ""
-echo "## Finish test"
-date
-ENDT=`date +%s`
-echo $ENDT
-echo -n 'TOTAL(seconds): '
-expr $ENDT - $STARTT
-
-
diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh b/testcases/kernel/fs/fs-bench/modaltr.sh
deleted file mode 100755
index e44c17f13..000000000
--- a/testcases/kernel/fs/fs-bench/modaltr.sh
+++ /dev/null
@@ -1,124 +0,0 @@
-#!/bin/sh
-#To run this script the following is necessary
-# 1.kernel should mtd support as module.
-# 2.kernel should hsve jffs2 support as module.
-# 3.kernel should have loopback device support .
-# 4.you should have fs-bench utility (http://h2np.net/tools/fs-bench-0.2.tar.gz)
-# 5.results will be copied to /tmp/log and /tmp/log1 files
-
-#DESCRIPTION: This testscript creates a jffs2 file system type and tests the filesystem test
-#and places the log in the log directory.The file system test actually creates a tree of large
-#directories and performs the delete and random delete operations as per the filesystem stress
-#algorithim and gives a report of real time ,user time,system time taken to perform the file
-#operations.
-
-#script created  G.BANU PRAKASH (mailto:prakash.banu@wipro.com).
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
-
-MTD_RAM=mtdram
-MTD_BLOCK=mtdblock
-JFFS2=jffs2
-LOOP=loop
-MTD_BLKDEVS=mtd_blkdevs
-ZLIB_DEFLATE=zlib_deflate
-ZLIB_INFLATE=zlib_inflate
-MTD_CORE=mtdcore
-MOUNT_DIR=/mnt
-LOG_DIR=/tmp/log
-LOG_DIR1=/tmp/log1
-HOME_DIR=/home
-BLOCK_DIR=/dev/mtdblock
-export PATH=$PATH:/sbin
-	if [ $(id -ru) -ne 0 ];
-then
-	echo "must be root to run this"
-	exit
-fi
-
-
-
-lsmod |grep $MTD_RAM
-
-	if [ $? -ne 0 ];
-then
-	echo "inserting mtd ram and its dependencies"
-fi
-modprobe $MTD_RAM  total_size=32768 erase_size=256
-	if [ $? -ne 0 ];
-then
-	echo "check wheather MTD -mtdram is been compiled in the kernel"
-fi
-lsmod |grep $MTD_BLOCK
-	if [ $? -ne 0 ]; then
-	echo "inserting mtdblock  and its dependencies"
-fi
-modprobe $MTD_BLOCK
-	if [ $? -ne 0 ]; then
-	echo "check wheather mtdblock is been compiled in the kernel"
-fi
-
-lsmod |grep $JFFS2
-	if [ $? -ne 0 ]; then
-	echo "inserting jffs2  and its dependencies"
-fi
-modprobe $JFFS2
-	if [ $? -ne 0 ]; then
-	echo "check wheather jffs2 is been compiled in the kernel"
-fi
-
-lsmod |grep $LOOP
-	if [ $? -ne 0 ]; then
-	echo "inserting loopback device module"
-fi
-modprobe $LOOP
-	if [ $? -ne 0 ]; then
-	echo "check wheather loopback device option is been compiled in the kernel"
-fi
-mkdir -p $BLOCK_DIR
-mknod $BLOCK_DIR/0 b 31 0 >/dev/null 2>&1
-mount -t jffs2 $BLOCK_DIR/0 $MOUNT_DIR
-mount|grep $JFFS2
-	if [ $? -eq 0 ]; then
- echo "jffs2 mounted sucessfully"
-	else
- echo "mount unsucessfull"
-fi
-cd $MOUNT_DIR
-echo "This is will take long time "
-./test.sh    >log 2>&1
-./test2.sh    >log1 2>&1
-
-mv log   $LOG_DIR
-mv log1  $LOG_DIR1
-cd $HOME_DIR
-
-
-#cleanup
-echo "unmounting $MOUNT_DIR "
-umount $MOUNT_DIR
-echo "removing the modules inserted"
-rmmod  $MTD_BLOCK
-rmmod  $MTD_BLKDEVS
-rmmod  $LOOP
-rmmod  $JFFS2
-rmmod  $ZLIB_DEFLATE
-rmmod  $ZLIB_INFLATE
-rmmod  $MTD_RAM
-rmmod  $MTD_CORE
-rm -rf /dev/mtdblock
-echo "TEST COMPLETE"
-echo "RESULTS LOGGED IN FILE  /tmp/log and /tmp/log1  "
diff --git a/testcases/kernel/fs/fs-bench/random-access-del-create.c b/testcases/kernel/fs/fs-bench/random-access-del-create.c
deleted file mode 100644
index 1878fd78b..000000000
--- a/testcases/kernel/fs/fs-bench/random-access-del-create.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/* random-del-create.c (GPL)*/
-/* Hironobu SUZUKI <hironobu@h2np.net> */
-
-#include <stdio.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <time.h>
-#include <stdlib.h>
-#define FAIL 0
-#define SUCCESS 1
-
-#define MAXNUM 0x100000
-
-#define  MAXERROR 1024
-
-extern int box_muler(int, int);
-extern void create_or_delete(char *);
-
-int delete_file(char *filename);
-int create_file(char *filename);
-
-int cfilecount = 0;
-int dfilecount = 0;
-int errorcount = 0;
-
-int main(int ac, char **av)
-{
-	int r;
-	char fname[1024];
-	time_t t;
-	int i;
-	int m;
-
-	if (ac != 2) {
-		printf("%s hex-style-filename \n", av[0]);
-		printf("ex) %s 00022300\n", av[0]);
-		exit(1);
-	}
-	sscanf(av[1], "%x", &m);
-	if (m < 1 || m > MAXNUM) {
-		printf("out of size %d\n", m);
-		exit(1);
-	}
-
-	time(&t);
-	srandom((unsigned int)getpid() ^
-		(((unsigned int)t << 16) | (unsigned int)t >> 16));
-
-	/* 00/00/00/00 */
-	for (i = 0; i < m; i++) {
-		r = random() % m;
-		sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
-			((r >> 16) & 0xFF),
-			((r >> 8) & 0xFF),
-			((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
-		create_or_delete(fname);
-	}
-	fprintf(stderr, "Total create files: %d\n", cfilecount);
-	fprintf(stderr, "Total delete files: %d\n", dfilecount);
-	fprintf(stderr, "Total error       : %d\n", errorcount);
-	exit(0);
-}
-
-#define MAXFSIZE (192*1024)
-#define AVEFSIZE (MAXFSIZE/2)
-#define POOLDISKSPACE (AVEFSIZE*128)
-
-static int disk_space_pool = 0;
-void create_or_delete(char *fname)
-{
-	int r;
-
-	r = (random() & 1);
-	if (r && disk_space_pool > POOLDISKSPACE) {
-		/* create */
-		create_file(fname);
-	} else {
-		delete_file(fname);
-	}
-	if ((errorcount > dfilecount || errorcount > cfilecount)
-	    && (errorcount > MAXERROR)) {
-		fprintf(stderr, "too much error -- stop\n");
-		fprintf(stderr, "Total create files: %d\n", cfilecount);
-		fprintf(stderr, "Total delete files: %d\n", dfilecount);
-		fprintf(stderr, "Total error       : %d\n", errorcount);
-		exit(1);
-	}
-}
-
-int create_file(char *filename)
-{
-	int fd;
-	int randomsize;
-	char wbuf[MAXFSIZE];
-	if ((fd = creat(filename, S_IRWXU)) < 0) {
-		errorcount++;
-		return (-1);
-	}
-	if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
-		randomsize = MAXFSIZE;
-	}
-	if (write(fd, wbuf, randomsize) < 0) {
-		errorcount++;
-		close(fd);
-		return (-1);
-	}
-	cfilecount++;
-	disk_space_pool -= randomsize;
-	close(fd);
-
-	return 0;
-}
-
-#include <sys/stat.h>
-#include <unistd.h>
-
-int delete_file(char *filename)
-{
-	struct stat buf;
-	int st;
-	st = stat(filename, &buf);
-	if (st < 0) {
-		errorcount++;
-		return (-1);
-	}
-	disk_space_pool += buf.st_size;
-	if (unlink(filename) < 0) {
-		errorcount++;
-		return (-1);
-	}
-	dfilecount++;
-
-	return 0;
-}
diff --git a/testcases/kernel/fs/fs-bench/random-access.c b/testcases/kernel/fs/fs-bench/random-access.c
deleted file mode 100644
index c2f32b86e..000000000
--- a/testcases/kernel/fs/fs-bench/random-access.c
+++ /dev/null
@@ -1,92 +0,0 @@
-/* random-access.c (GPL)*/
-/* Hironobu SUZUKI <hironobu@h2np.net> */
-#include <stdio.h>
-#include <errno.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <time.h>
-#include <stdlib.h>
-#define FAIL 0
-#define SUCCESS 1
-
-static int openlog[2] = { 0, 0 };
-
-#define MAXNUM 0x100000
-
-void open_read_close(char *fname);
-
-int nullfd;
-
-int main(int ac, char **av)
-{
-	int r;
-	char fname[1024];
-	time_t t;
-	int i;
-	int m;
-
-	if (ac != 2) {
-		printf("%s hex-style-filename \n", av[0]);
-		printf("ex) %s 00022300\n", av[0]);
-		exit(1);
-	}
-	sscanf(av[1], "%x", &m);
-	if (m < 1 || m > MAXNUM) {
-		printf("out of size %d\n", m);
-		exit(1);
-	}
-
-	time(&t);
-	srandom((unsigned int)getpid() ^
-		(((unsigned int)t << 16) | (unsigned int)t >> 16));
-
-	if ((nullfd = open("/dev/null", O_WRONLY)) < 0) {
-		perror("/dev/null");
-		exit(1);
-	}
-
-	/* 00/00/00/00 */
-	for (i = 0; i < m; i++) {
-		r = random() % m;
-		sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
-			((r >> 16) & 0xFF),
-			((r >> 8) & 0xFF),
-			((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
-		open_read_close(fname);
-	}
-	close(nullfd);
-	printf("Success:\t%d\nFail:\t%d\n", openlog[SUCCESS], openlog[FAIL]);
-	exit(0);
-}
-
-#define BUFS 8192
-void open_read_close(char *fname)
-{
-	int fd;
-	char buf[BUFS];
-	int c;
-
-	if ((fd = open(fname, O_RDONLY)) < 0) {
-		openlog[FAIL]++;
-		close(fd);
-		return;
-	}
-	openlog[SUCCESS]++;
-	while ((c = read(fd, buf, BUFS)) > 0) {
-		if (write(nullfd, buf, c) < 0) {
-			perror("/dev/null");
-			printf("Opened\t %d\nUnopend:\t%d\n", openlog[SUCCESS],
-			       openlog[FAIL]);
-			exit(1);
-		}
-	}
-	if (c < 0) {
-		perror(fname);
-		printf("Opened\t %d\nUnopend:\t%d\n", openlog[SUCCESS],
-		       openlog[FAIL]);
-		exit(1);
-	}
-	close(fd);
-}
diff --git a/testcases/kernel/fs/fs-bench/random-del-create.c b/testcases/kernel/fs/fs-bench/random-del-create.c
deleted file mode 100644
index 345031f28..000000000
--- a/testcases/kernel/fs/fs-bench/random-del-create.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/* random-del-create.c (GPL)*/
-/* Hironobu SUZUKI <hironobu@h2np.net> */
-
-#include <stdio.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <time.h>
-#include <stdlib.h>
-#define FAIL 0
-#define SUCCESS 1
-
-static int openlog[2] = { 0, 0 };
-
-#define MAXNUM 0x100000
-
-#define  MAXERROR 1024
-
-extern int box_muler(int, int);
-extern void create_or_delete(char *);
-
-int cfilecount = 0;
-int dfilecount = 0;
-int errorcount = 0;
-
-int main(int ac, char **av)
-{
-	int r;
-	char fname[1024];
-	time_t t;
-	int i;
-	int m;
-
-	if (ac != 2) {
-		printf("%s hex-style-filename \n", av[0]);
-		printf("ex) %s 00022300\n", av[0]);
-		exit(1);
-	}
-	sscanf(av[1], "%x", &m);
-	if (m < 1 || m > MAXNUM) {
-		printf("out of size %d\n", m);
-		exit(1);
-	}
-
-	time(&t);
-	srandom((unsigned int)getpid() ^
-		(((unsigned int)t << 16) | (unsigned int)t >> 16));
-
-	/* 00/00/00/00 */
-	for (i = 0; i < m; i++) {
-		r = random() % m;
-		sprintf(fname, "00/%2.2x/%2.2x/00%2.2x%2.2x%2.2x",
-			((r >> 16) & 0xFF),
-			((r >> 8) & 0xFF),
-			((r >> 16) & 0xFF), ((r >> 8) & 0xFF), (r & 0xFF));
-		create_or_delete(fname);
-	}
-	fprintf(stderr, "Total create files: %d\n", cfilecount);
-	fprintf(stderr, "Total delete files: %d\n", dfilecount);
-	fprintf(stderr, "Total error       : %d\n", errorcount);
-	exit(0);
-}
-
-#define MAXFSIZE (192*1024)
-#define AVEFSIZE (MAXFSIZE/2)
-#define POOLDISKSPACE (AVEFSIZE*128)
-
-static int disk_space_pool = 0;
-void create_or_delete(char *fname)
-{
-	int r;
-	int fsize;
-
-	r = (random() & 1);
-	if (r && disk_space_pool > POOLDISKSPACE) {
-		/* create */
-		create_file(fname);
-	} else {
-		delete_file(fname);
-	}
-	if ((errorcount > dfilecount || errorcount > cfilecount)
-	    && (errorcount > MAXERROR)) {
-		fprintf(stderr, "too much error -- stop\n");
-		fprintf(stderr, "Total create files: %d\n", cfilecount);
-		fprintf(stderr, "Total delete files: %d\n", dfilecount);
-		fprintf(stderr, "Total error       : %d\n", errorcount);
-		exit(1);
-	}
-}
-
-int create_file(char *filename)
-{
-	int fd;
-	int randomsize;
-	char wbuf[MAXFSIZE];
-	if ((fd = creat(filename, S_IRWXU)) < 0) {
-		errorcount++;
-		return (-1);
-	}
-	if ((randomsize = box_muler(0, MAXFSIZE)) < 0) {
-		randomsize = MAXFSIZE;
-	}
-	if (write(fd, wbuf, randomsize) < 0) {
-		errorcount++;
-		close(fd);
-		return (-1);
-	}
-	cfilecount++;
-	disk_space_pool -= randomsize;
-	close(fd);
-	return 0;
-}
-
-#include <sys/stat.h>
-#include <unistd.h>
-
-int delete_file(char *filename)
-{
-	struct stat buf;
-	int st;
-	st = stat(filename, &buf);
-	if (st < 0) {
-		errorcount++;
-		return (-1);
-	}
-	disk_space_pool += buf.st_size;
-	if (unlink(filename) < 0) {
-		errorcount++;
-		return (-1);
-	}
-	dfilecount++;
-	return 0;
-}
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
