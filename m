From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:47 +0200
Subject: [LTP] [RFC PATCH 1/8] lib/tst_test.c: mntpoint implies tmpdir
In-Reply-To: <20180405140154.6218-1-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
Message-ID: <20180405140154.6218-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If mntpoint is set in the test structure we create a directory hence it
should set needs_tmpdir flag so that we are sure we create directory in
the right place.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8be13327c..5e10460b0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -743,6 +743,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->all_filesystems)
 		tst_test->needs_device = 1;
 
+	if (tst_test->mntpoint)
+		tst_test->needs_tmpdir = 1;
+
 	setup_ipc();
 
 	if (needs_tmpdir() && !tst_tmpdir_created())
-- 
2.13.6

