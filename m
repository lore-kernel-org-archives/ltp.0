Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WYXjN-0002ea-Jh
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 09:26:41 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WYXjL-0007JL-Ie
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 09:26:41 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3B9QX9c014818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 09:26:34 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3B9QVtY004158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 09:26:32 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3B9QVbM022309
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 09:26:31 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 11 Apr 2014 13:26:59 +0400
Message-Id: <1397208419-27737-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] configure: add configure check for GCC
	-Wold-style-definition
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
Cc: vasily.isaenko@oracle.com

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 configure.ac            |    1 +
 include/mk/config.mk.in |    2 +-
 m4/ltp-gcc_option.m4    |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletions(-)
 create mode 100644 m4/ltp-gcc_option.m4

diff --git a/configure.ac b/configure.ac
index 44016e7..23bd02a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,5 +175,6 @@ LTP_CHECK_FCHOWNAT
 LTP_CHECK_MKNODAT
 LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
+LTP_CHECK_GCC_OPTION
 
 AC_OUTPUT
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index c83d08c..478b899 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -66,7 +66,7 @@ DEBUG_CXXFLAGS		?= $(DEBUG_CFLAGS)
 OPT_CFLAGS		?= -O2 -fno-strict-aliasing -pipe
 OPT_CXXFLAGS		?= $(OPT_CFLAGS)
 
-WCFLAGS			?= -Wall -W -Wold-style-definition
+WCFLAGS			?= -Wall -W @GCC_WARN_OLDSTYLE@
 WCXXFLAGS		?= $(WCFLAGS)
 
 LDFLAGS			+= $(WLDFLAGS)
diff --git a/m4/ltp-gcc_option.m4 b/m4/ltp-gcc_option.m4
new file mode 100644
index 0000000..93e67cd
--- /dev/null
+++ b/m4/ltp-gcc_option.m4
@@ -0,0 +1,37 @@
+dnl Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+AC_DEFUN([LTP_CHECK_GCC_OPTION],[dnl
+
+AC_MSG_CHECKING([for gcc -Wold-style-definition])
+
+backup_cflags="$CFLAGS"
+CFLAGS="-Wold-style-definition"
+
+AC_LINK_IFELSE(
+	[AC_LANG_PROGRAM([])],
+	[GCC_WARN_OLDSTYLE="$CFLAGS"]
+	[AC_MSG_RESULT([yes])],
+	[AC_MSG_RESULT([no])]
+)
+
+AC_SUBST(GCC_WARN_OLDSTYLE)
+CFLAGS="$backup_cflags"
+
+])
-- 
1.7.1


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
