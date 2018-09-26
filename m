From: Allen, John <John.Allen@amd.com>
Date: Wed, 26 Sep 2018 14:31:37 +0000
Subject: [LTP] [PATCH] runtest/{ltplite,
 stress.part3}: Update execve05 calling convention
Message-ID: <20180926143122.11889-1-john.allen@amd.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The calling convention for execve05 was recently changed and was updated
in runtest/syscalls when the change was introduced, but not for other
runtest files where execve05 is called. Update all calls to execve05 to
use the new calling convention.

Signed-off-by: John Allen <john.allen@amd.com>
---
 runtest/ltplite      | 2 +-
 runtest/stress.part3 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 61ab275d8..f0102e7e6 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -174,7 +174,7 @@ execve01 execve01
 execve02 execve02
 execve03 execve03
 execve04 execve04
-execve05 execve05 20 $LTPROOT/testcases/bin/execve05 $LTPROOT/testcases/bin/execve05 4
+execve05 execve05 -i 5 -n 32
 execvp01 execvp01
 
 exit01 exit01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 332daa9ec..513d2ea39 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -115,7 +115,7 @@ execve01 execve01
 execve02 execve02
 execve03 execve03
 execve04 execve04
-execve05 execve05 20 $LTPROOT/testcases/bin/execve05 $LTPROOT/testcases/bin/execve05 4
+execve05 execve05 -i 5 -n 32
 execvp01 execvp01
 
 exit01 exit01
-- 
2.17.1

