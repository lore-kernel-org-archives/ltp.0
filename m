Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Se5JZ-0001Lh-Em
	for ltp-list@lists.sourceforge.net; Mon, 11 Jun 2012 14:09:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Se5JT-0003GH-Ok
	for ltp-list@lists.sourceforge.net; Mon, 11 Jun 2012 14:09:53 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5BE9f9h019316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jun 2012 10:09:41 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q5BE9efn029731
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jun 2012 10:09:40 -0400
Message-ID: <4FD5FC23.3090806@redhat.com>
Date: Mon, 11 Jun 2012 16:09:39 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <cover.1339421791.git.jstancek@redhat.com>
In-Reply-To: <cover.1339421791.git.jstancek@redhat.com>
Content-Type: multipart/mixed; boundary="------------050504070407060102070807"
Subject: [LTP] [PATCH v3 1/3] add testcases/kernel/syscalls/cma
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
--------------050504070407060102070807
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



--------------050504070407060102070807
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


--------------050504070407060102070807
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
--------------050504070407060102070807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050504070407060102070807--

