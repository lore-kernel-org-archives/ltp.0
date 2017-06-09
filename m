From: Helge Deller <deller@gmx.de>
Date: Fri, 9 Jun 2017 16:53:28 +0200
Subject: [LTP] [PATCH] Fix mmap01 testcase on hppa architecture
Message-ID: <20170609145328.GA7129@ls3530>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The mmap() syscall to map a file at any given page-aligned address (via the
MAP_FIXED flag) can fail on the hppa architecture due to cache colouring
requirements of the architecture.

This patch drops the MAP_FIXED flag and thus maps the file instead at
some convenient address based on the hint as given by the addr
parameter. The tests covered by mmap01 check the *end* of the mmaped
file for consistency, so mapping the beginning of the file at any
address is okay without breaking the main intention of the mmap01
testcase.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 41183d109..a508edb10 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -81,7 +81,7 @@ int main(int ac, char **av)
 		 */
 		errno = 0;
 		addr = mmap(addr, page_sz, PROT_READ | PROT_WRITE,
-			    MAP_FILE | MAP_SHARED | MAP_FIXED, fildes, 0);
+			    MAP_FILE | MAP_SHARED, fildes, 0);
 
 		/* Check for the return value of mmap() */
 		if (addr == MAP_FAILED) {
