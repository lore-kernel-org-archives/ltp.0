From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 31 Aug 2021 10:10:03 +0100
Subject: [LTP] [PATCH v2 2/4] bpf: Print full verification log
In-Reply-To: <20210831091005.25361-1-rpalethorpe@suse.com>
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
Message-ID: <20210831091005.25361-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The log never falls within the 1024 byte limit imposed by format
string buffer. So print it separately with dprintf.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/bpf/bpf_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index ba0829a75..aac235cac 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2019-2020 Linux Test Project
  */
 
+#include <stdio.h>
+
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "bpf_common.h"
@@ -118,8 +120,10 @@ int bpf_load_prog(union bpf_attr *const attr, const char *const log)
 	if (ret != -1)
 		tst_brk(TBROK, "Invalid bpf() return value: %d", ret);
 
-	if (log[0] != 0)
-		tst_brk(TBROK | TERRNO, "Failed verification: %s", log);
+	if (log[0] != 0) {
+		tst_printf("%s\n", log);
+		tst_brk(TBROK | TERRNO, "Failed verification");
+	}
 
 	tst_brk(TBROK | TERRNO, "Failed to load program");
 	return ret;
-- 
2.31.1

