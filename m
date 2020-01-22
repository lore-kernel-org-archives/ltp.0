From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 22 Jan 2020 14:18:44 +0530
Subject: [LTP] [PATCH V2] gitignore: Ignore swap files
In-Reply-To: <b4026c746a164c83636ff14d77bd0638b1cd5407.1579669956.git.viresh.kumar@linaro.org>
References: <b4026c746a164c83636ff14d77bd0638b1cd5407.1579669956.git.viresh.kumar@linaro.org>
Message-ID: <a9f84c70b1044e863456ef0cfbc7e0d292298ff7.1579682844.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Update .gitignore to ignore .swp files.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Replace .* with .*.swp, as .* also ignored all .ignore files as well.

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 903d616b11c4..86d8190a3a65 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,5 @@
 CVS
+.*.swp
 *~
 *.o
 *.o.d
-- 
2.21.0.rc0.269.g1a574e7a288b

