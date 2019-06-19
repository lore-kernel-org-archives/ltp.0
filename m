From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jun 2019 17:07:28 +0200
Subject: [LTP] [PATCH] [COMMITTED] runtest: Fix asyncio02 -> stat02 rename
Message-ID: <20190619150728.32578-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes:

commit d0789f774b559ad87760b6958a58e6e2fd7f0dbe
Author: Sandeep Patil <sspatil@android.com>
Date:   Sun Jun 9 17:26:09 2019 -0700

    syscalls/asyncio02: convert to new library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/quickhit | 15 ---------------
 runtest/syscalls |  4 ++--
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/runtest/quickhit b/runtest/quickhit
index 9e6ad3ed4..e01b838fb 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -20,21 +20,6 @@ alarm03 alarm03
 #    TEST CASES
 # 	1.) alarm(100), fork, child's alarm(0) shall return 0;
 #	2.) alarm(100), fork, parent's alarm(0) shall return non-zero.
-asyncio02 asyncio02
-# 	Attempt to get some memory to work with.
-# 	Call testrun writing (BUFSIZ + 1) bytes
-# 	Call testrun writing BUFSIZ bytes
-# 	Repeated call to testrun() with decreasing write sizes
-# 		less than BUFSIZ
-# 	End
-#
-# 	Start testrun()
-# 	Attempt to open a temporary file.
-# 	Write the memory to the file.
-# 	Attempt to close the file which also flushes the buffers.
-# 	Now check to see if the number of bytes written is the
-# 		same as the number of bytes in the file.
-# 	Cleanup
 brk01 brk01
 # Basic test for brk()
 #    TEST CASES
diff --git a/runtest/syscalls b/runtest/syscalls
index a1106fb84..fda93e319 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -28,8 +28,6 @@ alarm05 alarm05
 alarm06 alarm06
 alarm07 alarm07
 
-asyncio02 asyncio02
-
 bind01 bind01
 bind02 bind02
 bind03 bind03
@@ -1330,6 +1328,8 @@ ssetmask01 ssetmask01
 
 stat01 stat01
 stat01_64 stat01_64
+stat02 stat02
+stat02_64 stat02_64
 stat03 stat03
 stat03_64 stat03_64
 stat04 symlink01 -T stat04
-- 
2.19.2

