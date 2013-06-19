Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UpH0z-0007yS-0H
	for ltp-list@lists.sourceforge.net; Wed, 19 Jun 2013 11:57:29 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UpH0v-0005SA-9T
	for ltp-list@lists.sourceforge.net; Wed, 19 Jun 2013 11:57:28 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r5JBp0E2005391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jun 2013 11:51:01 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5JBvH6s025316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jun 2013 11:57:18 GMT
Received: from abhmt102.oracle.com (abhmt102.oracle.com [141.146.116.54])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5JBvHtJ025312
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jun 2013 11:57:17 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 19 Jun 2013 15:56:43 +0400
Message-Id: <1371643003-23373-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3] configure: add configure checks to compile kernel
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
 m4/ltp-kernel_devel.m4       |   76 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 0 deletions(-)
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
index bd364a6..953747c 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -73,4 +73,10 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
+LINUX_VERSION		:=
+LINUX_DIR		:=
+LINUX_VERSION_MAJOR	:=
+LINUX_VERSION_PATCH	:=
+WITH_MODULES		:= no
+
 export datarootdir includedir libdir mandir prefix
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index b835c86..96633f1 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -75,6 +75,12 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
 
+LINUX_VERSION		:= @LINUX_VERSION@
+LINUX_DIR		:= @LINUX_DIR@
+LINUX_VERSION_MAJOR	:= @LINUX_VERSION_MAJOR@
+LINUX_VERSION_PATCH	:= @LINUX_VERSION_PATCH@
+WITH_MODULES		:= @WITH_MODULES@
+
 ifeq ($(strip $(prefix)),)
 $(error you are using $$(prefix) incorrectly -- set it to $(abs_top_srcdir) if you want to build in the source tree)
 endif
diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
new file mode 100644
index 0000000..ba53bc1
--- /dev/null
+++ b/m4/ltp-kernel_devel.m4
@@ -0,0 +1,76 @@
+dnl Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+dnl
+dnl This program is free software; you can redistribute it and/or
+dnl modify it under the terms of the GNU General Public License as
+dnl published by the Free Software Foundation; either version 2 of
+dnl the License, or (at your option) any later version.
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
+AC_DEFUN([LTP_CHECK_KERNEL_DEVEL],[dnl
+
+AC_MSG_CHECKING([for kernel-devel])
+AC_ARG_WITH(
+	[linux-version],
+	[AC_HELP_STRING([--with-linux-version=VERSION],
+			[specify the Linux version to build modules for])],
+	[LINUX_VERSION="${withval}"],
+	AS_IF([test "$cross_compiling" = "no"],
+		[LINUX_VERSION=`uname -r`]))
+
+AC_SUBST(LINUX_VERSION)
+
+AC_ARG_WITH([linux-dir],
+	[AC_HELP_STRING([--with-linux-dir=DIR],
+			[specify path to kernel-devel directory])],
+	[LINUX_DIR="${withval}"],
+	AS_IF([test -n "$LINUX_VERSION"],
+		[LINUX_DIR="/lib/modules/$LINUX_VERSION/build"]))
+
+AC_SUBST(LINUX_DIR)
+
+if test -f "$LINUX_DIR/Makefile"; then
+	LINUX_VERSION_MAJOR=`sed -n '0,/^VERSION = [[0-9]]*/s,\
+^VERSION = ,,p' ${LINUX_DIR}/Makefile`
+
+	LINUX_VERSION_PATCH=`sed -n '0,/^PATCHLEVEL = [[0-9]]*/s,\
+^PATCHLEVEL = ,,p' ${LINUX_DIR}/Makefile`
+fi
+
+if [[ -n "$LINUX_VERSION_MAJOR" -a -n "$LINUX_VERSION_PATCH" ]]; then
+	WITH_MODULES="yes"
+else
+	WITH_MODULES="no"
+fi
+
+AC_SUBST(LINUX_VERSION_MAJOR)
+AC_SUBST(LINUX_VERSION_PATCH)
+
+AC_MSG_RESULT([$WITH_MODULES])
+
+AC_ARG_WITH(
+	[modules],
+	[AC_HELP_STRING([--without-modules],
+			[disable auto-building kernel modules])],
+			[WITH_MODULES="no"],
+			[])
+
+AC_SUBST(WITH_MODULES)
+])
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
