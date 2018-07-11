From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Jul 2018 13:16:45 +0800
Subject: [LTP] [PATCH] open08: calling tst_get_bad_addr from LTP API
Message-ID: <20180711051645.5075-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From open(2) manual, pathname(unmapped_fname) points outside the
accessible address space, then test will result in failure with EFAULT.

LTP tst_get_bad_addr() maps a "guard-page" by using PROT_NONE
to provides page not be accessed too. Here we can take use of
it to achieve the same purpose.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    Jan,
    
    I'm sorry I didn't think of that function in LTP API when
    reveiwed your open08 patch.
    
    Here I propose to remove the get_invalid_addr() from open08.c.
    
    Li Wang

 testcases/kernel/syscalls/open/open08.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 5b24752..c407332 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -58,6 +58,7 @@
 #include <signal.h>
 #include <pwd.h>
 #include "tst_test.h"
+#include "tst_get_bad_addr.h"
 
 static char *existing_fname = "open08_testfile";
 static char *toolong_fname = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
@@ -101,17 +102,6 @@ void verify_open(unsigned int i)
 	}
 }
 
-static void *get_invalid_addr(void)
-{
-	char *bad_addr;
-	int len = 2 * 1024 * 1024;
-
-	bad_addr = SAFE_MMAP(0, len, PROT_READ|PROT_WRITE,
-		MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-	SAFE_MUNMAP(bad_addr, len);
-	return bad_addr + len/2;
-}
-
 static void setup(void)
 {
 	int fildes;
@@ -130,7 +120,7 @@ static void setup(void)
 	fildes = SAFE_CREAT(existing_fname, 0600);
 	close(fildes);
 
-	unmapped_fname = get_invalid_addr();
+	unmapped_fname = tst_get_bad_addr(NULL);
 }
 
 static struct tst_test test = {
-- 
2.9.5

