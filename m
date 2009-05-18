Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1M5sMo-0002QC-Vc
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 02:14:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5sMk-0003XR-C4
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 02:14:14 +0000
Message-ID: <4A10C4B1.2070105@cn.fujitsu.com>
Date: Mon, 18 May 2009 10:15:13 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] add memcgroup regression tests to LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Those testcases can reproduce bugs we found in memcg, and is useful
to track future regressions.

Note: this test may crash the system with older kernels, so it is
disabled for kernels older than 2.6.30

How to run this test:
	# runltp -f controllers

Result:

memcg_regression_test    1  PASS  :  no kernel bug was found
memcg_regression_test    2  PASS  :  EBUSY was returned as expected
memcg_regression_test    3  PASS  :  no kernel bug was found
./memcg_test_4.sh: line 41: 28374 was killed               swapoff -a
memcg_regression_test    4  PASS  :  no kernel bug was found

Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
---
 runtest/controllers                                         |    1
 testcases/kernel/controllers/Makefile                       |    6
 testcases/kernel/controllers/memcg/Makefile                 |   16
 testcases/kernel/controllers/memcg/README                   |    9
 testcases/kernel/controllers/memcg/memcg_regression_test.sh |  227 ++++++++++++
 testcases/kernel/controllers/memcg/memcg_test_1.c           |   71 +++
 testcases/kernel/controllers/memcg/memcg_test_2.c           |   53 ++
 testcases/kernel/controllers/memcg/memcg_test_4.c           |   62 +++
 testcases/kernel/controllers/memcg/memcg_test_4.sh          |   48 ++
 9 files changed, 493 insertions(+)

diff -Nurp ltp-intermediate-20090420.orig/runtest/controllers ltp-intermediate-20090420/runtest/controllers
--- ltp-intermediate-20090420.orig/runtest/controllers	2009-05-18 09:53:42.000000000 +0800
+++ ltp-intermediate-20090420/runtest/controllers	2009-05-18 09:54:02.000000000 +0800
@@ -1,3 +1,4 @@
 #DESCRIPTION:Resource Management testing
 cgroup		cgroup_regression_test.sh
+memcg		memcg_regression_test.sh
 controllers	test_controllers.sh
diff -Nurp ltp-intermediate-20090420.orig/testcases/kernel/controllers/Makefile ltp-intermediate-20090420/testcases/kernel/controllers/Makefile
--- ltp-intermediate-20090420.orig/testcases/kernel/controllers/Makefile	2009-05-18 09:53:42.000000000 +0800
+++ ltp-intermediate-20090420/testcases/kernel/controllers/Makefile	2009-05-15 14:53:17.000000000 +0800
@@ -10,6 +10,12 @@ else
 $(info "Kernel is not compiled with control cgroup support")
 endif
 
+ifeq ($(CHECK_MEMCTL),memory)
+SUBDIRS += memcg
+else
+$(info "Kernel is not compiled with memory resource controller support")
+endif
+
 ifeq ($(CHECK_CPUCTL),cpu)
 SUBDIRS += cpuctl
 else
