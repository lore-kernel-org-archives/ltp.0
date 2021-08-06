From: Li Wang <liwang@redhat.com>
Date: Fri,  6 Aug 2021 10:56:59 +0800
Subject: [LTP] [COMMITTED] setsockopt08: includes netinet/in.h
Message-ID: <20210806025659.1962902-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have to put netinet/in.h on the top to get rid of conflict
of glibc and kernel headers for old unbuntu.

  -----------
  /usr/include/linux/in.h:28:3: error: redeclaration of enumerator 'IPPROTO_IP'
        IPPROTO_IP = 0,  /* Dummy protocol for TCP  */
   ^
  /usr/include/netinet/in.h:42:5: note: previous definition of 'IPPROTO_IP' was here
       IPPROTO_IP = 0,    /* Dummy protocol for TCP.  */
  ...
  -----------

See: https://www.mail-archive.com/netdev@vger.kernel.org/msg132711.html

Fixes: ebf3a4fbd39a (Add setsockopt08, CVE-2021-22555)
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/setsockopt/setsockopt08.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index f758dcbdc..f7052f27b 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -79,6 +79,8 @@
  *  - sizeof(struct xt_entry_target) = 32
  */
 
+#include <netinet/in.h>
+
 #include "tst_test.h"
 #include "tst_safe_net.h"
 #include "lapi/ip_tables.h"
-- 
2.31.1

