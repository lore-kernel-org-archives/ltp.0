From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Sep 2020 16:04:28 +0530
Subject: [LTP] [PATCH] syscalls: fcntl: Update .gitignore
Message-ID: <fdae254836743a2200145a3883bdd869fb610bc2.1600252429.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Update gitignore file to include new binaries.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/fcntl/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index be8d9739e51b..ede0c97b8bba 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -72,3 +72,5 @@
 /fcntl36_64
 /fcntl37
 /fcntl37_64
+/fcntl38
+/fcntl38_64
-- 
2.25.0.rc1.19.g042ed3e048af

