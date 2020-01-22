From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 22 Jan 2020 10:42:47 +0530
Subject: [LTP] [PATCH] gitignore: Ignore all files starting with dot (.)
Message-ID: <b4026c746a164c83636ff14d77bd0638b1cd5407.1579669956.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The purpose behind this modification was to start ignoring the .*.swp
files, but then I looked at how the Linux kernel handles this and so
this patch ignores anything that starts with a dot (.).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 903d616b11c4..0a14ebcbeefc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,5 @@
 CVS
+.*
 *~
 *.o
 *.o.d
-- 
2.21.0.rc0.269.g1a574e7a288b

