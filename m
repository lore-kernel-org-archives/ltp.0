From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Apr 2021 11:42:45 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/unshare01: Fix special doc
 commment
Message-ID: <20210420094245.8910-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So that it's picked up by docparser and also add [Algorithm] part.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/unshare/unshare01.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index f4916ba6d..ad26a908d 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -4,10 +4,15 @@
  * Ported from Crackerjack to LTP by Manas Kumar Nayak maknayak@in.ibm.com>
  */
 
-/*
+/*\
  * [Description]
  *
  * Basic tests for the unshare() syscall.
+ *
+ * [Algorithm]
+ *
+ * Calls unshare() for different CLONE_* flags in a child process and expects
+ * them to succeed.
  */
 
 #define _GNU_SOURCE
-- 
2.26.3

