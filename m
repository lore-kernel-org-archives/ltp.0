From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 13 Feb 2018 16:41:36 +0800
Subject: [LTP] [PATCH v2 1/5] syscalls/mremap03: Do not pass MAP_FAILED into
	mremap()
In-Reply-To: <20180212162258.GA26897@rei>
References: <20180212162258.GA26897@rei>
Message-ID: <1518511300-12371-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running mremap03 -i n got the following errors:
-----------------------------------------------
mremap03    1  TPASS  :  mremap() Fails, 'old region not mapped', errno 14
mremap03    1  TFAIL  :  mremap03.c:137: mremap() Fails, 'Unexpected errno 22
...
-----------------------------------------------

When running mremap03 in loops, we passed MAP_FAILED instead of bad
address into mremap().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mremap/mremap03.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 12e3829..5cd1a67 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -84,7 +84,8 @@
 
 char *TCID = "mremap03";
 int TST_TOTAL = 1;
-char *addr;			/* addr of memory mapped region */
+static char *bad_addr;
+static char *addr;		/* addr of memory mapped region */
 int memsize;			/* memory mapped size */
 int newsize;			/* new size of virtual memory block */
 
@@ -111,7 +112,7 @@ int main(int ac, char **av)
 		 * virtual address was not mapped.
 		 */
 		errno = 0;
-		addr = mremap(addr, memsize, newsize, MREMAP_MAYMOVE);
+		addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
 		TEST_ERRNO = errno;
 
 		/* Check for the return value of mremap() */
@@ -173,7 +174,7 @@ void setup(void)
 	 * Set the old virtual address point to some address
 	 * which is not mapped.
 	 */
-	addr = (char *)get_high_address();
+	bad_addr = (char *)get_high_address();
 }
 
 /*
-- 
1.8.3.1



