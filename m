From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Nov 2016 11:36:53 +0800
Subject: [LTP] [PATCH 2/3] ltp/numa: cleanup work for numa/*
Message-ID: <1479872213-29969-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Remove useless test.sh

* Remove outdated numa_node_size.c
  Note: abandoned in commit 67045d7530

* Rewrite support_numa.c
  Note: No need to include test.h to get ltp standard
  PASS/FAIL as ordinary testcases, it's just an aided
  process which calling in numa.sh)

* Update README document

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/.gitignore       |  1 -
 testcases/kernel/numa/README           | 25 +---------
 testcases/kernel/numa/numa_node_size.c | 88 ----------------------------------
 testcases/kernel/numa/support_numa.c   | 58 +++++++++-------------
 testcases/kernel/numa/test.sh          | 57 ----------------------
 5 files changed, 25 insertions(+), 204 deletions(-)
 delete mode 100644 testcases/kernel/numa/numa_node_size.c
 delete mode 100644 testcases/kernel/numa/test.sh

diff --git a/testcases/kernel/numa/.gitignore b/testcases/kernel/numa/.gitignore
index 063d009..f4773f5 100644
--- a/testcases/kernel/numa/.gitignore
+++ b/testcases/kernel/numa/.gitignore
@@ -1,2 +1 @@
-/numa_node_size
 /support_numa
diff --git a/testcases/kernel/numa/README b/testcases/kernel/numa/README
index 3d9defb..d8a5891 100644
--- a/testcases/kernel/numa/README
+++ b/testcases/kernel/numa/README
@@ -12,7 +12,7 @@ to either decrease the memory latencies or increase the memory bandwidth by prop
 Please refer http://lse.sourceforge.net/numa/ to know the basics of numa and refer
 http://www.novell.com/collateral/4621437/4621437.pdf to understand the usage of numactl and numa libraries.
 
-We can always get the latest package from ftp://ftp.suse.com/pub/people/ak/numa.
+We can always get the latest package from http://oss.sgi.com/projects/libnuma/.
 
 Testcase Description:
 ====================================================================================================================
@@ -44,25 +44,4 @@ the policy applied.
 Pre-requisites
 ====================================================================================================================
  * libnuma should be installed on the NUMA machine before executing theses testcases
- * Testcases can also be executed on non-numa machines, but they will fail,
-
-Building the Tescases
-====================================================================================================================
-From LTP-Root, use <make> to build the testcases
-ltp-full-20070731]$ make
-or, from
-ltp-full-20070731_numa/testcases/kernel/numa]# make
-
-Installing the Testcases
-====================================================================================================================
-From LTP-Root, use <make> to install the testcases
-ltp-full-20070731]$ make install
-or, from
-ltp-full-20070731_numa/testcases/kernel/numa]# make install
-
-Running the Tescases
-====================================================================================================================
-From LTP-Root, invoke ./runltp
-ltp-full-20070731]$ ./runltp -p -l <logfile> -f numa
-
- * NUMA testcases will not run by default in LTP-runall
+ * Testcases will not run by default in LTP-runall, they also skip on non-numa machines
diff --git a/testcases/kernel/numa/numa_node_size.c b/testcases/kernel/numa/numa_node_size.c
deleted file mode 100644
index 6338bc7..0000000
--- a/testcases/kernel/numa/numa_node_size.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2007                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-/******************************************************************************/
-/*                                                                            */
-/* File:        numa_node_size.c                                              */
-/*                                                                            */
-/* Description: Invokes numa_node_size() API                                  */
-/*                                                                            */
-/* Author:     Pradeep Kumar Surisetty pradeepkumars@in.ibm.com               */
-/*                                                                            */
-/* History:     Created - Nov 28 2007 - Pradeep Kumar Surisetty               */
-/*                                                 pradeepkumars@in.ibm.com   */
-/*                                                                            */
-/******************************************************************************/
-
-#include "config.h"
-#include <stdio.h>
-#include <stdlib.h>
-#if HAVE_NUMA_H
-#include <numa.h>
-#endif
-
-int numa_exit_on_error = 0;
-char *fmt_mem(unsigned long long mem, char *buf)
-{
-	if (mem == -1L)
-		sprintf(buf, "<not available>");
-	else
-		sprintf(buf, "%Lu MB", mem >> 20);
-	return buf;
-}
-
-void hardware(void)
-{
-#if HAVE_NUMA_H
-	int i;
-	int maxnode = numa_max_node();
-	printf("available: %d nodes (0-%d)\n", 1 + maxnode, maxnode);
-	for (i = 0; i <= maxnode; i++) {
-		char buf[64];
-		long fr;
-		unsigned long sz = numa_node_size(i, &fr);
-		printf("node %d cpus:", i);
-		printf("node %d size: %s\n", i, fmt_mem(sz, buf));
-		printf("node %d free: %s\n", i, fmt_mem(fr, buf));
-	}
-#endif
-}
-
-int main(void)
-{
-#if HAVE_NUMA_H
-	nodemask_t nodemask;
-	void hardware();
-	if (numa_available() < 0) {
-		printf("This system does not support NUMA policy\n");
-		numa_error("numa_available");
-		numa_exit_on_error = 1;
-		exit(numa_exit_on_error);
-	}
-	nodemask_zero(&nodemask);
-	nodemask_set(&nodemask, 1);
-	numa_bind(&nodemask);
-	hardware();
-	return numa_exit_on_error;
-#else
-	printf("NUMA is not available\n");
-	return 1;
-#endif
-}
diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
index 3991955..5c6b066 100644
--- a/testcases/kernel/numa/support_numa.c
+++ b/testcases/kernel/numa/support_numa.c
@@ -1,34 +1,31 @@
 /******************************************************************************/
 /*                                                                            */
 /* Copyright (c) International Business Machines  Corp., 2007                 */
