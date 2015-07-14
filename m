Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1ZEzFK-00079e-C4
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 12:23:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEzFA-0005fl-U8
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 12:23:38 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 463903CEF6B
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jul 2015 12:23:23 +0000 (UTC)
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.89.68])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t6ECNA6L003401
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Jul 2015 08:23:22 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Tue, 14 Jul 2015 14:22:52 +0200
Message-Id: <1436876572-28759-2-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
References: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 2/2] containers/netns tests rewritten
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

All original test cases in ltp/testcases/kernel/containers/netns
were removed and replaced with the new ones. The new test cases
cover all of the tests in the original code and everything else
in the original code didn't exercise new code paths in the kernel.
Mapping of old test cases to the new ones:

netns_crtchild -> netns_comm
netns_two_children_ns -> netns_comm
netns_crtchild_delchild -> netns_sysfs
netns_par_chld_ipv6, netns_par_chld_ftp -> nets_comm (netns_comm
    does not complicate it with sshd or ftp, it just tests
    communication using ping/ping6)
netns_devices, netns_devices2 -> netns_comm
netns_isolation -> netns_breakns

New testcases also use the helper tools for creating and working
with namespaces from ltp/testcases/kernel/containers/share.

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                                 |  25 +-
 testcases/kernel/containers/README                 |  29 +--
 testcases/kernel/containers/netns/.gitignore       |   7 -
 testcases/kernel/containers/netns/Makefile         |  49 ++--
 testcases/kernel/containers/netns/common.c         | 130 ----------
 testcases/kernel/containers/netns/common.h         |  23 --
 testcases/kernel/containers/netns/netns_breakns.sh |  74 ++++++
 testcases/kernel/containers/netns/netns_ch_ftp.sh  |  47 ----
 testcases/kernel/containers/netns/netns_child.sh   |  43 ----
 testcases/kernel/containers/netns/netns_child_1.sh |  91 -------
 testcases/kernel/containers/netns/netns_child_2.sh |  89 -------
 .../containers/netns/netns_child_propagate.sh      |  74 ------
 .../kernel/containers/netns/netns_childipv6.sh     | 103 --------
 testcases/kernel/containers/netns/netns_childns.sh |  99 --------
 testcases/kernel/containers/netns/netns_comm.sh    |  99 ++++++++
 .../kernel/containers/netns/netns_container_ftp.pl |  88 -------
 .../containers/netns/netns_create_container.c      |  47 ----
 testcases/kernel/containers/netns/netns_crtchild.c |  54 ----
 .../containers/netns/netns_crtchild_delchild.c     |  57 -----
 .../kernel/containers/netns/netns_delchild.sh      |  78 ------
 testcases/kernel/containers/netns/netns_devices.sh | 117 ---------
 .../kernel/containers/netns/netns_devices2.sh      | 117 ---------
 testcases/kernel/containers/netns/netns_helper.h   |  41 ++-
 testcases/kernel/containers/netns/netns_helper.sh  | 277 ++++++++++++++++++++-
 .../kernel/containers/netns/netns_initialize.sh    | 152 -----------
 .../kernel/containers/netns/netns_isolation.sh     | 102 --------
 .../kernel/containers/netns/netns_par_chld_ftp.c   |  56 -----
 .../kernel/containers/netns/netns_par_chld_ftp.sh  |  50 ----
 .../kernel/containers/netns/netns_par_chld_ipv6.c  | 119 ---------
 testcases/kernel/containers/netns/netns_par_ftp.sh |  56 -----
 testcases/kernel/containers/netns/netns_parent.sh  |  42 ----
 .../kernel/containers/netns/netns_parent_1.sh      |  64 -----
 .../kernel/containers/netns/netns_parent_2.sh      |  60 -----
 .../kernel/containers/netns/netns_parent_share.sh  |  51 ----
 .../kernel/containers/netns/netns_parent_view.sh   |  66 -----
 .../kernel/containers/netns/netns_parentns.sh      | 102 --------
 testcases/kernel/containers/netns/netns_paripv6.sh | 117 ---------
 .../kernel/containers/netns/netns_rename_net.sh    |  77 ------
 testcases/kernel/containers/netns/netns_sysfs.sh   |  61 +++++
 .../kernel/containers/netns/netns_sysfsview.c      |  60 -----
 .../containers/netns/netns_two_children_ns.c       | 134 ----------
 testcases/kernel/containers/netns/nw_under_ns.sh   |  35 ---
 testcases/kernel/containers/netns/readme           |  15 --
 .../containers/netns/runallnetworktests_child.sh   | 156 ------------
 .../containers/netns/runallnetworktests_parent.sh  |  30 ---
 45 files changed, 562 insertions(+), 2901 deletions(-)
 delete mode 100644 testcases/kernel/containers/netns/common.c
 delete mode 100644 testcases/kernel/containers/netns/common.h
 create mode 100755 testcases/kernel/containers/netns/netns_breakns.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_ch_ftp.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_child.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_child_1.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_child_2.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_child_propagate.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_childipv6.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_childns.sh
 create mode 100755 testcases/kernel/containers/netns/netns_comm.sh
 delete mode 100644 testcases/kernel/containers/netns/netns_container_ftp.pl
 delete mode 100644 testcases/kernel/containers/netns/netns_create_container.c
 delete mode 100644 testcases/kernel/containers/netns/netns_crtchild.c
 delete mode 100644 testcases/kernel/containers/netns/netns_crtchild_delchild.c
 delete mode 100755 testcases/kernel/containers/netns/netns_delchild.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_devices.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_devices2.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_initialize.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_isolation.sh
 delete mode 100644 testcases/kernel/containers/netns/netns_par_chld_ftp.c
 delete mode 100755 testcases/kernel/containers/netns/netns_par_chld_ftp.sh
 delete mode 100644 testcases/kernel/containers/netns/netns_par_chld_ipv6.c
 delete mode 100755 testcases/kernel/containers/netns/netns_par_ftp.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_parent.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_parent_1.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_parent_2.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_parent_share.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_parent_view.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_parentns.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_paripv6.sh
 delete mode 100755 testcases/kernel/containers/netns/netns_rename_net.sh
 create mode 100755 testcases/kernel/containers/netns/netns_sysfs.sh
 delete mode 100644 testcases/kernel/containers/netns/netns_sysfsview.c
 delete mode 100644 testcases/kernel/containers/netns/netns_two_children_ns.c
 delete mode 100755 testcases/kernel/containers/netns/nw_under_ns.sh
 delete mode 100644 testcases/kernel/containers/netns/readme
 delete mode 100755 testcases/kernel/containers/netns/runallnetworktests_child.sh
 delete mode 100755 testcases/kernel/containers/netns/runallnetworktests_parent.sh

diff --git a/runtest/containers b/runtest/containers
index de4197e..2dee944 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -23,15 +23,24 @@ mqns_03_clone mqns_03 -clone
 mqns_04 mqns_04
 mqns_04_clone mqns_04 -clone
 
-netns_crtchild netns_crtchild
-netns_two_children_ns netns_two_children_ns
-netns_crtchild_delchild netns_crtchild_delchild
-netns_par_chld_ipv6 netns_par_chld_ipv6
-netns_par_chld_ftp netns_par_chld_ftp.sh
 netns_netlink netns_netlink
-netns_devices netns_devices.sh
-netns_devices2 netns_devices2.sh
-netns_isolation netns_isolation.sh
+netns_breakns netns_breakns.sh ns_exec ipv4 netlink
+netns_breakns netns_breakns.sh ns_exec ipv6 netlink
+netns_breakns netns_breakns.sh ns_exec ipv4 ioctl
+netns_breakns netns_breakns.sh ns_exec ipv6 ioctl
+netns_breakns netns_breakns.sh ip ipv4 netlink
+netns_breakns netns_breakns.sh ip ipv6 netlink
+netns_breakns netns_breakns.sh ip ipv4 ioctl
+netns_breakns netns_breakns.sh ip ipv6 ioctl
+netns_comm netns_comm.sh ns_exec ipv4 netlink
+netns_comm netns_comm.sh ns_exec ipv6 netlink
+netns_comm netns_comm.sh ns_exec ipv4 ioctl
+netns_comm netns_comm.sh ns_exec ipv6 ioctl
+netns_comm netns_comm.sh ip ipv4 netlink
+netns_comm netns_comm.sh ip ipv6 netlink
+netns_comm netns_comm.sh ip ipv4 ioctl
+netns_comm netns_comm.sh ip ipv6 ioctl
+netns_sysfs netns_sysfs.sh
 
 shmnstest_none shmnstest none
 shmnstest_clone shmnstest clone
