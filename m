From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sun, 25 Apr 2021 17:19:59 +0800
Subject: [LTP] [PATCH] syscalls/open05: Move cleanup() to the end of test
Message-ID: <20210425091959.13609-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the test run with the option of '-i', we need to move
cleanup() to the end of test, otherwist the test will fail,
and report: "TFAIL  :  open05.c:85: Expected EACCES got 2".

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/open/open05.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open05.c b/testcases/kernel/syscalls/open/open05.c
index 051aec3b3..f5098be2d 100644
--- a/testcases/kernel/syscalls/open/open05.c
+++ b/testcases/kernel/syscalls/open/open05.c
@@ -103,11 +103,10 @@ int main(int ac, char **av)
 				tst_resm(TFAIL, "Failures reported above");

 			close(fd);
-			cleanup();
-
 		}
 	}

+	cleanup();
 	tst_exit();
 }

--
2.17.1

