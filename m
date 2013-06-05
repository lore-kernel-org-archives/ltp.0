Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UkCPs-0005Xr-Us
	for ltp-list@lists.sourceforge.net; Wed, 05 Jun 2013 12:02:13 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UkCPr-0004Ei-Ss
	for ltp-list@lists.sourceforge.net; Wed, 05 Jun 2013 12:02:12 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r55C23a6029886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Jun 2013 12:02:03 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r55C24mJ001670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Jun 2013 12:02:05 GMT
Received: from abhmt109.oracle.com (abhmt109.oracle.com [141.146.116.61])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r55C24Hv026350
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Jun 2013 12:02:04 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  5 Jun 2013 16:01:14 +0400
Message-Id: <1370433674-6838-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] configure: add configure checks to compile kernel
	modules
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

There're new configure options added to tune modules building process.
New m4 function tries to determine if kernel-devel package is available
and sets makefile's variables (WITH_MODULES, ...) accordingly.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 configure.ac                 |    1 +
 include/mk/config.mk.default |    4 +++
 include/mk/config.mk.in      |    4 +++
 m4/ltp-kernel_devel.m4       |   61 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 m4/ltp-kernel_devel.m4

diff --git a/configure.ac b/configure.ac
index f217f50..f0fc6b0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -167,5 +167,6 @@ LTP_CHECK_MADVISE
 LTP_CHECK_ACL_SUPPORT
 LTP_CHECK_FS_IOC_FLAGS
 LTP_CHECK_MREMAP_FIXED
+LTP_CHECK_KERNEL_DEVEL
 
 AC_OUTPUT
diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index bd364a6..8eec868 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -73,4 +73,8 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
+KERNEL_RELEASE		:=
+KERNEL_DEVEL_DIR	:=
+WITH_MODULES		:= no
+
 export datarootdir includedir libdir mandir prefix
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index b835c86..4edd22a 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -75,6 +75,10 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
+KERNEL_RELEASE		:= @KERNEL_RELEASE@
+KERNEL_DEVEL_DIR	:= @KERNEL_DEVEL_DIR@
+WITH_MODULES		:= @WITH_MODULES@
+
 ifeq ($(strip $(prefix)),)
 $(error you are using $$(prefix) incorrectly -- set it to $(abs_top_srcdir) if you want to build in the source tree)
 endif
diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
new file mode 100644
index 0000000..f58ee2e
--- /dev/null
+++ b/m4/ltp-kernel_devel.m4
@@ -0,0 +1,61 @@
+dnl Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+dnl
+dnl This program is free software; you can redistribute it and/or
+dnl modify it under the terms of the GNU General Public License as
+dnl published by the Free Software Foundation.
+dnl
+dnl This program is distributed in the hope that it would be useful,
+dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+dnl GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program; if not, write the Free Software Foundation,
+dnl Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+dnl
+dnl Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+dnl
+
+dnl
+dnl LTP_CHECK_KERNEL_DEVEL
+dnl ----------------------------
+dnl Building kernel modules
+dnl requires kernel-devel installed
+dnl
+
+AC_DEFUN([LTP_CHECK_KERNEL_DEVEL],
+[
+AC_ARG_WITH(
+	    [kernel-release],
+	    [AC_HELP_STRING([--with-kernel-release=RELEASE],
+			    [specify the kernel release to build modules for])],
+	    [KERNEL_RELEASE="${withval}"],
+	    [KERNEL_RELEASE=`uname -r`])
+
+AC_SUBST(KERNEL_RELEASE)
+
+AC_ARG_WITH([kernel-devel],
+	    [AC_HELP_STRING([--with-kernel-devel=DIR],
+			    [specify path to kernel-devel directory])],
+	    [KERNEL_DEVEL_DIR="${withval}"],
+	    [KERNEL_DEVEL_DIR="/lib/modules/$KERNEL_RELEASE/build"])
+
+AC_SUBST(KERNEL_DEVEL_DIR)
+
+if test -f "$KERNEL_DEVEL_DIR/Makefile"; then
+	WITH_MODULES="yes"
+else
+	WITH_MODULES="no"
+fi
+
+AC_MSG_RESULT([checking for kernel-devel... $WITH_MODULES])
+
+AC_ARG_WITH(
+	    [modules],
+	    [AC_HELP_STRING([--without-modules],
+			    [disable auto-building kernel modules])],
+			    [WITH_MODULES="no"],
+			    [])
+
+AC_SUBST(WITH_MODULES)
+])
-- 
1.7.1


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