diff --git a/testcases/kernel/containers/README b/testcases/kernel/containers/README
index b618f97..0020938 100644
--- a/testcases/kernel/containers/README
+++ b/testcases/kernel/containers/README
@@ -46,31 +46,4 @@ utsname/*
 libclone/*
 	Contains the library API for clone() .
 netns/*
-        Contains the testcases related to the network NS tests. This tests uses
-the routes method to define the network namespaces.
-	The tests uses the library libclone/libnetns.a, netns/parentns.sh and
-netns/childns.sh scripts to define network namespace.
-
-To run your tests you can execute the runnetnstest.sh .
-
-To run the tests individually :
-
-For Ex: To access a container created
-
-1) You can comment the line in the childns.sh
-  'cleanup $sshpid $vnet1 '
-2)  run the script to create your first namespace.
-   ./crtchild
-3) Now you can login into the containers using
-   ssh -p 7890 root@192.168.0.182
-
-Also the same scripts parentns.sh and childns.sh can be used to
-create a container and write your testcases to test the namespace.
-
-Note:
-	This tests would use the following IPaddresses
-running sshd on PORT @ 7890 and @ 9876
-	192.168.0.181
-	192.168.0.182
-	192.168.0.183
-	192.168.0.184
+        Contains the testcases related to the network NS tests.
diff --git a/testcases/kernel/containers/netns/.gitignore b/testcases/kernel/containers/netns/.gitignore
index 65f96be..56237ec 100644
--- a/testcases/kernel/containers/netns/.gitignore
+++ b/testcases/kernel/containers/netns/.gitignore
@@ -1,8 +1 @@
-/netns_create_container
-/netns_crtchild
-/netns_crtchild_delchild
-/netns_par_chld_ftp
-/netns_par_chld_ipv6
-/netns_sysfsview
-/netns_two_children_ns
 /netns_netlink
diff --git a/testcases/kernel/containers/netns/Makefile b/testcases/kernel/containers/netns/Makefile
index eea0d88..3756a55 100644
--- a/testcases/kernel/containers/netns/Makefile
+++ b/testcases/kernel/containers/netns/Makefile
@@ -1,38 +1,27 @@
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
+# Copyright (c) International Business Machines  Corp., 2008
+# Copyright (c) 2015 Red Hat, Inc.
+#
+# This program is free software;  you can redistribute it and#or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Author:      Veerendra <veeren@linux.vnet.ibm.com>
 ################################################################################
 
-top_srcdir		?= ../../../..
+top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-INSTALL_TARGETS		:= *.sh netns_container_ftp.pl
-
-LDLIBS			+= -lclone
-
-MAKE_TARGETS		:= netns_create_container netns_crtchild \
-			   netns_crtchild_delchild netns_par_chld_ftp \
-			   netns_par_chld_ipv6 netns_sysfsview \
-			   netns_two_children_ns netns_netlink
-
-$(MAKE_TARGETS): %: common.o %.o
+LDLIBS                  := -lclone -lltp
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/netns/common.c b/testcases/kernel/containers/netns/common.c
deleted file mode 100644
index 16bb7bd..0000000
--- a/testcases/kernel/containers/netns/common.c
+++ /dev/null
@@ -1,130 +0,0 @@
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
-***************************************************************************/
-/*=========================================================================
-* This testcase creates the network namespace.
-* It creates veth pair veth8 & veth9. Also assigns IP addresses to the childNS.
-* Also it starts the sshd daemon @ port 7890
-*
-* Scripts Used: netns_parentns.sh netns_childns.sh
-*
-* Author:	  Veerendra <veeren@linux.vnet.ibm.com>
-=========================================================================*/
-
-#define _GNU_SOURCE
-
-#include <sys/utsname.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/syscall.h>
-#include <unistd.h>
-#include <signal.h>
-#include <string.h>
-#include <errno.h>
-#include <libgen.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "libclone.h"
-#include "test.h"
-#include "config.h"
-#include "common.h"
-
-#define PARENTNS_SCRIPT "netns_parentns.sh"
-#define CHILDNS_SCRIPT "netns_childns.sh"
-
-static int child_fn(void *c1);
-
-int crtchild(char *s1, char *s2)
-{
-	char *cmd[] = { "--", s1, s2, NULL };
-	execve("/bin/sh", cmd, __environ);
-	fprintf(stderr, "Failed to execve(%s, %s): %m\n", s1, s2);
-	return 1;
-}
-
-int create_net_namespace(char *p1, char *c1)
-{
-	int pid, status = 0, ret;
-	char par[FILENAME_MAX];
-	long int clone_flags = 0;
-
-	if (tst_kvercmp(2, 6, 19) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWPID not supported");
-
-	clone_flags |= CLONE_NEWNS;
-/* Enable other namespaces too optionally */
-#ifdef CLONE_NEWPID
-	clone_flags |= CLONE_NEWPID;
-#endif
-
-	pid = ltp_clone_quick(clone_flags, child_fn, (void *)c1);
-
-	if (pid == -1) {
-		perror("Failed to do clone...");
-		return -1;
-	}
-
-	/* We need to pass the child pid to the parentns.sh script */
-	sprintf(par, "%s %s %" PRId32, PARENTNS_SCRIPT, p1, pid);
-
-	ret = system(par);
-	status = WEXITSTATUS(ret);
-	if (ret == -1 || status != 0) {
-		tst_resm(TFAIL, "Error while running the script\n");
-		fflush(stdout);
-		tst_exit();
-	}
-	fflush(stdout);
-
-	ret = waitpid(pid, &status, __WALL);
-	status = WEXITSTATUS(status);
-	if (ret == -1 || status != 0) {
-		printf("Error: waitpid() returns %d, status %d\n", ret, status);
-	}
-
-	return status;
-}
-
-/* The function to be executed in the child namespace */
-int child_fn(void *c1)
-{
-	unsigned long flags = 0;
-#if HAVE_UNSHARE
-	int ret;
-#endif
-
-	/* Flags to unshare different Namespaces */
-	flags |= CLONE_NEWNS;
-	flags |= CLONE_NEWNET;
-	flags |= CLONE_NEWUTS;
-	flags |= CLONE_FS;
-
-	/* Unshare the network namespace in the child */
-#if HAVE_UNSHARE
-	ret = unshare(flags);
-	if (ret < 0) {
-		perror("Failed to unshare for netns...");
-		return 1;
-	}
-	return crtchild(CHILDNS_SCRIPT, c1);
-#else
-	printf("System doesn't support unshare.\n");
-	return -1;
-#endif
-}
diff --git a/testcases/kernel/containers/netns/common.h b/testcases/kernel/containers/netns/common.h
deleted file mode 100644
index db11d79..0000000
--- a/testcases/kernel/containers/netns/common.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
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
-***************************************************************************/
-#ifndef COMMON_H
-#define COMMON_H
-
-int crtchild(char *s1, char *s2);
-
-int create_net_namespace(char *p1, char *c1);
-
-#endif/*COMMON_H*/
diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
new file mode 100755
index 0000000..1dcacc2
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_breakns.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+#==============================================================================
+# Copyright (c) 2015 Red Hat, Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of version 2 the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Written by Matus Marhefka <mmarhefk@redhat.com>
+#
+#==============================================================================
+# File: netns_breakns.sh
+#=======================
+#
+# SYNOPSIS:
+# netns_breakns.sh <NS_EXEC_PROGRAM> <IP_VERSION> <COMM_TYPE>
+#
+# OPTIONS:
+#	* NS_EXEC_PROGRAM (ns_exec|ip)
+#		Program which will be used to enter and run other commands
+#		inside a network namespace.
+#	* IP_VERSION (ipv4|ipv6)
+#		Version of IP. (ipv4|ipv6)
+#	* COMM_TYPE (netlink|ioctl)
+#		Communication type between kernel and user space
+#		for basic setup: enabling and assigning IP addresses
+#		to the virtual ethernet devices. (Uses 'ip' command for netlink
+#		and 'ifconfig' for ioctl.)
+#
+# Tests communication with ip (uses netlink) and ifconfig (uses ioctl)
+# over a device which is not visible from the current network namespace.
+#
+# There are two test cases which are trying to set an ip address on the veth1
+# device which is not inside the network namespace referred to by NS_HANDLE0:
+# 1. using netlink (ip command).
+# 2. using ioctl (ifconfig command).
+#==============================================================================
+
+TCID=netns_breakns
+TST_TOTAL=2
+. netns_helper.sh
+
+# SETUP
+netns_setup $1 $2 $3 "192.168.0.2" "192.168.0.3" "fd00::2" "fd00::3"
+
+
+# TEST CASE #1
+$NS_EXEC $NS_HANDLE0 ip address add $IP1/$NETMASK dev veth1 2>/dev/null
+if [ $? -ne 0 ]; then
+	tst_resm TPASS "<$2> controlling device over netlink"
+else
+	tst_resm TFAIL "<$2> controlling device over netlink"
+fi
+
+
+# TEST CASE #2
+tst_check_cmds ifconfig
+$NS_EXEC $NS_HANDLE0 ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK 2>/dev/null
+if [ $? -ne 0 ]; then
+	tst_resm TPASS "<$2> controlling device over ioctl"
+else
+	tst_resm TFAIL "<$2> controlling device over ioctl"
+fi
+
+
+tst_exit
diff --git a/testcases/kernel/containers/netns/netns_ch_ftp.sh b/testcases/kernel/containers/netns/netns_ch_ftp.sh
deleted file mode 100755
index 1ec733b..0000000
--- a/testcases/kernel/containers/netns/netns_ch_ftp.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/bash
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-
-## This script checks that the parent namespace is reachable from the child
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>
-
-TCID=${TCID:-netns_ch_ftp.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    ping -q -c 2 $IP1 > /dev/null
-    if [ $? -ne 0 ] ; then
-        tst_resm TFAIL "Pinging parent NS from child : FAIL"
-        status=-1
-    else
-        debug "INFO: Pinging parent NS from child "
-        eval netns_container_ftp.pl $IP1
-        status=$?
-        if [ $status -ne 0 ] ; then
-            tst_resm TFAIL "ftp failed"
-            status=1
-        fi
-    fi
-    tst_timeout "echo $status > /tmp/FIFO6" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
diff --git a/testcases/kernel/containers/netns/netns_child.sh b/testcases/kernel/containers/netns/netns_child.sh
deleted file mode 100755
index fb88fb9..0000000
--- a/testcases/kernel/containers/netns/netns_child.sh
+++ /dev/null
@@ -1,43 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This script checks that the parent namespace is reachable from the child
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_child.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    ping -qc 2 $IP1 >  /dev/null
-
-    if [ $? = 0 ] ; then
-        tst_resm TINFO "PASS: Pinging ParentNS from ChildNS"
-        status=0
-    else
-        tst_resm TFAIL "FAIL: Unable to ping ParentNS from ChildNS"
-        status=1
-    fi
diff --git a/testcases/kernel/containers/netns/netns_child_1.sh b/testcases/kernel/containers/netns/netns_child_1.sh
deleted file mode 100755
index 85f380e..0000000
--- a/testcases/kernel/containers/netns/netns_child_1.sh
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/bash
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>
-
-# This script is trying to ping the Child2 from Child1
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_child_1.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-. netns_initialize.sh
-status=0
-
-    # Writing child PID number into /tmp/FIFO
-    tst_timeout "echo $$ > /tmp/FIFO2" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    # Reading device name from parent
-    vnet1=$(tst_timeout "cat /tmp/FIFO1" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: CHILD1: Network dev name received $vnet1";
-
-    # By now network is working
-    ifconfig $vnet1 $IP2$mask up > /dev/null 2>&1
-    ifconfig lo up
-
-    # Creating ssh session
-    /usr/sbin/sshd -p $PORT
-    if [ $? ]; then
-        debug "INFO: Started the sshd in CHILD1"
-        sshpid1=`ps -ef | grep "sshd -p $PORT" | awk '{ print $2 ; exit 0} ' `
-
-        ping -qc 2 $IP1 > /dev/null
-        if [ $? -ne 0 ] ; then
-            tst_resm TFAIL "FAIL: Unable to ping the Parent1 from Child1"
-            status=-1
-        fi
-    else
-        tst_resm TFAIL "FAIL: Unable to start sshd in child1"
-        status=-1
-    fi
-
-    # Waiting for CHILD2
-    ret=$(tst_timeout "cat /tmp/FIFO5" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    if [ "$ret" = "0" ]; then
-        # Pinging CHILD2 from CHILD1
-        debug "INFO: Trying to ping CHILD2..."
-        ping -qc 2 $IP4 > /dev/null
-        if [ $? -eq 0 ];
-        then
-            tst_resm TINFO "PASS: Child2 is pinging from CHILD1 !"
-        else
-            tst_resm TFAIL "FAIL: Unable to Ping Child2 from CHILD1 !"
-            status=-1
-        fi
-    else
-        tst_resm TFAIL "CHILD2 is unable to reach CHILD1"
-        status=-1
-    fi
-    cleanup $sshpid1 $vnet1
-    debug "INFO: ********End of Child-1 $0********"
-    exit $status
diff --git a/testcases/kernel/containers/netns/netns_child_2.sh b/testcases/kernel/containers/netns/netns_child_2.sh
deleted file mode 100755
index 1e16624..0000000
--- a/testcases/kernel/containers/netns/netns_child_2.sh
+++ /dev/null
@@ -1,89 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>
-
-# This script is pinging the child NS.
-
-TCID=${TCID:-netns_child_2.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-. netns_initialize.sh
-status=0
-
-    # Writing child PID number into /tmp/FIFO4
-    tst_timeout "echo $$ > /tmp/FIFO4" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    # Reading device name from parent
-    vnet2=$(tst_timeout "cat /tmp/FIFO3" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: CHILD2: Network dev name received $vnet2";
-
-    # By now networking is working
-    ifconfig $vnet2 $IP4$mask up 2> /dev/null
-    ifconfig lo up
-
-    # Creating ssh session
-    /usr/sbin/sshd -p $PORT2
-    if [ $? ]; then
-        debug "INFO: Started the sshd in CHILD2"
-        sshpid2=`ps -ef | grep "sshd -p $PORT2" | awk '{ print $2 ; exit 0} ' `
-
-        ping -qc 2 $IP3 > /dev/null
-        if [ $? -ne 0 ] ; then
-            tst_resm TFAIL "FAIL: Unable to ping Parent2 from Child2"
-            status=-1
-        fi
-    else
-        tst_resm TFAIL "FAIL: Unable to start sshd in child1"
-        status=-1
-    fi
-    # Pinging CHILD1 from CHILD2
-    debug "INFO: Trying to ping CHILD1..."
-
-    ping -qc 2 $IP2 > /dev/null
-    if [ $? -eq 0 ]; then
-        tst_resm TINFO "PASS: CHILD1 is pinging from CHILD2 ! "
-        # Using /tmp/FIFO5 to synchronize with CHILD1
-        tst_timeout "echo 0 > /tmp/FIFO5" $NETNS_TIMEOUT
-        if [ $? -ne 0 ]; then
-           tst_brkm TBROK "timeout reached!"
-        fi
-        sleep 2
-    else
-        tst_resm TFAIL "FAIL: Unable to ping Child1NS from Child2NS !"
-        tst_timeout "echo 1 > /tmp/FIFO5" $NETNS_TIMEOUT
-        if [ $? -ne 0 ]; then
-           tst_brkm TBROK "timeout reached!"
-        fi
-        status=-1
-    fi
-
-    cleanup $sshpid2 $vnet2
-    debug "INFO: ********End of Child-2 $0********"
-    exit $status
diff --git a/testcases/kernel/containers/netns/netns_child_propagate.sh b/testcases/kernel/containers/netns/netns_child_propagate.sh
deleted file mode 100755
index 420c324..0000000
--- a/testcases/kernel/containers/netns/netns_child_propagate.sh
+++ /dev/null
@@ -1,74 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This script propagates the child sysfs contents to be visible for parent
-# Also it will check the parent sysfs contents are visible.
-#Propagate child sys directory
-
-# The test case ID, the test case count and the total number of test case
-TCID=${TCID:-netns_child_propagate.sh}
-TST_TOTAL=1
-TST_COUNT=1
-#set -x
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    ret=0
-    PROPAGATE=$(tst_timeout "cat /tmp/FIFO4" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: CHILD propagated.."
-    mount -t sysfs none /sys || ret=1
-    mkdir -p /tmp/mnt/sys || ret=1
-    mount --bind /sys /tmp/mnt/sys > /dev/null || ret=1
-
-    if [ $ret -ne 0 ]; then
-        status=1
-        tst_resm TFAIL "error while doing bind mount"
-        exit $status
-    fi
-    #Capture childs sysfs contents
-    ls /sys/class/net > /tmp/child_sysfs
-    tst_timeout "echo 'propagated' > /tmp/FIFO5" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    #Capture parent sysfs in child
-    ls /tmp/par_sysfs/class/net > /tmp/parent_sysfs_in_child
-    diff /tmp/parent_sysfs_in_child /tmp/parent_sysfs > /dev/null 2>&1
-    if [ $? -eq 0 ]
-    then
-        tst_resm TINFO "Pass:Child is able to view parent sysfs"
-        status=0
-    else
-        tst_resm TFAIL "Fail:Child view of sysfs is not same as parent sysfs"
-        status=1
-    fi
-
-    #cleanup
-    rm -f /tmp/parent_sysfs_in_child /tmp/parent_sysfs
-    umount /tmp/mnt/sys
-    rm -rf /tmp/mnt  > /dev/null 2>&1 || true
diff --git a/testcases/kernel/containers/netns/netns_childipv6.sh b/testcases/kernel/containers/netns/netns_childipv6.sh
deleted file mode 100755
index f41dcc2..0000000
--- a/testcases/kernel/containers/netns/netns_childipv6.sh
+++ /dev/null
@@ -1,103 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-
-################################################################################
-# This test scripts passes the PID of the child NS to the parent NS.
-# Also it assigns the device address and starts the sshd daemon
-# It checks for basic network connection between parent and child.
-# It renames the network device of the child
-#
-# Arguments:    Accepts an argument 'script' and executes on top of this
-################################################################################
-#set -x
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_childipv6.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-.  netns_initialize.sh
-status=0
-
-    # Passing the PID of child
-    tst_timeout "echo $$ > /tmp/FIFO1" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    # waiting for the virt-eth devname and IPv6 addr from parent
-    vnet1=$(tst_timeout "cat /tmp/FIFO2" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    enable_veth_ipv6 $vnet1
-    vnet1_orig_status=$?
-
-    # Assigning the dev addresses
-    ifconfig $vnet1 $IP2/24 up > /dev/null 2>&1
-    ifconfig lo up
-    sleep 2
-
-    #starting the sshd inside the child NS
-    /usr/sbin/sshd -p $PORT
-    if [ $? = 0 ]; then
-        debug "INFO: started the sshd @ port no $PORT"
-        sshpid=`ps -ef | grep "sshd -p $PORT" | awk '{ print $2 ; exit 0} ' `
-    else
-        tst_resm TFAIL "Failed in starting ssh @ port $PORT"
-        status=1
-    fi
-
-    childIPv6=`ip -6 addr show dev $vnet1 | awk ' /inet6/ { print $2 } ' | awk -F"/" ' { print $1 } '`
-    tst_timeout "echo $childIPv6 >> /tmp/FIFO3" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    parIPv6=$(tst_timeout "cat /tmp/FIFO4" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then                       
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: Received the Ipv6 addr $parIPv6"
-
-    # checking if parent ns responding
-    ping6 -I $vnet1 -qc 2 $parIPv6 >/dev/null 2>&1
-           if [ $? = 0 ] ; then
-               tst_resm TINFO "IPv6: Pinging Parent from Child: PASS"
-            else
-               tst_resm TFAIL "IPv6: Pinging Parent from Child: FAIL"
-               status=1
-            fi
-    tst_timeout "echo $status > /tmp/FIFO6" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    if [ $vnet1_orig_status -eq 1 ];then
-       disable_veth_ipv6 $vnet1
-    fi
-
-    debug "INFO: Done with executing child script $0"
-    cleanup $sshpid $vnet1
-    exit $status
diff --git a/testcases/kernel/containers/netns/netns_childns.sh b/testcases/kernel/containers/netns/netns_childns.sh
deleted file mode 100755
index 7f196fb..0000000
--- a/testcases/kernel/containers/netns/netns_childns.sh
+++ /dev/null
@@ -1,99 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-
-################################################################################
-# This test scripts passes the PID of the child NS to the parent NS.
-# Also it assigns the device address and starts the sshd daemon
-# It checks for basic network connection between parent and child.
-#
-# Arguments:    Accepts an argument 'script' and executes on top of this
-################################################################################
-# set -x
-# The test case ID, the test case count and the total number of test case
-
-export TCID=${TCID:-netns_childns.sh}
-export TST_COUNT=1
-export TST_TOTAL=1
-. cmdlib.sh
-exists awk grep ip ping sshd
-. netns_initialize.sh
-status=0
-
-SSHD=`which sshd`
-
-if [ $# -eq 1 ] ; then
-    childscrpt=$1
-    debug "INFO: The script to be executed in child NS is $childscrpt"
-fi
-
-# Passing the PID of child
-tst_timeout "echo 'child ready' > /tmp/FIFO1" $NETNS_TIMEOUT
-if [ $? -ne 0 ]; then
-    tst_brkm TBROK "timeout reached!"
-fi
-
-# waiting for the device name from parent
-vnet1=$(tst_timeout "cat /tmp/FIFO2" $NETNS_TIMEOUT)
-if [ $? -ne 0 ]; then
-    tst_brkm TBROK "timeout reached!"
-fi
-debug "INFO: network dev name received $vnet1";
-# Assigning the dev addresses
-if ! ifconfig $vnet1 $IP2/24 up > /dev/null 2>&1 ; then
-    debug "Failed to make interface $vnet1 up in child....."
-fi
-
-ifconfig lo up
-sleep 2
-
-#starting the sshd inside the child NS
-if $SSHD -p $PORT; then
-    debug "INFO: started the sshd @ port no $PORT"
-    sshpid=`ps -ef | grep "sshd -p $PORT" | grep -v grep | awk '{ print $2 ; exit 0} ' `
-else
-    tst_resm TFAIL "Failed in starting ssh @ port $PORT"
-    cleanup $vnet1
-    status=1
-fi
-
-if [ $status -eq 0 ] ; then
-
-    # checking if parent ns responding
-    if ! ping -q -c 2 $IP1 > /dev/null ; then
-        tst_resm TFAIL "FAIL: ParentNS not responding"
-        status=1
-        cleanup $sshpid $vnet1
-        exit $status
-    fi
-
-    if [ -f "$childscrpt" ]; then
-        . "$childscrpt"
-    fi
-
-    cleanup $sshpid $vnet1
-    debug "INFO: Done with executing child script $0, status is $status"
-
-fi
-
-exit $status
diff --git a/testcases/kernel/containers/netns/netns_comm.sh b/testcases/kernel/containers/netns/netns_comm.sh
new file mode 100755
index 0000000..4a50c6c
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_comm.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+#==============================================================================
+# Copyright (c) 2015 Red Hat, Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of version 2 the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Written by Matus Marhefka <mmarhefk@redhat.com>
+#
+#==============================================================================
+# File: netns_comm.sh
+#====================
+#
+# SYNOPSIS:
+# netns_comm.sh <NS_EXEC_PROGRAM> <IP_VERSION> <COMM_TYPE>
+#
+# OPTIONS:
+#       * NS_EXEC_PROGRAM (ns_exec|ip)
+#               Program which will be used to enter and run other commands
+#               inside a network namespace.
+#       * IP_VERSION (ipv4|ipv6)
+#               Version of IP. (ipv4|ipv6)
+#	* COMM_TYPE (netlink|ioctl)
+#		Communication type between kernel and user space
+#		for basic setup: enabling and assigning IP addresses
+#		to the virtual ethernet devices. (Uses 'ip' command for netlink
+#		and 'ifconfig' for ioctl.)
+#
+# Tests that a separate network namespace can configure and communicate
+# over the devices it sees. Tests are done using netlink(7) ('ip' command)
+# or ioctl(2) ('ifconfig' command) for controlling devices.
+#
+# There are three test cases:
+# 1,2. communication over paired veth (virtual ethernet) devices
+#      from two different network namespaces (each namespace has
+#      one device)
+#   3. communication over the lo (localhost) device in a separate
+#      network namespace
+#==============================================================================
+
+TCID=netns_comm
+TST_TOTAL=3
+. netns_helper.sh
+
+# SETUP
+netns_setup $1 $2 $3 "192.168.0.2" "192.168.0.3" "fd00::2" "fd00::3"
+
+
+# TEST CASE #1
+$NS_EXEC $NS_HANDLE0 $tping -q -c2 -I veth0 $IP1 1>/dev/null
+if [ $? -eq 0 ]; then
+	tst_resm TPASS "<$2> configuration and communication over veth0"
+else
+	tst_resm TFAIL "<$2> configuration and communication over veth0"
+fi
+
+
+# TEST CASE #2
+$NS_EXEC $NS_HANDLE1 $tping -q -c2 -I veth1 $IP0 1>/dev/null
+if [ $? -eq 0 ]; then
+	tst_resm TPASS "<$2> configuration and communication over veth1"
+else
+	tst_resm TFAIL "<$2> configuration and communication over veth1"
+fi
+
+
+# TEST CASE #3
+case "$2" in
+ipv4) IP_LO="127.0.0.1" ;;
+ipv6) IP_LO="::1" ;;
+esac
+case "$3" in
+netlink)
+	$NS_EXEC $NS_HANDLE0 ip link set dev lo up || \
+		tst_brkm TBROK "enabling lo device failed"
+	;;
+ioctl)
+	$NS_EXEC $NS_HANDLE0 ifconfig lo up || \
+		tst_brkm TBROK "enabling lo device failed"
+	;;
+esac
+$NS_EXEC $NS_HANDLE0 $tping -q -c2 -I lo $IP_LO 1>/dev/null
+if [ $? -eq 0 ]; then
+	tst_resm TPASS "<$2> configuration and communication over localhost"
+else
+	tst_resm TFAIL "<$2> configuration and communication over localhost"
+fi
+
+
+tst_exit
diff --git a/testcases/kernel/containers/netns/netns_container_ftp.pl b/testcases/kernel/containers/netns/netns_container_ftp.pl
deleted file mode 100644
index 02a8300..0000000
--- a/testcases/kernel/containers/netns/netns_container_ftp.pl
+++ /dev/null
@@ -1,88 +0,0 @@
-#!/usr/bin/env perl
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-use File::Temp 'tempdir';
-use Net::FTP;
-use File::Path;
-
-if ($#ARGV == -1) {
-	print "usage: $0 host\n";
-	exit 1;
-}
-my $host =  $ARGV[0];
-
-my $newname;
-my $i = 0;
-my $kount = 51;
-my $file="junkfile";
-
-my $tmpdir = "/var/ftp";
-
-my $dir;
-$dir = tempdir("container_ftp.XXXXXXX", DIR => $tmpdir);
-if (!defined($dir)) {
-	push @ERRORS, "Failed to create a temporary directory: $!\n";
-	printerr();
-}
-if (chmod(0777, $dir) == 0) {
-	push @ERRORS, "Failed to change mode for temporary directory: $!\n";
-	printerr();
-}
-system("dd if=/dev/zero of=$dir/$file bs=512 count=10 > /dev/null 2>&1 ");
-
-while ( $i < $kount )
-{
-        $ftp=Net::FTP->new($host,Timeout=>240) or $newerr=1;
-        push @ERRORS, "Can't ftp to $host: $!\n" if $newerr;
-        printerr() if $newerr;
-
-        $ftp->login("anonymous","passwd") or $newerr=1;
-        push @ERRORS, "Can't login to $host: $!\n" if $newerr;
-        $ftp->quit if $newerr;
-        printerr() if $newerr;
-
-        $basedir = `basename "$dir"`;
-        chomp $basedir;
-        $ftp->cwd($basedir) or $newerr=1;
-        push @ERRORS, "Can't cd  $!\n" if $newerr;
-        $ftp->quit if $newerr;
-        printerr() if $newerr;
-
-        $newname = $file . "_" . $i ;
-        $ftp->get($file,$newname) or $newerr=1;
-        push @ERRORS, "Can't get file $file $!\n" if $newerr;
-        printerr() if $newerr;
-
-        $i++;
-        $ftp->quit;
-}
-
-sub printerr {
-	print "Error: ";
-	print @ERRORS;
-	exit 1;
-}
-
-END {
-	rmtree("$dir");
-}
diff --git a/testcases/kernel/containers/netns/netns_create_container.c b/testcases/kernel/containers/netns/netns_create_container.c
deleted file mode 100644
index a266496..0000000
--- a/testcases/kernel/containers/netns/netns_create_container.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*************************************************************************
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
-***************************************************************************/
-/* ============================================================================
-* This testcase creates the child container to test the tcp command testcases
-* inside the child namespace. The following program uses the library libclone
-* api to create the Network namespace container and may be removed to use the
-* containers management tools in future.
-*
-* The scripts runallnetworktests_parent.sh, runallnetworktests_child.sh, are
-* passed as the parameters which will be running in the parent and child
-* namespace respectively.
-*
-* Author: Sudhir Kumar <skumar@linux.vnet.ibm.com>   26/08/2008
-* ============================================================================*/
-
-#include <stdio.h>
-#include "common.h"
-
-const char *TCID = "create_container";
-
-int main(void)
-{
-	int status;
-	/*
-	 * The argument files contain the code to be run in the parent and
-	 * child network namespace container respectively
-	 */
-	status = create_net_namespace("runallnetworktests_parent.sh",
-				      "runallnetworktests_child.sh");
-	printf("Execution of all the network testcases under network"
-	       " namespace done. return value is %d\n", status);
-	return status;
-}
diff --git a/testcases/kernel/containers/netns/netns_crtchild.c b/testcases/kernel/containers/netns/netns_crtchild.c
deleted file mode 100644
index 8d9b68f..0000000
--- a/testcases/kernel/containers/netns/netns_crtchild.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*************************************************************************
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
-***************************************************************************/
-/* ============================================================================
-* This testcase uses the libnetns.c from the library to create network NS.
-* In libnetns.c it uses 2 scripts parentns.sh and childns.sh to create this.
-* After creating the NS, this program verifies that the network is reachable
-* from parent-NS to child-NS and vice-versa.
-*
-* Scripts Used: netns_parentns.sh, netns_childns.sh, netns_parent.sh, netns_child.sh.
-*
-* Author: Veerendra C <vechandr@in.ibm.com>
-*                      31/07/2008
-* =============================================================================*/
-
-#include "common.h"
-#include "netns_helper.h"
-
-#define IPROUTE_MIN_VER 80725
-
-const char *TCID = "netns_crtchild";
-
-static void setup(void)
-{
-	tst_require_root(NULL);
-	check_iproute(IPROUTE_MIN_VER);
-	check_netns();
-}
-
-int main(void)
-{
-	int status;
-
-	setup();
-	status = create_net_namespace("netns_parent.sh", "netns_child.sh");
-	if (status == 0)
-		tst_resm(TPASS, "create_net_namespace");
-	else
-		tst_resm(TFAIL, "create_net_namespace");
-	tst_exit();
-}
diff --git a/testcases/kernel/containers/netns/netns_crtchild_delchild.c b/testcases/kernel/containers/netns/netns_crtchild_delchild.c
deleted file mode 100644
index f46f2b3..0000000
--- a/testcases/kernel/containers/netns/netns_crtchild_delchild.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*************************************************************************
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
-***************************************************************************/
-/*========================================================================
-* This testcase uses the libnetns.c from the lib to create network NS1.
-* In libnetns.c it uses 2 scripts parentns.sh and childns.sh to create this.
-*
-* This testcase creates Network-NS NS1 and renames the net-dev of NS1 to veth4.
-* Then it kills the Network-NS, and checks the contents of parent sysfs.
-* The system should remain stable and also checks sysfs contents of parent NS.
-* It returns PASS on Success else returns FAIL.
-*
-* Scripts used: netns_parentns.sh, netns_childns.sh , netns_delchild.sh
-* netns_rename_net.sh
-*
-* Author: Veerendra C <vechandr@in.ibm.com>
-*                      31/07/2008
-* =========================================================================*/
-
-#include "common.h"
-#include "netns_helper.h"
-
-#define IPROUTE_MIN_VER 80725
-
-const char *TCID = "netns_crtchild_delchild";
-
-static void setup(void)
-{
-	tst_require_root(NULL);
-	check_iproute(IPROUTE_MIN_VER);
-	check_netns();
-}
-
-int main(void)
-{
-	int status;
-	setup();
-	status = create_net_namespace("netns_delchild.sh", "netns_rename_net.sh");
-	if (status == 0)
-		tst_resm(TPASS, "create_net_namespace");
-	else
-		tst_resm(TFAIL, "create_net_namespace");
-	tst_exit();
-}
diff --git a/testcases/kernel/containers/netns/netns_delchild.sh b/testcases/kernel/containers/netns/netns_delchild.sh
deleted file mode 100755
index ae83f0e..0000000
--- a/testcases/kernel/containers/netns/netns_delchild.sh
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This script deletes the child ns, and checks the device
-# returned to the parent ns.
-
-# Reading contents of the sys fs to file in Parent
-# set -x
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_delchild.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    sshpid=$(tst_timeout "cat /tmp/FIFO3" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-       tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: ssh pid is  $sshpid"
-    newnet=$(tst_timeout "cat /tmp/FIFO4" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: new dev is  $newnet"
-
-    if [ "$newnet" = "-1" ] ; then
-        status=-1
-    fi
-
-    ls /sys/class/net > /tmp/sys_b4_child_killed
-    sleep 2
-
-    debug "INFO: Deleting the child NS created.. "
-    debug "INFO: Killing processes $sshpid $pid"
-    kill -9 $sshpid $pid > /dev/null 2>&1
-    sleep 1
-
-    ls /sys/class/net > /tmp/sys_aftr_child_killed
-    diff -q /tmp/sys_b4_child_killed /tmp/sys_aftr_child_killed
-
-    if [ $? = 0 ] ; then
-        debug "INFO: No difference in the contents of sysfs after deleting the child"
-    else
-        grep -qw $newnet /tmp/sys_aftr_child_killed
-        if [ $? = 0 ]; then
-            debug "INFO: Device $newnet is moved to ParentNS"
-        else
-            debug "INFO: Device $newnet is moved under diff name in ParentNS"
-        fi
-    fi
-    # Cleanup
-    ip link delete $vnet0
-    rm -f /tmp/sys_b4_child_killed /tmp/sys_aftr_child_killed /tmp/FIFO6 > /dev/null
-
diff --git a/testcases/kernel/containers/netns/netns_devices.sh b/testcases/kernel/containers/netns/netns_devices.sh
deleted file mode 100755
index 750ffcc..0000000
--- a/testcases/kernel/containers/netns/netns_devices.sh
+++ /dev/null
@@ -1,117 +0,0 @@
-#!/bin/sh
-#==============================================================================
-# Copyright (c) 2014 Red Hat, Inc.
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of version 2 the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#==============================================================================
-# File: netns_devices.sh
-#
-# Tests that a separate network namespace can configure and communicate
-# over the devices it sees. Tests are done using ip command which uses
-# netlink(7) sockets to control devices. There are three test cases:
-# 1,2. communication over paired veth (virtual ethernet) devices
-#      from two different network namespaces (each namespace has
-#      one device)
-#   3. communication over the lo (localhost) device in a separate
-#      network namespace
-#
-
-TCID=netns_devices
-TST_TOTAL=3
-. test.sh
-. netns_helper.sh
-IP0=192.168.0.1
-IP1=192.168.0.2
-
-
-cleanup()
-{
-	# removes veth0 device (which also removes paired veth1 device)
-	ip netns exec myns0 ip link delete veth0
-	# removes the network namespace myns
-	ip netns del myns0
-	ip netns del myns1
-}
-
-
-# SETUP
-tst_require_root
-tst_check_cmds ip
-tst_check_iproute 111010
-TST_CLEANUP=cleanup
-
-# creates a new network namespace "myns0" (man 8 ip-netns)
-ip netns add myns0 || \
-	tst_brkm TBROK "unable to create a new network namespace (myns0)"
-
-# creates a new network namespace "myns1"
-ip netns add myns1 || \
-	tst_brkm TBROK "unable to create a new network namespace (myns1)"
-
-# creates a pair of virtual ethernet devices
-ip netns exec myns0 ip link add veth0 type veth peer name veth1 || \
-	tst_brkm TBROK "unable to create veth pair devices"
-
-# adds device veth1 to myns1 namespace
-ip netns exec myns0 ip link set veth1 netns myns1 || \
-	tst_brkm TBROK "unable to add device veth1 to the network namespace myns1"
-
-
-# setup for veth0 device (which is inside myns0 namespace)
-ip netns exec myns0 ip address add $IP0/24 dev veth0 || \
-	tst_brkm TBROK "adding address to veth0 failed"
-ip netns exec myns0 ip link set dev veth0 up || \
-	tst_brkm TBROK "enabling veth0 device failed"
-
-# setup for veth1 (which is inside myns1 namespace)
-ip netns exec myns1 ip address add $IP1/24 dev veth1 || \
-	tst_brkm TBROK "adding address to veth1 failed"
-ip netns exec myns1 ip link set dev veth1 up || \
-	tst_brkm TBROK "enabling veth1 device failed"
-
-
-# TEST CASE #1
-ip netns exec myns0 ping -q -c 2 -I veth0 $IP1 >/dev/null
-ret=$?
-if [ $ret -eq 0 ]; then
-	tst_resm TPASS "netlink configuration and communication over veth0 device"
-else
-	tst_resm TFAIL "netlink configuration and communication over veth0 device"
-fi
-
-
-# TEST CASE #2
-ip netns exec myns1 ping -q -c 2 -I veth1 $IP0 >/dev/null
-ret=$?
-if [ $ret -eq 0 ]; then
-	tst_resm TPASS "netlink configuration and communication over veth1 device"
-else
-	tst_resm TFAIL "netlink configuration and communication over veth1 device"
-fi
-
-
-# TEST CASE #3
-# enables lo device
-ip netns exec myns0 ip link set dev lo up || \
-	tst_brkm TBROK "enabling lo device failed"
-
-ip netns exec myns0 ping -q -c 2 -I lo 127.0.0.1 >/dev/null
-ret=$?
-if [ $ret -eq 0 ]; then
-	tst_resm TPASS "netlink configuration and communication over lo device"
-else
-	tst_resm TFAIL "netlink configuration and communication over lo device"
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/containers/netns/netns_devices2.sh b/testcases/kernel/containers/netns/netns_devices2.sh
deleted file mode 100755
index 8dfc6c6..0000000
--- a/testcases/kernel/containers/netns/netns_devices2.sh
+++ /dev/null
@@ -1,117 +0,0 @@
-#!/bin/sh
-#==============================================================================
-# Copyright (c) 2014 Red Hat, Inc.
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of version 2 the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#==============================================================================
-# File: netns_devices2.sh
-#
-# Tests that a separate network namespace can configure and communicate
-# over the devices it sees. Tests are done using ifconfig command which
-# uses ioctl(2) to control devices. There are three test cases:
-# 1,2. communication over paired veth (virtual ethernet) devices
-#      from two different network namespaces (each namespace has
-#      one device)
-#   3. communication over the lo (localhost) device in a separate
-#      network namespace
-#
-
-TCID=netns_devices2
-TST_TOTAL=3
-. test.sh
-. netns_helper.sh
-IP0=192.168.0.1
-IP1=192.168.0.2
-
-
-cleanup()
-{
-	# removes veth0 device (which also removes paired veth1 device)
-	ip netns exec myns0 ip link delete veth0
-	# removes the network namespace myns
-	ip netns del myns0
-	ip netns del myns1
-}
-
-
-# SETUP
-tst_require_root
-tst_check_cmds ip ifconfig
-tst_check_iproute 111010
-TST_CLEANUP=cleanup
-
-# creates a new network namespace "myns0" (man 8 ip-netns)
-ip netns add myns0 || \
-	tst_brkm TBROK "unable to create a new network namespace (myns0)"
-
-# creates a new network namespace "myns1"
-ip netns add myns1 || \
-	tst_brkm TBROK "unable to create a new network namespace (myns1)"
-
-# creates a pair of virtual ethernet devices
-ip netns exec myns0 ip link add veth0 type veth peer name veth1 || \
-	tst_brkm TBROK "unable to create veth pair devices"
-
-# adds device veth1 to myns1 namespace
-ip netns exec myns0 ip link set veth1 netns myns1 || \
-	tst_brkm TBROK "unable to add device veth1 to the network namespace myns1"
-
-
-# setup for veth0 device (which is inside myns0 namespace)
-ip netns exec myns0 ifconfig veth0 $IP0/24 || \
-	tst_brkm TBROK "adding address to veth0 failed"
-ip netns exec myns0 ifconfig veth0 up || \
-	tst_brkm TBROK "enabling veth0 device failed"
-
-# setup for veth1 (which is inside myns1 namespace)
-ip netns exec myns1 ifconfig veth1 $IP1/24 || \
-	tst_brkm TBROK "adding address to veth1 failed"
-ip netns exec myns1 ifconfig veth1 up || \
-	tst_brkm TBROK "enabling veth1 device failed"
-
-
-# TEST CASE #1
-ip netns exec myns0 ping -q -c 2 -I veth0 $IP1 >/dev/null
-ret=$?
-if [ $ret -eq 0 ]; then
-	tst_resm TPASS "ioctl configuration and communication over veth0 device"
-else
-	tst_resm TFAIL "ioctl configuration and communication over veth0 device"
-fi
-
-
-# TEST CASE #2
-ip netns exec myns1 ping -q -c 2 -I veth1 $IP0 >/dev/null
-ret=$?
-if [ $ret -eq 0 ]; then
-	tst_resm TPASS "ioctl configuration and communication over veth1 device"
-else
-	tst_resm TFAIL "ioctl configuration and communication over veth1 device"
-fi
-
-
-# TEST CASE #3
-# enables lo device
-ip netns exec myns0 ifconfig lo up || \
-	tst_brkm TBROK "enabling lo device failed"
-
-ip netns exec myns0 ping -q -c 2 -I lo 127.0.0.1 >/dev/null
-ret=$?
-if [ $ret -eq 0 ]; then
-	tst_resm TPASS "ioctl configuration and communication over lo device"
-else
-	tst_resm TFAIL "ioctl configuration and communication over lo device"
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
index 08fa3ff..2a331ae 100644
--- a/testcases/kernel/containers/netns/netns_helper.h
+++ b/testcases/kernel/containers/netns/netns_helper.h
@@ -1,27 +1,26 @@
 /*
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
-* Author: Veerendra C <vechandr@in.ibm.com>
-*
-* Net namespaces were introduced around 2.6.25.  Kernels before that,
-* assume they are not enabled.  Kernels after that, check for -EINVAL
-* when trying to use CLONE_NEWNET and CLONE_NEWNS.
-***************************************************************************/
+ * Copyright (c) International Business Machines Corp., 2008
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Veerendra C <vechandr@in.ibm.com>
+ *
+ * Net namespaces were introduced around 2.6.25.  Kernels before that,
+ * assume they are not enabled.  Kernels after that, check for -EINVAL
+ * when trying to use CLONE_NEWNET and CLONE_NEWNS.
+ ***************************************************************************/
 
 #define _GNU_SOURCE
-
 #include <sched.h>
 #include "config.h"
 #include "libclone.h"
diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index 70415d2..2b0623d 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
-#
+#==============================================================================
 # Copyright (c) Linux Test Project, 2014
+# Copyright (c) 2015 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -12,14 +13,52 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# This is a LTP shell test library for iproute.
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#==============================================================================
+# File: netns_helper.sh
+#=======================
 #
 
 . test.sh
+TST_CLEANUP=netns_ns_exec_cleanup
+
+# Set to 1 only for test cases using ifconfig (ioctl).
+USE_IFCONFIG=0
+
+
+##
+# Variables which can be used in test cases (set by netns_setup() function):
+###############################################################################
+# Use in test cases to execute commands inside a namespace. Set to 'ns_exec' or
+# 'ip netns exec' command according to NS_EXEC_PROGRAM argument specified in
+# netns_setup() function call.
+NS_EXEC=""
+
+# IP addresses of veth0 (IP0) and veth1 (IP1) devices (ipv4/ipv6 variant
+# is determined according to the IP_VERSION argument specified in netns_setup()
+# function call.
+IP0=""
+IP1=""
+NETMASK=""
+
+# 'ping' or 'ping6' according to the IP_VERSION argument specified
+# in netns_setup() function call.
+tping=""
+
+# Network namespaces handles for manipulating and executing commands inside
+# namespaces. For 'ns_exec' handles are PIDs of daemonized processes running
+# in namespaces.
+NS_HANDLE0=""
+NS_HANDLE1=""
+
+# Adds "inet6 add" to the 'ifconfig' arguments which is required for the ipv6
+# version. Always use with 'ifconfig', even if ipv4 version of a test case is
+# used, in which case IFCONF_IN6_ARG will be empty string. Usage:
+# ifconfig <device> $IFCONF_IN6_ARG IP/NETMASK
+IFCONF_IN6_ARG=""
+###############################################################################
+
 
 tst_check_iproute()
 {
@@ -37,3 +76,229 @@ tst_check_iproute()
 			"The commands in iproute tools do not support required objects"
 	fi
 }
+
+##
+# Sets up global variables which can be used in test cases (documented above),
+# creates two network namespaces and a pair of virtual ethernet devices, each
+# device in one namespace. Each device is then enabled and assigned an IP
+# address according to the function parameters. IFCONF_IN6_ARG variable is set
+# only if ipv6 variant of test case is used (determined by IP_VERSION argument).
+#
+# SYNOPSIS:
+# netns_setup <NS_EXEC_PROGRAM> <IP_VERSION> <COMM_TYPE> <IP4_VETH0>
+#             <IP4_VETH1> <IP6_VETH0> <IP6_VETH1>
+#
+# OPTIONS:
+#	* NS_EXEC_PROGRAM (ns_exec|ip)
+#		Program which will be used to enter and run other commands
+#		inside a network namespace.
+#	* IP_VERSION (ipv4|ipv6)
+#		Version of IP. (ipv4|ipv6)
+#	* COMM_TYPE (netlink|ioctl)
+#		Communication type between kernel and user space
+#		for enabling and assigning IP addresses to the virtual
+#		ethernet devices. Uses 'ip' command for netlink and 'ifconfig'
+#		for ioctl. (If set to ioctl, function also checks the existance
+#		of the 'ifconfig' command.)
+#	* IP4_VETH0, IP4_VETH1
+#		IPv4 addresses for veth0 and veth1 devices.
+#	* IP6_VETH0, IP6_VETH1
+#		IPv6 addresses for veth0 and veth1 devices.
+#
+# On success function returns, on error tst_brkm is called and TC is terminated.
+netns_setup()
+{
+	tst_require_root
+	tst_check_cmds ip
+
+	case "$1" in
+	ns_exec)
+		netns_ns_exec_setup
+		TST_CLEANUP=netns_ns_exec_cleanup
+		;;
+	ip)
+		netns_ip_setup
+		TST_CLEANUP=netns_ip_cleanup
+		;;
+	*)
+		tst_brkm TBROK \
+		"first argument must be a program used to enter a network namespace (ns_exec|ip)"
+		;;
+	esac
+
+	case "$3" in
+	netlink)
+		;;
+	ioctl)
+		USE_IFCONFIG=1
+		tst_check_cmds ifconfig
+		;;
+	*)
+		tst_brkm TBROK \
+		"third argument must be a comm. type between kernel and user space (netlink|ioctl)"
+		;;
+	esac
+
+	if [ -z "$4" ]; then
+		tst_brkm TBROK "fourth argument must be the IPv4 address for veth0"
+	fi
+	if [ -z "$5" ]; then
+		tst_brkm TBROK "fifth argument must be the IPv4 address for veth1"
+	fi
+	if [ -z "$6" ]; then
+		tst_brkm TBROK "sixth argument must be the IPv6 address for veth0"
+	fi
+	if [ -z "$7" ]; then
+		tst_brkm TBROK "seventh argument must be the IPv6 address for veth1"
+	fi
+
+	case "$2" in
+	ipv4)
+		IP0=$4; IP1=$5
+		tping="ping"; NETMASK=24
+		;;
+	ipv6)
+		IFCONF_IN6_ARG="inet6 add"
+		IP0=$6; IP1=$7;
+		tping="ping6"; NETMASK=64
+		;;
+	*)
+		tst_brkm TBROK "second argument must be an ip version (ipv4|ipv6)"
+		;;
+	esac
+
+	netns_set_ip
+	tst_resm TINFO "NS interaction: $1 | devices setup: $3"
+}
+
+##
+# Sets up NS_EXEC to use 'ns_exec', creates two network namespaces and stores
+# their handles into NS_HANDLE0 and NS_HANDLE1 variables (in this case handles
+# are PIDs of daemonized processes running in these namespaces). Virtual
+# ethernet device is then created for each namespace.
+netns_ns_exec_setup()
+{
+	NS_EXEC="ns_exec"
+
+	NS_HANDLE0=$(ns_create net)
+	if [ $? -eq 1 ]; then
+		tst_resm TINFO "$NS_HANDLE0"
+		tst_brkm TBROK "unable to create a new network namespace"
+	fi
+
+	NS_HANDLE1=$(ns_create net)
+	if [ $? -eq 1 ]; then
+		tst_resm TINFO "$NS_HANDLE1"
+		tst_brkm TBROK "unable to create a new network namespace"
+	fi
+
+	$NS_EXEC $NS_HANDLE0 ip link add veth0 type veth peer name veth1 || \
+		tst_brkm TBROK "unable to create veth pair devices"
+
+	$NS_EXEC $NS_HANDLE0 ns_ifmove veth1 $NS_HANDLE1 || \
+		tst_brkm TBROK "unable to add device veth1 to the separate network namespace"
+}
+
+##
+# Sets up NS_EXEC to use 'ip netns exec', creates two network namespaces
+# and stores their handles into NS_HANDLE0 and NS_HANDLE1 variables. Virtual
+# ethernet device is then created for each namespace.
+netns_ip_setup()
+{
+	tst_check_iproute 111010
+	NS_EXEC="ip netns exec"
+
+	NS_HANDLE0=tst_net_ns0
+	NS_HANDLE1=tst_net_ns1
+
+	ip netns del $NS_HANDLE0 2>/dev/null
+	ip netns del $NS_HANDLE1 2>/dev/null
+
+	ip netns add $NS_HANDLE0 || \
+		tst_brkm TBROK "unable to create a new network namespace"
+	ip netns add $NS_HANDLE1 || \
+		tst_brkm TBROK "unable to create a new network namespace"
+
+	$NS_EXEC $NS_HANDLE0 ip link add veth0 type veth peer name veth1 || \
+		tst_brkm TBROK "unable to create veth pair devices"
+
+	$NS_EXEC $NS_HANDLE0 ip link set veth1 netns $NS_HANDLE1 || \
+		tst_brkm TBROK "unable to add device veth1 to the separate network namespace"
+}
+
+##
+# Enables virtual ethernet devices and assigns IP addresses for both
+# of them (IPv4/IPv6 variant is decided by netns_setup() function).
+netns_set_ip()
+{
+	local state
+	local counter
+
+	if [ -z "$NS_EXEC" ]; then
+		tst_brkm TBROK "netns_setup() function must be called first"
+	fi
+
+	# This applies only for ipv6 variant:
+	# Do not accept Router Advertisements (accept_ra) and do not use
+	# Duplicate Address Detection (accept_dad) which uses Neighbor
+	# Discovery Protocol - the problem is that until DAD can confirm that
+	# there is no other host with the same address, the address is
+	# considered to be "tentative" (attempts to bind() to the address fail
+	# with EADDRNOTAVAIL) which may cause problems for tests using ipv6.
+	echo 0 | $NS_EXEC $NS_HANDLE0 \
+		tee /proc/sys/net/ipv6/conf/veth0/accept_dad \
+		/proc/sys/net/ipv6/conf/veth0/accept_ra >/dev/null
+	echo 0 | $NS_EXEC $NS_HANDLE1 \
+		tee /proc/sys/net/ipv6/conf/veth1/accept_dad \
+		/proc/sys/net/ipv6/conf/veth1/accept_ra >/dev/null
+
+	case $USE_IFCONFIG in
+	1)
+		$NS_EXEC $NS_HANDLE0 ifconfig veth0 $IFCONF_IN6_ARG $IP0/$NETMASK ||
+			tst_brkm TBROK "adding address to veth0 failed"
+		$NS_EXEC $NS_HANDLE1 ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK ||
+			tst_brkm TBROK "adding address to veth1 failed"
+		$NS_EXEC $NS_HANDLE0 ifconfig veth0 up ||
+			tst_brkm TBROK "enabling veth0 device failed"
+		$NS_EXEC $NS_HANDLE1 ifconfig veth1 up ||
+			tst_brkm TBROK "enabling veth1 device failed"
+		;;
+	*)
+		$NS_EXEC $NS_HANDLE0 ip address add $IP0/$NETMASK dev veth0 ||
+			tst_brkm TBROK "adding address to veth0 failed"
+		$NS_EXEC $NS_HANDLE1 ip address add $IP1/$NETMASK dev veth1 ||
+			tst_brkm TBROK "adding address to veth1 failed"
+		$NS_EXEC $NS_HANDLE0 ip link set veth0 up ||
+			tst_brkm TBROK "enabling veth0 device failed"
+		$NS_EXEC $NS_HANDLE1 ip link set veth1 up ||
+			tst_brkm TBROK "enabling veth1 device failed"
+		;;
+	esac
+}
+
+netns_ns_exec_cleanup()
+{
+	if [ -z "$NS_EXEC" ]; then
+		return
+	fi
+
+	# removes veth0 device (which also removes the paired veth1 device)
+	$NS_EXEC $NS_HANDLE0 ip link delete veth0
+
+	kill -9 $NS_HANDLE0 2>/dev/null
+	kill -9 $NS_HANDLE1 2>/dev/null
+}
+
+
+netns_ip_cleanup()
+{
+	if [ -z "$NS_EXEC" ]; then
+		return
+	fi
+
+	# removes veth0 device (which also removes the paired veth1 device)
+	$NS_EXEC $NS_HANDLE0 ip link delete veth0
+
+	ip netns del $NS_HANDLE0 2>/dev/null
+	ip netns del $NS_HANDLE1 2>/dev/null
+}
diff --git a/testcases/kernel/containers/netns/netns_initialize.sh b/testcases/kernel/containers/netns/netns_initialize.sh
deleted file mode 100755
index d44a02b..0000000
--- a/testcases/kernel/containers/netns/netns_initialize.sh
+++ /dev/null
@@ -1,152 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This scripts contains the IP addr, PortNum of sshd
-# to be used and cleanup functions.
-# set -x
-
-export TCID=${TCID:-initialize}
-export TST_TOTAL=1
-export TST_COUNT=1
-
-. test.sh
-
-TEST_SUBNET=${TEST_SUBNET:=192.168.0}
-i=1
-while [ $i -le 4 ] ; do
-    eval "IP${i}=\"$TEST_SUBNET.18$i\""
-    : $(( i += 1 ))
-done
-mask=/24
-PORT=7890
-PORT2=9876
-DEBUG=0
-
-# Maximum amount of time (in seconds) to wait for FIFO read/write operations
-NETNS_TIMEOUT=60
-
-# set the LTPROOT directory
-cd "$(dirname "$0")"
-if [ -n "${LTPROOT:-}" ]; then
-    FS_BIND=${LTPROOT}/testcases/bin/smount
-    if [ -f $FS_BIND ] ; then
-        smount=$FS_BIND
-    fi
-else
-    tst_resm TFAIL "Please set the LTP root env variable, and retry again"
-    exit 1
-fi
-
-i=1
-while [ $i -le 6 ] ; do
-    mkfifo /tmp/FIFO$i 2> /dev/null
-    : $(( i += 1 ))
-done
-
-netdev=`ip addr show | awk '/^[0-9]*:.*UP/ { a=$2 } /inet / { b=$2 ; \
-        if ( a !~ /lo/  && b ! NULL ) {  print a ; exit 0 } } ' `
-netdev=`basename $netdev ":"`
-if [ -z "$netdev" ] ; then
-    tst_resm  TINFO "Not able to determine the ethernet dev name"
-    exit 1
-fi
-
-# copying the values for restoring it later.
-ipfwd=`cat /proc/sys/net/ipv4/ip_forward`
-if [ -f "/proc/sys/net/ipv4/conf/$netdev/proxy_arp" ] ; then
-    arpproxy=`cat /proc/sys/net/ipv4/conf/$netdev/proxy_arp`
-else
-    arpproxy=0
-fi
-
-cleanup()
-{
-    if [ $# -eq 2 ]; then
-        pid=$1
-        netdev=$2
-    fi
-
-    debug "INFO: doing cleanup operation "
-    # Delete the veth pair:
-    (ip link delete $netdev) 2> /dev/null
-    sleep 1
-
-    #Restoring the orignial values .
-    echo "$ipfwd" > /proc/sys/net/ipv4/ip_forward
-    if [ -f /proc/sys/net/ipv4/conf/$netdev/proxy_arp ] ; then
-        echo $arpproxy > /proc/sys/net/ipv4/conf/$netdev/proxy_arp
-    fi
-    ( kill -s KILL $pid ) 2> /dev/null
-    rm -f /tmp/FIFO1 /tmp/FIFO2 /tmp/FIFO3 /tmp/FIFO4 /tmp/FIFO5 /tmp/FIFO6
-    rm -f /tmp/net1 /tmp/net2 || true
-}
-
-debug()
-{
-    [ "$DEBUG" = 1 ] && echo $1
-}
-
-create_veth()
-{
-    ip link show > /tmp/net1
-    ip link add type veth
-    sleep 1
-    ip link show > /tmp/net2
-    eval `diff /tmp/net1 /tmp/net2 | awk -F": "  '/^> [0-9]*:/ { print "dev" i+0 "=" $2; i++  }'`
-}
-
-# return 1 if disabled originally, 0 for enabled originally.
-enable_veth_ipv6()
-{
-    local veth=$1
-    local veth_ipv6_status=$(cat /proc/sys/net/ipv6/conf/$veth/disable_ipv6)
-    if [ -z "$veth_ipv6_status" ];then
-        tst_resm TFAIL "Error: cat /proc/sys/net/ipv6/conf/$veth/disable_ipv6"\
-            "failed"
-        exit 1
-    elif [ "$veth_ipv6_status" = "1" ]; then
-        echo 0 > /proc/sys/net/ipv6/conf/$veth/disable_ipv6
-        if [ $? -ne 0 ];then
-            tst_resm TFAIL "Error: set " \
-                "/proc/sys/net/ipv6/conf/$veth/disable_ipv6 to 0 failed"
-            exit 1
-        fi
-        return 1
-    else
-        return 0
-    fi
-}
-
-disable_veth_ipv6()
-{
-    local veth=$1
-    veth_exist=$(ip a | grep $veth)
-    if [ -n "$veth_exist" ]; then
-        echo 1 > /proc/sys/net/ipv6/conf/$veth/disable_ipv6
-        if [ $? -ne 0 ];then
-            tst_resm TFAIL "Error: set " \
-                "/proc/sys/net/ipv6/conf/$veth/disable_ipv6 to 1 failed"
-            exit 1
-        fi
-    fi
-}
diff --git a/testcases/kernel/containers/netns/netns_isolation.sh b/testcases/kernel/containers/netns/netns_isolation.sh
deleted file mode 100755
index 78dc081..0000000
--- a/testcases/kernel/containers/netns/netns_isolation.sh
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/sh
-#==============================================================================
-# Copyright (c) 2014 Red Hat, Inc.
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of version 2 the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#==============================================================================
-# File: netns_isolation.sh
-#
-# Tests communication with ifconfig (uses ioctl), ip (uses netlink)
-# and ping over a device which is not visible from the current network
-# namespace (this communication should not be possible).
-#
-
-TCID=netns_isolation
-TST_TOTAL=3
-. test.sh
-. netns_helper.sh
-IP=192.168.0.2
-
-
-cleanup()
-{
-	# removes veth0 device (which also removes paired veth1 device)
-	ip netns exec myns0 ip link delete veth0
-	# removes the network namespace myns
-	ip netns del myns0
-	ip netns del myns1
-}
-
-
-# SETUP
-tst_require_root
-tst_check_cmds ip
-tst_check_iproute 111010
-TST_CLEANUP=cleanup
-
-
-# creates a new network namespace "myns0" (man 8 ip-netns)
-ip netns add myns0 || \
-	tst_brkm TBROK "unable to create a new network namespace (myns0)"
-
-# creates a new network namespace "myns1"
-ip netns add myns1 || \
-	tst_brkm TBROK "unable to create a new network namespace (myns1)"
-
-# creates a pair of virtual ethernet devices
-ip netns exec myns0 ip link add veth0 type veth peer name veth1 || \
-	tst_brkm TBROK "unable to create veth pair devices"
-
-# adds device veth1 to myns1 namespace
-ip netns exec myns0 ip link set veth1 netns myns1 || \
-	tst_brkm TBROK "unable to add device veth1 to the network namespace myns1"
-
-
-# TEST CASE #1
-# setup an ip address on the veth1 device which is not visible
-# from the "myns0" network namespace using ip (netlink)
-ip netns exec myns0 ip address add $IP dev veth1 2>/dev/null
-ret=$?
-if [ $ret -ne 0 ]; then
-	tst_resm TPASS "controlling a device from a separate NETNS over netlink not possible"
-else
-	tst_resm TFAIL "controlling a device from a separate NETNS over netlink possible"
-fi
-
-
-# TEST CASE #2
-# ping over the veth1 device which is not visible from the "myns0"
-# network namespace
-ip netns exec myns0 ping -q -c 2 -I veth1 $IP 2>/dev/null
-ret=$?
-if [ $ret -ne 0 ]; then
-	tst_resm TPASS "communication over a device from a separate NETNS not possible"
-else
-	tst_resm TFAIL "communication over a device from a separate NETNS possible"
-fi
-
-
-# TEST CASE #3
-# setup an ip address on the veth1 device which is not visible
-# from the "myns0" network namespace using ifconfig (ioctl)
-tst_check_cmds ifconfig
-ip netns exec myns0 ifconfig veth1 $IP 2>/dev/null
-ret=$?
-if [ $ret -ne 0 ]; then
-	tst_resm TPASS "ioctl on a device from a separate NETNS not possible"
-else
-	tst_resm TFAIL "ioctl on a device from a separate NETNS possible"
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/containers/netns/netns_par_chld_ftp.c b/testcases/kernel/containers/netns/netns_par_chld_ftp.c
deleted file mode 100644
index d88780c..0000000
--- a/testcases/kernel/containers/netns/netns_par_chld_ftp.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*************************************************************************
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
-***************************************************************************/
-/* ============================================================================
-* This testcase uses the libnetns.c from the library to create network NS.
-* In libnetns.c it uses 2 scripts parentns.sh and childns.sh to create this.
-* After creating the NS, this program verifies that the network is reachable
-* from parent-NS to child-NS and vice-versa.
-*
-* Scripts Used: netns_parentns.sh, netns_childns.sh, netns_par_ftp.sh,
-* netns_ch_ftp.sh, netns_container_ftp.pl
-*
-* Author: Veerendra C <vechandr@in.ibm.com>
-*                      31/07/2008
-* =============================================================================*/
-
-#include "common.h"
-#include "netns_helper.h"
-
-#define IPROUTE_MIN_VER 80725
-
-const char *TCID = "netns_par_chld_ftp";
-
-static void setup(void)
-{
-	tst_require_root(NULL);
-	check_iproute(IPROUTE_MIN_VER);
-	check_netns();
-}
-
-int main(void)
-{
-	int status;
-
-	setup();
-
-	status = create_net_namespace("netns_par_ftp.sh", "netns_ch_ftp.sh");
-	if (status == 0)
-		tst_resm(TPASS, "create_net_namespace");
-	else
-		tst_resm(TFAIL, "create_net_namespace");
-	tst_exit();
-}
diff --git a/testcases/kernel/containers/netns/netns_par_chld_ftp.sh b/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
deleted file mode 100755
index 67b86bb..0000000
--- a/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-export TCID=${TCID:-netns_par_chld_ftp.sh}
-export TST_COUNT=1
-export TST_TOTAL=1
-
-. test.sh
-. daemonlib.sh
-
-flag=0
-
-status_daemon vsftpd
-if [ $? -ne 0 ]; then
-	start_daemon vsftpd
-	if [ $? -ne 0 ]; then
-		TST_CLEANUP=""
-		tst_brkm TCONF "Can't start vsftp"
-	fi
-	flag=1
-fi
-
-netns_par_chld_ftp &
-tst_record_childstatus $!
-
-if [ $flag -eq 1 ]; then
-	stop_daemon vsftpd
-fi
-
-tst_exit
diff --git a/testcases/kernel/containers/netns/netns_par_chld_ipv6.c b/testcases/kernel/containers/netns/netns_par_chld_ipv6.c
deleted file mode 100644
index b78537e..0000000
--- a/testcases/kernel/containers/netns/netns_par_chld_ipv6.c
+++ /dev/null
@@ -1,119 +0,0 @@
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
-***************************************************************************/
-/*=========================================================================
-* This testcase creates the network namespace.
-* It creates veth pair . Also assigns IP addresses to the childNS.
-* Also it starts the sshd daemon @ port 7890
-*
-* Scripts Used: netns_paripv6.sh childipv6.sh
-*
-* Author: Veerendra C <vechandr@in.ibm.com>
-*                      31/07/2008
-=========================================================================*/
-
-#define _GNU_SOURCE
-
-#include <sys/utsname.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include "libclone.h"
-#include <sched.h>
-#include <sys/syscall.h>
-#include <unistd.h>
-#include <signal.h>
-#include <string.h>
-#include <errno.h>
-#include <libgen.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "config.h"
-#include "common.h"
-#include "netns_helper.h"
-
-char *TCID = "netns_ipv6";
-int TST_TOTAL = 1;
-
-#define IPROUTE_MIN_VER 80725
-#define PARENT_SCRIPT "netns_paripv6.sh"
-#define CHILD_SCRIPT "netns_childipv6.sh"
-
-static void setup(void)
-{
-	tst_require_root(NULL);
-	check_iproute(IPROUTE_MIN_VER);
-	check_netns();
-}
-
-int main(void)
-{
-	int pid, status = 0, ret;
-	long int flags = 0;
-
-	setup();
-
-	flags |= CLONE_NEWNS;
-	flags |= CLONE_NEWNET;
-
-	if (tst_kvercmp(2, 6, 19) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWPID not supported");
-
-	if ((pid = fork()) == 0) {
-
-		// Child.
-#if HAVE_UNSHARE
-		ret = unshare(flags);
-		if (ret < 0) {
-			perror("unshare");
-			tst_brkm(TFAIL,
-				 NULL,
-				 "Error:Unshare syscall failed for network namespace");
-		}
-#else
-		tst_resm(TCONF, "System doesn't have unshare support");
-#endif
-		if (crtchild(CHILD_SCRIPT, NULL) != 0) {
-			tst_brkm(TFAIL, NULL, "Failed running child script");
-		}
-	} else {
-
-		//parent
-		ret = system(PARENT_SCRIPT);
-		status = WEXITSTATUS(ret);
-		if (ret == -1 || status != 0) {
-			tst_resm(TFAIL,
-				 "Error: While running the IPv6 tests between \
-parent & child NS");
-			fflush(stdout);
-			tst_exit();
-		}
-		fflush(stdout);
-
-		ret = waitpid(pid, &status, __WALL);
-		status = WEXITSTATUS(status);
-		if (status != 0 || ret == -1) {
-			tst_brkm(TFAIL, NULL,
-				 "waitpid() returns %d, errno %d", ret,
-				 errno);
-		}
-		tst_resm(TPASS, "par child ipv6");
-		tst_exit();
-	}
-	tst_exit();
-}
diff --git a/testcases/kernel/containers/netns/netns_par_ftp.sh b/testcases/kernel/containers/netns/netns_par_ftp.sh
deleted file mode 100755
index 848d051..0000000
--- a/testcases/kernel/containers/netns/netns_par_ftp.sh
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This script checks whether child NS is reachable from parent NS.
-#set -x
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-par_ftp.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    ping -q -c 2 $IP2 > /dev/null
-
-    if [ $? = 0 ] ; then
-        tst_resm TINFO "Pinging ChildNS from ParentNS"
-	status=0
-    else
-        tst_resm TFAIL "Error: Unable to ping ChildNS from ParentNS"
-        status=-1
-    fi
-    stat=$(tst_timeout "cat /tmp/FIFO6" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    if [ -z "$stat" ]; then
-        stat="-1"
-    fi
-    if [ "$stat" != "0" ] ; then
-        status=$(expr "$stat")
-    fi
-
-    exit $status
diff --git a/testcases/kernel/containers/netns/netns_parent.sh b/testcases/kernel/containers/netns/netns_parent.sh
deleted file mode 100755
index 86ddad8..0000000
--- a/testcases/kernel/containers/netns/netns_parent.sh
+++ /dev/null
@@ -1,42 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This script checks whether child NS is reachable from parent NS.
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_parent.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    ping -q -c 2 $IP2 > /dev/null
-    if [ $? = 0 ] ; then
-        tst_resm TINFO "PASS: Pinging ChildNS from ParentNS"
-        status=0
-    else
-        tst_resm TFAIL "FAIL: Unable to ping ChildNS from ParentNS"
-        status=-1
-    fi
diff --git a/testcases/kernel/containers/netns/netns_parent_1.sh b/testcases/kernel/containers/netns/netns_parent_1.sh
deleted file mode 100755
index 9398459..0000000
--- a/testcases/kernel/containers/netns/netns_parent_1.sh
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This testcase creates the net devices
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_parent_1.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    . netns_initialize.sh
-    echo 1 > /proc/sys/net/ipv4/ip_forward
-    echo 1 > /proc/sys/net/ipv4/conf/$netdev/proxy_arp
-    create_veth
-    vnet0=$dev0
-    vnet1=$dev1
-    if [ -z "$vnet0" -o -z "$vnet1" ] ; then
-        tst_resm TFAIL  "Error: unable to create veth pair in $0"
-        exit 1
-    else
-        debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
-    fi
-
-    ifconfig $vnet0 $IP1$mask up > /dev/null 2>&1
-    route add -host $IP2 dev $vnet0
-    echo 1 > /proc/sys/net/ipv4/conf/$vnet0/proxy_arp
-
-    pid=$(tst_timeout "cat /tmp/FIFO2" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: The pid of CHILD1 is $pid"
-    ip link set $vnet1 netns $pid
-    tst_timeout "echo $vnet1 > /tmp/FIFO1" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    debug "INFO: PARENT_1: End of $0"
-    exit 0
diff --git a/testcases/kernel/containers/netns/netns_parent_2.sh b/testcases/kernel/containers/netns/netns_parent_2.sh
deleted file mode 100755
index 349cf9e..0000000
--- a/testcases/kernel/containers/netns/netns_parent_2.sh
+++ /dev/null
@@ -1,60 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_parent_2.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-. netns_initialize.sh
-
-    create_veth
-    vnet2=$dev0
-    vnet3=$dev1
-
-    if [ -z "$vnet2" -o -z "$vnet3" ] ; then
-        tst_resm TFAIL  "Error: unable to create veth pair in $0"
-        exit 1
-    else
-        debug "INFO: vnet2 = $vnet2 , vnet3 = $vnet3"
-    fi
-    ifconfig $vnet2 $IP3$mask up > /dev/null 2>&1
-    route add -host $IP4 dev $vnet2
-    echo 1 > /proc/sys/net/ipv4/conf/$vnet2/proxy_arp
-
-    pid=$(tst_timeout "cat /tmp/FIFO4" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: The pid of CHILD2 is $pid"
-    ip link set $vnet3 netns $pid
-    tst_timeout "echo $vnet3 > /tmp/FIFO3" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    debug "INFO: PARENT-2: End of $0"
-    exit 0
diff --git a/testcases/kernel/containers/netns/netns_parent_share.sh b/testcases/kernel/containers/netns/netns_parent_share.sh
deleted file mode 100755
index efbfd3f..0000000
--- a/testcases/kernel/containers/netns/netns_parent_share.sh
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This script is executed in the parent NS.
-# It binds and does sharable mount of sysfs .
-#
-#For child to refer parent sys
-# set -x
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_parent_share.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-ret=0
-. netns_initialize.sh
-
-    mkdir -p /tmp/par_sysfs /tmp/mnt || ret=1
-    mount --bind /sys /tmp/par_sysfs || ret=1
-
-    #share parent namespace
-    mount --bind /tmp/mnt /tmp/mnt || ret=1
-    #mount --make-shared /mnt
-    $smount /tmp/mnt shared > /dev/null || ret=1
-    if [ $ret -ne 0 ] ; then
-        tst_resm TFAIL "Error while doing shared mount"
-        exit 1
-    fi
diff --git a/testcases/kernel/containers/netns/netns_parent_view.sh b/testcases/kernel/containers/netns/netns_parent_view.sh
deleted file mode 100755
index 3c85d50..0000000
--- a/testcases/kernel/containers/netns/netns_parent_view.sh
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This script verifies the contents of child sysfs is visible in parent NS.
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_parent_view.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    #capture parent /sys contents
-
-    debug "INFO: Parent SYSFS view"
-    ls /sys/class/net > /tmp/parent_sysfs
-    tst_timeout "echo 'PROPAGATE' > /tmp/FIFO4" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    PROPAGATED=$(tst_timeout "cat /tmp/FIFO5" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    ls /tmp/mnt/sys/class/net > /tmp/child_sysfs_in_parent
-    diff /tmp/child_sysfs_in_parent /tmp/child_sysfs
-    if [ $? -eq 0 ]
-    then
-        tst_resm TINFO "Pass: Parent is able to view child sysfs"
-        status=0
-    else
-        tst_resm TFAIL "Fail: Parent is not able to view Child-NS sysfs"
-        status=-1
-    fi
-
-    #cleanup temp files
-
-    rm -f /tmp/child_sysfs_in_parent /tmp/child_sysfs
-    umount /tmp/par_sysfs
-    umount /tmp/mnt
-    sleep 1
-    rm -rf /tmp/par_sysfs /tmp/mnt > /dev/null 2>&1 || true
-    cleanup $sshpid $vnet0
diff --git a/testcases/kernel/containers/netns/netns_parentns.sh b/testcases/kernel/containers/netns/netns_parentns.sh
deleted file mode 100755
index 7bcde12..0000000
--- a/testcases/kernel/containers/netns/netns_parentns.sh
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-################################################################################
-# This script creates 2 veth devices.
-# It will assign $IP1 to vnet0 .
-# And defines the $IP2 as route to vnet1
-# Also it assigns the $vnet1 to child network-NS
-#
-# Arguments:    Accepts an argument 'script' and executes on top of this
-################################################################################
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_parentns.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-#set -x
-. netns_initialize.sh
-status=0
-
-    # Checks if any script is passed as argument.
-    if [ $# = 2 ]; then
-        scrpt=$1
-        debug "INFO: Script to be executed in parent NS is $scrpt"
-    fi
-
-    # Sets up the infrastructure for creating network NS
-
-    echo 1 > /proc/sys/net/ipv4/ip_forward
-    echo 1 > /proc/sys/net/ipv4/conf/$netdev/proxy_arp
-
-    create_veth
-    vnet0=$dev0
-    vnet1=$dev1
-    if [ -z "$vnet0" -o -z "$vnet1" ] ; then
-        tst_resm TFAIL  "Error: unable to create veth pair"
-        exit 1
-    else
-        debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
-    fi
-    sleep 2
-
-    ifconfig $vnet0 $IP1/24 up > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		debug "Failed to make interface $vnet0 up in parent....."
-	fi
-    route add -host $IP2 dev $vnet0
-	if [ $? -ne 0 ]; then
-		debug "Failed to add route to child in parent for $vnet0....."
-	fi
-    echo 1 > /proc/sys/net/ipv4/conf/$vnet0/proxy_arp
-
-    # Waits for the Child-NS to get created and reads the PID
-    tmp=$(tst_timeout "cat /tmp/FIFO1" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    pid=$2;
-    debug "INFO: the pid of child is $pid"
-    ip link set $vnet1 netns $pid
-    if [ $? -ne 0 ]; then
-	echo "Failed to assign network device to child .........."
-    fi
-
-    # Passes the device name to Child NS
-    tst_timeout "echo $vnet1 > /tmp/FIFO2" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    # Executes the script if it is passed as an argument.
-    if [ ! -z $scrpt ] && [ -f $scrpt ] ;  then
-        . $scrpt
-    fi
-
-    debug "INFO: Done executing parent script $0, status is $status "
-    exit $status
-
diff --git a/testcases/kernel/containers/netns/netns_paripv6.sh b/testcases/kernel/containers/netns/netns_paripv6.sh
deleted file mode 100755
index 9f2270a..0000000
--- a/testcases/kernel/containers/netns/netns_paripv6.sh
+++ /dev/null
@@ -1,117 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-################################################################################
-# This script creates 2 veth devices $vnet0 and $vnet1.
-# It will assign $IP1 to $vnet0 .
-# And defines the $IP2 as route to $vnet1
-# Also it assigns the $vnet1 to child network-NS
-#
-################################################################################
-
-#set -x
-
-# The test case ID, the test case count and the total number of test case
-
-TCID=${TCID:-netns_paripv6.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-. netns_initialize.sh
-status=0
-
-    # Sets up the infrastructure for creating network NS
-    # By defining the veth pair $vnet0 and $vnet1
-    echo 1 > /proc/sys/net/ipv4/ip_forward
-    echo 1 > /proc/sys/net/ipv4/conf/$netdev/proxy_arp
-    create_veth
-    vnet0=$dev0
-    vnet1=$dev1
-    if [ -z "$vnet0" -o -z "$vnet1" ] ; then
-        tst_resm TFAIL "Error: unable to create veth pair"
-        exit 1
-    else
-        debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
-    fi
-
-    enable_veth_ipv6 $vnet0
-    vnet0_orig_status=$?
-
-    ifconfig $vnet0 $IP1/24 up > /dev/null 2>&1
-    route add -host $IP2 dev $vnet0
-    echo 1 > /proc/sys/net/ipv4/conf/$vnet0/proxy_arp
-
-    # Waits for the Child-NS to get created and reads the PID
-    pid=$(tst_timeout "cat /tmp/FIFO1" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: the pid of child is $pid"
-    ip link set $vnet1 netns $pid
-
-    tst_timeout "echo $vnet1 > /tmp/FIFO2" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-
-    childIPv6=$(tst_timeout "cat /tmp/FIFO3" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    debug "INFO: The ipv6 addr of child is $childIPv6"
-    # Passes the IPv6 addr to Child NS
-    parIPv6=`ip -6 addr show dev $vnet0 | awk ' /inet6/ { print $2 } ' | awk -F"/" ' { print $1 } '`
-
-    tst_timeout "echo $parIPv6 > /tmp/FIFO4" $NETNS_TIMEOUT
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    ping6 -I $vnet0 -qc 2 $childIPv6 >/dev/null 2>&1
-
-    if [ $? = 0 ] ; then
-       tst_resm TINFO "IPv6: Pinging child from parent: PASS"
-       status=0
-    else
-       tst_resm TFAIL "IPv6: Pinging child from parent: FAIL"
-       status=-1
-
-    fi
-    ret=$(tst_timeout "cat /tmp/FIFO6" $NETNS_TIMEOUT)
-    if [ $? -ne 0 ]; then
-        tst_brkm TBROK "timeout reached!"
-    fi
-    if [ -z "$ret" ]; then
-        ret="-1"
-    fi
-
-    if [ "$ret" != "0" ] ; then
-        status=$(expr "$ret")
-    fi
-
-    if [ $vnet0_orig_status -eq 1 ];then
-       disable_veth_ipv6 $vnet0
-    fi
-debug "INFO: Done with executing parent script $0 "
-exit $status
diff --git a/testcases/kernel/containers/netns/netns_rename_net.sh b/testcases/kernel/containers/netns/netns_rename_net.sh
deleted file mode 100755
index cceb975..0000000
--- a/testcases/kernel/containers/netns/netns_rename_net.sh
+++ /dev/null
@@ -1,77 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-# This script Renames the net device of the child ns to $NewNetDev.
-
-# set -x
-TCID=${TCID:-netns_rename_net.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-    # Find the free dev name
-    for i in `seq 1 100`
-    do
-        newdev=veth$i
-        ip link show | grep -qw $newdev
-        # On finding free device break.
-        if [ $? != 0 ] ; then
-                break
-        fi
-    done
-
-    ifconfig $vnet1 down
-    ip link set $vnet1 name $newdev
-    ifconfig $newdev $IP2/24 up > /dev/null 2>&1
-
-    if [ $? = 0 ] ; then
-        tst_resm TINFO "Successfully Renamed device to $newdev"
-        if [ "$DEBUG" = 1 ]; then
-                ifconfig
-        fi
-    else
-        tst_resm TFAIL "Renaming of device failed: FAIL"
-        status=-1
-    fi
-
-    if [ $status = 0 ] ; then
-        tst_timeout "echo $sshpid > /tmp/FIFO3" $NETNS_TIMEOUT
-	if [ $? -ne 0 ]; then
-            tst_brkm TBROK "timeout reached!"
-        fi
-        tst_timeout "echo $newdev > /tmp/FIFO4" $NETNS_TIMEOUT
-	if [ $? -ne 0 ]; then
-            tst_brkm TBROK "timeout reached!"
-        fi
-    else
-        tst_timeout "echo 'FAIL' > /tmp/FIFO3" $NETNS_TIMEOUT
-	if [ $? -ne 0 ]; then
-            tst_brkm TBROK "timeout reached!"
-        fi
-        tst_timeout "echo -1 > /tmp/FIFO4" $NETNS_TIMEOUT
-	if [ $? -ne 0 ]; then
-            tst_brkm TBROK "timeout reached!"
-        fi
-    fi
diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
new file mode 100755
index 0000000..d1e2dff
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+#==============================================================================
+# Copyright (c) 2015 Red Hat, Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of version 2 the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Written by Matus Marhefka <mmarhefk@redhat.com>
+#
+#==============================================================================
+# File: netns_sysfs.sh
+#=====================
+#
+# Tests that a separate network namespace cannot affect sysfs contents
+# of the main namespace.
+#==============================================================================
+
+TCID=netns_sysfs
+TST_TOTAL=1
+. test.sh
+
+cleanup()
+{
+	tst_rmdir
+	ip link del dummy0 2>/dev/null
+	kill -9 $NS_HANDLE 2>/dev/null
+}
+
+tst_tmpdir
+NS_HANDLE=$(ns_create net,mnt)
+if [ $? -eq 1 ]; then
+	tst_resm TINFO "$NS_HANDLE"
+	tst_brkm TBROK "unable to create a new network namespace"
+fi
+TST_CLEANUP=cleanup
+ls /sys/class/net >sysfs_before
+
+
+ns_exec $NS_HANDLE ip link add dummy0 type dummy || \
+	tst_brkm TBROK "failed to add a new dummy device"
+ns_exec $NS_HANDLE mount -t sysfs none /sys 2>/dev/null
+kill -9 $NS_HANDLE
+
+ls /sys/class/net >sysfs_after
+diff sysfs_before sysfs_after
+if [ $? -eq 0 ]; then
+	tst_resm TPASS "sysfs not affected by a separate namespace"
+else
+	tst_resm TFAIL "sysfs affected by a separate namespace"
+fi
+
+tst_exit
diff --git a/testcases/kernel/containers/netns/netns_sysfsview.c b/testcases/kernel/containers/netns/netns_sysfsview.c
deleted file mode 100644
index f29cec1..0000000
--- a/testcases/kernel/containers/netns/netns_sysfsview.c
+++ /dev/null
@@ -1,60 +0,0 @@
-
-/*************************************************************************
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
-***************************************************************************/
-
-/* ============================================================================
-* This testcase uses the libnetns.c from the lib to create network NS1.
-* In libnetns.c it uses 2 scripts parentns.sh and childns.sh to create this.
-*
-* This testcase verifies sysfs contents of parentNS is visible from child NS.
-* Also it checks the sysfs contents of the child are visible from the parent NS.
-* On Success it returns PASS else returns FAIL
-*
-* Scripts used: parent_share.sh parent_view.sh child_propagate.sh
-*               parentns.sh childns.sh
-*
-*
-* Authors:      Poornima Nayak <poornima.nayak@in.ibm.com>
-*               Veerendra C <vechandr@in.ibm.com>
-*                      31/07/2008
-* ============================================================================*/
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "common.h"
-
-const char *TCID = "netns_sysfsview";
-
-#define SCRIPT "netns_parent_share.sh"
-
-int main(void)
-{
-	int ret, status = 0;
-
-	/* Parent should be able to view child sysfs and vice versa */
-	ret = system(SCRIPT);
-	status = WEXITSTATUS(ret);
-	if (ret == -1 || status != 0) {
-		printf("Error while executing the script %s\n", SCRIPT);
-		fflush(stdout);
-		exit(1);
-	}
-
-	status = create_net_namespace("netns_parent_view.sh", "netns_child_propagate.sh");
-	return status;
-}
diff --git a/testcases/kernel/containers/netns/netns_two_children_ns.c b/testcases/kernel/containers/netns/netns_two_children_ns.c
deleted file mode 100644
index 19507a9..0000000
--- a/testcases/kernel/containers/netns/netns_two_children_ns.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/*************************************************************************
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
-***************************************************************************/
-
-/*******************************************************************************
-* This testcase creates 2 network Namespace NS1 & NS2, oin the parent NS.
-* It creates veth device pair for NS1 and NS2
-* It checks the network connection between NS1 and NS2 .
-* On Success returns PASS else returns FAIL.
-*
-* scripts used: parent_1.sh parent_2.sh child_1.sh child_2.sh
-*
-* Authors: Veerendra C <vechandr@in.ibm.com> ,
-           Munipradeep <mbeeraka@in.ibm.com>
-*                      31/07/2008
-*******************************************************************************/
-
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <sched.h>
-#include <libgen.h>
-#include <unistd.h>
-#include <signal.h>
-#include <string.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/utsname.h>
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "libclone.h"
-#include "config.h"
-#include "common.h"
-#include "netns_helper.h"
-
-#define IPROUTE_MIN_VER 80725
-
-char *TCID = "netns_2children";
-int TST_TOTAL = 1;
-
-static void setup(void)
-{
-	tst_require_root(NULL);
-	check_iproute(IPROUTE_MIN_VER);
-	check_netns();
-}
-
-int main(void)
-{
-	int ret, pid[2], status, i;
-	long long flags = 0;
-	char child[2][FILENAME_MAX], par[2][FILENAME_MAX];
-
-	setup();
-
-	flags |= CLONE_NEWNS;
-	flags |= CLONE_NEWNET;
-
-#if ! HAVE_UNSHARE
-	tst_brkm(TCONF, NULL, "System doesn't support unshare.");
-#endif
-
-	/* Checking for Kernel Version */
-	if (tst_kvercmp(2, 6, 19) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWPID not supported");
-
-	strcpy(child[0], "netns_child_1.sh");
-	strcpy(child[1], "netns_child_2.sh");
-	strcpy(par[0], "netns_parent_1.sh");
-	strcpy(par[1], "netns_parent_2.sh");
-
-	/* Loop for creating two child Network Namespaces */
-	for (i = 0; i < 2; i++) {
-
-		if ((pid[i] = fork()) == 0) {
-			/* Child1 and Child2 based on the iteration. */
-
-#if HAVE_UNSHARE
-			ret = unshare(flags);
-			if (ret < 0) {
-				perror("Unshare");
-				tst_brkm(TFAIL,
-					 NULL,
-					 "Error:Unshare syscall failed for network namespace");
-			}
-#endif
-			if (crtchild(child[i], NULL) != 0) {
-				tst_brkm(TFAIL, NULL,
-					 "Failed running child script");
-			}
-		} else {
-			//Parent
-
-			ret = system(par[i]);
-			status = WEXITSTATUS(ret);
-			if (ret == -1 || status != 0) {
-				tst_brkm(TFAIL,
-					 NULL,
-					 "Error while running the scripts");
-			}
-		}
-	}			//End of FOR Loop
-
-	/* Parent waiting for two children to quit */
-	for (i = 0; i < 2; i++) {
-		ret = waitpid(pid[i], &status, __WALL);
-		status = WEXITSTATUS(status);
-		if (status != 0 || ret == -1) {
-			tst_resm(TFAIL, "waitpid() returns %d, errno %d", ret,
-				 status);
-			fflush(stdout);
-			tst_exit();
-		}
-	}
-
-	tst_resm(TPASS, "two children ns");
-	tst_exit();
-}
diff --git a/testcases/kernel/containers/netns/nw_under_ns.sh b/testcases/kernel/containers/netns/nw_under_ns.sh
deleted file mode 100755
index 835b34e..0000000
--- a/testcases/kernel/containers/netns/nw_under_ns.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/bash
-
-#############################################################################
-#                                                                           #
-# Copyright (c) International Business Machines  Corp., 2008                #
-#                                                                           #
-# This program is free software;  you can redistribute it and#or modify     #
-# it under the terms of the GNU General Public License as published by      #
-# the Free Software Foundation; either version 2 of the License, or         #
-# (at your option) any later version.                                       #
-#                                                                           #
-# This program is distributed in the hope that it will be useful, but       #
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY#
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License  #
-# for more details.                                                         #
-#                                                                           #
-# You should have received a copy of the GNU General Public License         #
-# along with this program;  if not, write to the Free Software              #
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA   #
-#                                                                           #
-# Author:      Sudhir Kumar <skumar@linux.vnet.ibm.com>                     #
-#############################################################################
-
-# this script is used to run all the testcases for networks under network
-# namespace. This script is called by a separate command file nw_under_ns
-# The testcases are grouped as per the requirement of the particular
-# testcase.
-
-echo "*****************************************************"
-echo "Running network testcases under containers..."
-
-if ! netns_create_container; then
-	echo "some of the network testcases under netns failed"
-	exit 1;
-fi
diff --git a/testcases/kernel/containers/netns/readme b/testcases/kernel/containers/netns/readme
deleted file mode 100644
index a8b2166..0000000
--- a/testcases/kernel/containers/netns/readme
+++ /dev/null
@@ -1,15 +0,0 @@
-This file is to do the setup for running the Network Testcases under containers.
-The corresponding command file is nw_under_ns, hence a sample command will be
-./runltp -p -f nw_under_ns
-from the LTP root directory.
-Most of the requirements are common as for the NW testcases. For ex, xinetd
-and other packages should be installed on machine, /etc/securetty/ should have
-entry for the particular services, /root/.rhosts should allow the host (put a
-line having just + in /root/.rhosts, but remember the potential security risk).
-Also add the hostname container1 with 192.168.0.182 ip in /etc/hosts.
-
-The variables RHOSTS is automatically set up by script, however RUSER and PASSWD
-need to be setup. The variables are exported in the runallnetworktests_child.sh
-script and hence need to be updated manually there. However I will try any better
-way to do this. By default it will try with "root"/"linux" which will fail.
-Hence put the root password in the file runallnetworktests_child.sh (bad ;( )
diff --git a/testcases/kernel/containers/netns/runallnetworktests_child.sh b/testcases/kernel/containers/netns/runallnetworktests_child.sh
deleted file mode 100755
index 0d9f341..0000000
--- a/testcases/kernel/containers/netns/runallnetworktests_child.sh
+++ /dev/null
@@ -1,156 +0,0 @@
-#!/bin/bash
-
-#############################################################################
-#                                                                           #
-# Copyright (c) International Business Machines  Corp., 2008                #
-#                                                                           #
-# This program is free software;  you can redistribute it and#or modify     #
-# it under the terms of the GNU General Public License as published by      #
-# the Free Software Foundation; either version 2 of the License, or         #
-# (at your option) any later version.                                       #
-#                                                                           #
-# This program is distributed in the hope that it will be useful, but       #
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY#
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License  #
-# for more details.                                                         #
-#                                                                           #
-# You should have received a copy of the GNU General Public License         #
-# along with this program;  if not, write to the Free Software              #
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA   #
-#                                                                           #
-# Author:      Sudhir Kumar <skumar@linux.vnet.ibm.com>                     #
-#############################################################################
-
-# The script to be run in the child network namespace
-# Add the code as per the requirement of different existing
-# network testcases
-
-# mount the proc fs in the child
-mount -t proc lxcproc /proc;
-if [ $? -ne 0 ]; then
-	echo "TBROK	Failed to mount the proc fs in child... "
-	echo "Testcases will fail. So exiting the tests....."
-	exit 1;
-fi
-
-. netns_initialize.sh;
-
-/etc/init.d/xinetd restart;
-if [ $? -ne 0 ]; then
-	echo "TBROK	Failed to restart the xinetd daemon. Please ensure "
-		"you have xinetd installed, appropriate permissions etc."
-	exit 1;
-fi
-
-echo "Assuming user has updated the RUSER and PASSWD fields in $0 file"
-echo "If not updated some of the testcases will fail"
-
-export RHOST=$IP1;
-export RUSER="root";
-export PASSWD="linux";	# Please update this field
-debug "DEBUG: RHOST = $RHOST";
-
-#***********************************#
-# Child namespace requires /var to be unshared
-mkdir /var2 >/dev/null 2>&1;
-mount --bind /var2 /var >/dev/null 2>&1;
-
-# Execute the different testcases in the child namespace
-# Ping testcase
-echo "Running ping testcase...."
-export LTPROOT; ping01;
-
-echo "Running arp testcase...."
-arp01;
-
-echo "Running echo testcase...."
-export TCbin=$LTPROOT/testcases/network/tcp_cmds/echo; echo01
-
-echo "Running finger testcase...."
-finger01;
-
-echo "Running rcp testcase...."
-export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
-
-echo "Running rdist testcase...."
-export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
-
-echo "Running rlogin testcase...."
-rlogin01;
-
-echo "Running rwho testcase...."
-rwho01;
-
-echo "Running rsh testcase...."
-rsh01;
-echo "Running sendfile testcase...."
-export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
-
-echo "Running LAN perf testcase...."
-export TCbin=$LTPROOT/testcases/network/tcp_cmds/perf_lan; perf_lan
-
-echo "Running set of rpc testcase...."
-export TCbin=$LTPROOT/testcases/network/rpc/basic_tests/rpc01; rpc01
-export TCbin=$LTPROOT/testcases/network/rpc/basic_tests/rpcinfo01; rpcinfo01
-export TCbin=$LTPROOT/testcases/network/rpc/basic_tests/rup; rup01
-export TCbin=$LTPROOT/testcases/network/rpc/basic_tests/rusers; rusers01
-
-echo "Running set of nfs testcase...."
-export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/network/nfs/nfs01;
-nfs01;
-
-export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/network/nfs/nfs02;
-nfs02;
-
-export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/network/nfs/nfs03;
-nfs03;
-export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/network/nfs/nfs04;
-nfs04;
-
-export VERSION; export TCbin=$LTPROOT/testcases/network/nfs/nfslock01; nfslock01
-
-echo "Running set of nfs stress testcase...."
-
-export VERSION SOCKET_TYPE;
-export TCbin=$LTPROOT/testcases/network/nfs/nfsstress;
-nfsstress 20 50 1
-
-export VERSION; export TCbin=$LTPROOT/testcases/network/nfs/nfsstat01; nfsstat01
-
-export VERSION SOCKET_TYPE; export TCbin=$LTPROOT/testcases/bin; fsx.sh
-
-echo "Running ftp testcase...."
-export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
-
-echo "Running set of ssh testcase...."
-# This requires ssh daemon to be listening on port 22
-/usr/sbin/sshd -p 22
-if [ $? -eq 0 ]; then
-	ssh01;
-	ssh02;
-	ssh03;
-	sshpid=`ps -ef | grep "sshd -p $PORT" | awk '{ print $2 ; exit 0} ' `;
-	kill -s SIGKILL $sshpid;
-else
-	echo "Failed to start ssh daemon at port 22 in container";
-	echo "Skipping the set of ssh testcases";
-fi
-
-echo "Running netstat testcase...."
-netstat01;
-
-echo "Running iptables testcase...."
-iptables_tests.sh
-
-echo "Running telnet testcase...."
-telnet01;
-
-cleanup $sshpid $vnet1;
-/etc/init.d/xinetd stop;
-umount /var ;
-umount /proc ;
-if [ $? -ne 0 ]; then
-	echo "Failed to unmount the proc fs in child... Exiting"
-	exit 1;
-fi
-
diff --git a/testcases/kernel/containers/netns/runallnetworktests_parent.sh b/testcases/kernel/containers/netns/runallnetworktests_parent.sh
deleted file mode 100755
index d6aede4..0000000
--- a/testcases/kernel/containers/netns/runallnetworktests_parent.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/bash
-
-#############################################################################
-#                                                                           #
-# Copyright (c) International Business Machines  Corp., 2008                #
-#                                                                           #
-# This program is free software;  you can redistribute it and#or modify     #
-# it under the terms of the GNU General Public License as published by      #
-# the Free Software Foundation; either version 2 of the License, or         #
-# (at your option) any later version.                                       #
-#                                                                           #
-# This program is distributed in the hope that it will be useful, but       #
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY#
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License  #
-# for more details.                                                         #
-#                                                                           #
-# You should have received a copy of the GNU General Public License         #
-# along with this program;  if not, write to the Free Software              #
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA   #
-#                                                                           #
-# Author:      Sudhir Kumar <skumar@linux.vnet.ibm.com>                     #
-#############################################################################
-
-# The script to be run in the parent network namespace
-# Add the code as per the requirement of different existing
-# network testcases
-
-echo "This is parent process....."
-service xinetd restart;
-sleep 5;
-- 
1.8.3.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
