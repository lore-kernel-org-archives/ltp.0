From: Yixin Zhang <yixin.zhang@intel.com>
Date: Mon, 24 Dec 2018 11:39:42 +0800
Subject: [LTP] [PATCH ltp] syscalls/getrlimit: add getrlimit03 into
	.gitignore
Message-ID: <20181224033942.20421-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/syscalls/getrlimit/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/getrlimit/.gitignore b/testcases/kernel/syscalls/getrlimit/.gitignore
index bb951c2cd..9074f1600 100644
--- a/testcases/kernel/syscalls/getrlimit/.gitignore
+++ b/testcases/kernel/syscalls/getrlimit/.gitignore
@@ -1,2 +1,3 @@
 /getrlimit01
 /getrlimit02
+/getrlimit03
-- 
2.17.1