diff -Nurp ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/Makefile ltp-intermediate-20090420/testcases/kernel/controllers/memcg/Makefile
--- ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/Makefile	1970-01-01 08:00:00.000000000 +0800
+++ ltp-intermediate-20090420/testcases/kernel/controllers/memcg/Makefile	2009-05-15 14:46:35.000000000 +0800
@@ -0,0 +1,16 @@
+CFLAGS += -Wall
+CPPFLAGS += -I../../../../include -I../libcontrollers
+LDLIBS += -L../../../../lib/ -lltp
+
+SRCS    = $(wildcard *.c)
+
+TARGETS = $(patsubst %.c,%,$(SRCS))
+
+all:    $(TARGETS)
+
+clean:
+	rm -f $(TARGETS) *.o
+
+install:
+	@set -e; for i in $(TARGETS) *.sh; do ln -f $$i ../../../bin/$$i ; chmod +x $$i ; done
+
diff -Nurp ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_regression_test.sh ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_regression_test.sh
--- ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_regression_test.sh	1970-01-01 08:00:00.000000000 +0800
+++ ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_regression_test.sh	2009-05-15 15:05:00.000000000 +0800
@@ -0,0 +1,227 @@
+#! /bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+##                                                                            ##
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+export TCID="memcg_regression_test"
+export TST_TOTAL=4
+export TST_COUNT=1
+
+if [ "$USER" != root ]; then
+	tst_brkm TBROK ignored "Test must be run as root"
+	exit 0
+fi
+
+tst_kvercmp 2 6 30
+if [ $? -eq 0 ]; then
+	tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
+	exit 0
+fi
+
+nr_bug=`dmesg | grep -c "kernel BUG"`
+nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
+nr_warning=`dmesg | grep -c "^WARNING"`
+nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+
+# check_kernel_bug - check if some kind of kernel bug happened
+check_kernel_bug()
+{
+	new_bug=`dmesg | grep -c "kernel BUG"`
+	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
+	new_warning=`dmesg | grep -c "^WARNING"`
+	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+
+	# no kernel bug is detected
+	if [ $new_bug -eq $nr_bug -a $new_warning -eq $nr_warning -a \
+	     $new_null -eq $nr_null -a $new_lockdep -eq $nr_lockdep ]; then
+		return 1
+	fi
+
+	# some kernel bug is detected
+	if [ $new_bug -gt $nr_bug ]; then
+		tst_resm TFAIL "kernel BUG was detected!"
+	fi
+	if [ $new_warning -gt $nr_warning ]; then
+		tst_resm TFAIL "kernel WARNING was detected!"
+	fi
+	if [ $new_null -gt $nr_null ]; then
+		tst_resm "kernel NULL pointer dereference!"
+	fi
+	if [ $new_lockdep -gt $nr_lockdep ]; then
+		tst_resm "kernel lockdep warning was detected!"
+	fi
+
+	nr_bug=$new_bug
+	nr_null=$new_null
+	nr_warning=$new_warning
+	nr_lockdep=$new_lockdep
+
+	failed=1
+	return 0
+}
+
+#---------------------------------------------------------------------------
+# Bug:    The bug was, while forking mass processes, trigger memcgroup OOM,
+#         then NULL pointer dereference may be hit.
+# Kernel: 2.6.25-rcX
+# Links:  http://lkml.org/lkml/2008/4/14/38
+# Fix:    commit e115f2d89253490fb2dbf304b627f8d908df26f1
+#---------------------------------------------------------------------------
+test_1()
+{
+	mkdir memcg/0/
+	echo 0 > memcg/0/memory.limit_in_bytes
+
+	./memcg_test_1
+
+	rmdir memcg/0/
+
+	check_kernel_bug
+	if [ $? -eq 1 ]; then
+		tst_resm TPASS "no kernel bug was found"
+	fi
+}
+
+#---------------------------------------------------------------------------
+# Bug:    Shrink memory might never return, unless send signal to stop it.
+# Kernel: 2.6.29
+# Links:  http://marc.info/?t=123199973900003&r=1&w=2
+#         http://lkml.org/lkml/2009/2/3/72
+# Fix:    81d39c20f5ee2437d71709beb82597e2a38efbbc
+#---------------------------------------------------------------------------
+test_2()
+{
+	./memcg_test_2 &
+	pid1=$!
+	sleep 1
+
+	mkdir memcg/0
+	echo $pid1 > memcg/0/tasks
+
+	# let pid1 'test_2' allocate memory
+	/bin/kill -SIGUSR1 $pid1
+	sleep 1
+
+	# shrink memory
+	echo 1 > memcg/0/memory.limit_in_bytes 2>&1 &
+	pid2=$!
+
+	# check if 'echo' will exit and exit with failure
+	for ((tmp = 0; tmp < 5; tmp++))
+	{
+		sleep 1
+		ps -p $! > /dev/null
+		if [ $? -ne 0 ]; then
+			wait $pid2
+			if [ $? -eq 0 ]; then
+				tst_resm TFAIL "echo should return failure"
+				failed=1
+				kill -9 $pid1 $pid2 > /dev/null 2>&1
+				wait $pid1 $pid2
+				rmdir memcg/0
+			fi
+			break
+		fi
+	}
+
+	if [ $tmp -eq 5 ]; then
+		tst_resm TFAIL "'echo' doesn't exit!"
+		failed=1
+	else
+		tst_resm TPASS "EBUSY was returned as expected"
+	fi
+
+	kill -9 $pid1 $pid2 > /dev/null 2>&1
+	wait $pid1 $pid2 > /dev/null 2>&1
+	rmdir memcg/0
+}
+
+#---------------------------------------------------------------------------
+# Bug:    crash when rmdir a cgroup on IA64
+# Kernel: 2.6.29-rcX
+# Links:  http://marc.info/?t=123235660300001&r=1&w=2
+# Fix:    commit 299b4eaa302138426d5a9ecd954de1f565d76c94
+#---------------------------------------------------------------------------
+test_3()
+{
+	mkdir memcg/0
+	for pid in `cat memcg/tasks`; do
+		echo $pid > memcg/0/tasks 2> /dev/null
+	done
+
+	for pid in `cat memcg/0/tasks`; do
+		echo $pid > memcg/tasks 2> /dev/null
+	done
+	rmdir memcg/0
+
+	check_kernel_bug
+	if [ $? -eq 1 ]; then
+		tst_resm TPASS "no kernel bug was found"
+	fi
+}
+
+#---------------------------------------------------------------------------
+# Bug:    the memcg's refcnt handling at swapoff was wrong, causing crash
+# Kernel: 2.6.29-rcX
+# Links:  http://marc.info/?t=123208656300004&r=1&w=2
+# Fix:    commit 85d9fc89fb0f0703df6444f260187c088a8d59ff
+#---------------------------------------------------------------------------
+test_4()
+{
+	./memcg_test_4.sh
+
+	check_kernel_bug
+	if [ $? -eq 1 ]; then
+		tst_resm TPASS "no kernel bug was found"
+	fi
+
+	# test_4.sh might be killed by oom, so do clean up here
+	killall -9 memcg_test_4 2> /dev/null
+	killall -9 memcg_test_4.sh 2> /dev/null
+	swapon -a
+}
+
+# main
+
+mkdir memcg/
+
+for ((cur = 1; cur <= $TST_TOTAL; cur++))
+{
+	export TST_COUNT=$cur
+
+	mount -t cgroup -o memory xxx memcg/
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount memory subsytem"
+		continue
+	fi
+
+	test_$cur
+
+	umount memcg/
+}
+
+rmdir memcg/
+
+exit $failed
+
diff -Nurp ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_test_1.c ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_test_1.c
--- ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_test_1.c	1970-01-01 08:00:00.000000000 +0800
+++ ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_test_1.c	2009-05-15 14:48:05.000000000 +0800
@@ -0,0 +1,71 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
+/*                                                                            */
+/******************************************************************************/
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#define MAP_FLAGS	(MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED)
+
+#define LOOP		40
+
+int main(void)
+{
+	char buf[10];
+	int i;
+	int loop;
+	int pid;
+	int size = getpagesize();
+	int fd = open("memcg/0/tasks", O_WRONLY);
+
+	if (fd < 0)
+		return 1;
+
+	for (loop = 0; loop < LOOP; loop++) {
+		for (i = 0; i < 10; i++) {
+			pid = fork();
+			if (pid == 0) {
+				char *p;
+
+				sprintf(buf, "%d", getpid());
+				write(fd, buf, 10);
+				fsync(fd);
+
+				p = mmap(NULL, size, PROT_READ | PROT_WRITE,
+					 MAP_FLAGS, 0, 0);
+
+				return 0;
+			}
+		}
+
+		for (i = 0; i < 10; i++)
+			wait(NULL);
+	}
+
+	close(fd);
+
+	return 0;
+}
+
diff -Nurp ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_test_2.c ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_test_2.c
--- ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_test_2.c	1970-01-01 08:00:00.000000000 +0800
+++ ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_test_2.c	2009-05-15 14:48:18.000000000 +0800
@@ -0,0 +1,53 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
+/*                                                                            */
+/******************************************************************************/
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <signal.h>
+
+void sigusr_handler(int __attribute__((unused)) signo)
+{
+	char *p;
+	int size = getpagesize() * 2;
+
+	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0, 0);
+	if (p == MAP_FAILED)
+		exit(1);
+}
+
+int main(void)
+{
+	struct sigaction sigusr_action;
+
+	memset(&sigusr_action, 0, sizeof(sigusr_action));
+	sigusr_action.sa_handler = &sigusr_handler;
+	sigaction(SIGUSR1, &sigusr_action, NULL);
+
+	while (1)
+		sleep(1);
+
+	return 0;
+}
+
diff -Nurp ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_test_4.c ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_test_4.c
--- ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_test_4.c	1970-01-01 08:00:00.000000000 +0800
+++ ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_test_4.c	2009-05-15 14:48:28.000000000 +0800
@@ -0,0 +1,62 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
+/*                                                                            */
+/******************************************************************************/
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/mman.h>
+
+#define MEM_SIZE	(1024 * 1024 * 100)
+
+void sigusr_handler(int __attribute__((unused)) signo)
+{
+	char *p;
+	int i;
+	int pagesize = getpagesize();
+
+	p = mmap(NULL, MEM_SIZE, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (p == MAP_FAILED) {
+		fprintf(stderr, "failed to allocate memory!\n");
+		exit(1);
+	}
+
+	for (i = 0; i < MEM_SIZE; i += pagesize)
+		p[i] = 'z';
+}
+
+int main(void)
+{
+	struct sigaction sigusr_action;
+
+	memset(&sigusr_action, 0, sizeof(sigusr_action));
+	sigusr_action.sa_handler = &sigusr_handler;
+	sigaction(SIGUSR1, &sigusr_action, NULL);
+
+	while (1)
+		sleep(1);
+
+	return 0;
+}
+
diff -Nurp ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_test_4.sh ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_test_4.sh
--- ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/memcg_test_4.sh	1970-01-01 08:00:00.000000000 +0800
+++ ltp-intermediate-20090420/testcases/kernel/controllers/memcg/memcg_test_4.sh	2009-05-15 14:59:38.000000000 +0800
@@ -0,0 +1,48 @@
+#! /bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+##                                                                            ##
+################################################################################
+
+# attach current task to memcg/0/
+mkdir memcg/0
+echo $$ > memcg/0/tasks
+
+./memcg_test_4 &
+pid=$!
+sleep 1
+
+# let $pid allocate 100M memory
+/bin/kill -SIGUSR1 $pid
+sleep 1
+
+# shrink memory, and then 80M will be swapped
+echo 40M > memcg/0/memory.limit_in_bytes
+
+# turn off swap, and swapoff will be killed
+swapoff -a
+sleep 1
+echo $pid > memcg/tasks 2> /dev/null
+echo $$ > memcg/tasks 2> /dev/null
+
+# now remove the cgroup
+rmdir memcg/0
+
diff -Nurp ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/README ltp-intermediate-20090420/testcases/kernel/controllers/memcg/README
--- ltp-intermediate-20090420.orig/testcases/kernel/controllers/memcg/README	1970-01-01 08:00:00.000000000 +0800
+++ ltp-intermediate-20090420/testcases/kernel/controllers/memcg/README	2009-05-15 14:47:26.000000000 +0800
@@ -0,0 +1,9 @@
+TEST SUITE:
+
+The directory memcg contains the tests related to memory resource controller.
+Those testcases can reproduce bugs we found.
+
+TESTS AIM:
+
+The aim of the tests is to track any future regressions.
+

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
