From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:55 +0300
Subject: [LTP] [PATCH V2 07/11] waitpid11: update the description
In-Reply-To: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1472041679-29759-8-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
No changes since V1.

 testcases/kernel/syscalls/waitpid/waitpid11.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid11.c b/testcases/kernel/syscalls/waitpid/waitpid11.c
index 1067bca..532c1db 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid11.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid11.c
@@ -25,7 +25,7 @@
  *	Tests to see if pids returned from fork and waitpid are same
  *
  * ALGORITHM
- * 	Check proper functioning of waitpid with pid = -1 and arg = 0
+ *	Check proper functioning of waitpid with pid = 0 and < -1 with arg 0
  */
 
 #include "waitpid_common.h"
-- 
1.7.1

