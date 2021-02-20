From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sat, 20 Feb 2021 13:09:48 +0800
Subject: [LTP] [PATCH v2] openposix/fork/11-1.c: Clean up temporary file
Message-ID: <20210220050948.142027-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need to clean up temporary file /tmp/fork-11-1-XXXXXX which created by mkstemp.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
(v2->v1: Call unlink behind of close(fd) that makes logic more clear then before fork.)
 .../open_posix_testsuite/conformance/interfaces/fork/11-1.c      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
index a43bc274c..8a7796cfd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
@@ -106,5 +106,6 @@ int main(void)

 cleanup:
 	close(fd);
+	unlink(path_template);
 	return result;
 }
--
2.17.1

