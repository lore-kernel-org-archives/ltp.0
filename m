From: Michael Moese <mmoese@suse.de>
Date: Fri, 12 Jan 2018 10:32:30 +0100
Subject: [LTP] [PATCH] Add missing entry to .gitignore
Message-ID: <20180112093230.4093-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In testcases/kernel/syscalls/.gitignore an entry was missing for
/mount/mount03_setuid_test
---
 testcases/kernel/syscalls/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 12a136edb..efc0d4878 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -590,6 +590,7 @@
 /mount/mount01
 /mount/mount02
 /mount/mount03
+/mount/mount03_setuid_test
 /mount/mount04
 /mount/mount05
 /mount/mount06
-- 
2.13.6

