From: Zhanghui Yuan <zhanghuix.yuan@intel.com>
Date: Fri, 10 Aug 2018 10:56:56 +0800
Subject: [LTP] [PATCH ltp] syscalls/bind02.c: Fix create socker failed for
	nobody user and nogroup for "Permission denied"
Message-ID: <20180810025656.8825-1-zhanghuix.yuan@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Socket will try to be bind by user: nobody, group: nobody and socket failed for "Permission denied"
Add line 89~95 to fix this issue:
               if (errno == EACCES) {
                       tst_resm(TPASS, "correct error");
                       return;
               } else {
                       tst_brkm(TBROK | TERRNO, 0, "socket() failed");
               }

Signed-off-by: Zhanghui Yuan <zhanghuix.yuan@intel.com>
---
 testcases/kernel/syscalls/bind/bind02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/bind/bind02.c b/testcases/kernel/syscalls/bind/bind02.c
index 90b0e9d8e..84ce588ce 100644
--- a/testcases/kernel/syscalls/bind/bind02.c
+++ b/testcases/kernel/syscalls/bind/bind02.c
@@ -86,7 +86,12 @@ void try_bind(void)
 	}
 
 	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
-		tst_brkm(TBROK | TERRNO, 0, "socket() failed");
+		if (errno == EACCES) {
+			tst_resm(TPASS, "correct error");
+			return;
+		}else {
+			tst_brkm(TBROK | TERRNO, 0, "socket() failed");
+		}
 	}
 
 	memset(&servaddr, 0, sizeof(servaddr));
-- 
2.17.1

