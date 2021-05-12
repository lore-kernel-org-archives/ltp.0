From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 12:07:46 +0200
Subject: [LTP] [PATCH 1/1] netns_netlink: Check ip tuntap support
Message-ID: <20210512100746.5907-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

11b1fea9d removed ip version check. Although check shouldn't be needed
because version 100519 (v2.6.34) is old enough, add check.

Instead of parsing ip version just try run 'ip tuntap'.

Fixes: ("netns_netlink: Rewrite into new API")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Cyril,

feel free to reject this as most of the distros having that old kernel
will also have too old toolchain to compile recent LTP
(tst_netdevice.c:218:44: error: use of undeclared identifier
'IFA_FLAGS').

Kind regards,
Petr

 testcases/kernel/containers/netns/netns_netlink.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index 1e8e78fc5..ab56afb99 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -36,11 +36,19 @@
 #include <sched.h>
 
 #include "tst_test.h"
+#include "tst_cmd.h"
 #include "tst_safe_macros.h"
 #include "lapi/namespaces_constants.h"
 
 #define MAX_TRIES 1000
 
+static void setup(void)
+{
+	if (tst_cmd((const char *const []){"ip", "tuntap", NULL}, "/dev/null",
+		      NULL, TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING))
+		tst_brk(TCONF, "ip missing tuntap support");
+}
+
 static void child_func(void)
 {
 	int fd, len, event_found, tries;
@@ -114,6 +122,7 @@ static void test_netns_netlink(void)
 
 
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = test_netns_netlink,
 	.needs_checkpoints = 1,
 	.needs_tmpdir = 1,
-- 
2.31.1

