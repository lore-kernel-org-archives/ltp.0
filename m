From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  1 Mar 2017 15:31:08 +0100
Subject: [LTP] [PATCH v2 1/2] color: Rename file
Message-ID: <20170301143109.32593-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use singular (to be consistent with shell).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/{tst_ansi_colors.h => tst_ansi_color.h} | 8 ++++----
 lib/{tst_ansi_colors.c => tst_ansi_color.c}     | 2 +-
 lib/tst_res.c                                   | 2 +-
 lib/tst_test.c                                  | 2 +-
 testcases/lib/tst_ansi_color.sh                 | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename include/{tst_ansi_colors.h => tst_ansi_color.h} (89%)
 rename lib/{tst_ansi_colors.c => tst_ansi_color.c} (98%)

diff --git a/include/tst_ansi_colors.h b/include/tst_ansi_color.h
similarity index 89%
rename from include/tst_ansi_colors.h
rename to include/tst_ansi_color.h
index bc1cb89aa..0793b830c 100644
--- a/include/tst_ansi_colors.h
+++ b/include/tst_ansi_color.h
@@ -15,11 +15,11 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef TST_ANSI_COLORS_H__
-#define TST_ANSI_COLORS_H__
+#ifndef TST_ANSI_COLOR_H__
+#define TST_ANSI_COLOR_H__
 /*
  * NOTE: these colors should match colors defined in tst_flag2color() in
- * testcases/lib/tst_ansi_colors.sh
+ * testcases/lib/tst_ansi_color.sh
  */
 #define ANSI_COLOR_BLUE		"\e[1;34m"
 #define ANSI_COLOR_GREEN	"\e[1;32m"
@@ -32,4 +32,4 @@
 char* tst_ttype2color(int ttype);
 int tst_color_enabled(int fd);
 
-#endif	/* TST_ANSI_COLORS_H__ */
+#endif	/* TST_ANSI_COLOR_H__ */
diff --git a/lib/tst_ansi_colors.c b/lib/tst_ansi_color.c
similarity index 98%
rename from lib/tst_ansi_colors.c
rename to lib/tst_ansi_color.c
index bebea84ef..f25c4d952 100644
--- a/lib/tst_ansi_colors.c
+++ b/lib/tst_ansi_color.c
@@ -20,7 +20,7 @@
 #include <string.h>
 
 #include "tst_res_flags.h"
-#include "tst_ansi_colors.h"
+#include "tst_ansi_color.h"
 
 char* tst_ttype2color(int ttype)
 {
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 59209a9fa..ff0ad685f 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -50,7 +50,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "ltp_priv.h"
-#include "tst_ansi_colors.h"
+#include "tst_ansi_color.h"
 
 long TEST_RETURN;
 int TEST_ERRNO;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f19f76340..9757ee2f9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -29,7 +29,7 @@
 #include "tst_test.h"
 #include "tst_device.h"
 #include "lapi/futex.h"
-#include "tst_ansi_colors.h"
+#include "tst_ansi_color.h"
 
 #include "old_resource.h"
 #include "old_device.h"
diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color.sh
index 8a1ab26f6..987397144 100644
--- a/testcases/lib/tst_ansi_color.sh
+++ b/testcases/lib/tst_ansi_color.sh
@@ -20,7 +20,7 @@
 
 tst_flag2color()
 {
-	# NOTE: these colors should match colors defined in include/tst_ansi_colors.h
+	# NOTE: these colors should match colors defined in include/tst_ansi_color.h
 	local ansi_color_blue='\e[1;34m'
 	local ansi_color_green='\e[1;32m'
 	local ansi_color_magenta='\e[1;35m'
-- 
2.11.0

