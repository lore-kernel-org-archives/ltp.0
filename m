Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UmLKc-0001bD-A1
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 09:57:38 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UmLKb-0007d0-Ep
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 09:57:38 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r5B9vUxL008510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jun 2013 09:57:31 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5B9vUWX001123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jun 2013 09:57:30 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5B9vT93001110
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jun 2013 09:57:30 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 11 Jun 2013 13:56:10 +0400
Message-Id: <1370944570-5215-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] prot_hsymlinks & cgroup_xattr: fix copyright header
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/controllers/cgroup_xattr/Makefile |    3 ++-
 .../kernel/controllers/cgroup_xattr/cgroup_xattr.c |    3 ++-
 testcases/kernel/security/prot_hsymlinks/Makefile  |    5 +++--
 .../security/prot_hsymlinks/prot_hsymlinks.c       |    3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_xattr/Makefile b/testcases/kernel/controllers/cgroup_xattr/Makefile
index 2d75069..effd5da 100644
--- a/testcases/kernel/controllers/cgroup_xattr/Makefile
+++ b/testcases/kernel/controllers/cgroup_xattr/Makefile
@@ -2,7 +2,8 @@
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
 # This program is distributed in the hope that it would be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index 20473d4..512d505 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -3,7 +3,8 @@
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation.
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it would be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/testcases/kernel/security/prot_hsymlinks/Makefile b/testcases/kernel/security/prot_hsymlinks/Makefile
index cd49588..effd5da 100644
--- a/testcases/kernel/security/prot_hsymlinks/Makefile
+++ b/testcases/kernel/security/prot_hsymlinks/Makefile
@@ -2,7 +2,8 @@
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
 # This program is distributed in the hope that it would be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -11,7 +12,7 @@
 #
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA 
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 82bc770..558681a 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -3,7 +3,8 @@
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation.
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it would be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
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
