From: Jan Stancek <jstancek@redhat.com>
Date: Sun, 27 Oct 2019 09:22:29 +0100
Subject: [LTP] [PATCH COMMITTED] mtest06/mmap1: add missing lapi/abisize.h
 include
In-Reply-To: <CA+G9fYvdOcsqZ8M4VfOinnGGiacSL9rms5cnSkPK-cuZKNNP=w@mail.gmail.com>
References: <CA+G9fYvdOcsqZ8M4VfOinnGGiacSL9rms5cnSkPK-cuZKNNP=w@mail.gmail.com>
Message-ID: <74d9fe32fda90a76c130491bdb4d0656aea6dcb1.1572164382.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Naresh reported failures on 32-bit systems, with strace showing
test trying to mmap 2G area.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 1 +
 1 file changed, 1 insertion(+)

@Naresh: Can you give a try with this patch?

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 8d84a0bb76f3..c5417444fe9e 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -28,6 +28,7 @@
 #include <setjmp.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "lapi/abisize.h"
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
 
-- 
1.8.3.1

