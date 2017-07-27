From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Jul 2017 11:20:43 +0200
Subject: [LTP] [PATCH] [COMMITTED] lib/tst_test.c: Move parse_opts() up
Message-ID: <20170727092043.29121-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move parse_opts() before check for root, minimal kernel version, etc. So
that -h works regardless of the restrictions for test execution.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 16ea64fe9..51d39438d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -675,6 +675,8 @@ static void do_setup(int argc, char *argv[])
 	if (!tst_test->tid)
 		tst_test->tid = get_tid(argv);
 
+	parse_opts(argc, argv);
+
 	if (tst_test->needs_root && geteuid() != 0)
 		tst_brk(TCONF, "Test needs to be run as root");
 
@@ -689,8 +691,6 @@ static void do_setup(int argc, char *argv[])
 		tst_test->format_device = 1;
 	}
 
-	parse_opts(argc, argv);
-
 	setup_ipc();
 
 	if (needs_tmpdir() && !tst_tmpdir_created())
-- 
2.13.0

