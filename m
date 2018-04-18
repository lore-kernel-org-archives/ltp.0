From: Sebastian Chlad <schlad@suse.de>
Date: Wed, 18 Apr 2018 11:51:42 +0200
Subject: [LTP] [PATCH] gitignore: Add some binaries to gitignore
Message-ID: <20180418095142.20394-1-schlad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Sebastian Chlad <schlad@suse.de>
---
 testcases/kernel/syscalls/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 3cc60f9bd..cc4076a88 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -12,6 +12,7 @@
 /add_key/add_key04
 /adjtimex/adjtimex01
 /adjtimex/adjtimex02
+/alarm/alarm01
 /alarm/alarm02
 /alarm/alarm03
 /alarm/alarm05
@@ -539,6 +540,7 @@
 /migrate_pages/migrate_pages02
 /mincore/mincore01
 /mincore/mincore02
+/mkdir/mkdir01
 /mkdir/mkdir02
 /mkdir/mkdir03
 /mkdir/mkdir04
@@ -740,7 +742,9 @@
 /readdir/readdir21
 /readlink/creat_slink
 /readlink/readlink01
+/readlink/readlink02
 /readlink/readlink03
+/readlink/readlink04
 /readlinkat/readlinkat01
 /readlinkat/readlinkat02
 /readv/readv01
-- 
2.13.6

