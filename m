From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 28 Apr 2020 10:44:07 +0530
Subject: [LTP] [PATCH] syscalls/pipe2: Add pipe2_02_child in .gitignore
Message-ID: <6bbeda113f33b284abcd652647273726fc1bef5c.1588050829.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/pipe2/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/pipe2/.gitignore b/testcases/kernel/syscalls/pipe2/.gitignore
index 773450a484af..7e7b3cc89916 100644
--- a/testcases/kernel/syscalls/pipe2/.gitignore
+++ b/testcases/kernel/syscalls/pipe2/.gitignore
@@ -1,3 +1,4 @@
 /pipe2_01
 /pipe2_02
 /pipe2_04
+/pipe2_02_child
-- 
2.25.0.rc1.19.g042ed3e048af

