From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Fri, 28 Jun 2019 17:37:09 +0800
Subject: [LTP] [PATCH] cve/meltdown.c: abort the test if kallsyms was not
 enabled
Message-ID: <20190628093709.6625-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The cve-2017-5754 meltdown test does not work with a kernel that does
not have CONFIG_KALLSYMS enabled (e.g. Ubuntu KVM kernel).

Add and extra check for /proc/kallsyms to determine if we can run it.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/cve/meltdown.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index 1a3303ec0..f78c38b80 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -269,6 +269,9 @@ find_kernel_symbol(const char *name)
 	struct utsname utsname;
 	unsigned long addr;
 
+	if (access("/proc/kallsyms", F_OK) == -1)
+		tst_brk(TCONF, "/proc/kallsyms not enabled");
+
 	addr = find_symbol_in_file("/proc/kallsyms", name);
 	if (addr)
 		return addr;
-- 
2.17.1

