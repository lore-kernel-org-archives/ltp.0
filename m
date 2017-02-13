From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 16:33:13 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/7] lib: tst_ansi_colors: Fix output is
	terminal check
Message-ID: <20170213153313.2600-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The newlib prints to stderr, hence we have to pass which file descriptor
we would use to the tst_color_enabled() function.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_ansi_colors.h | 2 +-
 lib/tst_ansi_colors.c     | 4 ++--
 lib/tst_res.c             | 2 +-
 lib/tst_test.c            | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/tst_ansi_colors.h b/include/tst_ansi_colors.h
index 3ad4dcd..bc1cb89 100644
--- a/include/tst_ansi_colors.h
+++ b/include/tst_ansi_colors.h
@@ -30,6 +30,6 @@
 #define ANSI_COLOR_RESET	"\e[00m"
 
 char* tst_ttype2color(int ttype);
-int tst_color_enabled(void);
+int tst_color_enabled(int fd);
 
 #endif	/* TST_ANSI_COLORS_H__ */
diff --git a/lib/tst_ansi_colors.c b/lib/tst_ansi_colors.c
index a37eb10..bebea84 100644
--- a/lib/tst_ansi_colors.c
+++ b/lib/tst_ansi_colors.c
@@ -48,7 +48,7 @@ char* tst_ttype2color(int ttype)
 	}
 }
 
-int tst_color_enabled(void)
+int tst_color_enabled(int fd)
 {
 	static int color;
 
@@ -67,7 +67,7 @@ int tst_color_enabled(void)
 		return color - 1;
 	}
 
-	if (isatty(STDOUT_FILENO) == 0)
+	if (isatty(fd) == 0)
 		color = 1;
 	else
 		color = 2;
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 96f0c1f..59209a9 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -299,7 +299,7 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 		abort();
 	}
 
-	if (tst_color_enabled())
+	if (tst_color_enabled(STDOUT_FILENO))
 		size += snprintf(message + size, sizeof(message) - size,
 		"%s%s%s  :  %s", tst_ttype2color(ttype), type, ANSI_COLOR_RESET, tmesg);
 	else
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e78b412..1518c7c 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -209,7 +209,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 	str += ret;
 	size -= ret;
 
-	if (tst_color_enabled())
+	if (tst_color_enabled(STDERR_FILENO))
 		ret = snprintf(str, size, "%s%s: %s", tst_ttype2color(ttype),
 			       res, ANSI_COLOR_RESET);
 	else
-- 
2.10.2

