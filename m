From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 25 Sep 2020 23:33:39 +0800
Subject: [LTP] [PATCH] thp04: Add linux tag
Message-ID: <1601048019-2758-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When I test this case on cenots7.8GA, thp04 will trigger ltp default timeout
and it can't be killed even its process stat is R(running). After looking code
and documentation, I found it also triggers another kernel bug(infinite loop).
commit 8310d48b125d ("mm/huge_memory.c: respect FOLL_FORCE/FOLL_COW for thp")
fix this.

Also, when I backport cve-2017-1000405 patch into centos7.8ga, this case still
passed and it is not enough to cover the another bug. I will add a new test case
to test the another bug.

Adding a url to make user know huge dirty cow bug easily.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/mem/thp/thp04.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index e71261c1d..985394dc3 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -14,6 +14,16 @@
  *  Date:   Mon Nov 27 06:21:25 2017 +0300
  *
  *   mm, thp: Do not make page table dirty unconditionally in touch_p[mu]d()
+ *
+ * More details see the following URL
+ * https://medium.com/bindecy/huge-dirty-cow-cve-2017-1000405-110eca132de0
+ *
+ * On old kernel such as 4.9, it has fixed the Dirty Cow bug but a similar check
+ * in huge_memory.c was forgotten.  As a result, remote memory writes to ro regions
+ * of memory backed by transparent huge pages cause an infinite loop in the kernel.
+ * While in this state the process is stil SIGKILLable, but little else works.
+ * It is also a regression test about kernel
+ * commit 8310d48b125d("huge_memory.c: respect FOLL_FORCE/FOLL_COW for thp").
  */
 
 #include <sys/mman.h>
@@ -155,6 +165,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a8f97366452e"},
+		{"linux-git", "8310d48b125d"},
 		{"CVE", "2017-1000405"},
 		{}
 	}
-- 
2.23.0



