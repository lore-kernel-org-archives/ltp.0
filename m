From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 28 Apr 2021 20:49:39 +0800
Subject: [LTP] [PATCH] syscalls/setfsgid02: Bugfix for running as root
Message-ID: <20210428124939.23546-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When we run the test as root id, and with the option "-i 2",
test will fail.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/setfsgid/setfsgid02.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid02.c b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
index 4788957e2..a5485294e 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid02.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
@@ -49,10 +49,11 @@ int main(int ac, char **av)

 	setup();

+	gid = 1;
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;

-		gid = 1;
 		while (getgrgid(gid))
 			gid++;

@@ -73,6 +74,8 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "setfsgid() returned expected value : "
 				 "%ld", TEST_RETURN);
 		}
+
+		gid++;
 	}

 	cleanup();
--
2.17.1

