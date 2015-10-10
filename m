From: Li Wang <liwang@redhat.com>
Date: Sat, 10 Oct 2015 14:46:46 +0800
Subject: [LTP] [PATCH] mem/hugetlb: shift an empty region to use in
	hugemmap02.c
Message-ID: <1444459606-20540-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

the testcase 'hugemmap02' always failed on s390x as:
----------
hugemmap02    0  TINFO  :  set nr_hugepages to 128
hugemmap02    1  TPASS  :  huge mmap succeeded (64-bit)
./hugemmap02: relocation error: ./hugemmap02: symbol , version GLIBC_2.2 not defined in file libc.so.6 with link time reference
----------

the reason is that function
	"addr = mmap(LOW_ADDR, page_sz, PROT_READ,
		MAP_SHARED | MAP_FIXED, nfildes, 0);"
expect to map in the virtual address from 0x80000000 to 0x80001000.

but in the program we could obviously see the region has been used:
---------
 # readelf -s hugemmap02 |grep 80001 -B 10

   120: 0000000080002c00     0 FUNC    GLOBAL DEFAULT  UND getgid@GLIBC_2.2 (4)

   Symbol table '.symtab' contains 406 entries:
      Num:    Value          Size Type    Bind   Vis      Ndx Name
        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
        1: 0000000080000238     0 SECTION LOCAL  DEFAULT    1
        2: 0000000080000248     0 SECTION LOCAL  DEFAULT    2
        3: 0000000080000268     0 SECTION LOCAL  DEFAULT    3
        4: 0000000080000290     0 SECTION LOCAL  DEFAULT    4
        5: 0000000080000678     0 SECTION LOCAL  DEFAULT    5
        6: 00000000800011d0     0 SECTION LOCAL  DEFAULT    6
        7: 00000000800015f0     0 SECTION LOCAL  DEFAULT    7
        8: 00000000800016e8     0 SECTION LOCAL  DEFAULT    8
        9: 0000000080001768     0 SECTION LOCAL  DEFAULT    9
       10: 00000000800017c8     0 SECTION LOCAL  DEFAULT   10
----------

then I print the address during the program runing. it looks like as the guess:
----------
hugemmap02    0  TINFO  :  set nr_hugepages to 128
program address:
80000000-80012000 r-xp 00000000 fd:00 68124645                           /mnt/tests/kernel/vm/hugepage/ltp-hugetlbfs/ltp-full-20150903/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02
80012000-80013000 r--p 00011000 fd:00 68124645                           /mnt/tests/kernel/vm/hugepage/ltp-hugetlbfs/ltp-full-20150903/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02
...
80014000-80017000 rw-p 00000000 00:00 0
9cf72000-9cf93000 rw-p 00000000 00:00 0                                  [heap]
3ffad56e000-3ffbd56e000 r--s 00000000 00:05 2677                         /dev/zero
3ffbd56e000-3ffcd56e000 r--s 00000000 00:05 2677                         /dev/zero
...
?Lhugemmap02    1  TPASS  :  huge mmap succeeded (64-bit)
./hugemmap02: relocation error: ./hugemmap02: symbol , version GLIBC_2.2 not defined in file libc.so.6 with link time reference
-----------

So I draft this patch to shift 'LOW_ADDR' with an empty region on s390x.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index cfdcb3c..c5bb429 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -56,8 +56,14 @@
 #include "safe_macros.h"
 #include "mem.h"
 
+#if __s390__ || __s390x__
+#define LOW_ADDR       (void *)(0x90000000)
+#define LOW_ADDR2      (void *)(0xa0000000)
+
+#else
 #define LOW_ADDR       (void *)(0x80000000)
 #define LOW_ADDR2      (void *)(0x90000000)
+#endif
 
 static char TEMPFILE[MAXPATHLEN];
 
-- 
1.8.3.1

