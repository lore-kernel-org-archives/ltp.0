Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1SwyAP-0001cs-41
	for ltp-list@lists.sourceforge.net; Thu, 02 Aug 2012 16:22:29 +0000
Received: from acsinet15.oracle.com ([141.146.126.227])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SwyAO-0006o0-8O
	for ltp-list@lists.sourceforge.net; Thu, 02 Aug 2012 16:22:29 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by acsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with
	ESMTP id q72GMKjV029525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Aug 2012 16:22:21 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Fri,  3 Aug 2012 00:22:08 +0800
Message-Id: <1343924528-1811-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH 1/1] capability: fix sys/capability.h compile error
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
Cc: OEL-QA_WW@oracle.com

Capability testcases fail to compile with sys/capability.h of libcap-devel in
RHEL5-like distros:

In file included from /usr/include/sys/capability.h:34, from cap_bounds_r.c:30:
/usr/include/linux/capability.h:70:
         error: expected specifier-qualifier-list before '__le32'

This is due to sys/capability.h preventing the correct _LINUX_TYPES_H_ from
being included.  The problem can be bypassed by including linux/types.h in
capability testcases.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/kernel/security/cap_bound/cap_bounds_r.c        | 1 +
 testcases/kernel/security/cap_bound/cap_bounds_rw.c       | 1 +
 testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c | 1 +
 testcases/kernel/security/cap_bound/check_pe.c            | 1 +
 testcases/kernel/security/cap_bound/dummy.c               | 1 +
 testcases/kernel/security/cap_bound/exec_with_inh.c       | 1 +
 testcases/kernel/security/cap_bound/exec_without_inh.c    | 1 +
 testcases/kernel/security/filecaps/c.c                    | 1 +
 testcases/kernel/security/filecaps/check_simple_capset.c  | 1 +
 testcases/kernel/security/filecaps/inh_capped.c           | 1 +
 testcases/kernel/security/filecaps/print_caps.c           | 1 +
 testcases/kernel/security/filecaps/verify_caps_exec.c     | 1 +
 testcases/kernel/security/securebits/check_keepcaps.c     | 1 +
 13 files changed, 13 insertions(+)

diff --git a/testcases/kernel/security/cap_bound/cap_bounds_r.c b/testcases/kernel/security/cap_bound/cap_bounds_r.c
index 0c09873..4b28a6f 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_r.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_r.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include <sys/prctl.h>
diff --git a/testcases/kernel/security/cap_bound/cap_bounds_rw.c b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
index 010ace6..e5bcb74 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_rw.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
@@ -26,6 +26,7 @@
 #include <errno.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include <sys/prctl.h>
diff --git a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
index 3a65faf..f4b0bd3 100644
--- a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
+++ b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include <sys/prctl.h>
diff --git a/testcases/kernel/security/cap_bound/check_pe.c b/testcases/kernel/security/cap_bound/check_pe.c
index be16cc5..acdefe5 100644
--- a/testcases/kernel/security/cap_bound/check_pe.c
+++ b/testcases/kernel/security/cap_bound/check_pe.c
@@ -30,6 +30,7 @@
 #include <errno.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include <sys/prctl.h>
diff --git a/testcases/kernel/security/cap_bound/dummy.c b/testcases/kernel/security/cap_bound/dummy.c
index 0559a8e..cb58259 100644
--- a/testcases/kernel/security/cap_bound/dummy.c
+++ b/testcases/kernel/security/cap_bound/dummy.c
@@ -3,6 +3,7 @@
 #include "test.h"
 
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 
diff --git a/testcases/kernel/security/cap_bound/exec_with_inh.c b/testcases/kernel/security/cap_bound/exec_with_inh.c
index dd026ce..4bacfcf 100644
--- a/testcases/kernel/security/cap_bound/exec_with_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_with_inh.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include <sys/prctl.h>
diff --git a/testcases/kernel/security/cap_bound/exec_without_inh.c b/testcases/kernel/security/cap_bound/exec_without_inh.c
index 687e72b..56e9e9d 100644
--- a/testcases/kernel/security/cap_bound/exec_without_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_without_inh.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include <sys/prctl.h>
diff --git a/testcases/kernel/security/filecaps/c.c b/testcases/kernel/security/filecaps/c.c
index fbd0365..76f1803 100644
--- a/testcases/kernel/security/filecaps/c.c
+++ b/testcases/kernel/security/filecaps/c.c
@@ -20,6 +20,7 @@
 
 #include <stdio.h>
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 
diff --git a/testcases/kernel/security/filecaps/check_simple_capset.c b/testcases/kernel/security/filecaps/check_simple_capset.c
index 8f391e0..d1d2ee5 100644
--- a/testcases/kernel/security/filecaps/check_simple_capset.c
+++ b/testcases/kernel/security/filecaps/check_simple_capset.c
@@ -21,6 +21,7 @@
 #include <stdio.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 
diff --git a/testcases/kernel/security/filecaps/inh_capped.c b/testcases/kernel/security/filecaps/inh_capped.c
index b6dfeee..285c2ea 100644
--- a/testcases/kernel/security/filecaps/inh_capped.c
+++ b/testcases/kernel/security/filecaps/inh_capped.c
@@ -27,6 +27,7 @@
 #include <stdio.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include "test.h"
diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcases/kernel/security/filecaps/print_caps.c
index ed40c45..7584820 100644
--- a/testcases/kernel/security/filecaps/print_caps.c
+++ b/testcases/kernel/security/filecaps/print_caps.c
@@ -33,6 +33,7 @@
 #include "config.h"
 
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 
diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index d89df82..f10ce86 100644
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
@@ -38,6 +38,7 @@
 #include <fcntl.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include <sys/prctl.h>
diff --git a/testcases/kernel/security/securebits/check_keepcaps.c b/testcases/kernel/security/securebits/check_keepcaps.c
index 8cb9d22..f5c18eb 100644
--- a/testcases/kernel/security/securebits/check_keepcaps.c
+++ b/testcases/kernel/security/securebits/check_keepcaps.c
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
+#include <linux/types.h>
 #include <sys/capability.h>
 #endif
 #include <sys/prctl.h>
-- 
1.7.11.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
