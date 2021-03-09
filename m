From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 9 Mar 2021 12:00:15 +0800
Subject: [LTP] [PATCH] setns01.c: Change TINFO to TCONF since TINFO will not
 update test results
Message-ID: <20210309040015.21891-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When ns_total < 2 in testcase[3], we need to use TCONF since TINFO will not
update test results, and test will be broken.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/setns/setns01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setns/setns01.c b/testcases/kernel/syscalls/setns/setns01.c
index b07044060..4578871f6 100644
--- a/testcases/kernel/syscalls/setns/setns01.c
+++ b/testcases/kernel/syscalls/setns/setns01.c
@@ -117,7 +117,7 @@ static void test_setns(unsigned int testno)
 			t->setup(t, i);

 		if (t->skip) {
-			tst_res(TINFO, "skip %s", t->msg);
+			tst_res(TCONF, "skip %s", t->msg);
 			continue;
 		}

--
2.17.1

