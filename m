Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lgliang@taco.beaverton.ibm.com>) id 1Qt2vS-0008QD-AB
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:34:18 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qt2vR-0006jJ-3L
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:34:18 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7FIsB5r002959
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 12:54:11 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7FIv9wK124454
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 12:57:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7FCugXP017198
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 06:56:42 -0600
From: Lucy Liang <lgliang@linux.vnet.ibm.com>
Date: Mon, 15 Aug 2011 11:56:29 -0700
Message-Id: <1313434593-7942-3-git-send-email-lgliang@linux.vnet.ibm.com>
In-Reply-To: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
References: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.4.1"
Subject: [LTP] [PATCH 3/7 ver2 w/attachment] Added test_repo directory
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.4.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Added the test_repo/ directory, which provides an example of
what the default test scheduler should look like after it is
unpacked. This directory is also used by pounder to fetch
the excluded/ directory when handling creation of new
test schedulers using pounder -c (described in further detail
in doc/SCHEDULER).

Signed-off-by: Lucy Liang <lgliang@linux.vnet.ibm.com>
---
 tools/pounder21/test_repo/D01stats                 |    1 +
 tools/pounder21/test_repo/T00hwinfo                |    1 +
 tools/pounder21/test_repo/T00sysrq_on              |    1 +
 tools/pounder21/test_repo/T01screen_noblank        |    1 +
 .../pounder21/test_repo/T10single/T00xterm_stress  |    1 +
 tools/pounder21/test_repo/T10single/T01ltp         |    1 +
 tools/pounder21/test_repo/T10single/T02ipmitool    |    6 ++++++
 tools/pounder21/test_repo/T90ramp/D01bonnie++      |    5 +++++
 tools/pounder21/test_repo/T90ramp/D02build_kernel  |    5 +++++
 .../pounder21/test_repo/T90ramp/D03copy_large_tree |    5 +++++
 tools/pounder21/test_repo/T90ramp/D04ddhappy       |    5 +++++
 .../pounder21/test_repo/T90ramp/D05ide_cdrom_copy  |    5 +++++
 tools/pounder21/test_repo/T90ramp/D06lame          |    5 +++++
 tools/pounder21/test_repo/T90ramp/D07cpufreq       |    5 +++++
 tools/pounder21/test_repo/T90ramp/D08memtest       |    5 +++++
 tools/pounder21/test_repo/T90ramp/D09memxfer5b     |    5 +++++
 tools/pounder21/test_repo/T90ramp/D10nfs           |    5 +++++
 tools/pounder21/test_repo/T90ramp/D11ramsnake      |    5 +++++
 .../pounder21/test_repo/T90ramp/D12random_syscall  |    5 +++++
 tools/pounder21/test_repo/T90ramp/D13mem_alloc     |    5 +++++
 tools/pounder21/test_repo/T90ramp/D14ltp           |    5 +++++
 .../test_repo/T90ramp/D15time_consistency          |    5 +++++
 tools/pounder21/test_repo/T90ramp/D16time_drift    |    5 +++++
 tools/pounder21/test_repo/T90ramp/D17xterm_stress  |    5 +++++
 tools/pounder21/test_repo/T90ramp/T01rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T02rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T03rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T04rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T05rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T06rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T07rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T08rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T09rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T10rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T11rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T12rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T13rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T14rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T15rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T16rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T17rampup        |    1 +
 tools/pounder21/test_repo/T90ramp/T99runawhile     |    4 ++++
 tools/pounder21/test_repo/T90ramp/ramp_wait        |    3 +++
 tools/pounder21/test_repo/T99screen_blank          |    1 +
 tools/pounder21/test_repo/excluded/testlist        |    7 +++++++
 45 files changed, 129 insertions(+), 0 deletions(-)
 create mode 120000 tools/pounder21/test_repo/D01stats
 create mode 120000 tools/pounder21/test_repo/T00hwinfo
 create mode 120000 tools/pounder21/test_repo/T00sysrq_on
 create mode 120000 tools/pounder21/test_repo/T01screen_noblank
 create mode 120000 tools/pounder21/test_repo/T10single/T00xterm_stress
 create mode 120000 tools/pounder21/test_repo/T10single/T01ltp
 create mode 100755 tools/pounder21/test_repo/T10single/T02ipmitool
 create mode 100755 tools/pounder21/test_repo/T90ramp/D01bonnie++
 create mode 100755 tools/pounder21/test_repo/T90ramp/D02build_kernel
 create mode 100755 tools/pounder21/test_repo/T90ramp/D03copy_large_tree
 create mode 100755 tools/pounder21/test_repo/T90ramp/D04ddhappy
 create mode 100755 tools/pounder21/test_repo/T90ramp/D05ide_cdrom_copy
 create mode 100755 tools/pounder21/test_repo/T90ramp/D06lame
 create mode 100755 tools/pounder21/test_repo/T90ramp/D07cpufreq
 create mode 100755 tools/pounder21/test_repo/T90ramp/D08memtest
 create mode 100755 tools/pounder21/test_repo/T90ramp/D09memxfer5b
 create mode 100755 tools/pounder21/test_repo/T90ramp/D10nfs
 create mode 100755 tools/pounder21/test_repo/T90ramp/D11ramsnake
 create mode 100755 tools/pounder21/test_repo/T90ramp/D12random_syscall
 create mode 100755 tools/pounder21/test_repo/T90ramp/D13mem_alloc
 create mode 100755 tools/pounder21/test_repo/T90ramp/D14ltp
 create mode 100755 tools/pounder21/test_repo/T90ramp/D15time_consistency
 create mode 100755 tools/pounder21/test_repo/T90ramp/D16time_drift
 create mode 100755 tools/pounder21/test_repo/T90ramp/D17xterm_stress
 create mode 120000 tools/pounder21/test_repo/T90ramp/T01rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T02rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T03rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T04rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T05rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T06rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T07rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T08rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T09rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T10rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T11rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T12rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T13rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T14rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T15rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T16rampup
 create mode 120000 tools/pounder21/test_repo/T90ramp/T17rampup
 create mode 100755 tools/pounder21/test_repo/T90ramp/T99runawhile
 create mode 100755 tools/pounder21/test_repo/T90ramp/ramp_wait
 create mode 120000 tools/pounder21/test_repo/T99screen_blank
 create mode 100644 tools/pounder21/test_repo/excluded/testlist