+/* Copyright (c) Linux Test Project, 2016                                     */
 /*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
+/* This program is free software: you can redistribute it and/or modify       */
 /* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
+/* the Free Software Foundation, either version 3 of the License, or          */
 /* (at your option) any later version.                                        */
 /*                                                                            */
 /* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
+/* but WITHOUT ANY WARRANTY; without even the implied warranty of             */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              */
+/* GNU General Public License for more details.                               */
 /*                                                                            */
 /* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
+/* along with this program. If not, see <http://www.gnu.org/licenses/>.       */
 /*                                                                            */
 /******************************************************************************/
 
 /******************************************************************************/
 /*                                                                            */
-/* File:        support_numa.c                                                     */
+/* File:        support_numa.c                                                */
 /*                                                                            */
 /* Description: Allocates 1MB of memory and touches it to verify numa         */
 /*                                                                            */
 /* Author:      Sivakumar Chinnaiah  Sivakumar.C@in.ibm.com                   */
 /*                                                                            */
-/* History:     Created - Jul 18 2007 - Sivakumar Chinnaiah                   */
-/*                                                 Sivakumar.C@in.ibm.com     */
-/*                                                                            */
 /******************************************************************************/
 
 #include <stdio.h>
@@ -38,24 +35,14 @@
 #include <signal.h>
 #include <limits.h>
 #include <string.h>
-#include "test.h"
 
 /* Global Variables */
 #define MB (1<<20)
 #define PAGE_SIZE getpagesize()
 #define barrier() __asm__ __volatile__("": : :"memory")
 
-/* Extern Global Variables */
-extern int tst_count;		/* to avoid compilation errors. */
-extern char *TESTDIR;		/* to avoid compilation errors. */
-
-/* Global Variables */
-char *TCID = "support_numa";	/* to avoid compilation errors. */
-int TST_TOTAL = 1;		/* to avoid compilation errors. */
-
-void sigfunc(int sig)
+void sigfunc(__attribute__ ((unused)) int sig)
 {
-	tst_resm(TINFO, "#Caught signal signum=%d", sig);
 }
 
 /******************************************************************************/
@@ -65,9 +52,9 @@ void sigfunc(int sig)
 /* Description: Alloctes 1MB of memory and touches it to verify numa behaviour*/
 /*                                                                            */
 /* Input:       Describe input arguments to this program                      */
-/*               argv[1] ==1 then print pagesize                              */
-/*               argv[1] ==2 then allocate 1MB of memory                      */
-/*		 argv[1] ==3 then pause the program to catch sigint	      */
+/*               argv[1] == 1 then print pagesize                             */
+/*               argv[1] == 2 then allocate 1MB of memory                     */
+/*		 argv[1] == 3 then pause the program to catch sigint          */
 /*                                                                            */
 /* Exit:       On failure - Exits with non-zero value.                        */
 /*             On success - exits with 0 exit value.                          */
@@ -78,40 +65,41 @@ int main(int argc, char *argv[])
 {
 	int i;
 	char *buf = NULL;
-	int count = 0;
 	struct sigaction sa;
 
+	if (argc != 2) {
+		printf("Error: arguments not right.\n");
+		exit(-1);
+	}
+
 	switch (atoi(argv[1])) {
 	case 1:
 		printf("%d", PAGE_SIZE);
-		tst_exit();
+		return 0;
 	case 2:
 		buf = malloc(MB);
 		if (!buf) {
-			tst_resm(TINFO, "#Memory is not available\n");
-			tst_exit();
+			printf("Memory is not available\n");
 			exit(2);
 		}
 		for (i = 0; i < MB; i += PAGE_SIZE) {
-			count++;
 			buf[i] = 'a';
 			barrier();
 		}
 		free(buf);
-		tst_exit();
+		return 0;
 	case 3:
 		/* Trap SIGINT */
 		sa.sa_handler = sigfunc;
 		sa.sa_flags = SA_RESTART;
 		sigemptyset(&sa.sa_mask);
 		if (sigaction(SIGINT, &sa, 0) < 0) {
-			tst_brkm(TBROK, NULL, "#Sigaction SIGINT failed\n");
-			tst_exit();
-			exit(1);
+			printf("Sigaction SIGINT failed\n");
+			exit(3);
 		}
 		/* wait for signat Int */
 		pause();
-		tst_exit();
+		return 0;
 	default:
 		exit(1);
 	}
diff --git a/testcases/kernel/numa/test.sh b/testcases/kernel/numa/test.sh
deleted file mode 100644
index 112cdaa..0000000
--- a/testcases/kernel/numa/test.sh
+++ /dev/null
@@ -1,57 +0,0 @@
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2007                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-#
-# Author         Pradeep Kumar Surisetty, pradeepkumars@in.ibm.com
-#
-# History        Nov 27 2007 -created- pradeep kumar surisetty
-#! /bin/sh
-#
-# File :         test.sh
-
-
-#!/bin/sh
-x=0
-chk_ifexist()
-{
-if [ ! -d /sys/devices/system/node ]
-then
-x=0
-else
-x=$(ls /sys/devices/system/node | wc -l)
-fi
-if [ $x -gt 1 ]
-then
-	if [ ! -f /usr/include/numa.h ]
-	then
-		echo no;
- 	else
-		echo yes;
-	fi
-else
-        echo no;     #numa is not present
-
-fi
-}
-if [ "$CROSS_COMPILER" = "" ] then
-	chk_ifexist
-else
-    echo no;
-fi
-
-- 
1.8.3.1

