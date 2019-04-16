From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Apr 2019 15:34:33 +0200
Subject: [LTP] [PATCH] [COMMITTED] runtest/syscalls: Add entry for fanotify12
Message-ID: <20190416133433.21708-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes:
commit 579a27b8c3e496a74614836e80a5f4b5085c050c
Author: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date:   Sat Oct 27 21:09:01 2018 +1100

    syscalls/fanotify12: add new test to support new FAN_OPEN_EXEC event mask

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 runtest/syscalls | 1 +
 1 file changed, 1 insertion(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 5267c4d93..2b8ca719b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -536,6 +536,7 @@ fanotify08 fanotify08
 fanotify09 fanotify09
 fanotify10 fanotify10
 fanotify11 fanotify11
+fanotify12 fanotify12
 
 ioperm01 ioperm01
 ioperm02 ioperm02
-- 
2.19.2

