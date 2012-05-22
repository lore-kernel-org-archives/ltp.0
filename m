Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SWpuY-0003AF-H7
	for ltp-list@lists.sourceforge.net; Tue, 22 May 2012 14:18:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SWpuU-0002s6-M3
	for ltp-list@lists.sourceforge.net; Tue, 22 May 2012 14:18:06 +0000
Message-ID: <4FBBA00E.2060606@redhat.com>
Date: Tue, 22 May 2012 16:17:50 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090506020803000404090203"
Subject: [LTP] [PATCH v2 1/3] add testcases/kernel/syscalls/cma
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
--------------090506020803000404090203
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


add directory structure for tests related to syscalls:
process_vm_readv
process_vm_writev

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/cma/Makefile             |   22 ++++++++++++++++++++
 .../kernel/syscalls/cma/process_vm_readv/Makefile  |   22 ++++++++++++++++++++
 .../kernel/syscalls/cma/process_vm_writev/Makefile |   22 ++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/cma/Makefile
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv/Makefile
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_writev/Makefile



--------------090506020803000404090203
Content-Type: text/x-patch; name="0001-add-testcases-kernel-syscalls-cma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-add-testcases-kernel-syscalls-cma.patch"

diff --git a/testcases/kernel/syscalls/cma/Makefile b/testcases/kernel/syscalls/cma/Makefile
new file mode 100644
index 0000000..39d4657
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (C) 2012 Linux Test Project, Inc.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv/Makefile b/testcases/kernel/syscalls/cma/process_vm_readv/Makefile
new file mode 100644
index 0000000..f10cac2
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_vm_readv/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (C) 2012 Linux Test Project, Inc.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir              ?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev/Makefile b/testcases/kernel/syscalls/cma/process_vm_writev/Makefile
new file mode 100644
index 0000000..f10cac2
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_vm_writev/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (C) 2012 Linux Test Project, Inc.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir              ?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk


--------------090506020803000404090203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------090506020803000404090203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090506020803000404090203--

