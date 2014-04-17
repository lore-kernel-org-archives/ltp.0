Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1Waioq-0008A4-NT
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 09:41:20 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Waiop-0001cr-JJ
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 09:41:20 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3H9fC7a009228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Apr 2014 09:41:13 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3H9fCFG002775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Apr 2014 09:41:12 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3H9fBjO002769
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Apr 2014 09:41:12 GMT
Message-ID: <534FA1A9.10902@oracle.com>
Date: Thu, 17 Apr 2014 17:40:57 +0800
From: Shuang Qiu <shuang.qiu@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] containers/netns:parameters are not correct when
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
  testcases/kernel/containers/libclone/libclone.h    |    2 -
  testcases/kernel/containers/netns/common.c         |   18 +-------
  testcases/kernel/containers/netns/common.h         |   47 
++++++++++++++++++++
  .../kernel/containers/netns/create_container.c     |    2 +-
  testcases/kernel/containers/netns/crtchild.c       |    2 +-
  .../kernel/containers/netns/crtchild_delchild.c    |    2 +-
  testcases/kernel/containers/netns/par_chld_ftp.c   |    2 +-
  testcases/kernel/containers/netns/par_chld_ipv6.c  |    5 +--
  testcases/kernel/containers/netns/sysfsview.c      |    2 +-
  .../kernel/containers/netns/two_children_ns.c      |    5 +--
  10 files changed, 57 insertions(+), 30 deletions(-)
  create mode 100644 testcases/kernel/containers/netns/common.h

diff --git a/testcases/kernel/containers/libclone/libclone.h 
b/testcases/kernel/containers/libclone/libclone.h
index 9380cec..6a2d66d 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -77,8 +77,6 @@
  #define CLONE_NEWNET        0x40000000
  #endif

-extern int create_net_namespace(char *, char *);
-
  /*
   * Run fn1 in a unshared environmnent, and fn2 in the original context
   * Fn2 may be NULL.
diff --git a/testcases/kernel/containers/netns/common.c 
b/testcases/kernel/containers/netns/common.c
index 291aeb7..67e1a2e 100644
--- a/testcases/kernel/containers/netns/common.c
+++ b/testcases/kernel/containers/netns/common.c
@@ -26,23 +26,7 @@

  #define _GNU_SOURCE

-#include <sys/utsname.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/syscall.h>
-#include <unistd.h>
-#include <signal.h>
-#include <string.h>
-#include <errno.h>
-#include <libgen.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "libclone.h"
-#include "test.h"
-#include "config.h"
+#include "common.h"

  static int child_fn(void *c1);

diff --git a/testcases/kernel/containers/netns/common.h 
b/testcases/kernel/containers/netns/common.h
new file mode 100644
index 0000000..c769a7f
--- /dev/null
+++ b/testcases/kernel/containers/netns/common.h
@@ -0,0 +1,47 @@
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
+* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 
02110-1301 USA
+*
+***************************************************************************/
+/*=========================================================================
+* This testcase creates the network namespace.
+* It creates veth pair veth8 & veth9. Also assigns IP addresses to the 
childNS.
+* Also it starts the sshd daemon @ port 7890
+*
+* Scripts Used: parentns.sh childns.sh
+*
+* Author:         Veerendra <veeren@linux.vnet.ibm.com>
+=========================================================================*/
+
+
+#include <sys/utsname.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <signal.h>
+#include <string.h>
+#include <errno.h>
+#include <libgen.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "libclone.h"
+#include "test.h"
+#include "config.h"
+
+int crtchild(char *s1, char *s2);
+
+int create_net_namespace(char *p1, char *c1);
diff --git a/testcases/kernel/containers/netns/create_container.c 
b/testcases/kernel/containers/netns/create_container.c
index 8622153..ad74e4f 100644
--- a/testcases/kernel/containers/netns/create_container.c
+++ b/testcases/kernel/containers/netns/create_container.c
@@ -27,7 +27,7 @@
  * Author: Sudhir Kumar <skumar@linux.vnet.ibm.com> 26/08/2008
  * 
============================================================================*/

-#include "libclone.h"
+#include "common.h"

  const char *TCID = "create_container";

diff --git a/testcases/kernel/containers/netns/crtchild.c 
b/testcases/kernel/containers/netns/crtchild.c
index 7b0d43a..d2769c7 100644
--- a/testcases/kernel/containers/netns/crtchild.c
+++ b/testcases/kernel/containers/netns/crtchild.c
@@ -26,7 +26,7 @@
  *                      31/07/2008
  * 
=============================================================================*/

-#include "libclone.h"
+#include "common.h"

  const char *TCID = "crtchild";

diff --git a/testcases/kernel/containers/netns/crtchild_delchild.c 
b/testcases/kernel/containers/netns/crtchild_delchild.c
index 4d37b6f..6b82997 100644
--- a/testcases/kernel/containers/netns/crtchild_delchild.c
+++ b/testcases/kernel/containers/netns/crtchild_delchild.c
@@ -29,7 +29,7 @@
  *                      31/07/2008
  * 
=========================================================================*/

-#include "libclone.h"
+#include "common.h"

  const char *TCID = "crtchild_delchild";

diff --git a/testcases/kernel/containers/netns/par_chld_ftp.c 
b/testcases/kernel/containers/netns/par_chld_ftp.c
index 4b9ac71..605be19 100644
--- a/testcases/kernel/containers/netns/par_chld_ftp.c
+++ b/testcases/kernel/containers/netns/par_chld_ftp.c
@@ -26,7 +26,7 @@
  *                      31/07/2008
  * 
=============================================================================*/

-#include "libclone.h"
+#include "common.h"

  const char *TCID = "par_chld_ftp";

diff --git a/testcases/kernel/containers/netns/par_chld_ipv6.c 
b/testcases/kernel/containers/netns/par_chld_ipv6.c
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
-        return crtchild(child);
+        return crtchild(child, NULL);
      } else {

          //parent
diff --git a/testcases/kernel/containers/netns/sysfsview.c 
b/testcases/kernel/containers/netns/sysfsview.c
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

diff --git a/testcases/kernel/containers/netns/two_children_ns.c 
b/testcases/kernel/containers/netns/two_children_ns.c
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
-            return crtchild(child[i]);
+            return crtchild(child[i], NULL);
          } else {
              //Parent

-- 
1.7.9.5

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
