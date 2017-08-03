From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:33 +0200
Subject: [LTP] [COMMITTED] [PATCH 9/9] syscalls/splice{04,
	05}: Include lapi/splice.h
In-Reply-To: <20170803135233.13676-1-chrubis@suse.cz>
References: <20170803135233.13676-1-chrubis@suse.cz>
Message-ID: <20170803135233.13676-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes compilation on older distros.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/splice/splice04.c | 1 +
 testcases/kernel/syscalls/splice/splice05.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
index dbdc1048f..852dd0569 100644
--- a/testcases/kernel/syscalls/splice/splice04.c
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -27,6 +27,7 @@
 #include <fcntl.h>
 #include <stdlib.h>
 #include "tst_test.h"
+#include "lapi/splice.h"
 #include "splice.h"
 
 #define PIPE_MAX (64*1024)
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index 4cd1c5f6a..b8ee49cfd 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "tst_test.h"
+#include "lapi/splice.h"
 #include "splice.h"
 
 #define PIPE_MAX (64*1024)
-- 
2.13.0

