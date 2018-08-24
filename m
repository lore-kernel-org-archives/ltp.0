From: He Zhe <zhe.he@windriver.com>
Date: Thu, 23 Aug 2018 18:59:53 -0700
Subject: [LTP] [PATCH] fs/ftest/ftest06.c: Fix too small name string and
	related failure
Message-ID: <20180824015953.28684-1-zhe.he@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The name string is too small to contain normal full path names and causes
the following failure.

"ftest06     2  TFAIL  :  ftest06.c:223: Can't chdir(): errno=ENOENT(2): No such file or directory"

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 testcases/kernel/fs/ftest/ftest06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
index 2ca7c8880..b43406785 100644
--- a/testcases/kernel/fs/ftest/ftest06.c
+++ b/testcases/kernel/fs/ftest/ftest06.c
@@ -100,7 +100,7 @@ static char *fstyp;
 int main(int ac, char *av[])
 {
 	int pid, child, status, count, k, j;
-	char name[3];
+	char name[MAXPATHLEN];
 
 	int lc;
 
-- 
2.11.0

