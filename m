From: Ping Fang <pifang@redhat.com>
Date: Wed, 23 Oct 2019 10:56:06 +0800
Subject: [LTP] [PATCH] syscalls/pkeys/pkey01: build fail MAP_HUGETLB undefine
Message-ID: <20191023025606.24449-1-pifang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

build fail on old distro(based glibc-2.12.1 2010-08-03)
MAP_HUGELTB introduced in glibc-2.11.3 2010-11-30.
include lapi/mmap.h to fix it.

Signed-off-by: Ping Fang <pifang@redhat.com>
---
 testcases/kernel/syscalls/pkeys/pkey.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/pkeys/pkey.h b/testcases/kernel/syscalls/pkeys/pkey.h
index 3c1204978..6e32326b6 100644
--- a/testcases/kernel/syscalls/pkeys/pkey.h
+++ b/testcases/kernel/syscalls/pkeys/pkey.h
@@ -9,6 +9,7 @@
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "lapi/mmap.h"
 
 #ifndef PKEY_DISABLE_ACCESS
 # define PKEY_DISABLE_ACCESS 0x1
-- 
2.21.0

