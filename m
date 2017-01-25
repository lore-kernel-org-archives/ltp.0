From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Jan 2017 14:33:12 +0100
Subject: [LTP] [PATCH v3 1/1] test.sh: colorize test type in the output
In-Reply-To: <20170124194730.13542-1-pvorel@suse.cz>
References: <20170124194730.13542-1-pvorel@suse.cz>
Message-ID: <20170125133312.GA11652@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Applied with following diff (thanks!):

I've added caching to the tst_color_enabled() fucntion and fixed a few
obvious typos.

diff --git a/include/tst_ansi_colors.h b/include/tst_ansi_colors.h
index 832c4ee..3ad4dcd 100644
--- a/include/tst_ansi_colors.h
+++ b/include/tst_ansi_colors.h
@@ -19,7 +19,7 @@
 #define TST_ANSI_COLORS_H__
 /*
  * NOTE: these colors should match colors defined in tst_flag2color() in
- * testcases/lib/test.sh
+ * testcases/lib/tst_ansi_colors.sh
  */
 #define ANSI_COLOR_BLUE		"\e[1;34m"
 #define ANSI_COLOR_GREEN	"\e[1;32m"
diff --git a/lib/tst_ansi_colors.c b/lib/tst_ansi_colors.c
index da90e5e..a37eb10 100644
--- a/lib/tst_ansi_colors.c
+++ b/lib/tst_ansi_colors.c
@@ -50,18 +50,27 @@ char* tst_ttype2color(int ttype)
 
 int tst_color_enabled(void)
 {
+	static int color;
+
+	if (color)
+		return color - 1;
+
 	char *env = getenv("LTP_COLORIZE_OUTPUT");
 
 	if (env) {
 		if (!strcmp(env, "n") || !strcmp(env, "0"))
-			return 0;
+			color = 1;
 
 		if (!strcmp(env, "y") || !strcmp(env, "1"))
-			return 1;
+			color = 2;
+
+		return color - 1;
 	}
 
 	if (isatty(STDOUT_FILENO) == 0)
-		return 0;
+		color = 1;
+	else
+		color = 2;
 
-	return 1;
+	return color - 1;
 }
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 52dfb20..0dd4055 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -307,12 +307,6 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 		abort();
 	}
 
-
-	if (size >= sizeof(message)) {
-		printf("%s: %i: line too long\n", __func__, __LINE__);
-		abort();
-	}
-
 	if (ttype & TERRNO) {
 		size += snprintf(message + size, sizeof(message) - size,
 				 ": errno=%s(%i): %s", tst_strerrno(err),
diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color.sh
index 81c1c8c..8a1ab26 100644
--- a/testcases/lib/tst_ansi_color.sh
+++ b/testcases/lib/tst_ansi_color.sh
@@ -51,6 +51,6 @@ tst_print_colored()
 	local color=$?
 
 	[ "$color" = "1" ] && tst_flag2color "$1"
-	printf "$@"
+	printf "$2"
 	[ "$color" = "1" ] && printf '\e[00m'
 }
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index ea65218..4803c23 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -104,7 +104,7 @@ tst_res()
 	tst_inc_res "$res"
 
 	printf "$TCID $TST_COUNT "
-	tst_print_colored $res "$ret: "
+	tst_print_colored $res "$res: "
 	echo "$@"
 }
 

-- 
Cyril Hrubis
chrubis@suse.cz
