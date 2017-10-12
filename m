From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 12 Oct 2017 09:38:39 +0200
Subject: [LTP] [PATCH] Assign CVE number to add_key02
Message-ID: <20171012073839.3783-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve                                   | 1 +
 testcases/kernel/syscalls/add_key/add_key02.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 8c140b5cb..37db825b3 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -17,4 +17,5 @@ cve-2017-2671 cve-2017-2671
 cve-2017-5669 cve-2017-5669
 cve-2017-6951 cve-2017-6951
 cve-2017-7472 keyctl04
+CVE-2017-15274 add_key02
 cve-2017-1000364 stack_clash
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index ce467308d..369e828e3 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -30,6 +30,8 @@
  * can, in the hope of catching one.  We also test with the "user" key type for
  * good measure, although it was one of the types that failed with EINVAL rather
  * than dereferencing NULL.
+ *
+ * This has been assigned CVE-2017-15274.
  */
 
 #include <errno.h>
-- 
2.14.2

