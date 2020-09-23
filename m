From: Xiao Yang <ice_yangxiao@163.com>
Date: Wed, 23 Sep 2020 22:35:35 +0800
Subject: [LTP] [PATCH] syscalls/recvmmsg: Add missing .gitignore
Message-ID: <20200923143535.6124-1-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

Fixes: 135af8ededd4 ("syscalls/{send|recv}mmsg: add a test case for timeout and errno test")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/recvmmsg/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 testcases/kernel/syscalls/recvmmsg/.gitignore

diff --git a/testcases/kernel/syscalls/recvmmsg/.gitignore b/testcases/kernel/syscalls/recvmmsg/.gitignore
new file mode 100644
index 000000000..974ae1ef9
--- /dev/null
+++ b/testcases/kernel/syscalls/recvmmsg/.gitignore
@@ -0,0 +1 @@
+recvmmsg01
-- 
2.26.2

