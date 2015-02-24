Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YQAr5-0000ez-1D
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 08:28:35 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YQAr3-0007eF-Dx
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 08:28:35 +0000
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Tue, 24 Feb 2015 16:27:38 +0800
Message-ID: <1424766459-22439-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] lib: provide a way to detect if we are running on
	KVM or Xen
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
Cc: jjaburek@redhat.com

The command virt-what can be used to detect if the program is
running in a virtual machine, and prints out a list of "facts"
about the virtual machine. such as hyperv, lxc, qemu, kvm, xen
and so on.

Refer to the following for more details,
<http://people.redhat.com/~rjones/virt-what/>

This patch references the method that has already proposed
and implemented in the code of virt-what.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 lib/tst_virt.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 87f73dc..eb3b487 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -23,9 +23,78 @@
  */
 
 #include <unistd.h>
+#include <string.h>
 #include "test.h"
 #include "safe_macros.h"
 
+#define SIG_MAX_LEN 13  // Limit the length of the CPU sign array
+
+#if defined(__i386__) || defined(__x86_64__)
+
+static unsigned int
+cpuid (unsigned int eax, char *sigp)
+{
+    unsigned int *sig32 = (unsigned int *) sigp;
+
+    asm volatile (
+        "xor %%ebx, %%ebx; cpuid"
+        : "=a" (eax), "=b" (sig32[0]), "=c" (sig32[1]), "=d" (sig32[2])
+        : "0" (eax));
+    sigp[SIG_MAX_LEN - 1] = 0;
+
+    return eax;
+}
+
+/*
+ * confirm that we are running inside KVM or Xen HVM by CPU sign
+ *
+ * Inputs:
+ *   char* sigp - the pointer of CPU sign array, sig[].
+ *                Possible Values of sig[]:
+ *                  String        - Virtual Type
+ *                  KVMKVMKVM     - KVM guest
+ *                  XenVMMXenVMM  - Xen HVM guest
+ *
+ * Returns:
+ *   0  - success
+ *   -1 - an error has occurred (unsupported architecture)
+ */
+static int
+cpu_sign (char* sigp)
+{
+    unsigned int base = 0x40000000, leaf = base;
+    unsigned int max_entries;
+
+    memset (sigp, 0, SIG_MAX_LEN);
+    max_entries = cpuid (leaf, sigp);
+
+    /* Most hypervisors only have information in leaf 0x40000000, but
+     * upstream Xen contains further leaf entries (in particular when
+     * used with Viridian [HyperV] extensions).  CPUID is supposed to
+     * return the maximum leaf offset in %eax, so that's what we use,
+     * but only if it looks sensible.
+     */
+    if (max_entries > 3 && max_entries < 0x10000) {
+        for (leaf = base + 0x100; leaf <= base + max_entries; leaf += 0x100) {
+            memset (sigp, 0, SIG_MAX_LEN);
+            cpuid (leaf, sigp);
+        }
+    }
+
+    return 0;
+}
+
+#else /* !i386, !x86_64 */
+
+static int
+cpu_sign (char* sigp)
+{
+    /* nothing for other architectures */
+    return -1;
+}
+
+#endif
+
 static int is_kvm(void)
 {
 	FILE *cpuinfo;
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
