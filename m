From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 29 Aug 2016 14:08:36 +0300
Subject: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
Message-ID: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In my environment, if TMPDIR is on NFSv4, this test case fails with:

lsmod01 1 TFAIL : lsmod output different from /proc/modules.
  21c21
  < sunrpc 207591 28
  ---
  > sunrpc 207591 29

To avoid such problems I separate the process of getting data from
/proc/modules and the process of parsing it in the pipe structure.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
This was found while preparing for the next LTP release.

testcases/commands/lsmod/lsmod01.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index 5cf2fee..a880b97 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -45,7 +45,8 @@ lsmod_test()
 
 	awk '!/Module/{print $1, $2, $3}' temp |sort >temp1
 
-	awk '{print $1, $2, $3}' /proc/modules |sort >temp2
+	cat /proc/modules > temp
+	awk '{print $1, $2, $3}' temp |sort >temp2
 
 	diff temp1 temp2 >temp3
 	if [ $? -ne 0 ]; then
-- 
1.7.1

