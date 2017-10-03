From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:58 +0200
Subject: [LTP] [COMMITTED] [PATCH 11/13] Make use of SAFE_LSEEK()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-11-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/sendfile/sendfile08.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
index f9e2605c1..a29632712 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile08.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -67,10 +67,7 @@ int main(int argc, char *argv[])
 		if (TEST_RETURN == -1)
 			tst_brkm(TBROK | TTERRNO, cleanup, "sendfile() failed");
 
-		ret = lseek(out_fd, 0, SEEK_SET);
-		if (ret == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "lseek %s failed",
-				 out_file);
+		ret = SAFE_LSEEK(cleanup, out_fd, 0, SEEK_SET);
 		ret = read(out_fd, buf, BUFSIZ);
 		if (ret == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "read %s failed",
-- 
2.13.5

