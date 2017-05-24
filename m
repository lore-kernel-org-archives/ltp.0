From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 May 2017 14:05:55 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/2] fallocate02: Fix compilation
In-Reply-To: <20170524120555.26571-1-chrubis@suse.cz>
References: <20170524120555.26571-1-chrubis@suse.cz>
Message-ID: <20170524120555.26571-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes commit:

commit a14f756d5890cee192f1cffe403b7607074a9b72
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Tue May 23 16:25:25 2017 +02001

    Unify MIN()/MAX() implementation + cleanup

The LLONG_MAX definition is missing on some distributions unless the
test includes limits.h as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fallocate/fallocate02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index bee0863a8..4840eaf28 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -36,6 +36,7 @@
 #include <fcntl.h>
 #include <inttypes.h>
 #include <sys/utsname.h>
+#include <limits.h>
 
 #include "test.h"
 #include "safe_macros.h"
-- 
2.13.0

