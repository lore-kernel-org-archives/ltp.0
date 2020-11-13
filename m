From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Nov 2020 17:07:03 +0100
Subject: [LTP] [PATCH] [COMMITTED] openposix: threads_scenarii: Fix a
 warnings.
Message-ID: <20201113160703.4523-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix many warnings caused by non-static declaration of the threaded()
function in the threads_scenarii.c.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../conformance/interfaces/testfrmw/threads_scenarii.c          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/threads_scenarii.c b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/threads_scenarii.c
index 4597c43e8..baf30a87c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/threads_scenarii.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/threads_scenarii.c
@@ -486,7 +486,7 @@ static unsigned int sc;
 
 #ifdef STD_MAIN
 
-extern void *threaded(void *arg);
+static void *threaded(void *arg);
 
 int main(void)
 {
-- 
2.26.2

