From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Jul 2017 16:25:00 +0200
Subject: [LTP] [PATCH v2 2/2] doc: Cleanup typo
In-Reply-To: <20170718142500.2725-1-pvorel@suse.cz>
References: <20170718142500.2725-1-pvorel@suse.cz>
Message-ID: <20170718142500.2725-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Just to prevent copy & paste error for people reading our wiki.
---
 doc/test-writing-guidelines.txt | 2 +-
 lib/tst_resource.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 479c24e8c..ed6322b02 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -215,7 +215,7 @@ The path is constructed according to these rules:
 
 1. if '$LTPROOT' is set, return '$LTPROOT/testcases/data/$TCID'
 2. else if 'tst_tmpdir()' was called return '$STARTWD/datafiles'
-   (where '$STARTWD' is initial working directory as recorded by 'tst_tmdir()')
+   (where '$STARTWD' is initial working directory as recorded by 'tst_tmpdir()')
 3. else return '$CWD/datafiles'
 
 See 'testcases/commands/file/' for example.
diff --git a/lib/tst_resource.c b/lib/tst_resource.c
index 78450df53..0b9b381f1 100644
--- a/lib/tst_resource.c
+++ b/lib/tst_resource.c
@@ -46,7 +46,7 @@ static void tst_dataroot_init(void)
 	int ret;
 
 	/* 1. if LTPROOT is set, use $LTPROOT/testcases/data/$TCID
-	 * 2. else if startwd is set by tst_tmdir(), use $STARWD/datafiles
+	 * 2. else if startwd is set by tst_tmpdir(), use $STARWD/datafiles
 	 * 3. else use $CWD/datafiles */
 	if (ltproot) {
 		ret = snprintf(dataroot, PATH_MAX, "%s/testcases/data/%s",
-- 
2.13.2

