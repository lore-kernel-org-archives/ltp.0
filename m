From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jan 2018 15:56:41 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/2] endian_switch01: Fix build on older
	distros.
In-Reply-To: <20180117145641.21103-1-chrubis@suse.cz>
References: <20180117145641.21103-1-chrubis@suse.cz>
Message-ID: <20180117145641.21103-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes build failures:

...
In function `test_le_switch':
endian_switch01.c:84: undefined reference to `WIFSIGNALED'
endian_switch01.c:88: undefined reference to `WIFEXITED'
endian_switch01.c:85: undefined reference to `WTERMSIG'
endian_switch01.c:89: undefined reference to `WEXITSTATUS'
...
collect2: ld returned 1 exit status

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/switch/endian_switch01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/switch/endian_switch01.c b/testcases/kernel/syscalls/switch/endian_switch01.c
index 3e5ff47fc..777280afb 100644
--- a/testcases/kernel/syscalls/switch/endian_switch01.c
+++ b/testcases/kernel/syscalls/switch/endian_switch01.c
@@ -27,6 +27,8 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <elf.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include "tst_test.h"
 
 #if defined (__powerpc64__) || (__powerpc__)
-- 
2.13.6

