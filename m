Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WcphQ-0002Q3-3H
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 05:26:24 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WcphM-0008Hl-RJ
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 05:26:24 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3N5QEnf017378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Apr 2014 05:26:15 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3N5QD2B023798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Apr 2014 05:26:14 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s3N5QDUB028111
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Apr 2014 05:26:13 GMT
From: shuang.qiu@oracle.com
Date: Wed, 23 Apr 2014 13:24:47 +0800
Message-Id: <1398230687-4561-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH v3] containers/netns:parameters are not correct when
	calling, crtchild() function
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

The numbers of parameters for crtchild() function which called in
two_children_ns.c and par_chld_ipv6.c is not correct.And it will make
the child process to be a zombie process.
And also move the definition of the function to the header file(common.h)

Signed-off-by: shuang.qiu@oracle.com
---
 testcases/kernel/containers/libclone/libclone.h    |    2 --
 testcases/kernel/containers/netns/common.c         |    1 +
 testcases/kernel/containers/netns/common.h         |   23 ++++++++++++++++++++
 .../kernel/containers/netns/create_container.c     |    2 +-
 testcases/kernel/containers/netns/crtchild.c       |    2 +-
 .../kernel/containers/netns/crtchild_delchild.c    |    2 +-
 testcases/kernel/containers/netns/par_chld_ftp.c   |    2 +-
 testcases/kernel/containers/netns/par_chld_ipv6.c  |    5 ++---
 testcases/kernel/containers/netns/sysfsview.c      |    2 +-
 .../kernel/containers/netns/two_children_ns.c      |    5 ++---
 10 files changed, 33 insertions(+), 13 deletions(-)
 create mode 100644 testcases/kernel/containers/netns/common.h

diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
index 9380cec..6a2d66d 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -77,8 +77,6 @@
 #define CLONE_NEWNET		0x40000000
 #endif
 
-extern int create_net_namespace(char *, char *);
-
 /*
  * Run fn1 in a unshared environmnent, and fn2 in the original context
  * Fn2 may be NULL.
diff --git a/testcases/kernel/containers/netns/common.c b/testcases/kernel/containers/netns/common.c
index 291aeb7..6862700 100644
--- a/testcases/kernel/containers/netns/common.c
+++ b/testcases/kernel/containers/netns/common.c
@@ -43,6 +43,7 @@
 #include "libclone.h"
 #include "test.h"
 #include "config.h"
+#include "common.h"
 
 static int child_fn(void *c1);
 
diff --git a/testcases/kernel/containers/netns/common.h b/testcases/kernel/containers/netns/common.h
new file mode 100644
index 0000000..d7af403
--- /dev/null
+++ b/testcases/kernel/containers/netns/common.h
@@ -0,0 +1,23 @@
+/*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+* the GNU General Public License for more details.
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+*
+***************************************************************************/
+#ifndef COMMON_H
+#define COMMON_H
+
+int crtchild(char *s1, char *s2);
+
+int create_net_namespace(char *p1, char *c1);
+
+#endif/*COMMON_H*/
diff --git a/testcases/kernel/containers/netns/create_container.c b/testcases/kernel/containers/netns/create_container.c
index 8622153..ad74e4f 100644
--- a/testcases/kernel/containers/netns/create_container.c
+++ b/testcases/kernel/containers/netns/create_container.c
@@ -27,7 +27,7 @@
 * Author: Sudhir Kumar <skumar@linux.vnet.ibm.com>   26/08/2008
 * ============================================================================*/
 
-#include "libclone.h"
+#include "common.h"
 
 const char *TCID = "create_container";
 
diff --git a/testcases/kernel/containers/netns/crtchild.c b/testcases/kernel/containers/netns/crtchild.c
index 7b0d43a..d2769c7 100644
--- a/testcases/kernel/containers/netns/crtchild.c
+++ b/testcases/kernel/containers/netns/crtchild.c
@@ -26,7 +26,7 @@
 *                      31/07/2008
 * =============================================================================*/
 
-#include "libclone.h"
+#include "common.h"
 
 const char *TCID = "crtchild";
 
diff --git a/testcases/kernel/containers/netns/crtchild_delchild.c b/testcases/kernel/containers/netns/crtchild_delchild.c
index 4d37b6f..6b82997 100644
--- a/testcases/kernel/containers/netns/crtchild_delchild.c
+++ b/testcases/kernel/containers/netns/crtchild_delchild.c
@@ -29,7 +29,7 @@
 *                      31/07/2008
 * =========================================================================*/
 
-#include "libclone.h"
+#include "common.h"
 
 const char *TCID = "crtchild_delchild";
 
diff --git a/testcases/kernel/containers/netns/par_chld_ftp.c b/testcases/kernel/containers/netns/par_chld_ftp.c
index 4b9ac71..605be19 100644
--- a/testcases/kernel/containers/netns/par_chld_ftp.c
+++ b/testcases/kernel/containers/netns/par_chld_ftp.c
@@ -26,7 +26,7 @@
 *                      31/07/2008
 * =============================================================================*/
 
-#include "libclone.h"
+#include "common.h"
 
 const char *TCID = "par_chld_ftp";
 
diff --git a/testcases/kernel/containers/netns/par_chld_ipv6.c b/testcases/kernel/containers/netns/par_chld_ipv6.c
index f0d17ba..4d982bc 100644
--- a/testcases/kernel/containers/netns/par_chld_ipv6.c
+++ b/testcases/kernel/containers/netns/par_chld_ipv6.c
@@ -44,8 +44,7 @@
 #include <sys/wait.h>
 #include "test.h"
 #include "config.h"
-
-extern int crtchild(char *);
+#include "common.h"
 
 char *TCID = "netns_ipv6";
 int TST_TOTAL = 1;
@@ -95,7 +94,7 @@ int main()
 #else
 		tst_resm(TCONF, "System doesn't have unshare support");
 #endif
-		return crtchild(child);
+		return crtchild(child, NULL);
 	} else {
 
 		//parent
diff --git a/testcases/kernel/containers/netns/sysfsview.c b/testcases/kernel/containers/netns/sysfsview.c
index b130973..f558f82 100644
--- a/testcases/kernel/containers/netns/sysfsview.c
+++ b/testcases/kernel/containers/netns/sysfsview.c
@@ -36,7 +36,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "libclone.h"
+#include "common.h"
 
 const char *TCID = "sysfsview";
 
diff --git a/testcases/kernel/containers/netns/two_children_ns.c b/testcases/kernel/containers/netns/two_children_ns.c
index 235d9c4..1abff54 100644
--- a/testcases/kernel/containers/netns/two_children_ns.c
+++ b/testcases/kernel/containers/netns/two_children_ns.c
@@ -46,8 +46,7 @@
 #include "test.h"
 #include "libclone.h"
 #include "config.h"
-
-extern int crtchild(char *);
+#include "common.h"
 
 char *TCID = "netns_2children";
 int TST_TOTAL = 1;
@@ -109,7 +108,7 @@ int main()
 				return ret;
 			}
 #endif
-			return crtchild(child[i]);
+			return crtchild(child[i], NULL);
 		} else {
 			//Parent
 
-- 
1.7.9.5


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
