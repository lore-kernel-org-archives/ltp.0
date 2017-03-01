From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  1 Mar 2017 15:31:09 +0100
Subject: [LTP] [PATCH v2 2/2] color: Fix backslash-escape sequences for some
	non-bash shells
In-Reply-To: <20170301143109.32593-1-pvorel@suse.cz>
References: <20170301143109.32593-1-pvorel@suse.cz>
Message-ID: <20170301143109.32593-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes at least for ksh and dash.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_ansi_color.h        | 12 ++++++------
 testcases/lib/tst_ansi_color.sh | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/tst_ansi_color.h b/include/tst_ansi_color.h
index 0793b830c..d5d2b6dd1 100644
--- a/include/tst_ansi_color.h
+++ b/include/tst_ansi_color.h
@@ -21,13 +21,13 @@
  * NOTE: these colors should match colors defined in tst_flag2color() in
  * testcases/lib/tst_ansi_color.sh
  */
-#define ANSI_COLOR_BLUE		"\e[1;34m"
-#define ANSI_COLOR_GREEN	"\e[1;32m"
-#define ANSI_COLOR_MAGENTA	"\e[1;35m"
-#define ANSI_COLOR_RED		"\e[1;31m"
-#define ANSI_COLOR_YELLOW	"\e[1;33m"
+#define ANSI_COLOR_BLUE		"\033[1;34m"
+#define ANSI_COLOR_GREEN	"\033[1;32m"
+#define ANSI_COLOR_MAGENTA	"\033[1;35m"
+#define ANSI_COLOR_RED		"\033[1;31m"
+#define ANSI_COLOR_YELLOW	"\033[1;33"
 
-#define ANSI_COLOR_RESET	"\e[00m"
+#define ANSI_COLOR_RESET	"\033[0m"
 
 char* tst_ttype2color(int ttype);
 int tst_color_enabled(int fd);
diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color.sh
index 987397144..b7baa9bbf 100644
--- a/testcases/lib/tst_ansi_color.sh
+++ b/testcases/lib/tst_ansi_color.sh
@@ -21,11 +21,11 @@
 tst_flag2color()
 {
 	# NOTE: these colors should match colors defined in include/tst_ansi_color.h
-	local ansi_color_blue='\e[1;34m'
-	local ansi_color_green='\e[1;32m'
-	local ansi_color_magenta='\e[1;35m'
-	local ansi_color_red='\e[1;31m'
-	local ansi_color_yellow='\e[1;33m'
+	local ansi_color_blue='\033[1;34m'
+	local ansi_color_green='\033[1;32m'
+	local ansi_color_magenta='\033[1;35m'
+	local ansi_color_red='\033[1;31m'
+	local ansi_color_yellow='\033[1;33m'
 
 	case "$1" in
 	TPASS) printf $ansi_color_green;;
@@ -52,5 +52,5 @@ tst_print_colored()
 
 	[ "$color" = "1" ] && tst_flag2color "$1"
 	printf "$2"
-	[ "$color" = "1" ] && printf '\e[00m'
+	[ "$color" = "1" ] && printf '\033[0m'
 }
-- 
2.11.0

