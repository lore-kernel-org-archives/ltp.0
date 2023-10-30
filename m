Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC6EC4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 11:01:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D4493CC97B
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 12:01:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAF043C6D29
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:01:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 359C11A05C72
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:01:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26B6E21CE7;
 Mon, 30 Oct 2023 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698663669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvmjRyDtlZtSc2144z/r7k1dgJo27P+Nf3J8S5giEDo=;
 b=ZtZiBOMiotQf9paSPuB7wx2vj/sTdwcmOAKRUkhoXQdjZyAagxItNc9/9QOOLC8d7EYU98
 xqrMOKWoPAbgmBk7waiI2wqPwnXYIWGBs3qy2BNCPUYuVboia5k80X2o5sH7lZy+7F019P
 ehXst/mw3cibC94sKPO58C6XDam65zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698663669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvmjRyDtlZtSc2144z/r7k1dgJo27P+Nf3J8S5giEDo=;
 b=KNhTXNZV9j35BgrnjqoeFe+f+Ij9LIogrky0Zyl77bKQZ88r0z+GNwEpLO4j8CTlg0Kdr+
 IMjqVVx57apKWoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04EB913A66;
 Mon, 30 Oct 2023 11:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2KeFO/SMP2UYPQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 30 Oct 2023 11:01:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 30 Oct 2023 12:01:07 +0100
Message-Id: <20231030110107.4528-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231030110107.4528-1-andrea.cervesato@suse.de>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] Remove fsx runtest suite
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

After fsx-linux refactoring fsx testing suite is not needed anymore,
since most of the test cases are already covered by ltp-aiodio.part3.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/ltp-run-files.txt                   |  1 -
 runtest/fsx                             |  8 ----
 scenario_groups/default                 |  1 -
 testcases/kernel/fs/fsx-linux/fsxtest   | 50 -------------------------
 testcases/kernel/fs/fsx-linux/fsxtest02 | 44 ----------------------
 5 files changed, 104 deletions(-)
 delete mode 100644 runtest/fsx
 delete mode 100755 testcases/kernel/fs/fsx-linux/fsxtest
 delete mode 100755 testcases/kernel/fs/fsx-linux/fsxtest02

diff --git a/doc/ltp-run-files.txt b/doc/ltp-run-files.txt
index 3f405b387..8b3ed78fd 100644
--- a/doc/ltp-run-files.txt
+++ b/doc/ltp-run-files.txt
@@ -41,7 +41,6 @@ Test suites
 
  - syscalls  (except epoll, see below)
  - fs
- - fsx
  - dio
  - mm
  - ipc
diff --git a/runtest/fsx b/runtest/fsx
deleted file mode 100644
index b09e5c2af..000000000
--- a/runtest/fsx
+++ /dev/null
@@ -1,8 +0,0 @@
-#DESCRIPTION:fsx filesystem stress tests
-fsx-linux export TCbin=$LTPROOT/testcases/bin;fsxtest02 10000
-#fsx-ext2 fsxtest $SCRATCHDEV ext2 10000
-#fsx-ext3 fsxtest $SCRATCHDEV ext3 10000
-#fsx-jfs fsxtest $SCRATCHDEV jfs 10000
-#fsx-xfs  fsxtest $SCRATCHDEV xfs 10000
-#fsx-reiserfs fsxtest $SCRATCHDEV reiserfs 10000
-
diff --git a/scenario_groups/default b/scenario_groups/default
index 68bd5300d..f17b2061a 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -1,7 +1,6 @@
 syscalls
 fs
 fs_perms_simple
-fsx
 dio
 io
 mm
diff --git a/testcases/kernel/fs/fsx-linux/fsxtest b/testcases/kernel/fs/fsx-linux/fsxtest
deleted file mode 100755
index 61835437d..000000000
--- a/testcases/kernel/fs/fsx-linux/fsxtest
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2001 Silicon Graphics, Inc.  All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2001
-#
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-# Proper error checking and result reporting still needed
-#
-# usage:  fsxtest $1 $2 $3
-# $1 scratch device to use for testing
-# $2 optional file system type
-# $3 number of operations to perform
-
-#Uncomment line below for debugging
-#set -x
-if [ $2 = "jfs" ]; then
-  mkfs -t $2 -q $1
-else
-  mkfs -t $2 $1
-fi
-mkdir /testmount
-mount -t $2 $1 /testmount
-touch /testmount/testfile
-fsx-linux -N $3 /testmount/testfile
-RESULT=$?
-# report the results
-if [ $RESULT -eq "0" ]; then
-  echo "PASS: fsxtest $1 $2 $3"
-else
-  echo "FAIL: fsxtest $1 $2 $3"
-fi
-umount /testmount
-rm -rf /testmount
-fsck -a -t $2 $1  # report the results
-exit $RESULT
diff --git a/testcases/kernel/fs/fsx-linux/fsxtest02 b/testcases/kernel/fs/fsx-linux/fsxtest02
deleted file mode 100755
index fe014abdd..000000000
--- a/testcases/kernel/fs/fsx-linux/fsxtest02
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2001 Silicon Graphics, Inc.  All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2001
-#
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-# Proper error checking and result reporting still needed
-#
-# usage:  fsxtest02 $1
-# $1 number of operations to perform
-
-#Uncomment line below for debugging
-#set -x
-
-TCbin=${TCbin:-`pwd`}
-TCtmp=${TCtmp:-/tmp/fsxtest2.$$}
-
-mkdir -p $TCtmp 2>/dev/null
-touch $TCtmp/testfile
-$TCbin/fsx-linux -N $1 $TCtmp/testfile
-RESULT=$?
-# report the results
-if [ $RESULT -eq "0" ]; then
-  echo "PASS: fsxtest02 $1 $2 $3"
-else
-  echo "FAIL: fsxtest02 $1 $2 $3"
-fi
-rm -rf $TCtmp
-exit $RESULT
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
