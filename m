From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Fri,  6 Aug 2021 11:21:31 +0800
Subject: [LTP] [PATCH] lib/tst_tmpdir: tst_get_tmpdir() add error handing
Message-ID: <20210806032131.25721-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 0c39eb89f..f006e4893 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -108,12 +108,18 @@ int tst_tmpdir_created(void)

 char *tst_get_tmpdir(void)
 {
+	char *ret = NULL;
+
 	if (TESTDIR == NULL) {
 		tst_brkm(TBROK, NULL, "you must call tst_tmpdir() first");
 		return NULL;
 	}

-	return strdup(TESTDIR);
+	ret = strdup(TESTDIR);
+	if (!ret)
+		tst_brkm(TBROK, NULL, "strdup() failed");
+
+	return ret;
 }

 const char *tst_get_startwd(void)
--
2.20.1



