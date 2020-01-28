From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Jan 2020 15:59:44 +0100
Subject: [LTP] [COMMITTED] [PATCH] pty03: Remove termio.h
Message-ID: <20200128145944.30957-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Apparently termio.h is backward compatibility header that just includes
termios.h and sys/ioctl.h. Moreover it's not present on Alpine at least
which broke the build.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/pty/pty03.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index d0dd908da..8514aa43d 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -27,7 +27,6 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
-#include <termio.h>
 #include <termios.h>
 #include <sys/ioctl.h>
 
-- 
2.23.0

