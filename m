From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 May 2017 15:40:53 +0200
Subject: [LTP] [COMMITTED] [PATCH] readahead02: Fix warnings.
Message-ID: <20170526134053.13913-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index e2eb8bc63..77862cf41 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -59,7 +59,7 @@ static int opt_fsize;
 static char *opt_fsizestr;
 static int pagesize;
 
-#define MIN_SANE_READAHEAD (4 * 1024)
+#define MIN_SANE_READAHEAD (4u * 1024u)
 
 option_t options[] = {
 	{"s:", &opt_fsize, &opt_fsizestr},
@@ -161,7 +161,7 @@ static void create_testfile(void)
 	char *tmp;
 	size_t i;
 
-	tst_resm(TINFO, "creating test file of size: %ld", testfile_size);
+	tst_resm(TINFO, "creating test file of size: %zu", testfile_size);
 	tmp = SAFE_MALLOC(cleanup, pagesize);
 
 	/* round to page size */
-- 
2.13.0

