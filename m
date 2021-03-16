From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 16 Mar 2021 11:38:37 +0800
Subject: [LTP] [PATCH] kernel/syscalls/brk: Update file list for .gitignore
Message-ID: <20210316033837.7813-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add brk02 to .gitignore, which was previously ignored by the author.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/brk/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/brk/.gitignore b/testcases/kernel/syscalls/brk/.gitignore
index b16ea36c7..60e16e591 100644
--- a/testcases/kernel/syscalls/brk/.gitignore
+++ b/testcases/kernel/syscalls/brk/.gitignore
@@ -1 +1,2 @@
 /brk01
+/brk02
--
2.17.1

