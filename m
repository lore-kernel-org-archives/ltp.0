From: Cedric Hnyda <chnyda@suse.com>
Date: Mon,  5 Oct 2015 12:17:05 +0200
Subject: [LTP]  [PATCH] kernel/include: getrandom
Message-ID: <1444040225-7683-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add getrandom's number for sparc64, sparc and aarch64

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 testcases/kernel/include/aarch64.in | 1 +
 testcases/kernel/include/sparc.in   | 1 +
 testcases/kernel/include/sparc64.in | 1 +
 3 files changed, 3 insertions(+)

diff --git a/testcases/kernel/include/aarch64.in b/testcases/kernel/include/aarch64.in
index ceb67c6..173584c 100644
--- a/testcases/kernel/include/aarch64.in
+++ b/testcases/kernel/include/aarch64.in
@@ -253,3 +253,4 @@ clock_adjtime 266
 syncfs 267
 setns 268
 sendmmsg 269
+getrandom 384
diff --git a/testcases/kernel/include/sparc.in b/testcases/kernel/include/sparc.in
index 697378f..18f55e6 100644
--- a/testcases/kernel/include/sparc.in
+++ b/testcases/kernel/include/sparc.in
@@ -331,3 +331,4 @@ recvmmsg 328
 fanotify_init 329
 fanotify_mark 330
 prlimit64 331
+getrandom 347
diff --git a/testcases/kernel/include/sparc64.in b/testcases/kernel/include/sparc64.in
index 83c1792..2319369 100644
--- a/testcases/kernel/include/sparc64.in
+++ b/testcases/kernel/include/sparc64.in
@@ -307,3 +307,4 @@ recvmmsg 328
 fanotify_init 329
 fanotify_mark 330
 prlimit64 331
+getrandom 347
-- 
2.1.4

