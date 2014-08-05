Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XEgn4-0001ma-Ts
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XEgn2-0008U3-VE
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:42 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s75FaZAN005035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Aug 2014 11:36:35 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Tue,  5 Aug 2014 17:36:22 +0200
Message-Id: <1407252982-27023-6-git-send-email-asavkov@redhat.com>
In-Reply-To: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
References: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH 5/5] check_for_unshare test removed from containers
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Artem Savkov <asavkov@redhat.com>

Removed this test as it doesn't seem to be needed any more, it just checks
availability of unshare(2) call and all the code that actually uses it has it
wrapped with appropriate #if HAVE_UNSARE clauses.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 runtest/containers                              |  2 -
 testcases/kernel/containers/check_for_unshare.c | 57 -------------------------
 testcases/kernel/containers/container_test.sh   | 32 --------------
 3 files changed, 91 deletions(-)
 delete mode 100644 testcases/kernel/containers/check_for_unshare.c
 delete mode 100755 testcases/kernel/containers/container_test.sh

diff --git a/runtest/containers b/runtest/containers
index 827a5d7..a15bd50 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -55,5 +55,3 @@ utstest_clone_2 utstest clone 2
 utstest_clone_3 utstest clone 3
 utstest_clone_4 utstest clone 4
 utstest_clone_5 utstest clone 5
-
-Containers	container_test.sh
diff --git a/testcases/kernel/containers/check_for_unshare.c b/testcases/kernel/containers/check_for_unshare.c
deleted file mode 100644
index fbb8d11..0000000
--- a/testcases/kernel/containers/check_for_unshare.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
-* Copyright (c) International Business Machines Corp., 2008
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-**************************************************************************/
-/*
-* Description:
-* This program verifies the kernel version to be no later than 2.6.16
-* And checks if the unshare() system call is defined using dlsym(),
-* in the Dynamically Linked Libraries.
-*
-* Date : 26-11-2008
-* Author : Veerendra C <vechandr@in.ibm.com>
-*/
-
-#include <dlfcn.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include "test.h"
-
-const char *TCID = "check_for_unshare";
-
-int main(int argc, char **argv)
-{
-	void *handle;
-	void *ret;
-	char *error;
-	if (tst_kvercmp(2, 6, 16) < 0)
-		return 1;
-
-	handle = dlopen(NULL, RTLD_LAZY);
-	if (!handle) {
-		fprintf(stderr, "%s\n", dlerror());
-		exit(1);
-	}
-
-	dlerror();		/* Clear any existing error */
-	ret = dlsym(handle, "unshare");
-	if ((error = dlerror()) != NULL) {
-		fprintf(stderr, "Error: %s\n", error);
-		exit(1);
-	}
-
-	dlclose(handle);
-	return 0;
-}
diff --git a/testcases/kernel/containers/container_test.sh b/testcases/kernel/containers/container_test.sh
deleted file mode 100755
index 9e515e4..0000000
--- a/testcases/kernel/containers/container_test.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/bash
-#
-# This test performs capability tests for file operations.
-#
-# Copyright 2007 IBM
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of the GNU General Public License as published by the Free
-# Software Foundation; either version 2 of the License, or (at your option)
-# any later version.
-
-#check_utsns_enabled
-check_for_unshare
-if [ $? -eq 1 ]; then
-	echo "Unshare not supported.  Not running container tests"
-	exit 0
-fi
-
-#check_userns_enabled
-#if [ $? -eq 0 ]; then
-	#echo "Running userns tests."
-#	userns_mounts unshare
-#	userns_mounts clone
-#	userns_sigio none
-#	userns_sigio unshare
-#	userns_sigio clone
-#	for i in `seq 1 4`; do
-#		userns_sigpending $i
-#	done
-#else
-	#echo "User namespaces not enabled in kernel.  Not running userns tests."
-#fi
-- 
1.9.3


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
