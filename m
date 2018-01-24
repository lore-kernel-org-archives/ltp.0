From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:02:54 +0100
Subject: [LTP] [PATCH 01/19] fix warning on old style function definition
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-2-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/misc/f00f/f00f.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/misc/f00f/f00f.c b/testcases/misc/f00f/f00f.c
index 3f10b9aed..5fdc6da1a 100644
--- a/testcases/misc/f00f/f00f.c
+++ b/testcases/misc/f00f/f00f.c
@@ -52,7 +52,7 @@ void sigill(int sig)
 	tst_exit();
 }
 
-int main()
+int main(void)
 {
 	signal(SIGILL, sigill);
 	tst_resm(TINFO, "Testing for proper f00f instruction handling.");
@@ -73,7 +73,7 @@ int main()
 
 #else /* __i386__ */
 
-int main()
+int main(void)
 {
 	tst_brkm(TCONF, NULL, "f00f bug test only for i386");
 }
-- 
2.13.6

