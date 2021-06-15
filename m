From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jun 2021 18:33:06 +0200
Subject: [LTP] [RFC PATCH 2/3] lib: Add $LTPROOT/testcases/bin into PATH
In-Reply-To: <20210615163307.10755-1-pvorel@suse.cz>
References: <20210615163307.10755-1-pvorel@suse.cz>
Message-ID: <20210615163307.10755-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

when LTPROOT set. Put it as the last.
TWARN when directory does not exist.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 36a4809c7..14a739eb5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1149,15 +1149,31 @@ static unsigned long long get_time_ms(void)
 static void add_paths(void)
 {
 	char *old_path = getenv("PATH");
+	const char *ltproot = getenv("LTPROOT");
 	const char *start_dir;
-	char *new_path;
+	char *bin_dir, *new_path = NULL;
 
 	start_dir = tst_get_startwd();
 
+	/* : - current directory */
 	if (old_path)
-		SAFE_ASPRINTF(&new_path, "%s::%s", old_path, start_dir);
+		SAFE_ASPRINTF(&new_path, "%s:", old_path);
 	else
-		SAFE_ASPRINTF(&new_path, "::%s", start_dir);
+		strcat(new_path, ":");
+
+	/* empty for library C API tests */
+	if (strlen(start_dir) > 0)
+		SAFE_ASPRINTF(&new_path, "%s:%s", new_path, start_dir);
+
+	if (ltproot) {
+		SAFE_ASPRINTF(&bin_dir, "%s/testcases/bin", ltproot);
+
+		if (access(bin_dir, F_OK) == -1)
+			tst_res(TWARN, "'%s' does not exist, is $LTPROOT set correctly?",
+				bin_dir);
+		else
+			SAFE_ASPRINTF(&new_path, "%s:%s", new_path, bin_dir);
+	}
 
 	SAFE_SETENV("PATH", new_path, 1);
 	free(new_path);
-- 
2.32.0

