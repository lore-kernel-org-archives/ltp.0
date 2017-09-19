From: Sandeep Patil <sspatil@google.com>
Date: Tue, 19 Sep 2017 16:27:13 -0700
Subject: [LTP] [PATCH] android: io/diotest4: remove dependency on <sys/shm.h>
Message-ID: <20170919232713.57314-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The dependency causes the test to fail build when being compiled against
bionic. The code however only seem to need that header for 'SHMLBA'
constant used to set the mmap'ed segment size. That is replaced by
the page size with this change. Tested on both Android device and a
x86 workstation successfully.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---

 testcases/kernel/io/direct_io/diotest4.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index f3b7d3ba8..a9ecff00f 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -65,7 +65,6 @@
 #include <sys/mman.h>
 #include <sys/syscall.h>
 #include <errno.h>
-#include <sys/shm.h>
 
 #include "diotest_routines.h"
 
@@ -195,7 +194,7 @@ int main(int argc, char *argv[])
 	int fd, newfd;
 	int i, l_fail = 0, fail_count = 0, total = 0;
 	int failed = 0;
-	int shmsz = SHMLBA;
+	int shmsz = sysconf(_SC_PAGE_SIZE);
 	int pagemask = ~(sysconf(_SC_PAGE_SIZE) - 1);
 	char *buf0, *buf1, *buf2;
 	caddr_t shm_base;
-- 
2.14.1.690.gbb1197296e-goog

