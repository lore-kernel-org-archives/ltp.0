Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Ukb5d-0001GH-PU
	for ltp-list@lists.sourceforge.net; Thu, 06 Jun 2013 14:22:57 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ukb5b-0003ZX-QW
	for ltp-list@lists.sourceforge.net; Thu, 06 Jun 2013 14:22:57 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r56EMkSo030565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jun 2013 14:22:47 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r56EMmsn000226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jun 2013 14:22:48 GMT
Received: from abhmt111.oracle.com (abhmt111.oracle.com [141.146.116.63])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r56EMmZh008267
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jun 2013 14:22:48 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  6 Jun 2013 18:21:47 +0400
Message-Id: <1370528507-15313-1-git-send-email-alexey.kodanev@oracle.com>
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
 include/mk/config.mk.default |    6 +++
 include/mk/config.mk.in      |    6 +++
 m4/ltp-kernel_devel.m4       |   72 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 0 deletions(-)
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
index bd364a6..558e856 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -73,4 +73,10 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
+KBUILD_RELEASE		:=
+KBUILD_DIR		:=
+KBUILD_VERSION		:=
+KBUILD_PATCHLEVEL	:=
+WITH_MODULES		:= no
+
 export datarootdir includedir libdir mandir prefix
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index b835c86..d38e5f1 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -75,6 +75,12 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
+KBUILD_RELEASE		:= @KBUILD_RELEASE@
+KBUILD_DIR		:= @KBUILD_DIR@
+KBUILD_VERSION		:= @KBUILD_VERSION@
+KBUILD_PATCHLEVEL	:= @KBUILD_PATCHLEVEL@
+WITH_MODULES		:= @WITH_MODULES@
+
 ifeq ($(strip $(prefix)),)
 $(error you are using $$(prefix) incorrectly -- set it to $(abs_top_srcdir) if you want to build in the source tree)
 endif
diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
new file mode 100644
index 0000000..cf4a56e
--- /dev/null
+++ b/m4/ltp-kernel_devel.m4
@@ -0,0 +1,72 @@
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
+	    [kbuild-release],
+	    [AC_HELP_STRING([--with-kbuild-release=RELEASE],
+			    [specify the kernel release to build modules for])],
+	    [KBUILD_RELEASE="${withval}"],
+	    [KBUILD_RELEASE=`uname -r`])
+
+AC_SUBST(KBUILD_RELEASE)
+
+AC_ARG_WITH([kbuild-dir],
+	    [AC_HELP_STRING([--with-kbuild-dir=DIR],
+			    [specify path to kernel-devel directory])],
+	    [KBUILD_DIR="${withval}"],
+	    [KBUILD_DIR="/lib/modules/$KBUILD_RELEASE/build"])
+
+AC_SUBST(KBUILD_DIR)
+
+WITH_MODULES="no"
+
+if test -f "$KBUILD_DIR/Makefile"; then
+
+	KBUILD_VERSION=`grep -o '^VERSION = [[0-9]]*' -m 1 \
+"${KBUILD_DIR}/Makefile" | grep -o '[[0-9]]*'`
+
+	KBUILD_PATCHLEVEL=`grep -o "^PATCHLEVEL = [[0-9]]*" -m 1 \
+"${KBUILD_DIR}/Makefile" | grep -o "[[0-9]]*"`
+
+	if [[ -n "$KBUILD_VERSION" ]] && [[ -n "$KBUILD_PATCHLEVEL" ]]; then
+		WITH_MODULES="yes"
+	fi
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
+AC_SUBST(KBUILD_VERSION)
+AC_SUBST(KBUILD_PATCHLEVEL)
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
