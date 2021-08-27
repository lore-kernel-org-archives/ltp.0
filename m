From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri, 27 Aug 2021 11:34:17 +0300
Subject: [LTP] [PATCH] network/netstress: fix stdout/stderr log file flags
 and mode
Message-ID: <20210827083417.67579-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* fix access mode for stdout/stderr

* add a write bit to the mode so that the next time the server
  starts, it doesn't fail with EACCES because the log file
  already exists and has read-only permissions.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/network/netstress/netstress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index c46bc86c3..03b1563dc 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -723,7 +723,7 @@ static void move_to_background(void)
 	close(STDOUT_FILENO);
 	close(STDERR_FILENO);
 
-	int fd = SAFE_OPEN(log_path, O_CREAT | O_TRUNC | O_RDONLY, 00444);
+	int fd = SAFE_OPEN(log_path, O_CREAT | O_TRUNC | O_WRONLY, 0644);
 
 	SAFE_DUP(fd);
 }
-- 
2.25.1

