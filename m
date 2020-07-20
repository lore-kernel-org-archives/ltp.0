From: Yixin Zhang <yixin.zhang@intel.com>
Date: Mon, 20 Jul 2020 20:54:52 +0800
Subject: [LTP] [PATCH ltp] syscalls/io_uring: add .gitignore file
Message-ID: <20200720125452.13821-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add .gitignore file for syscalls/io_uring

Fixes: 4c97e173cfdd ("syscall: Add io_uring related tests")
Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/syscalls/io_uring/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/.gitignore

diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
new file mode 100644
index 000000000000..bfe22441fbf2
--- /dev/null
+++ b/testcases/kernel/syscalls/io_uring/.gitignore
@@ -0,0 +1 @@
+/io_uring01
-- 
2.17.1

