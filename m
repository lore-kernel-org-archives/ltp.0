From: zhao gongyi <zhaogongyi@huawei.com>
Date: Fri, 19 Feb 2021 13:04:39 +0800
Subject: [LTP] [PATCH] openposix/fork/11-1.c: Clean up temporary file
Message-ID: <20210219050439.179039-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need to clean up temporary file /tmp/fork-11-1-XXXXXX which created by mkstemp.

Signed-off-by: zhao gongyi <zhaogongyi@huawei.com>
---
 .../open_posix_testsuite/conformance/interfaces/fork/11-1.c     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
index a43bc274c..e9b18958c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
@@ -79,6 +79,8 @@ int main(void)
 		return result;
 	}

+	unlink(path_template);
+
 	if (fcntl(fd, F_SETLK, &fl) == -1) {
 		printf("Could not set initial lock: %s (%d)\n",
 		       strerror(errno), errno);
--
2.17.1

