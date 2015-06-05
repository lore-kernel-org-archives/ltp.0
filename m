Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1Z0oP1-0001kA-52
	for ltp-list@lists.sourceforge.net; Fri, 05 Jun 2015 09:59:03 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z0oOy-0004EO-Ls
	for ltp-list@lists.sourceforge.net; Fri, 05 Jun 2015 09:59:03 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id A958531980A
	for <ltp-list@lists.sourceforge.net>;
	Fri,  5 Jun 2015 09:58:54 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp-12-104.nay.redhat.com
	[10.66.12.104])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t559wnxe012471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Jun 2015 05:58:52 -0400
From: Li Wang <liwang@redhat.com>
Date: Fri,  5 Jun 2015 17:58:47 +0800
Message-Id: <1433498327-16042-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] thp/hzp: new case for Huge Zero Page testing
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

Huge Zero Page feature has been added in kernel-3.17, so I draft these
testcase to cover it in LTP.

hzp01.sh: Checking if the HZP feature works well.

hzp02.sh: Checking if the HZP feature peformed well.

hzp03.sh: Do Huge Zero Page stress test.

Reference: https://lwn.net/Articles/525301/

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/mm                              |   4 ++
 testcases/kernel/mem/thp/Makefile       |   3 +-
 testcases/kernel/mem/thp/hzp/Makefile   |  20 ++++++
 testcases/kernel/mem/thp/hzp/hzp01.sh   | 108 ++++++++++++++++++++++++++++++++
 testcases/kernel/mem/thp/hzp/hzp02.sh   |  93 +++++++++++++++++++++++++++
 testcases/kernel/mem/thp/hzp/hzp03.sh   |  54 ++++++++++++++++
 testcases/kernel/mem/thp/hzp/hzp_lib.sh |  76 ++++++++++++++++++++++
 testcases/kernel/mem/thp/hzp/memcmp01.c |  47 ++++++++++++++
 testcases/kernel/mem/thp/hzp/memcmp02.c |  62 ++++++++++++++++++
 9 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/mem/thp/hzp/Makefile
 create mode 100755 testcases/kernel/mem/thp/hzp/hzp01.sh
 create mode 100755 testcases/kernel/mem/thp/hzp/hzp02.sh
 create mode 100755 testcases/kernel/mem/thp/hzp/hzp03.sh
 create mode 100755 testcases/kernel/mem/thp/hzp/hzp_lib.sh
 create mode 100644 testcases/kernel/mem/thp/hzp/memcmp01.c
 create mode 100644 testcases/kernel/mem/thp/hzp/memcmp02.c

diff --git a/runtest/mm b/runtest/mm
index 031d766..f1eea2b 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -91,6 +91,10 @@ thp05_1 thp05
 thp05_2 thp05 -n 10 -N 20
 thp05_3 thp05 -n 1 -N 300
 
+hzp01 hzp01.sh
+hzp02 hzp02.sh
+hzp03 hzp03.sh
+
 vma01 vma01
 vma02 vma02
 vma03 vma03
diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
index 867dcf0..28757e0 100644
--- a/testcases/kernel/mem/thp/Makefile
+++ b/testcases/kernel/mem/thp/Makefile
@@ -21,4 +21,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
+SUBDIRS		:= hzp
diff --git a/testcases/kernel/mem/thp/hzp/Makefile b/testcases/kernel/mem/thp/hzp/Makefile
new file mode 100644
index 0000000..c91ad17
--- /dev/null
+++ b/testcases/kernel/mem/thp/hzp/Makefile
@@ -0,0 +1,20 @@
+# Copyright (c) 2015  Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir	?= ../../../../..
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+INSTALL_TARGETS		:= *.sh
diff --git a/testcases/kernel/mem/thp/hzp/hzp01.sh b/testcases/kernel/mem/thp/hzp/hzp01.sh
new file mode 100755
index 0000000..887e99e
--- /dev/null
+++ b/testcases/kernel/mem/thp/hzp/hzp01.sh
@@ -0,0 +1,108 @@
+#!/bin/bash
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  #  Copyright (C) 2015 Linux Test Project.
+#  #
+#  #  Licensed under the GNU GPLv2 or later.
+#  #  This program is free software;  you can redistribute it and/or modify
+#  #  it under the terms of the GNU General Public License as published by
+#  #  the Free Software Foundation; either version 2 of the License, or
+#  #  (at your option) any later version.
+#  #
+#  #  This program is distributed in the hope that it will be useful,
+#  #  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  #  the GNU General Public License for more details.
+#  #
+#  #  You should have received a copy of the GNU General Public License
+#  #  along with this program;  if not, write to the Free Software
+#  #  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#  #
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  #  Description:
+#  #
+#  #  This THP case measure the RSS size of test process memcmp01 on a system with
+#  #  Huge Zero Page on/off. The size of rss_off is absolutely larger than 100*rss_on,
+#  #  eg. x86_64, the rss_on is about 400K, the rss_off is about 200M.
+#  #
+#  #  Author: Li Wang <liwang@redhat.com>
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+export TCID="hzp01"
+export TST_TOTAL=5
+
+. test.sh
+. hzp_lib.sh
+
+rss_off=-1
+rss_on=-1
+
+hzp_off_test()
+{
+	# Testing with use_zero_page disable
+	hzp_off
+
+	# Running the process in background
+	$TPATH/memcmp01 & >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "failed to run the process in background."
+	fi
+
+	sleep 2
+	# Check the RSS size of test_memcmp01
+	local pid=`pidof "$TPATH/memcmp01"`
+	rss_off=`pmap -x $pid | grep total | awk '{print $4}'`
+	tst_resm TINFO "rss_off= $rss_off K"
+
+	# Kill the test process
+	kill $pid >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "failed to kill the process."
+	fi
+}
+
+hzp_on_test()
+{
+	# Testing with use_zero_page enable
+	hzp_on
+
+	# Running the process in background
+	$TPATH/memcmp01 & >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "failed to run the process in background."
+	fi
+
+	sleep 2
+	# Check the RSS size of test_memcmp01
+	local pid=`pidof "$TPATH/memcmp01"`
+	rss_on=`pmap -x $pid | grep total | awk '{print $4}'`
+	tst_resm TINFO "rss_on= $rss_on K"
+
+	kill $pid >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "failed to kill the process."
+	fi
+}
+
+rss_cmp()
+{
+	hzp_off_test
+	hzp_on_test
+
+	# eg. rss_on is about 400k, rss_off is about 200M (arch: x86_64),
+	# so the size of rss_off should be absolutely lager than 100*rss_on
+	test_success=`echo "$rss_off > 100*$rss_on" |bc`
+	if [ $test_success -eq 1 ]; then
+		tst_resm TPASS "Huge Zero Page works well."
+	else
+		tst_resm TFAIL "Huge Zero Page works bad."
+	fi
+}
+
+#--------Test Start----------
+hzp_setup
+
+rss_cmp
+
+hzp_cleanup
+
+tst_exit
diff --git a/testcases/kernel/mem/thp/hzp/hzp02.sh b/testcases/kernel/mem/thp/hzp/hzp02.sh
new file mode 100755
index 0000000..e0f8adb
--- /dev/null
+++ b/testcases/kernel/mem/thp/hzp/hzp02.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  #  Copyright (C) 2015 Linux Test Project.
+#  #
+#  #  Licensed under the GNU GPLv2 or later.
+#  #  This program is free software;  you can redistribute it and/or modify
+#  #  it under the terms of the GNU General Public License as published by
+#  #  the Free Software Foundation; either version 2 of the License, or
+#  #  (at your option) any later version.
+#  #
+#  #  This program is distributed in the hope that it will be useful,
+#  #  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  #  the GNU General Public License for more details.
+#  #
+#  #  You should have received a copy of the GNU General Public License
+#  #  along with this program;  if not, write to the Free Software
+#  #  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#  #
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  #  Description:
+#  #
+#  #  This case measure the time consumption of test program memcmp02 on
+#  #  a system with Huge Zero Page on/off, then judge if the HZP performance
+#  #  well or not from the results comparison.
+#  #
+#  #  Author: Li Wang <liwang@redhat.com>
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+export TCID="hzp02"
+export TST_TOTAL=5
+
+. test.sh
+. hzp_lib.sh
+
+time_elapsed_off=-1
+time_elapsed_on=-1
+
+mem_total=`grep MemTotal: /proc/meminfo |awk '{print $2}'`
+mem_free=`grep MemFree: /proc/meminfo |awk '{print $2}'`
+
+tst_resm TINFO "mem_total= $mem_total kB, mem_free= $mem_free kB."
+
+# Configure Memory testing size
+if [ $mem_total -gt 16777216 ]; then
+	MEM=10
+	NUM=8
+elif [ $mem_total -gt 8388608 ]; then
+	MEM=$(( $mem_free / 1024 / 1000 ))
+	NUM=$(( $MEM - 6 ))
+elif [ $mem_total -gt 2097152 ]; then
+	MEM=2
+	NUM=2
+else
+	tst_brkm TCONF "Sorry, the system RAM is too low to test."
+fi
+
+test_begin()
+{
+	# Testing with use_zero_page disable
+	hzp_off
+	(time -p taskset -c 0 $TPATH/memcmp02 $MEM) 2> memcmp_off.log
+	time_elapse_off=`grep real memcmp_off.log|awk '{print $2}'`
+	tst_resm TINFO "time_elapse_off= $time_elapse_off"
+
+	# Testing with use_zero_page enable
+	hzp_on
+	(time -p taskset -c 0 $TPATH/memcmp02 $MEM) 2> memcmp_on.log
+	time_elapse_on=`grep real memcmp_on.log|awk '{print $2}'`
+	tst_resm TINFO "time_elapse_on= $time_elapse_on"
+}
+
+test_result()
+{
+	# Compare the time cosumption with HZP on/off
+	test_success=`echo "$time_elapse_off > $NUM*$time_elapse_on" |bc`
+	if [ $test_success -eq 1 ]; then
+		tst_resm TPASS "Huge Zero Page performed well."
+	else
+		tst_resm TFAIL "Huge Zero Page performed bad."
+	fi
+}
+
+#--------Test Start----------
+hzp_setup
+
+test_begin
+
+test_result
+
+hzp_cleanup
+
+tst_exit
diff --git a/testcases/kernel/mem/thp/hzp/hzp03.sh b/testcases/kernel/mem/thp/hzp/hzp03.sh
new file mode 100755
index 0000000..1f58d53
--- /dev/null
+++ b/testcases/kernel/mem/thp/hzp/hzp03.sh
@@ -0,0 +1,54 @@
+#!/bin/bash
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  #  Copyright (C) 2015 Linux Test Project.
+#  #
+#  #  Licensed under the GNU GPLv2 or later.
+#  #  This program is free software;  you can redistribute it and/or modify
+#  #  it under the terms of the GNU General Public License as published by
+#  #  the Free Software Foundation; either version 2 of the License, or
+#  #  (at your option) any later version.
+#  #
+#  #  This program is distributed in the hope that it will be useful,
+#  #  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  #  the GNU General Public License for more details.
+#  #
+#  #  You should have received a copy of the GNU General Public License
+#  #  along with this program;  if not, write to the Free Software
+#  #  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#  #
+#  #  Author: Li Wang <liwang@redhat.com>
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+export TCID="hzp03"
+export TST_TOTAL=1
+
+. test.sh
+. hzp_lib.sh
+
+MAX_LOOP=2000
+RC=0
+
+hzp_stress_test()
+{
+	for ((i = 0; i < $MAX_LOOP; i++))
+	{
+		hzp_on || RC=$?
+		hzp_off || RC=$?
+	}
+
+	if [ $RC -eq 0 ]; then
+		tst_resm TPASS "finished running the stress test."
+	else
+		tst_resm TFAIL "please check log message."
+	fi
+}
+
+#--------Test Start----------
+hzp_setup
+
+hzp_stress_test
+
+hzp_cleanup
+
+tst_exit
diff --git a/testcases/kernel/mem/thp/hzp/hzp_lib.sh b/testcases/kernel/mem/thp/hzp/hzp_lib.sh
new file mode 100755
index 0000000..99f417e
--- /dev/null
+++ b/testcases/kernel/mem/thp/hzp/hzp_lib.sh
@@ -0,0 +1,76 @@
+#!/bin/bash
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#  #  Copyright (C) 2015 Linux Test Project.
+#  #
+#  #  Licensed under the GNU GPLv2 or later.
+#  #  This program is free software;  you can redistribute it and/or modify
+#  #  it under the terms of the GNU General Public License as published by
+#  #  the Free Software Foundation; either version 2 of the License, or
+#  #  (at your option) any later version.
+#  #
+#  #  This program is distributed in the hope that it will be useful,
+#  #  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  #  the GNU General Public License for more details.
+#  #
+#  #  You should have received a copy of the GNU General Public License
+#  #  along with this program;  if not, write to the Free Software
+#  #  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#  #
+#  #  Author: Li Wang <liwang@redhat.com>
+#  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+trap tst_exit INT
+
+export TPATH="$PWD"
+export THP_ENABLED="/sys/kernel/mm/transparent_hugepage/enabled"
+export USE_ZERO_PAGE="/sys/kernel/mm/transparent_hugepage/use_zero_page"
+
+hzp=-1
+
+hzp_on()
+{
+	echo 1 >$USE_ZERO_PAGE
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "turn on hzp failed."
+	fi
+}
+
+hzp_off()
+{
+	echo 0 >$USE_ZERO_PAGE
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "turn off hzp failed."
+	fi
+}
+
+hzp_setup()
+{
+	tst_require_root
+
+	# Check to see huge zero page feature is supported or not
+	if [ ! -f $USE_ZERO_PAGE ];then
+		tst_brkm TCONF "The huge zero page is not supported. Skip the test..."
+	fi
+
+	echo always >$THP_ENABLED
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "Enable the THP option failed."
+	fi
+
+	# Save the original value of $USE_ZERO_PAGE
+	hzp=`cat $USE_ZERO_PAGE`
+
+	tst_tmpdir
+}
+
+hzp_cleanup()
+{
+	tst_resm TINFO "hzp cleanup."
+
+	# Reset the $USE_ZERO_PAGE to original value
+	echo $hzp >$USE_ZERO_PAGE
+	rm -f *.log
+
+	tst_rmdir
+}
diff --git a/testcases/kernel/mem/thp/hzp/memcmp01.c b/testcases/kernel/mem/thp/hzp/memcmp01.c
new file mode 100644
index 0000000..2faba78
--- /dev/null
+++ b/testcases/kernel/mem/thp/hzp/memcmp01.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2015 Linux Test Project.
+ *
+ * Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+ * Modify: Li Wang <liwang@redhat.com>
+ *
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#define MB (1UL << 20)
+
+#ifdef __i386__ || __x86_64__
+#define HPAGE_SIZE (2 * MB)
+
+#elif __powerpc__ || __powerpc64__
+#define HPAGE_SIZE (16 * MB)
+
+#elif __s390__ || __s390x__
+#define HPAGE_SIZE (1 * MB)
+
+#else
+#define HPAGE_SIZE (2 * MB)
+#endif
+
+int main(void)
+{
+	char *p;
+	unsigned long i;
+	int ret;
+
+	ret = posix_memalign((void **)&p, HPAGE_SIZE, 100 * HPAGE_SIZE);
+	if (ret) {
+		fprintf(stderr, "posix_memalign: %s\n",
+				strerror(ret));
+		return -1;
+	}
+
+	for (i = 0; i < 100 * HPAGE_SIZE; i += 4096)
+		assert(p[i] == 0);
+	pause();
+	return 0;
+}
diff --git a/testcases/kernel/mem/thp/hzp/memcmp02.c b/testcases/kernel/mem/thp/hzp/memcmp02.c
new file mode 100644
index 0000000..2bbb116
--- /dev/null
+++ b/testcases/kernel/mem/thp/hzp/memcmp02.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2015 Linux Test Project.
+ *
+ * Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+ * Modify: Li Wang <liwang@redhat.com>
+ *
+ */
+
+#include <assert.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#define MB	(1UL << 20)
+#define GB	(1UL << 30)
+
+#ifdef __i386__ || __x86_64__
+#define HPAGE_SIZE (2 * MB)
+
+#elif __powerpc__ || __powerpc64__
+#define HPAGE_SIZE (16 * MB)
+
+#elif __s390__ || __s390x__
+#define HPAGE_SIZE (1 * MB)
+
+#else
+#define HPAGE_SIZE (2 * MB)
+#endif
+
+int main(int argc, char **argv)
+{
+	char *p;
+	int i, ret;
+	int N = atoi(argv[1]);
+
+	if (N < 1) {
+		fprintf(stderr, "Invalid argument\n");
+		exit(1);
+	}
+
+	ret = posix_memalign((void **)&p, HPAGE_SIZE, N * GB);
+	if (ret) {
+		fprintf(stderr, "posix_memalign: %s\n",
+				strerror(ret));
+		return -1;
+	}
+
+	for (i = 0; i < 1000; i++) {
+		char *_p = p;
+
+		while (_p < p+N/2*GB) {
+			assert(*_p == *(_p+N/2*GB));
+			_p += 4096;
+			asm volatile ("" : : : "memory");
+		}
+	}
+
+	free(p);
+
+	return 0;
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
