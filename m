Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757B7C35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 15:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 053013CAD10
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 16:26:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 428BE3CA46A
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 16:25:53 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8B145600470
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 16:25:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66DAF21FE7;
 Wed, 19 Mar 2025 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742397947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7EexRVxYidHzsmF3dY0j00sQhtc0kIrHa3uQzX7Fp+U=;
 b=OTkKfOFUGlqCU5spjguWZ3xx2jsr0vX9fFd2B5XUSKIrAnSHmvGY0RSRvqJ3Vho/fMXvOU
 TSUxbed6M6FDHF5mz8I7sqD50iPbTRnWI+V6/8F4cUXUZBKS+W948TQ9nwP76SMLhecl94
 Wluaor4j478lCdCl4pY483/GgLJ3E4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742397947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7EexRVxYidHzsmF3dY0j00sQhtc0kIrHa3uQzX7Fp+U=;
 b=QDnmyuhtV/hwER8N1V+mht4hgyMgg2r0JXFIUc8w7Ib2mLAfegSqDaIviPaASxoq8pZyvX
 Tjqr/15VhxeFKiDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742397947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7EexRVxYidHzsmF3dY0j00sQhtc0kIrHa3uQzX7Fp+U=;
 b=OTkKfOFUGlqCU5spjguWZ3xx2jsr0vX9fFd2B5XUSKIrAnSHmvGY0RSRvqJ3Vho/fMXvOU
 TSUxbed6M6FDHF5mz8I7sqD50iPbTRnWI+V6/8F4cUXUZBKS+W948TQ9nwP76SMLhecl94
 Wluaor4j478lCdCl4pY483/GgLJ3E4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742397947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7EexRVxYidHzsmF3dY0j00sQhtc0kIrHa3uQzX7Fp+U=;
 b=QDnmyuhtV/hwER8N1V+mht4hgyMgg2r0JXFIUc8w7Ib2mLAfegSqDaIviPaASxoq8pZyvX
 Tjqr/15VhxeFKiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AD6F13726;
 Wed, 19 Mar 2025 15:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jLjnC/vh2me5SAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Mar 2025 15:25:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Mar 2025 16:25:03 +0100
MIME-Version: 1.0
Message-Id: <20250319-remove_symlink01-v1-1-1a532d6fc89f@suse.com>
X-B4-Tracking: v=1; b=H4sIAM7h2mcC/x3M0QpAMBSA4VfRubbamYx5FUni4MQ2bSWSd7dcf
 hf//0CkwBShyR4IdHJk7xIwz2BcB7eQ4CkZlFSlLNCIQNaf1Mfb7uw2iYIqrA2iVkZrSNkRaOb
 rX7bd+35i6BVrYgAAAA==
X-Change-ID: 20250319-remove_symlink01-e71891162966
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742397947; l=68972;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=il2CFDe+xnadGecBvV1NkuV3W6x3h9JtuX5CJol+7YA=;
 b=FEjw5d/Ty+TWYw0ZTL/u/ZEVT5lR7tWzuz/sHkNyi9IMrkGBUNqqQBmWxvE0Qk0IwGE8887Lv
 oyJ225YbvOgDiI+T9mUUZuowiuOMdSv5k4Yz+aNyDZ58cYoZ826jr9G
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Remove symlink01 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Remove symlink01 test since it has been split already in
https://patchwork.ozlabs.org/project/ltp/list/?series=414743&state=*

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/smoketest                             |    1 -
 runtest/syscalls                              |    8 -
 testcases/kernel/syscalls/symlink/symlink01.c | 1886 -------------------------
 3 files changed, 1895 deletions(-)

diff --git a/runtest/smoketest b/runtest/smoketest
index aeb74c9ee57fa384f1914a4ef848efaaf5deb53f..538ee06f1b1c1d2e9620c35e5008047d23e03e00 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -7,7 +7,6 @@ fork01 fork01
 time01 time01
 wait02 wait02
 write01 write01
-symlink01 symlink01
 stat04 stat04
 splice02 splice02 -s 20
 df01_sh df01.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index 839c23d0a02b0ab8ee7c64881d845184246d86d1..05b3e0d376fae3adf1eb29c22c0b83fa49eee56f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -68,11 +68,9 @@ cachestat03 cachestat03
 cachestat04 cachestat04
 
 chdir01 chdir01
-chdir01A symlink01 -T chdir01
 chdir04 chdir04
 
 chmod01 chmod01
-chmod01A symlink01 -T chmod01
 chmod03 chmod03
 chmod05 chmod05
 chmod06 chmod06
@@ -723,7 +721,6 @@ lchown03_16 lchown03_16
 lgetxattr01 lgetxattr01
 lgetxattr02 lgetxattr02
 
-link01 symlink01 -T link01
 link02 link02
 link04 link04
 link05 link05
@@ -1163,7 +1160,6 @@ readahead02 readahead02
 readdir01 readdir01
 readdir21 readdir21
 
-readlink01A symlink01 -T readlink01
 readlink01 readlink01
 readlink03 readlink03
 
@@ -1196,7 +1192,6 @@ removexattr01 removexattr01
 removexattr02 removexattr02
 
 rename01 rename01
-rename01A symlink01 -T rename01
 rename03 rename03
 rename04 rename04
 rename05 rename05
@@ -1227,7 +1222,6 @@ request_key06 request_key06
 rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
-rmdir03A symlink01 -T rmdir03
 
 rt_sigaction01 rt_sigaction01
 rt_sigaction02 rt_sigaction02
@@ -1617,7 +1611,6 @@ swapon03 swapon03
 #Exclusive syscall() for POWER6 machines only
 switch01 endian_switch01
 
-symlink01 symlink01
 symlink02 symlink02
 symlink03 symlink03
 symlink04 symlink04
@@ -1707,7 +1700,6 @@ uname01 uname01
 uname02 uname02
 uname04 uname04
 
-unlink01 symlink01 -T unlink01
 unlink05 unlink05
 unlink07 unlink07
 unlink08 unlink08
