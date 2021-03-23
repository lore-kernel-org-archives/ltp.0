From: xueshi hu <hubachelar@gmail.com>
Date: Tue, 23 Mar 2021 21:31:37 +0800
Subject: [LTP] [PATCH] change mmap flags from PROT_EXEC to PROT_READ
Message-ID: <20210323133137.2280947-1-hubachelar@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In some architecture(e.g., mips), PROT_EXEC doesn't guarantee PROT_READ,
which will cause segment fault. In others architectures, PROT_READ is
more accurate.

Signed-off-by: xueshi hu <hubachelar@gmail.com>
---
 testcases/kernel/syscalls/mmap/mmap03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.c
index b957a3218..2fcf1ef17 100644
--- a/testcases/kernel/syscalls/mmap/mmap03.c
+++ b/testcases/kernel/syscalls/mmap/mmap03.c
@@ -85,7 +85,7 @@ int main(int ac, char **av)
 		 * with execute access.
 		 */
 		errno = 0;
-		addr = mmap(0, page_sz, PROT_EXEC,
+		addr = mmap(0, page_sz, PROT_READ,
 			    MAP_FILE | MAP_SHARED, fildes, 0);
 
 		/* Check for the return value of mmap() */
-- 
2.25.1

