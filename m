From: Xiao Yang <ice_yangxiao@163.com>
Date: Sat,  8 Jun 2019 18:27:13 +0800
Subject: [LTP] [PATCH] syscalls/acct02.c: Fix EMFILE error
Message-ID: <1559989633-24711-1-git-send-email-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running acct02 with "-i large number" option may get EMFILE error,
because 'fd' file descriptor is not closed on each iteration.

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 testcases/kernel/syscalls/acct/acct02.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 8a99bb9..f61faf2 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -140,6 +140,8 @@ static void run(void)
 		tst_res(TPASS, "acct() wrote correct file contents!");
 	else
 		tst_res(TFAIL, "acct() wrote incorrect file contents!");
+
+	SAFE_CLOSE(fd);
 }
 
 static void setup(void)
-- 
1.8.3.1


