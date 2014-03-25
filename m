Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSI2-0007vP-A1
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:18 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSI0-0005w6-C3
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:18 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEP9DO006371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:10 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s2PEP9TY006176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:09 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEP8Ge004862
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:08 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:29 +0400
Message-Id: <1395757480-27424-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 03/14] Implemented autoconf check for libtirpc
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

This library is needed to build testcases/network/rpc/rpc-tirpc.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 configure.ac                 |    1 +
 include/mk/config.mk.default |    2 ++
 include/mk/config.mk.in      |    2 ++
 m4/ltp-tirpc.m4              |   34 ++++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 m4/ltp-tirpc.m4

diff --git a/configure.ac b/configure.ac
index 44016e7..c44149b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,5 +175,6 @@ LTP_CHECK_FCHOWNAT
 LTP_CHECK_MKNODAT
 LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
+LTP_CHECK_TIRPC
 
 AC_OUTPUT
diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index ea82766..20d8323 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -42,6 +42,8 @@ YACC			:= bison -y
 #NUMA_CPPFLAGS		:= -DNUMA_VERSION1_COMPATIBILITY
 #NUMA_LIBS		:= -lnuma
 #SELINUX_LIBS		:= -lselinux
+#TIRPC_CPPFLAGS		:= -I/usr/include/tirpc
+#TIRPC_LIBS		:= -ltirpc
 
 prefix			:= /opt/ltp
 
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index c83d08c..e1e02b6 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -44,6 +44,8 @@ LEXLIB			:= @LEXLIB@
 NUMA_CPPFLAGS		:= @NUMA_CPPFLAGS@
 NUMA_LIBS		:= @NUMA_LIBS@
 SELINUX_LIBS		:= @SELINUX_LIBS@
+TIRPC_CPPFLAGS		:= @TIRPC_CPPFLAGS@
+TIRPC_LIBS		:= @TIRPC_LIBS@
 
 prefix			:= @prefix@
 
diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
new file mode 100644
index 0000000..73fde51
--- /dev/null
+++ b/m4/ltp-tirpc.m4
@@ -0,0 +1,34 @@
+dnl
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
+
+dnl
+dnl LTP_CHECK_TIRPC
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_TIRPC],[
+	TIRPC_CPPFLAGS=""
+	TIRPC_LIBS=""
+
+	AC_CHECK_HEADER(tirpc/netconfig.h,[
+		TIRPC_CPPFLAGS="-I/usr/include/tirpc"
+		AC_DEFINE(HAVE_LIBTIRPC, 1, [Define to 1 if you have libtirpc headers installed])
+		AC_CHECK_LIB(tirpc, rpcb_set, [TIRPC_LIBS="-ltirpc"])])
+
+	AC_SUBST(TIRPC_CPPFLAGS)
+	AC_SUBST(TIRPC_LIBS)
+])
-- 
1.7.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
