From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:39 +0100
Subject: [LTP] [COMMITTED] [PATCH 17/23] syscalls/msync02: Make use of
	tst_parse_opts()
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-17-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/msync/msync02.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/msync/msync02.c b/testcases/kernel/syscalls/msync/msync02.c
index e1076a9..243ceb0 100644
--- a/testcases/kernel/syscalls/msync/msync02.c
+++ b/testcases/kernel/syscalls/msync/msync02.c
@@ -87,11 +87,10 @@ void cleanup();			/* cleanup function for the test */
 
 int main(int ac, char **av)
 {
+	tst_parse_opts(ac, av, NULL, NULL);
 
 	setup();
 
-	tst_count = 0;
-
 	TEST(msync(addr, page_sz, MS_INVALIDATE));
 
 	if (TEST_RETURN == -1)
@@ -102,7 +101,6 @@ int main(int ac, char **av)
 		tst_resm(TPASS, "Functionality of msync successful");
 
 	cleanup();
-
 	tst_exit();
 }
 
-- 
2.10.2

