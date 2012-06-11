Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Se5JZ-0006um-4C
	for ltp-list@lists.sourceforge.net; Mon, 11 Jun 2012 14:09:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Se5JY-0003GO-HZ
	for ltp-list@lists.sourceforge.net; Mon, 11 Jun 2012 14:09:53 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5BE9l0i027886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jun 2012 10:09:47 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q5BE9iD7017617
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jun 2012 10:09:46 -0400
Message-ID: <4FD5FC28.9040208@redhat.com>
Date: Mon, 11 Jun 2012 16:09:44 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <cover.1339421791.git.jstancek@redhat.com>
In-Reply-To: <cover.1339421791.git.jstancek@redhat.com>
Content-Type: multipart/mixed; boundary="------------080705030009050709070701"
Subject: [LTP] [PATCH v3 2/3] cma: add process_vm.h
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
--------------080705030009050709070701
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


header file shared by tests, defines:
test_process_vm_readv
test_process_vm_writev

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/cma/process_vm.h |   58 ++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/cma/process_vm.h



--------------080705030009050709070701
Content-Type: text/x-patch;
 name="0002-cma-add-process_vm.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-cma-add-process_vm.h.patch"

diff --git a/testcases/kernel/syscalls/cma/process_vm.h b/testcases/kernel/syscalls/cma/process_vm.h
new file mode 100644
index 0000000..04176c9
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_vm.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2012 Linux Test Project, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+#ifndef _PROCESS_VM_H_
+#define _PROCESS_VM_H_
+
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+static inline ssize_t test_process_vm_readv(pid_t pid,
+		const struct iovec *lvec, unsigned long liovcnt,
+		const struct iovec *rvec, unsigned long riovcnt,
+		unsigned long flags)
+{
+#if defined(__NR_process_vm_readv)
+	return syscall(__NR_process_vm_readv, pid, lvec, liovcnt,
+			rvec, riovcnt, flags);
+#else
+	return syscall(-1);
+#endif
+}
+
+static inline ssize_t test_process_vm_writev(pid_t pid,
+		const struct iovec *lvec, unsigned long liovcnt,
+		const struct iovec *rvec, unsigned long riovcnt,
+		unsigned long flags)
+{
+#if defined(__NR_process_vm_writev)
+	return syscall(__NR_process_vm_writev, pid, lvec, liovcnt,
+			rvec, riovcnt, flags);
+#else
+	return syscall(-1);
+#endif
+}
+
+#endif /* _PROCESS_VM_H_ */


--------------080705030009050709070701
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
--------------080705030009050709070701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080705030009050709070701--