diff --git a/testcases/kernel/syscalls/symlink/symlink01.c b/testcases/kernel/syscalls/symlink/symlink01.c
deleted file mode 100644
index 8cf0c8f1cd4de782100b6bcf0dd91ccca66e062a..0000000000000000000000000000000000000000
--- a/testcases/kernel/syscalls/symlink/symlink01.c
+++ /dev/null
@@ -1,1886 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- */
-/* $Id: symlink01.c,v 1.20 2009/11/02 13:57:19 subrata_modak Exp $ */
-/*
- *	OS Test - Silicon Graphics, Inc.
- *
- *	TEST IDENTIFIER	: symlink01 (symlink)
- *	TEST TITLE	: Make a Symbolic Link to a File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 5
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: readlink01 (readlink)
- *	TEST TITLE	: Reads Value of a Symbolic Link
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 4
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: stat04  (stat)
- *	TEST TITLE	: Gets File Status Indirectly From a Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 3
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: lstat01 (lstat)
- *	TEST TITLE	: Get file Status About a Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 3
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: mkdir05 (mkdir)
- *	TEST TITLE	: Fail When Making a Directory File Indirectly From
- *				a Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 1
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: rmdir03 (rmdir)
- *	TEST TITLE	: Fail When Removing a Directory File Indirectly
- *				From a Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 1
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: chdir01 (chdir)
- *	TEST TITLE	: Changes Current Working DIrectory Location
- *				Indirectly From a Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 3
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: link01 (link)
- *	TEST TITLE	: Creates a Link To a File Indirectly From a
- *				Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 3
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: unlink01 (unlink)
- *	TEST TITLE	: Removes a Link To a File And Not Any Object File
- *				Which Maybe Pointed At
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 1
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: chmod01 (chmod)
- *	TEST TITLE	: Change Object File Permissions Indirectly From a
- *				Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 3
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: utime01 (utime)
- *	TEST TITLE	: Set File Access And Modify Object File Times
- *				Indirectly From a Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 3
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: rename01 (rename)
- *	TEST TITLE	: Rename a Symbolic Link File And Not Any Object
- *				File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 3
- *	WALL CLOCK TIME	: 3
- *
- *	TEST IDENTIFIER	: open01 (open)
- *	TEST TITLE	: Create/Open a File For Reading Or Writing
- *				Indirectly From a Symbolic Link File
- *	PARENT DOCUMENT	: symtds01
- *	TEST CASE TOTAL	: 5
- *	WALL CLOCK TIME	: 3
- *
- *
- *	EXECUTED BY	: whom ever
- *	CPU TYPES		: ALL
- *	AUTHOR		: David Fenner
- *	CO-PILOT		: Jon Hendrickson
- *	DATE STARTED	: 07/25/90
- *	INITIAL RELEASE	: UNICOS 6.0
- *
- *	TEST CASES
- *
- *	For symlink
- *	1. Create symbolic link with abnormal object name path
- *	2. Create symbolic link with normal object name path
- *	3. Create symbolic link with path to an existing object file
- *	4. Receive EEXIST error when creating an already existing symbolic link file.
- *	5. Receive ENAMETOOLONG error when creating symbolic link which exceeds PATH_MAX in length
- *
- *	For readlink
- *	1. Read a symbolic link file which points at no object file
- *	2. Read a symbolic link file which points at an object file
- *	3. Receive ENAMETOOLONG error when reading symbolic link which exceeds PATH_MAX in length
- *	4. Receive an EINVAL error when reading a file which is not a symbolic
- *	link file.
- *
- *	For stat
- *	1. Get object file status through symbolic link file
- *	2. Receive ENOENT error when accessing non-existent object file through symbolic link file
- *	3. Receive ELOOP error when nesting of symbolic links exceed maximum
- *
- *	For lstat
- *	1. Get symbolic link file status when pointing at no object file
- *	2. Get symbolic link file status when pointing at an object file
- *	3. Get object file status when argument is not a symbolic link
- *	file.
- *
- *	For mkdir
- *	1. Receive EEXIST error when creating a directory through a symbolic link file
- *
- *	For rmdir
- *	1. Receive ENOTDIR error when removing an existing directory through a symbolic link file
- *
- *	For chdir
- *	1. Change current working directory through a symbolic link file
- *	2. Receive ENOENT error when accessing non-existent directory through symbolic link file
- *	3. Receive ELOOP error when nesting of symbolic links exceed maximum
- *
- *	For link
- *	1. Link an object file to a new file through symbolic link file
- *	2. Receive ENOENT error when accessing non-existent object file through symbolic link file
- *	3. Receive ELOOP error when nesting of symbolic links exceed maximum
- *
- *	For unlink
- *	1. Delete a symbolic link file and not the object file which it points at
- *
- *	For chmod
- *	1. Change file permissions of object file through a symbolic link file
- *	2. Receive ENOENT error when accessing non-existent directory through symbolic link file
- *	3. Receive ELOOP error when nesting of symbolic links exceed maximum
- *
- *	For utime
- *	1. Change inode times of object file through a symbolic link file
- *	2. Receive ENOENT error when accessing non-existent directory through symbolic link file
- *	3. Receive ELOOP error when nesting of symbolic links exceed maximum
- *
- *	For rename
- *	1. Rename a symbolic link file which points at no object file
- *	2. Rename a symbolic link file which points at an object file without any object file alterations.
- *	3. Receive EXDEV when trying to rename a symbolic link file to an address outside of current file system
- *
- *	For open
- *	1. Create an object file through a symbolic link file
- *	2. Open an object file through a symbolic link file
- *	3. Receive EEXIST error when exclusively creating an object file through a symbolic link file
- *	4. Receive ENOENT error when accessing non-existent object file through symbolic link file
- *	5. Receive ELOOP error when nesting of symbolic links exceed maximum
- *
- *	ENVIRONMENTAL NEEDS
- *		None
- *
- *	DETAILED DESCRIPTION
- *
- *	Self-documenting code so see below
- */
-
-#include <stdio.h>
-#include <signal.h>
-#include <string.h>
-#include <fcntl.h>		/* open(2) system call */
-#include <errno.h>
-#include <sys/types.h>
-#include <utime.h>		/* utime(2) system call */
-#include <sys/param.h>
-#include <sys/stat.h>		/* stat(2) and lstat(2) system calls */
-#include <stdint.h>
-#include <unistd.h>
-
-#include "test.h"
-
-void setup(void);
-void cleanup(void);
-void help(void);
-void delete_files(char *path1, char *path2);
-struct all_test_cases;
-void do_EEXIST(struct all_test_cases *tc_ptr);
-void do_ENOENT(struct all_test_cases *tc_ptr);
-void do_ELOOP(struct all_test_cases *tc_ptr);
-void do_ENOTDIR(struct all_test_cases *tc_ptr);
-void do_EXDEV(struct all_test_cases *tc_ptr);
-void do_ENAMETOOLONG(struct all_test_cases *tc_ptr);
-void do_EINVAL(struct all_test_cases *tc_ptr);
-void do_readlink(struct all_test_cases *tc_ptr);
-void do_stat(struct all_test_cases *tc_ptr);
-void do_chdir(struct all_test_cases *tc_ptr);
-void do_link(struct all_test_cases *tc_ptr);
-void do_unlink(struct all_test_cases *tc_ptr);
-void do_chmod(struct all_test_cases *tc_ptr);
-void do_utime(struct all_test_cases *tc_ptr);
-void do_rename(struct all_test_cases *tc_ptr);
-void do_open(struct all_test_cases *tc_ptr);
-struct tcses;
-int do_syscalltests(struct tcses *tcs);
-struct tcses *get_tcs_info(char *ptr);
-
-#define S_FILE "symbolic"	/* Name of symbolic link file */
-#define O_FILE "object"		/* Name of object file */
-#define A_S_FILE "asymbolic"	/* Another name for a symbolic link file */
-#define Y_A_S_FILE "/NiCkEr"	/* Yet another symbolic link file */
-#define BIG_STRING "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
-
-#define DEFAULT_TCID  "symlink01"
-
-#define SYMLINK "symlink01"
-#define READLINK "readlink01"
-#define STAT "stat04"
-#define STAT_64 "stat04_64"
-#define LSTAT "lstat01"
-#define LSTAT_64 "lstat01_64"
-#define MKDIR "mkdir05"
-#define RMDIR "rmdir03"
-#define CHDIR "chdir01"
-#define LINK "link01"
-#define UNLINK "unlink01"
-#define CHMOD "chmod01"
-#define UTIME "utime01"
-#define RENAME "rename01"
-#define OPEN "open01"
-
-#define cktcsid(s1,s2) (!strcmp(s1,s2))
-#define BUFMAX 512
-#define MODE 0700
-#define MASK 0100777		/* A regular file with r,w,x for all mask */
-
-/*
- * Lets be optimistic and only define messages for passing test cases
- */
-const char *msgs[] = {
-	"Creation of symbolic link file to no object file is ok",
-	"Creation of symbolic link file and object file via symbolic link is ok",
-	"Creating an existing symbolic link file error is caught",
-	"Creating a symbolic link which exceeds maximum pathname error is caught",
-	"Reading of symbolic link file contents checks out ok",
-	"Reading a symbolic link which exceeds maximum pathname error is caught",
-	"Getting stat info about object file through symbolic link file is ok",
-	"Stat(2) error when accessing non-existent object through symbolic link is caught",
-	"lstat(2) of symbolic link file which points to no object file is ok",
-	"lstat(2) of symbolic link file which points at an object file is ok",
-	"mkdir(2) of object file through symbolic link file failed as expected",
-	"rmdir(2) of object file through symbolic link file failed as expected",
-	"chdir(2) to object file location through symbolic link file is ok",
-	"chdir(2) to non-existent object file location through symbolic link file failed as expected",
-	"link(2) to a symbolic link, which is pointing to an existing object file worked - file created and link count adjusted",
-	"link(2) to a symbolic link, which is pointing to a non-existing object file worked ok - file created and link count adjusted.",
-	"unlink(2) of symbolic link file with no object file removal is ok",
-	"chmod(2) of object file permissions through symbolic link file is ok",
-	"chmod(2) error when accessing non-existent object through symbolic link is caught",
-	"utime(2) change of object file access and modify times through symbolic link file is ok",
-	"utime(2) error when accessing non-existent object through symbolic link is caught",
-	"rename(3) of symbolic link file name which points at no object file is ok",
-	"rename(3) of symbolic link file name which points at object file is ok",
-	"rename(3) error of symbolic link file name across file systems is caught",
-	"open(2) with (O_CREAT | O_RDWR) to create object file through symbolic link file and all writes, reads, and lseeks are ok",
-	"open(2) with O_RDWR of existing  object file through symbolic link file and all writes, reads, and lseeks are ok",
-	"open(2) with (O_CREAT | O_EXCL) error  is caught when creating object file through symbolic link file",
-	"open(2) error with O_RDWR is caught when processing symbolic link file which points at no object file",
-	"Nested symbolic link access condition caught.  ELOOP is returned",
-	"Reading a nonsymbolic link file error condition is caught.  EINVAL is returned",
-	"lstat(2) of object file returns object file inode information",
-	"NULL"
-};
-
-/*
- * Define test object setup and validation functions
- */
-int creat_both(char *path1, char *path2, char *path3);
-int creat_symlink(char *path1, char *path2, char *_path3);
-int creat_path_max(char *path1, char *path2, char *path3);
-int ck_symlink(char *path1, char *path2, char *path3);
-int creat_object(char *path1, char *_path2, char *_path3);
-int ck_object(char *path1, char *path2, char *path3);
-int ck_both(char *path1, char *path2, char *path3);
-int ck_path_max(char *path1, char *path2, char *path3);
-
-/*
- *  Define test cases
- */
-struct all_test_cases {
-	char *tcid;
-	int test_fail;
-	int errno_val;
-	int pass_msg;
-	int (*test_setup) (char *path1, char *path2, char *path3);
-	int (*ck_test) (char *path1, char *path2, char *path3);
-	char *fn_arg[3];
-
-} test_objects[] = {
-	{
-		SYMLINK, 0, 0, 0, creat_symlink, ck_symlink, {
-	"%bc+eFhi!k", S_FILE, NULL}}, {
-		SYMLINK, 0, 0, 0, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		SYMLINK, 0, 0, 1, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		SYMLINK, 1, EEXIST, 2, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		SYMLINK, 1, ENAMETOOLONG, 3, creat_path_max, ck_path_max, {
-	O_FILE, S_FILE, NULL}}, {
-		READLINK, 0, 0, 4, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		READLINK, 0, 0, 4, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		READLINK, 1, ENAMETOOLONG, 5, creat_path_max, ck_path_max, {
-	O_FILE, S_FILE, NULL}}, {
-		READLINK, 1, EINVAL, 29, creat_object, ck_object, {
-	O_FILE, NULL, NULL}}, {
-		STAT, 0, 0, 6, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}},
-	    /* 10 */
-	{
-		STAT, 1, ENOENT, 7, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		STAT, 1, ELOOP, 28, creat_symlink, ck_symlink, {
-	S_FILE, S_FILE, NULL}}, {
-		STAT_64, 0, 0, 6, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		STAT_64, 1, ENOENT, 7, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		STAT_64, 1, ELOOP, 28, creat_symlink, ck_symlink, {
-	S_FILE, S_FILE, NULL}}, {
-		LSTAT, 0, 0, 8, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		LSTAT, 0, 0, 9, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		LSTAT, 0, 0, 30, creat_object, ck_object, {
-	O_FILE, NULL, NULL}}, {
-		LSTAT_64, 0, 0, 8, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		LSTAT_64, 0, 0, 9, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}},
-	    /* 20 */
-	{
-		LSTAT_64, 0, 0, 30, creat_object, ck_object, {
-	O_FILE, NULL, NULL}}, {
-		MKDIR, 1, EEXIST, 10, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		RMDIR, 1, ENOTDIR, 11, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		CHDIR, 0, 0, 12, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, O_FILE}}, {
-		CHDIR, 1, ENOENT, 13, creat_symlink, ck_symlink, {
-	"%bc+eFhi!k", S_FILE, NULL}}, {
-		CHDIR, 1, ELOOP, 28, creat_symlink, ck_symlink, {
-	S_FILE, S_FILE, NULL}}, {
-		LINK, 0, 0, 14, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		LINK, 0, 0, 15, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}},
-	    /* The following link test case is invalid - leaving it defined so */
-	    /* I don't have to change all the entries in the all_tcses array after link */
-	    /* It has been disabled at the moment. */
-	{
-		LINK, 1, -1, -1, creat_symlink, ck_symlink, {
-	NULL, NULL, NULL}}, {
-		UNLINK, 0, 0, 16, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}},
-	    /* 30 */
-	{
-		CHMOD, 0, 0, 17, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		CHMOD, 1, ENOENT, 18, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		CHMOD, 1, ELOOP, 28, creat_symlink, ck_symlink, {
-	S_FILE, S_FILE, NULL}}, {
-		UTIME, 0, 0, 19, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		UTIME, 1, ENOENT, 20, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		UTIME, 1, ELOOP, 28, creat_symlink, ck_symlink, {
-	S_FILE, S_FILE, NULL}}, {
-		RENAME, 0, 0, 21, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		RENAME, 0, 0, 22, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}},
-	    /* The following rename test makes assumption that the link and target */
-	    /* files are located in different filesystems, which is incorrect. */
-	    /* It has been disabled at the moment. */
-	{
-		RENAME, 1, EXDEV, 23, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		OPEN, 0, 0, 24, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}},
-	    /* 40 */
-	{
-		OPEN, 0, 0, 25, creat_both, ck_both, {
-	O_FILE, S_FILE, O_FILE}}, {
-		OPEN, 1, EEXIST, 26, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, O_FILE}}, {
-		OPEN, 1, ENOENT, 27, creat_symlink, ck_symlink, {
-	O_FILE, S_FILE, NULL}}, {
-		OPEN, 1, ELOOP, 28, creat_symlink, ck_symlink, {
-	S_FILE, S_FILE, NULL}}
-};
-
-/*
- * Define tcses
- */
-struct tcses {
-	char *tcid;
-	char *syscall;
-	int test_cases;		/* number of entries in test_objects array */
-	struct all_test_cases *tc_ptr;
-	char *desc;
-} all_tcses[] = {
-
-	{
-	SYMLINK, "symlink", 5, &test_objects[0],
-		    "Make a Symbolic Link to a File"}, {
-	READLINK, "readlink", 4, &test_objects[5],
-		    "Reads Value of a Symbolic Link"}, {
-	STAT, "stat", 3, &test_objects[9],
-		    "Gets File Status Indirectly From a Symbolic Link file"}, {
-	STAT_64, "stat64", 3, &test_objects[12],
-		    "Gets File Status Indirectly From a Symbolic Link file"}, {
-	LSTAT, "lstat", 3, &test_objects[15],
-		    "Get file Status About a Symbolic Link File"}, {
-	LSTAT_64, "lstat64", 3, &test_objects[18],
-		    "Get file Status About a Symbolic Link File"}, {
-	MKDIR, "mkdir", 1, &test_objects[21],
-		    "Fail When Making a Directory File Indirectly from a symlink"},
-	{
-	RMDIR, "rmdir", 1, &test_objects[22],
-		    "Fail When Removing a Directory File Indirectly from a symlink"},
-	{
-	CHDIR, "chdir", 3, &test_objects[23],
-		    "Changes CWD Location Indirectly from a symlink"}, {
-	LINK, "link", 2, &test_objects[26],
-		    "Creates a Link To a File Indirectly From a Symbolic"}, {
-	UNLINK, "unlink", 1, &test_objects[29],
-		    "Removes a Link To a File but not the Object File"}, {
-	CHMOD, "chmod", 3, &test_objects[30],
-		    "Change Object File Permissions Indirectly From a Symbolic"},
-	{
-	UTIME, "utime", 3, &test_objects[33],
-		    "Set File Access And Modify Object File Times via symlink"},
-	{
-	RENAME, "rename", 2, &test_objects[36],
-		    "Rename a Symbolic Link File And Not Any Object file"}, {
-OPEN, "open", 5, &test_objects[39],
-		    "Create/Open a File For Reading Or Writing via symlink"},};
-
-/*
- * Define GLOBAL variables
- */
-
-int TST_TOTAL;
-int TEST_RESULT;
-time_t a_time_value = 100;
-char *TCID;
-char *Selectedtests = NULL;	/* Name (tcid) of selected test cases */
-char test_msg[BUFMAX];
-char full_path[PATH_MAX + 1 + 1];	/* Add one for '\0' and another to exceed the PATH_MAX limit, see creat_path_max() */
-
-struct stat asymlink, statter;
-char Buffer[1024];
-char Buf[1024];
-
-char *Tcid = NULL;
-
-option_t Options[] = {
-	{"T:", NULL, &Tcid},	/* -T tcid option */
-	{NULL, NULL, NULL}
-};
-
-/***********************************************************************
- * MAIN
- ***********************************************************************/
-int main(int argc, char *argv[])
-{
-	struct tcses *tcs_ptr;
-	int lc;
-
-	tst_parse_opts(argc, argv, Options, &help);
-
-	/*
-	 * If the -T option was used, use that TCID or use the default
-	 */
-	if (Tcid != NULL) {
-		TCID = Tcid;
-		Selectedtests = Tcid;
-
-	}
-#ifndef ALL
-	else {
-		TCID = DEFAULT_TCID;
-		Selectedtests = DEFAULT_TCID;
-	}
-#endif
-
-	/*
-	 * Get test case specification information and assign TST_TOTAL
-	 */
-	if ((tcs_ptr = get_tcs_info(Selectedtests)) == NULL) {
-		TST_TOTAL = 1;
-		tst_brkm(TBROK, cleanup,
-			 "Unknown symbolic link test case specification executed");
-	}
-
-   /***************************************************************
-    * perform global setup for test
-    ***************************************************************/
-
-	setup();
-
-    /***************************************************************
-     * check looping state if -c option given
-     ***************************************************************/
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Execute tcs testing function and all defined test cases
-		 */
-		do_syscalltests(tcs_ptr);
-
-	}
-
-	/*
-	 * End appropriately
-	 */
-	cleanup();
-	tst_exit();
-
-}
-
-/***********************************************************************
- *  This function maps the name of the process to a test case specification
- *  defined in the all_tcses array of tcses structures.  Either a pointer
- *  to the mapped test case specification information is returned or a
- *  null pointer.
- *
- *      Argument is path to program name.
- ***********************************************************************/
-struct tcses *get_tcs_info(char *ptr)
-{
-	int ctr;
-	struct tcses *tcs_ptr;
-
-#if ALL
-	if (ptr == NULL) {
-
-		TST_TOTAL = 0;
-		for (ctr = 1; ctr < sizeof(all_tcses) / sizeof(struct tcses);
-		     ctr++)
-			TST_TOTAL += all_tcses[ctr].test_cases;
-		return all_tcses;
-	}
-#endif
-
-	for (ctr = 0; ctr < (int)(sizeof(all_tcses) / sizeof(struct tcses)); ctr++) {
-		if (strcmp(ptr, all_tcses[ctr].tcid) == 0 ||
-		    strcmp(ptr, all_tcses[ctr].syscall) == 0) {
-			tcs_ptr = &all_tcses[ctr];
-			TCID = all_tcses[ctr].tcid;
-			TST_TOTAL = tcs_ptr->test_cases;
-			return (tcs_ptr);
-		}
-
-	}
-	return NULL;
-}
-
-/***********************************************************************
- *  Determines if what path points at is a symbolic link file
- *
- *      Argument is path to symbolic link file.
- *
- *  Return status is one if a symbolic link file.  Zero if not a symbolic
- *  link file and a minus one if the path doesn't point at a file.
- ***********************************************************************/
-static int see_if_a_symlink(char *path)
-{
-	if (lstat(path, &asymlink) < 0)
-		return (-1);
-
-	if ((asymlink.st_mode & S_IFMT) == S_IFLNK)
-		return 1;
-	else
-		return 0;
-}
-
-/***********************************************************************
- * This function performs without any hesitation, file(s) deletions
- ***********************************************************************/
-void delete_files(char *path1, char *path2)
-{
-	unlink(path1);
-	unlink(path2);
-}
-
-/***********************************************************************
- *
- * This routine creates a symbolic link file.
- *
- *      Argument one is symbolic link pathname to point at.
- *      Argument two is name of symbolic link file.
- *
- ***********************************************************************/
-int creat_symlink(char *path1, char *path2, char *_path3)
-{
-	TEST(symlink(path1, path2));
-	errno = TEST_ERRNO;
-	if (TEST_RETURN == -1) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"symlink(2) Failure when creating setup %s object file: errno:%d %s",
-			path1, errno, strerror(errno));
-		return 0;
-	} else {
-		sprintf(Buf, "symlink(%s, %s) was successful.\n", path1, path2);
-		strcat(Buffer, Buf);
-#if DEBUG
-		tst_resm(TPASS, "symlink(%s, %s) was successful.", path1, path2);
-#endif
-	}
-	return 1;
-}
-#define creat_symlink(p1, p2) creat_symlink(p1, p2, NULL)
-
-/***********************************************************************
- *
- * This routine creates a regular file.
- *
- *      Argument one is a pathname
- *
- ***********************************************************************/
-int creat_object(char *path1, char *_path2, char *_path3)
-{
-	int fd;
-	if ((fd = creat(path1, MODE)) == -1) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"creat(2) Failure when creating setup %s object file: errno:%d %s",
-			path1, errno, strerror(errno));
-		return 0;
-	} else {
-		sprintf(Buf, "creat(%s, %#o) was successful.\n", path1, MODE);
-		strcat(Buffer, Buf);
-#if DEBUG
-		tst_resm(TPASS, "creat(%s, %#o) was successful.", path1, MODE);
-#endif
-	}
-	if (close(fd) == -1) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"close(2) Failure when closing setup %s object file: errno:%d %s",
-			path1, errno, strerror(errno));
-		return 0;
-	}
-	return 1;
-}
-#define creat_object(p1) creat_object(p1, NULL, NULL)
-
-/***********************************************************************
- *
- * This routine creates a symbolic link file and a regular file.
- *
- *      Argument one is a pathname of object file
- *      Argument two is symbolic link file name
- *      Argument three is regular file name
- *
- ***********************************************************************/
-int creat_both(char *path1, char *path2, char *path3)
-{
-	if (creat_symlink(path1, path2) == -1)
-		return 0;
-	else if (creat_object(path3) == -1)
-		return 0;
-	return 1;
-}
-
-/***********************************************************************
- *
- * This routine checks if symbolic link file is a symbolic link file.
- *
- *      Argument one is a pathname of object file
- *      Argument two is symbolic link file name
- *      Argument three is regular file name
- *
- ***********************************************************************/
-int ck_symlink(char *path1, char *path2, char *path3)
-{
-	int ret;
-
-	if ((ret = see_if_a_symlink(path2)) == -1) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"lstat(2) Failure when accessing %s symbolic link file which should contain %s path to %s file ",
-			path2, path1, path3);
-		return 0;
-	} else if (ret == 0) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"%s is not a symbolic link file which contains %s path to %s file",
-			path2, path1, path3);
-		return 0;
-	}
-	return 1;
-}
-
-/***********************************************************************
- *
- * This routine checks if symbolic link file points at object file.
- *
- *      Argument one is a pathname of object file
- *      Argument two is symbolic link file name
- *      Argument three is regular file name
- *
- ***********************************************************************/
-int ck_both(char *path1, char *path2, char *path3)
-{
-	if (ck_symlink(path1, path2, path3) == 0)
-		return 0;
-	else if ((stat(path3, &statter) == -1) && (errno == ENOENT)) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"stat(2) Failure when accessing %s object file ",
-			path3);
-		return 0;
-	} else if ((stat(path2, &asymlink) == -1) && (errno == ENOENT)) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"stat(2) Failure when accessing %s symbolic link file ",
-			path2);
-		return 0;
-	} else if (statter.st_ino != asymlink.st_ino) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"stat(2) Failure when accessing %s object file through %s symbolic link file ",
-			path3, path2);
-		return 0;
-	}
-	return 1;
-
-}
-
-/***********************************************************************
- * This routine populates full_path with a pathname whose length exceeds
- * the PATH_MAX define value in param.h
- *
- *      Argument one is a pathname of object file
- *      Argument two is symbolic link file name
- *      Argument three is regular file name
- ***********************************************************************/
-int creat_path_max(char *path1, char *path2, char *path3)
-{
-	int ctr, to_go, size, whole_chunks;
-	char *cwd;
-
-	if ((cwd = getcwd(NULL, 0)) == NULL) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"getcwd(3) Failure in setup of %s %s %s test case object elements",
-			path1, path2, path3);
-		return 0;
-	}
-	cwd = getcwd(NULL, 0);
-	size = strlen(cwd);
-
-	to_go = PATH_MAX - size;
-	size = strlen(path1);
-	whole_chunks = to_go / size;
-	strcpy(full_path, cwd);
-	for (ctr = 0; ctr < whole_chunks; ctr++) {
-		strcat(full_path, path1);
-	}
-	size = strlen(full_path);
-	to_go = PATH_MAX - size;
-	strcat(full_path, "/");
-	for (ctr = 0; ctr < to_go; ctr++)
-		strcat(full_path, "Z");
-
-	return 1;
-}
-
-/***********************************************************************
- * This routine checks that full_path's  length exceeds the PATH_MAX
- * define value in param.h
- *
- *      Argument one is a pathname of object file
- *      Argument two is symbolic link file name
- *      Argument three is regular file name
- ***********************************************************************/
-int ck_path_max(char *path1, char *path2, char *path3)
-{
-	if (strlen(full_path) == (PATH_MAX + 1))
-		return 1;
-	else {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg, "%s %d %s %s %s %s",
-			"full_path character array length was not",
-			(PATH_MAX + 1),
-			"characters long for test case object elements", path1,
-			path2, path3);
-		return 0;
-	}
-}
-
-/***********************************************************************
- * This routine checks if the stat(2) and lstat(2) calls return the same
- * information when the path is not a symbolic link file
- *
- *      Argument one is a pathname of object file
- *      Argument two is symbolic link file name
- *      Argument three is regular file name
- *
- ***********************************************************************/
-int ck_object(char *path1, char *path2, char *path3)
-{
-	int ret;
-
-	if ((ret = see_if_a_symlink(path1)) < 0) {
-		TEST_RESULT = TFAIL;
-		sprintf(test_msg,
-			"lstat(2) failed to return inode information for a regular object file");
-		return 0;
-	} else if (ret == 1) {
-		TEST_RESULT = TFAIL;
-		sprintf(test_msg,
-			"lstat(2) detected a regular object file as a symbolic link file");
-		return 0;
-	} else if (stat(path1, &statter) == -1) {
-		TEST_RESULT = TBROK;
-		sprintf(test_msg,
-			"stat(2) failed to return inode information for a regular object file");
-		return 0;
-	} else if (memcmp((char *)&statter, (char *)&asymlink, sizeof(statter))
-		   != 0) {
-		TEST_RESULT = TFAIL;
-		sprintf(test_msg,
-			"lstat(2) and stat(2) do not return same inode information for an object file");
-		return 0;
-
-	}
-	return 1;
-}
-
-/***********************************************************************
- * Main test case processing function
- *
- *  Argument is a ptr into the all_tcses array of structures of type tcses
- ***********************************************************************/
-int do_syscalltests(struct tcses *tcs)
-{
-	int ctr, ret;
-	struct all_test_cases *tc_ptr;
-
-	/*
-	 * loop through desired number of test cases
-	 */
-	for (ctr = 0, tc_ptr = tcs->tc_ptr; ctr < TST_TOTAL; ctr++, tc_ptr++) {
-
-		Buffer[0] = '\0';
-
-		/*
-		 * If running all test cases for all tcid, set the TCID if needed.
-		 */
-		if (Selectedtests == NULL) {
-			if (strcmp(tcs->tcid, tc_ptr->tcid) != 0) {
-				TCID = tc_ptr->tcid;
-				tst_count = 0;
-			}
-		}
-		/*
-		 * Insure that we are executing the correct tcs test case
-		 */
-		if (strcmp(tcs->tcid, tc_ptr->tcid) != 0) {
-			tst_resm(TBROK,
-				 "%s TCID attempted to execute %s %d %d test case",
-				 tcs->tcid, tc_ptr->tcid, tc_ptr->test_fail,
-				 tc_ptr->errno_val);
-			continue;
-		}
-		TEST_RESULT = TPASS;
-		delete_files(S_FILE, O_FILE);
-		/*
-		 * Perform test case setup
-		 */
-		ret =
-		    (tc_ptr->test_setup) (tc_ptr->fn_arg[0], tc_ptr->fn_arg[1],
-					  tc_ptr->fn_arg[2]);
-
-		/* If an expected error, try it out */
-
-		if (tc_ptr->test_fail) {
-			/*
-			 * Try to perform test verification function
-			 */
-			if (!(tc_ptr->ck_test)
-			    (tc_ptr->fn_arg[0], tc_ptr->fn_arg[1],
-			     tc_ptr->fn_arg[2]))
-				tst_resm(TEST_RESULT, "%s", test_msg);
-			else if (tc_ptr->errno_val == EEXIST)
-				do_EEXIST(tc_ptr);
-			else if (tc_ptr->errno_val == ENOENT)
-				do_ENOENT(tc_ptr);
-			else if (tc_ptr->errno_val == ELOOP)
-				do_ELOOP(tc_ptr);
-			else if (tc_ptr->errno_val == ENOTDIR)
-				do_ENOTDIR(tc_ptr);
-			else if (tc_ptr->errno_val == EXDEV)
-				do_EXDEV(tc_ptr);
-			else if (tc_ptr->errno_val == ENAMETOOLONG)
-				do_ENAMETOOLONG(tc_ptr);
-			else if (tc_ptr->errno_val == EINVAL)
-				do_EINVAL(tc_ptr);
-			else
-				tst_resm(TBROK, "Test Case Declaration Error");
-		} else if (ret == 1) {	/*  No setup function error */
-
-			if (tc_ptr->errno_val != 0)
-				tst_resm(TBROK, "Test Case Declaration Error");
-			else {
-				/*
-				 * Perform test verification function
-				 */
-				ret =
-				    (tc_ptr->ck_test) (tc_ptr->fn_arg[0],
-						       tc_ptr->fn_arg[1],
-						       tc_ptr->fn_arg[2]);
-
-				/* Perform requested symbolic link system call test */
-
-				if ((cktcsid(tc_ptr->tcid, SYMLINK)) ||
-				    (cktcsid(tc_ptr->tcid, LSTAT)) ||
-				    (cktcsid(tc_ptr->tcid, LSTAT_64))) {
-					if (ret == 1)
-						tst_resm(TEST_RESULT, "%s",
-							 msgs[tc_ptr->
-							      pass_msg]);
-					else
-						tst_resm(TEST_RESULT, "%s",
-							 test_msg);
-				} else if (ret == 0)
-					tst_resm(TEST_RESULT, "%s", test_msg);
-				else if (cktcsid(tc_ptr->tcid, READLINK))
-					do_readlink(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, STAT))
-					do_stat(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, STAT_64))
-					do_stat(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, CHDIR))
-					do_chdir(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, LINK))
-					do_link(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, UNLINK))
-					do_unlink(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, CHMOD))
-					do_chmod(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, UTIME))
-					do_utime(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, RENAME))
-					do_rename(tc_ptr);
-				else if (cktcsid(tc_ptr->tcid, OPEN))
-					do_open(tc_ptr);
-				else
-					tst_resm(TBROK,
-						 "Unknown test case processing actions declared");
-			}
-		} else
-			tst_resm(TBROK, "Test Case Declaration Error");
-	}
-	return 0;
-}
-
-/***********************************************************************
- * This routine checks for the return of EEXIST errno from requested
- * system call
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_EEXIST(struct all_test_cases *tc_ptr)
-{
-	if (cktcsid(tc_ptr->tcid, SYMLINK)) {
-
-		TEST(symlink(tc_ptr->fn_arg[0], tc_ptr->fn_arg[1]));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == EEXIST))
-			tst_resm(TPASS, "%s", msgs[tc_ptr->pass_msg]);
-		else
-			tst_resm(TFAIL, "%s %s",
-				 "Expected EEXIST error when creating a symbolic link file",
-				 "which already existed");
-	} else if (cktcsid(tc_ptr->tcid, MKDIR)) {
-
-		TEST(mkdir(tc_ptr->fn_arg[1], MODE));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == EEXIST)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-
-			tst_resm(TFAIL, "%s %s",
-				 "Expected EEXIST error when creating a directory by a symbolic",
-				 "link file which pointed at no object file");
-			rmdir(tc_ptr->fn_arg[1]);
-		}
-	} else if (cktcsid(tc_ptr->tcid, OPEN)) {
-
-		TEST(open(tc_ptr->fn_arg[1], (O_EXCL | O_CREAT), 0666));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == EEXIST)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected EEXIST error for exclusively opening an object file",
-				 "through a symbolic link file was not received:",
-				 errno, strerror(errno));
-		}
-	} else
-		tst_resm(TBROK,
-			 "Unknown test case processing actions declared");
-}
-
-/***********************************************************************
- * This routine checks for the return of ENOENT errno from requested
- * system call
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_ENOENT(struct all_test_cases *tc_ptr)
-{
-	if ((cktcsid(tc_ptr->tcid, STAT)) || (cktcsid(tc_ptr->tcid, STAT_64))) {
-
-		if ((stat(tc_ptr->fn_arg[1], &asymlink) == -1)
-		    && (errno == ENOENT)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected ENOENT error for stating a non-existent directory",
-				 "through a symbolic link file was not received:",
-				 errno, strerror(errno));
-		}
-	} else if (cktcsid(tc_ptr->tcid, CHDIR)) {
-		if ((chdir(tc_ptr->fn_arg[1]) == -1) && (errno == ENOENT)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected ENOENT error for changing to a non-existent",
-				 "directory through a symbolic link file was not received:",
-				 errno, strerror(errno));
-			/* FIXME (garrcoop): memory leak */
-			chdir(tst_get_tmpdir());
-		}
-	} else if (cktcsid(tc_ptr->tcid, LINK)) {
-
-		if ((link(tc_ptr->fn_arg[1], "nick") == -1)
-		    && (errno == ENOENT)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected ENOENT error condition when link(2) a symbolic",
-				 "link which pointed at no object:", errno,
-				 strerror(errno));
-			delete_files("nick", NULL);
-		}
-	} else if (cktcsid(tc_ptr->tcid, CHMOD)) {
-
-		if ((chmod(tc_ptr->fn_arg[1], MODE) == -1) && (errno == ENOENT)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected ENOENT error condition when chmod(2) a symbolic",
-				 "link which pointed at no object,", errno,
-				 strerror(errno));
-		}
-	} else if (cktcsid(tc_ptr->tcid, UTIME)) {
-
-		if ((utime(tc_ptr->fn_arg[1], NULL) == -1) && (errno == ENOENT)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected ENOENT error condition when utime(2) a symbolic",
-				 "link which pointed at no object:", errno,
-				 strerror(errno));
-		}
-	} else if (cktcsid(tc_ptr->tcid, OPEN)) {
-
-		if ((open(tc_ptr->fn_arg[1], O_RDWR) == -1)
-		    && (errno == ENOENT)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected ENOENT error for opening a non-existent object",
-				 " file through a symbolic link file was not received,",
-				 errno, strerror(errno));
-		}
-	} else
-		tst_resm(TBROK,
-			 "Unknown test case processing actions declared");
-}
-
-/***********************************************************************
- * This routine checks for the return of ELOOP errno from requested
- * system call
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_ELOOP(struct all_test_cases *tc_ptr)
-{
-	if ((cktcsid(tc_ptr->tcid, STAT)) || (cktcsid(tc_ptr->tcid, STAT_64))) {
-
-		TEST(stat(tc_ptr->fn_arg[1], &asymlink));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == ELOOP)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TEST_RESULT, "%s errno:%d %s",
-				 "Expected ELOOP errno from stat(2) (nested symb link),",
-				 errno, strerror(errno));
-		}
-	} else if (cktcsid(tc_ptr->tcid, CHDIR)) {
-
-		TEST(chdir(tc_ptr->fn_arg[1]));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == ELOOP)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-
-			tst_resm(TFAIL, "%s errno:%d %s",
-				 "Expected ELOOP error condition when chdir(2) a nested symbolic link:",
-				 errno, strerror(errno));
-			/* FIXME (garrcoop): memory leak */
-			chdir(tst_get_tmpdir());
-		}
-	} else if (cktcsid(tc_ptr->tcid, LINK)) {
-
-		TEST(link(tc_ptr->fn_arg[1], O_FILE));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == ELOOP)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s errno:%d %s",
-				 "Expected ELOOP error condition when link(2) a nested symbolic link:",
-				 errno, strerror(errno));
-		}
-	} else if (cktcsid(tc_ptr->tcid, CHMOD)) {
-
-		TEST(chmod(tc_ptr->fn_arg[1], MODE));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == ELOOP)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s errno:%d %s",
-				 "Expected ELOOP error condition when chmod(2) a nested symbolic link:",
-				 errno, strerror(errno));
-		}
-		return;
-	} else if (cktcsid(tc_ptr->tcid, UTIME)) {
-
-		TEST(utime(tc_ptr->fn_arg[1], NULL));
-		errno = TEST_ERRNO;
-
-		if ((TEST_RETURN == -1) && (errno == ELOOP)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s errno:%d %s",
-				 "Expected ELOOP error condition when utime(2) a nested symbolic link:",
-				 errno, strerror(errno));
-		}
-	} else if (cktcsid(tc_ptr->tcid, OPEN)) {
-
-		int fd;
-		TEST(open(tc_ptr->fn_arg[1], O_CREAT, 0666));
-		fd = TEST_RETURN;
-		errno = TEST_ERRNO;
-		if ((fd == -1) && (errno == ELOOP)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s errno:%d %s",
-				 "Expected ELOOP error condition when open(2) a nested symbolic link:",
-				 errno, strerror(errno));
-		}
-	} else
-		tst_resm(TBROK,
-			 "Unknown test case processing actions declared");
-}
-
-/***********************************************************************
- * This routine checks for the return of ENOTDIR errno from requested
- * system call
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_ENOTDIR(struct all_test_cases *tc_ptr)
-{
-	if (cktcsid(tc_ptr->tcid, RMDIR)) {
-
-		TEST(mkdir(tc_ptr->fn_arg[0], MODE));
-		errno = TEST_ERRNO;
-		if (TEST_RETURN == -1)
-			tst_resm(TBROK, "mkdir(2) Failure when creating %s",
-				 tc_ptr->fn_arg[0]);
-		else if ((rmdir(tc_ptr->fn_arg[1]) == -1) && (errno == ENOTDIR)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-			rmdir(tc_ptr->fn_arg[0]);
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected ENOTDIR error for removing a non-existent",
-				 "directory through a symbolic link file was not received,",
-				 errno, strerror(errno));
-		}
-	} else
-		tst_resm(TBROK,
-			 "Unknown test case processing actions declared");
-}
-
-/***********************************************************************
- * This routine checks for the return of EXDEV errno from requested
- * system call
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_EXDEV(struct all_test_cases *tc_ptr)
-{
-	if (cktcsid(tc_ptr->tcid, RENAME)) {
-
-		TEST(rename(tc_ptr->fn_arg[1], Y_A_S_FILE));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == EXDEV)) {
-			if (see_if_a_symlink(Y_A_S_FILE) == -1) {
-				tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-			} else {
-				tst_resm(TFAIL,
-					 "%s %s %s file outside of current file system",
-					 "rename(3) returned -1 when trying to move symbolic link file",
-					 "outside of current file system, but created",
-					 Y_A_S_FILE);
-			}
-		} else {
-			tst_resm(TFAIL, "%s %s errno:%d %s",
-				 "Expected EXDEV error for renaming an existing symbolic",
-				 "link file to a location outside of existing file system,",
-				 errno, strerror(errno));
-			delete_files("/NiCkEr", NULL);
-		}
-	} else
-		tst_resm(TBROK,
-			 "Unknown test case processing actions declared");
-}
-
-/***********************************************************************
- * This routine checks for the return of ENAMETOOLONG errno from requested
- * system call
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_ENAMETOOLONG(struct all_test_cases *tc_ptr)
-{
-	int ret;
-
-	if (cktcsid(tc_ptr->tcid, SYMLINK)) {
-
-		TEST(symlink(tc_ptr->fn_arg[0], full_path));
-		errno = TEST_ERRNO;
-		if ((TEST_RETURN == -1) && (errno == ENAMETOOLONG)) {
-			if (see_if_a_symlink(full_path) == -1) {
-				tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-			} else {
-				tst_resm(TFAIL, "%s %s %d %s",
-					 "symlink(2) returned -1 when trying to create a symbolic",
-					 "link file whose name exceeded",
-					 (PATH_MAX + 1),
-					 "characters, but it created the symbolic link file");
-			}
-		} else {
-			tst_resm(TFAIL | TERRNO,
-				 "Expected ENAMETOOLONG error when creating %s symbolic link file with a path exceeding %d characters",
-				 tc_ptr->fn_arg[1], (PATH_MAX + 1));
-		}
-	} else if (cktcsid(tc_ptr->tcid, READLINK)) {
-
-		char scratch[PATH_MAX + 1];
-
-		ret = readlink(full_path, scratch, strlen(full_path));
-		if ((ret == -1) && (errno == ENAMETOOLONG)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL,
-				 "Expected ENAMETOOLONG error when reading %s symbolic link file with a path exceeding %d characters: errno:%d %s",
-				 tc_ptr->fn_arg[1], (PATH_MAX + 1), errno,
-				 strerror(errno));
-		}
-	} else
-		tst_resm(TBROK,
-			 "Unknown test case processing actions declared");
-}
-
-/***********************************************************************
- * This routine checks for the return of EINVAL errno from requested
- * system call
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_EINVAL(struct all_test_cases *tc_ptr)
-{
-	if (cktcsid(tc_ptr->tcid, READLINK)) {
-		TEST(readlink(tc_ptr->fn_arg[0], test_msg, BUFMAX));
-		errno = TEST_ERRNO;
-		if (TEST_RETURN == -1) {
-			if (errno == EINVAL) {
-				tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-			} else {
-				tst_resm(TFAIL,
-					 "readlink(2) ret:-1, errno:%d, : Exp errno:%d",
-					 errno, EINVAL);
-			}
-		} else {
-			tst_resm(TFAIL,
-				 "readlink(2) did not returned -1 when reading %s",
-				 "a file which is not a symbolic link file");
-		}
-	} else
-		tst_resm(TBROK,
-			 "Unknown test case processing actions declared");
-}
-
-/***********************************************************************
- * This routine checks out the readlink(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_readlink(struct all_test_cases *tc_ptr)
-{
-	char scratch[PATH_MAX];
-	int ret;
-
-	ret = readlink(tc_ptr->fn_arg[1], scratch, strlen(tc_ptr->fn_arg[0]));
-
-     /*** the TEST macro cannot be used here for some reason ****/
-
-	if (ret == -1) {
-		tst_resm(TFAIL, "readlink(2) failure on %s symbolic link file",
-			 tc_ptr->fn_arg[1]);
-
-	} else
-	    if (strncmp(tc_ptr->fn_arg[0], scratch, strlen(tc_ptr->fn_arg[0]))
-		!= 0) {
-
-		/* Must null terminate scratch because readlink(2) doesn't */
-
-		scratch[strlen(tc_ptr->fn_arg[0])] = '\0';
-
-		tst_resm(TFAIL,
-			 "readlink(2) Error : Expected %s symbolic link file contents but %s actual contents were returned",
-			 tc_ptr->fn_arg[0], scratch);
-	} else {
-		tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-	}
-}
-
-/***********************************************************************
- * This routine checks out the stat(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_stat(struct all_test_cases *tc_ptr)
-{
-	if (statter.st_dev != asymlink.st_dev)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object device info %jd != stat of object file device info %jd",
-			 (intmax_t) statter.st_dev, (intmax_t) asymlink.st_dev);
-
-	else if (statter.st_mode != asymlink.st_mode)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file permissions %jd != stat of object file permissions %jd",
-			 (intmax_t) statter.st_mode,
-			 (intmax_t) asymlink.st_mode);
-
-	else if (statter.st_nlink != asymlink.st_nlink)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file link count %jd != stat of object file link count %jd",
-			 (intmax_t) statter.st_nlink,
-			 (intmax_t) asymlink.st_nlink);
-
-	else if (statter.st_uid != asymlink.st_uid)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file uid %jd != stat of object file uid %jd",
-			 (intmax_t) statter.st_uid, (intmax_t) asymlink.st_uid);
-
-	else if (statter.st_gid != asymlink.st_gid)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file gid %jd != stat of object file gid %jd",
-			 (intmax_t) statter.st_gid, (intmax_t) asymlink.st_gid);
-
-	else if (statter.st_size != asymlink.st_size)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object file size %ld != stat of object file size %ld",
-			 statter.st_size, asymlink.st_size);
-
-	else if (statter.st_atime != asymlink.st_atime)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object access time %ld != stat of object file access time %ld",
-			 statter.st_atime, asymlink.st_atime);
-
-	else if (statter.st_mtime != asymlink.st_mtime)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object modify time %ld != stat of object file modify time %ld",
-			 statter.st_atime, asymlink.st_atime);
-
-	else if (statter.st_ctime != asymlink.st_ctime)
-		tst_resm(TFAIL,
-			 "stat of symbolic link reference to object change time %ld != stat of object file change time %ld",
-			 statter.st_atime, asymlink.st_atime);
-	else
-		tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-}
-
-/***********************************************************************
- * This routine checks out the chdir(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_chdir(struct all_test_cases *tc_ptr)
-{
-	if (mkdir(tc_ptr->fn_arg[2], MODE) == -1)
-		tst_resm(TFAIL, "Could not create a setup directory file");
-	else {
-
-		sprintf(Buf, "mkdir(%s, %#o) was successful\n",
-			tc_ptr->fn_arg[2], MODE);
-		strcat(Buffer, Buf);
-
-		if (chdir(tc_ptr->fn_arg[1]) == -1)
-			tst_resm(TFAIL,
-				 "%sCould not change a directory file through a %s",
-				 Buffer,
-				 "symbolic link which which pointed at object");
-		else {
-
-			char *cwd;
-			char expected_location[PATH_MAX];
-			/*
-			 *  Build expected current directory position
-			 */
-			/* FIXME (garrcoop): memory leak */
-			strcpy(expected_location, tst_get_tmpdir());
-			strcat(expected_location, "/");
-			strcat(expected_location, tc_ptr->fn_arg[2]);
-
-			if ((cwd = getcwd(NULL, 0)) == NULL) {
-				tst_resm(TFAIL, "getcwd(3) FAILURE");
-			} else if (strcmp(cwd, expected_location) == 0) {
-				tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-			} else {
-				tst_resm(TFAIL,
-					 "%s%s %s %s not equal to expected %s",
-					 Buffer,
-					 "chdir(2) returned successfully, but getcwd(3) indicated",
-					 "new current working directory location",
-					 cwd, expected_location);
-			}
-			/* FIXME (garrcoop): memory leak */
-			chdir(tst_get_tmpdir());
-		}
-		rmdir(tc_ptr->fn_arg[2]);
-	}
-}
-
-/***********************************************************************
- * This routine checks out the link(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_link(struct all_test_cases *tc_ptr)
-{
-	struct stat stbuf;
-
-	if (link(tc_ptr->fn_arg[1], "nick") == -1) {
-		tst_resm(TFAIL, "%slink(%s, \"nick\") failed, errno: %d: %s %s",
-			 Buffer, tc_ptr->fn_arg[1], errno,
-			 "link of new file to object file via symbolic link file failed",
-			 "when expected not to");
-	} else {
-		sprintf(Buf, "link(%s, \"nick\") was successful\n",
-			tc_ptr->fn_arg[1]);
-		strcat(Buffer, Buf);
-
-		/*
-		 * Check that links counts were properly set
-		 */
-		if (lstat(tc_ptr->fn_arg[1], &asymlink) == -1) {
-			tst_resm(TBROK, "lstat(%s) failed. errno: %d",
-				 tc_ptr->fn_arg[1], errno);
-
-		} else if (lstat("nick", &statter) == -1) {
-			tst_resm(TBROK, "lstat(nick) failed, errno:%d",
-				 errno);
-		} else {
-			if (statter.st_ino == asymlink.st_ino) {
-				if ((statter.st_nlink == 2) && (asymlink.st_nlink == 2)) {
-					tst_resm(TEST_RESULT, "%s",
-					         msgs[tc_ptr->pass_msg]);
-				} else {
-					lstat(tc_ptr->fn_arg[2],
-					      &stbuf);
-
-					tst_resm(TFAIL,
-						 "%slink(%s, %s) failed to adjust link count.\n\
-		count for nick is %d, count for %s is %d, count for %s is %d.",
-						 Buffer, tc_ptr->fn_arg[1], "nick", statter.st_nlink, tc_ptr->fn_arg[1], asymlink.st_nlink, tc_ptr->fn_arg[2],
-						 stbuf.st_nlink);
-				}
-			} else {
-				tst_resm(TFAIL, "%sA lstat of %s (ino:%jd) and of\n\t\t\
-%s (ino:%jd), does not show them being the same ino.", Buffer,
-					 tc_ptr->fn_arg[1], (intmax_t) asymlink.st_ino, "nick", (intmax_t) statter.st_ino);
-			}
-		}
-
-		delete_files("nick", NULL);
-	}
-}
-
-/***********************************************************************
- * This routine checks out the unlink(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_unlink(struct all_test_cases *tc_ptr)
-{
-	if (stat(tc_ptr->fn_arg[2], &asymlink) == -1)
-		tst_resm(TBROK, "stat(2) Failure when accessing %s object file",
-			 tc_ptr->fn_arg[2]);
-	else if (unlink(tc_ptr->fn_arg[1]) == -1)
-		tst_resm(TFAIL,
-			 "unlink(2) failed when removing symbolic link file");
-	else {
-		sprintf(Buf, "unlink(%s) was successful\n", tc_ptr->fn_arg[1]);
-		strcat(Buffer, Buf);
-		if (stat(tc_ptr->fn_arg[2], &statter) == -1) {
-			tst_resm(TFAIL, "%s %s",
-				 "unlink(2) failed because it not only removed symbolic link",
-				 "file which pointed at object file, but object file as well");
-
-		} else if ((statter.st_ino == asymlink.st_ino) &&
-			 (statter.st_dev == asymlink.st_dev) &&
-			 (statter.st_size == asymlink.st_size)) {
-
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s%s %s %s", Buffer,
-				 "unlink(2) failed because it not only removed symbolic link",
-				 "file which pointed at object file, but it changed object",
-				 "file inode information");
-		}
-	}
-
-}
-
-/***********************************************************************
- * This routine checks out the chmod(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_chmod(struct all_test_cases *tc_ptr)
-{
-	if (stat(tc_ptr->fn_arg[2], &asymlink) == -1)
-		tst_resm(TBROK, "stat(2) Failure when accessing %s object file",
-			 tc_ptr->fn_arg[2]);
-	else if (chmod(tc_ptr->fn_arg[1], (MODE | MASK)) == -1)
-		tst_resm(TFAIL, "%s%s %s", Buffer,
-			 "chmod(2) failed when changing file permission",
-			 "through symbolic link file");
-	else {
-		sprintf(Buf, "chmod(%s, %#o) was successful\n",
-			tc_ptr->fn_arg[1], (MODE | MASK));
-		strcat(Buffer, Buf);
-
-		if (stat(tc_ptr->fn_arg[2], &statter) == -1) {
-			tst_resm(TBROK,
-				 "stat(2) Failure when accessing %s object file",
-				 tc_ptr->fn_arg[2]);
-		} else if ((statter.st_mode == (MODE | MASK))
-			 && (statter.st_mode != asymlink.st_mode)) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s%s %o to %o %s", Buffer,
-				 "chmod(2) failed to change object file permissions from",
-				 asymlink.st_mode, (MODE | MASK),
-				 "through symbolic link file");
-		}
-	}
-
-}
-
-/***********************************************************************
- * This routine checks out the utime(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_utime(struct all_test_cases *tc_ptr)
-{
-	struct utimbuf utimes;
-
-	if (stat(tc_ptr->fn_arg[2], &asymlink) == -1)
-		tst_resm(TBROK, "stat(2) Failure when accessing %s object file",
-			 tc_ptr->fn_arg[2]);
-	else {
-		/* Now add a few values to access and modify times */
-
-		utimes.actime = asymlink.st_atime + a_time_value;
-		utimes.modtime = asymlink.st_mtime + a_time_value;
-
-		/* Now hand off to utime(2) via symbolic link file */
-
-		if (utime(tc_ptr->fn_arg[1], &utimes) == -1)
-			tst_resm(TFAIL, "%s %s",
-				 "utime(2) failed to process object file access and modify",
-				 "time updates through symbolic link");
-		else {
-			/* Now verify changes were made */
-
-			if (stat(tc_ptr->fn_arg[2], &statter) == -1)
-				tst_resm(TBROK,
-					 "stat(2) Failure when accessing %s object file",
-					 tc_ptr->fn_arg[2]);
-			else {
-				time_t temp, diff;
-
-				temp = statter.st_atime - asymlink.st_atime;
-				diff =
-				    (statter.st_mtime - asymlink.st_mtime) -
-				    temp;
-
-				if (!diff) {
-					tst_resm(TEST_RESULT, "%s",
-					         msgs[tc_ptr->pass_msg]);
-				} else {
-					tst_resm(TFAIL,
-						 "%s %s %jd greater than original times",
-						 "utime(2) failed to change object file access and",
-						 "modify times through symbolic link to a value",
-						 (intmax_t) a_time_value);
-				}
-			}
-		}
-	}
-}
-
-/***********************************************************************
- * This routine checks out the rename(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_rename(struct all_test_cases *tc_ptr)
-{
-	int pts_at_object = 0;
-
-	if (stat(tc_ptr->fn_arg[2], &statter) != -1)
-		pts_at_object = 1;
-
-	TEST(rename(tc_ptr->fn_arg[1], A_S_FILE));
-	errno = TEST_ERRNO;
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL,
-			 "rename(3) failed to rename %s symbolic link file to %s",
-			 tc_ptr->fn_arg[2], A_S_FILE);
-	} else if (pts_at_object) {
-		if (ck_both(tc_ptr->fn_arg[0], A_S_FILE, tc_ptr->fn_arg[2])) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {
-			tst_resm(TFAIL, "%s", test_msg);
-		}
-	} else if (!ck_symlink(tc_ptr->fn_arg[0], A_S_FILE, NULL)) {
-		tst_resm(TFAIL, "%s", test_msg);
-	} else if (stat(tc_ptr->fn_arg[1], &asymlink) != -1) {
-		tst_resm(TFAIL,
-			 "rename(3) did not remove %s when renaming to %s",
-			 tc_ptr->fn_arg[1], A_S_FILE);
-	} else {
-		tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-	}
-}
-
-/***********************************************************************
- * This routine checks out the open(2) system call for a successful
- * invocation
- *
- *   Argument is pointer to test_objects array of structures of type
- *   all_test_cases
- ***********************************************************************/
-void do_open(struct all_test_cases *tc_ptr)
-{
-	int fd = -1;
-	int ret, pts_at_object = 0;
-	char scratch[PATH_MAX];
-
-	if (stat(tc_ptr->fn_arg[2], &statter) != -1)
-		pts_at_object = 1;
-
-	if (pts_at_object) {
-		TEST(open(tc_ptr->fn_arg[1], O_RDWR));
-		errno = TEST_ERRNO;
-		if ((fd = TEST_RETURN) == -1) {
-			tst_resm(TFAIL,
-				 "open(2) Failure when opening object file through symbolic link file");
-			return;
-		}
-	} else {
-		TEST(open(tc_ptr->fn_arg[1], (O_CREAT | O_RDWR), MODE));
-		errno = TEST_ERRNO;
-		if ((fd = TEST_RETURN) == -1) {
-			tst_resm(TFAIL,
-				 "open(2) Failure when creating object file through symbolic link file");
-			return;
-		}
-	}
-	if ((ret = write(fd, BIG_STRING, strlen(BIG_STRING))) == -1) {
-		tst_resm(TFAIL,
-			 "write(2) Failure to object file opened through a symbolic link file: errno:%d",
-			 errno);
-	} else if (ret != strlen(BIG_STRING)) {
-		tst_resm(TFAIL,
-			 "write(2) Failed to write %zu bytes to object file opened through a symbolic link file",
-			 strlen(BIG_STRING));
-	} else if (lseek(fd, 0L, 0) == -1) {
-		tst_resm(TFAIL,
-			 "lseek(2) Failed to position to beginning of object file opened through a symbolic link file: errno = %d",
-			 errno);
-	} else if ((ret = read(fd, scratch, strlen(BIG_STRING))) == -1) {
-		tst_resm(TFAIL,
-			 "read(2) Failure of object file opened through a symbolic link file: errno = %d",
-			 errno);
-	} else if (ret != strlen(BIG_STRING)) {
-		tst_resm(TFAIL,
-			 "read(2) Failed to read %zu bytes to object file opened through a symbolic link file",
-			 strlen(BIG_STRING));
-	} else if (strncmp(BIG_STRING, scratch, strlen(BIG_STRING)) != 0) {
-		tst_resm(TFAIL,
-			 "Content of write(2) and read(2) Failed to object file through symbolic link file was not as expected. Expected %s and read returned %s",
-			 BIG_STRING, scratch);
-	} else {
-		/*
-		 *  Close off symbolic link file to object file access
-		 */
-		if (close(fd) == -1) {
-			tst_resm(TFAIL,
-				 "close(2) Failure when closing object file accessed symbolic link file");
-		}
-		/*
-		 * Now, lets open up and read object file and compare contents
-		 */
-		else if ((fd = open(tc_ptr->fn_arg[0], O_RDONLY)) == -1) {
-			tst_resm(TFAIL,
-				 "open(2) Failure when opening %s file: errno:%d %s",
-				 tc_ptr->fn_arg[0], errno, strerror(errno));
-		} else if ((ret = read(fd, scratch, strlen(BIG_STRING))) == -1) {
-			tst_resm(TFAIL,
-				 "read(2) Failure of object file opened through a symbolic link file: errno:%d",
-				 errno);
-		} else if (ret != strlen(BIG_STRING)) {
-			tst_resm(TFAIL,
-				 "read(2) Failed to read %zu bytes to object file opened through a symbolic link file",
-				 strlen(BIG_STRING));
-		} else if (strncmp(BIG_STRING, scratch, strlen(BIG_STRING)) !=
-			   0) {
-			tst_resm(TFAIL,
-				 "Content of write(2) and read(2) Failed to object file through symbolic link file was not as expected. Expected %s and read returned %s",
-				 BIG_STRING, scratch);
-		} else if (pts_at_object) {
-			tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
-		} else {	/* Insure newly created object file is pointed at */
-			if (ck_both
-			    (tc_ptr->fn_arg[0], tc_ptr->fn_arg[1],
-			     tc_ptr->fn_arg[0])) {
-				tst_resm(TEST_RESULT, "%s",
-					 msgs[tc_ptr->pass_msg]);
-			} else {
-				tst_resm(TFAIL, "%s", test_msg);
-			}
-		}
-		close(fd);
-	}
-}
-
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* create a temporary directory and go to it */
-	tst_tmpdir();
-
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *              completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
-
-void help(void)
-{
-	unsigned int ind;
-
-	printf("   -T id  Determines which tests cases to execute:\n");
-
-	for (ind = 0; ind < sizeof(all_tcses) / sizeof(struct tcses); ind++) {
-		printf("  %s/%s - %s\n", all_tcses[ind].tcid,
-		       all_tcses[ind].syscall, all_tcses[ind].desc);
-	}
-}

---
base-commit: ae279276535fc9ca3117a12c4bba0029d792904e
change-id: 20250319-remove_symlink01-e71891162966

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
