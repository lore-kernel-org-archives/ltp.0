Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SMGZ2-000662-DD
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 10:32:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SMGZ1-0004m8-Ed
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 10:32:12 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3NAW5ud003127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Apr 2012 06:32:05 -0400
Message-ID: <4F952FA2.7060305@redhat.com>
Date: Mon, 23 Apr 2012 12:32:02 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080506040505090304060607"
Subject: [LTP] [PATCH 1/3] configure: check if process_vm_read/write is
	supported
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
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------080506040505090304060607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


CMA (cross memory attach) patch introduced 2 new syscalls:
process_vm_readv
process_vm_writev

Check in configure if these are supported.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 configure.ac  |    1 +
 m4/ltp-cma.m4 |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 m4/ltp-cma.m4



--------------080506040505090304060607
Content-Type: text/x-patch;
	name="0001-configure-check-if-process_vm_read-write-is-supporte.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-configure-check-if-process_vm_read-write-is-supporte.pa";
	filename*1="tch"

diff --git a/configure.ac b/configure.ac
index 1696df0..55ee132 100644
--- a/configure.ac
+++ b/configure.ac
@@ -166,5 +166,6 @@ LTP_CHECK_MADVISE
 LTP_CHECK_ACL_SUPPORT
 LTP_CHECK_FS_IOC_FLAGS
 LTP_CHECK_MREMAP_FIXED
+LTP_CHECK_SYSCALLS_CMA
 
 AC_OUTPUT
diff --git a/m4/ltp-cma.m4 b/m4/ltp-cma.m4
new file mode 100644
index 0000000..8867a5e
--- /dev/null
+++ b/m4/ltp-cma.m4
@@ -0,0 +1,67 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2012
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+dnl
+
+dnl
+dnl LTP_CHECK_SYSCALLS_CMA
+dnl ----------------------------
+dnl
+dnl
+dnl
+
+AC_DEFUN([LTP_CHECK_SYSCALLS_CMA],[
+_LTP_CHECK_SYSCALL_PROCESS_VM_READV
+_LTP_CHECK_SYSCALL_PROCESS_VM_WRITEV
+])
+
+dnl _LTP_CHECK_SYSCALL_PROCESS_VM_READV
+AC_DEFUN([_LTP_CHECK_SYSCALL_PROCESS_VM_READV],[dnl
+AC_MSG_CHECKING([for process_vm_readv])
+AC_LINK_IFELSE([AC_LANG_SOURCE([
+#include <sys/uio.h>
+#include <stdlib.h>
+int main(void) {
+        (void) process_vm_readv(0, NULL, 0, NULL, 0 ,0);
+        return 0;
+}])],[has_process_vm_readv="yes"])
+if test "x$has_process_vm_readv" = "xyes"; then
+        AC_DEFINE(HAVE_PROCESS_VM_READV,1,[Define to 1 if process_vm_readv is present])
+	AC_MSG_RESULT(yes)
+else
+        AC_DEFINE(HAVE_PROCESS_VM_READV,0,[Define to 1 if process_vm_readv is present])
+	AC_MSG_RESULT(no)
+fi
+])
+
+dnl _LTP_CHECK_SYSCALL_PROCESS_VM_WRITEV
+AC_DEFUN([_LTP_CHECK_SYSCALL_PROCESS_VM_WRITEV],[dnl
+AC_MSG_CHECKING([for process_vm_writev])
+AC_LINK_IFELSE([AC_LANG_SOURCE([
+#include <sys/uio.h>
+#include <stdlib.h>
+int main(void) {
+        (void) process_vm_writev(0, NULL, 0, NULL, 0 ,0);
+        return 0;
+}])],[has_process_vm_writev="yes"])
+if test "x$has_process_vm_writev" = "xyes"; then
+        AC_DEFINE(HAVE_PROCESS_VM_WRITEV,1,[Define to 1 if process_vm_writev is present])
+	AC_MSG_RESULT(yes)
+else
+        AC_DEFINE(HAVE_PROCESS_VM_WRITEV,0,[Define to 1 if process_vm_writev is present])
+	AC_MSG_RESULT(no)
+fi
+])


--------------080506040505090304060607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2

--------------080506040505090304060607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080506040505090304060607--