--------------1.7.4.1
Content-Type: text/x-patch; name="0003-Added-test_repo-directory.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0003-Added-test_repo-directory.patch"

diff --git a/tools/pounder21/test_repo/D01stats b/tools/pounder21/test_repo/D01stats
new file mode 120000
index 0000000..5b98648
--- /dev/null
+++ b/tools/pounder21/test_repo/D01stats
@@ -0,0 +1 @@
+../test_scripts/statslogging
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T00hwinfo b/tools/pounder21/test_repo/T00hwinfo
new file mode 120000
index 0000000..e7db6e7
--- /dev/null
+++ b/tools/pounder21/test_repo/T00hwinfo
@@ -0,0 +1 @@
+../test_scripts/get_hw_info
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T00sysrq_on b/tools/pounder21/test_repo/T00sysrq_on
new file mode 120000
index 0000000..d44b81e
--- /dev/null
+++ b/tools/pounder21/test_repo/T00sysrq_on
@@ -0,0 +1 @@
+../test_scripts/sysrq-on
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T01screen_noblank b/tools/pounder21/test_repo/T01screen_noblank
new file mode 120000
index 0000000..c6c8761
--- /dev/null
+++ b/tools/pounder21/test_repo/T01screen_noblank
@@ -0,0 +1 @@
+../test_scripts/screen_noblank
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T10single/T00xterm_stress b/tools/pounder21/test_repo/T10single/T00xterm_stress
new file mode 120000
index 0000000..580fa03
--- /dev/null
+++ b/tools/pounder21/test_repo/T10single/T00xterm_stress
@@ -0,0 +1 @@
+../../test_scripts/xterm_stress
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T10single/T01ltp b/tools/pounder21/test_repo/T10single/T01ltp
new file mode 120000
index 0000000..40eebf5
--- /dev/null
+++ b/tools/pounder21/test_repo/T10single/T01ltp
@@ -0,0 +1 @@
+../../test_scripts/ltp
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T10single/T02ipmitool b/tools/pounder21/test_repo/T10single/T02ipmitool
new file mode 100755
index 0000000..ade36b8
--- /dev/null
+++ b/tools/pounder21/test_repo/T10single/T02ipmitool
@@ -0,0 +1,6 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+
+$POUNDER_HOME/test_scripts/ipmitool
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D01bonnie++ b/tools/pounder21/test_repo/T90ramp/D01bonnie++
new file mode 100755
index 0000000..12483f8
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D01bonnie++
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/bonnie++
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D02build_kernel b/tools/pounder21/test_repo/T90ramp/D02build_kernel
new file mode 100755
index 0000000..3a4fd62
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D02build_kernel
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/build_kernel
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D03copy_large_tree b/tools/pounder21/test_repo/T90ramp/D03copy_large_tree
new file mode 100755
index 0000000..e01b24d
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D03copy_large_tree
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/copy_large_tree
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D04ddhappy b/tools/pounder21/test_repo/T90ramp/D04ddhappy
new file mode 100755
index 0000000..e395ae0
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D04ddhappy
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/ddhappy
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D05ide_cdrom_copy b/tools/pounder21/test_repo/T90ramp/D05ide_cdrom_copy
new file mode 100755
index 0000000..9329b5d
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D05ide_cdrom_copy
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/ide_cdrom_copy
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D06lame b/tools/pounder21/test_repo/T90ramp/D06lame
new file mode 100755
index 0000000..fd09095
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D06lame
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/lame
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D07cpufreq b/tools/pounder21/test_repo/T90ramp/D07cpufreq
new file mode 100755
index 0000000..f490087
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D07cpufreq
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/cpufreq
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D08memtest b/tools/pounder21/test_repo/T90ramp/D08memtest
new file mode 100755
index 0000000..f2843fc
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D08memtest
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/memtest
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D09memxfer5b b/tools/pounder21/test_repo/T90ramp/D09memxfer5b
new file mode 100755
index 0000000..d72b51e
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D09memxfer5b
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/memxfer5b
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D10nfs b/tools/pounder21/test_repo/T90ramp/D10nfs
new file mode 100755
index 0000000..403e4c1
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D10nfs
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/nfs
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D11ramsnake b/tools/pounder21/test_repo/T90ramp/D11ramsnake
new file mode 100755
index 0000000..f78f1a8
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D11ramsnake
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/ramsnake
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D12random_syscall b/tools/pounder21/test_repo/T90ramp/D12random_syscall
new file mode 100755
index 0000000..614ed30
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D12random_syscall
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/random_syscall
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D13mem_alloc b/tools/pounder21/test_repo/T90ramp/D13mem_alloc
new file mode 100755
index 0000000..9e84be5
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D13mem_alloc
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/mem_alloc
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D14ltp b/tools/pounder21/test_repo/T90ramp/D14ltp
new file mode 100755
index 0000000..8f9dcdb
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D14ltp
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/ltp
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D15time_consistency b/tools/pounder21/test_repo/T90ramp/D15time_consistency
new file mode 100755
index 0000000..bca0546
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D15time_consistency
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/time_consistency
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D16time_drift b/tools/pounder21/test_repo/T90ramp/D16time_drift
new file mode 100755
index 0000000..134aa76
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D16time_drift
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/time_drift
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/D17xterm_stress b/tools/pounder21/test_repo/T90ramp/D17xterm_stress
new file mode 100755
index 0000000..e4a87ac
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/D17xterm_stress
@@ -0,0 +1,5 @@
+#!/bin/bash 
+
+trap 'exit 0' 15
+$POUNDER_HOME/infinite_loop $POUNDER_HOME/test_scripts/xterm_stress
+exit $?
diff --git a/tools/pounder21/test_repo/T90ramp/T01rampup b/tools/pounder21/test_repo/T90ramp/T01rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T01rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T02rampup b/tools/pounder21/test_repo/T90ramp/T02rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T02rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T03rampup b/tools/pounder21/test_repo/T90ramp/T03rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T03rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T04rampup b/tools/pounder21/test_repo/T90ramp/T04rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T04rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T05rampup b/tools/pounder21/test_repo/T90ramp/T05rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T05rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T06rampup b/tools/pounder21/test_repo/T90ramp/T06rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T06rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T07rampup b/tools/pounder21/test_repo/T90ramp/T07rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T07rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T08rampup b/tools/pounder21/test_repo/T90ramp/T08rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T08rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T09rampup b/tools/pounder21/test_repo/T90ramp/T09rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T09rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T10rampup b/tools/pounder21/test_repo/T90ramp/T10rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T10rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T11rampup b/tools/pounder21/test_repo/T90ramp/T11rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T11rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T12rampup b/tools/pounder21/test_repo/T90ramp/T12rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T12rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T13rampup b/tools/pounder21/test_repo/T90ramp/T13rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T13rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T14rampup b/tools/pounder21/test_repo/T90ramp/T14rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T14rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T15rampup b/tools/pounder21/test_repo/T90ramp/T15rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T15rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T16rampup b/tools/pounder21/test_repo/T90ramp/T16rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T16rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T17rampup b/tools/pounder21/test_repo/T90ramp/T17rampup
new file mode 120000
index 0000000..cfb100c
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T17rampup
@@ -0,0 +1 @@
+ramp_wait
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/T90ramp/T99runawhile b/tools/pounder21/test_repo/T90ramp/T99runawhile
new file mode 100755
index 0000000..56f1946
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/T99runawhile
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+# Run for two days
+sleep 172800
diff --git a/tools/pounder21/test_repo/T90ramp/ramp_wait b/tools/pounder21/test_repo/T90ramp/ramp_wait
new file mode 100755
index 0000000..edddf42
--- /dev/null
+++ b/tools/pounder21/test_repo/T90ramp/ramp_wait
@@ -0,0 +1,3 @@
+#!/bin/bash
+
+sleep 30
diff --git a/tools/pounder21/test_repo/T99screen_blank b/tools/pounder21/test_repo/T99screen_blank
new file mode 120000
index 0000000..684b876
--- /dev/null
+++ b/tools/pounder21/test_repo/T99screen_blank
@@ -0,0 +1 @@
+../test_scripts/screen_blank
\ No newline at end of file
diff --git a/tools/pounder21/test_repo/excluded/testlist b/tools/pounder21/test_repo/excluded/testlist
new file mode 100644
index 0000000..48c7df5
--- /dev/null
+++ b/tools/pounder21/test_repo/excluded/testlist
@@ -0,0 +1,7 @@
+# The purpose of this file is to keep tabs on
+# which pounder subtests are excluded from the
+# test run. Whenever ./pounder -e subtest-to-exclude
+# is used, the subtest name and path get logged
+# here.
+
+# DO NOT MODIFY THIS FILE.

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.4.1--



