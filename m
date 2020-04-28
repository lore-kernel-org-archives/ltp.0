From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 28 Apr 2020 10:55:30 +0530
Subject: [LTP] [PATCH V2] syscalls/pipe2: Add pipe2_02_child in .gitignore
Message-ID: <c3cbc45d1758c6eaf1957c7e75d920b7990e24eb.1588051498.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Move it a line up to keep ordering intact.

 testcases/kernel/syscalls/pipe2/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/pipe2/.gitignore b/testcases/kernel/syscalls/pipe2/.gitignore
index 773450a484af..50f7023b8dd4 100644
--- a/testcases/kernel/syscalls/pipe2/.gitignore
+++ b/testcases/kernel/syscalls/pipe2/.gitignore
@@ -1,3 +1,4 @@
 /pipe2_01
 /pipe2_02
+/pipe2_02_child
 /pipe2_04
-- 
2.25.0.rc1.19.g042ed3e048af

