From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Dec 2020 11:10:08 +0100
Subject: [LTP] [PATCH 1/5] docparse/docparse: Warn on truncated docstring
In-Reply-To: <20201216101012.14644-1-chrubis@suse.cz>
References: <20201216101012.14644-1-chrubis@suse.cz>
Message-ID: <20201216101012.14644-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 docparse/docparse.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docparse/docparse.c b/docparse/docparse.c
index 22c5c6f2c..702820757 100644
--- a/docparse/docparse.c
+++ b/docparse/docparse.c
@@ -12,6 +12,8 @@
 
 #include "data_storage.h"
 
+#define WARN(str) fprintf(stderr, "WARNING: " str "\n")
+
 static void oneline_comment(FILE *f)
 {
 	int c;
@@ -52,7 +54,8 @@ static void multiline_comment(FILE *f, struct data_node *doc)
 				struct data_node *line;
 				buf[bufp] = 0;
 				line = data_node_string(eat_asterisk_space(buf));
-				data_node_array_add(doc, line);
+				if (data_node_array_add(doc, line))
+					WARN("doc string comment truncated");
 				bufp = 0;
 				continue;
 			}
@@ -194,8 +197,6 @@ exit:
 	return buf;
 }
 
-#define WARN(str) fprintf(stderr, str "\n")
-
 static int parse_array(FILE *f, struct data_node *node)
 {
 	const char *token;
-- 
2.26.2

