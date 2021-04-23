From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 23 Apr 2021 15:22:22 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/sendfile04: Fix setup()
Message-ID: <20210423132222.25597-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The in_file has to be opened O_RDWR in order to be useable to be passed
to the sendfile(). It does not matter much in this case, since we get
the EFAULT even before the kernel attempts to resolve the file
descriptors, but let's keep the rest of the parameters to the sycall
correct.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/sendfile/sendfile04.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 4cbc48edc..67d004c74 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -48,9 +48,8 @@ struct test_case_t {
 
 static void setup(void)
 {
-	in_fd = SAFE_CREAT("in_file", O_RDONLY);
-	out_fd = SAFE_CREAT("out_file", O_WRONLY);
-	SAFE_WRITE(1, in_fd, "a", 1);
+	in_fd = SAFE_OPEN("in_file", O_CREAT | O_RDWR, 0600);
+	out_fd = SAFE_CREAT("out_file", 0600);
 }
 
 static void cleanup(void)
-- 
2.26.3

