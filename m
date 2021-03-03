From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 3 Mar 2021 12:30:12 +0800
Subject: [LTP] [PATCH 1/3] docparse/docparse.c: Make docparse check implied
 flags recursively
Message-ID: <20210303043014.484426-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current docparse cannot check implied flags recursively.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 docparse/docparse.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/docparse/docparse.c b/docparse/docparse.c
index 9f617c8bb..5879a9944 100644
--- a/docparse/docparse.c
+++ b/docparse/docparse.c
@@ -361,14 +361,16 @@ static const char *filter_out[] = {
 
 static struct implies {
 	const char *flag;
-	const char *implies;
+	const char **implies;
 } implies[] = {
-	{"format_device", "needs_device"},
-	{"mount_device", "needs_device"},
-	{"mount_device", "format_device"},
-	{"all_filesystems", "needs_device"},
-	{"needs_device", "needs_tmpdir"},
-	{NULL, NULL}
+	{"mount_device", (const char *[]) {"format_device", "needs_device",
+		"needs_tmpdir", NULL}},
+	{"format_device", (const char *[]) {"needs_device", "needs_tmpdir",
+		NULL}},
+	{"all_filesystems", (const char *[]) {"needs_device", "needs_tmpdir",
+		NULL}},
+	{"needs_device", (const char *[]) {"needs_tmpdir", NULL}},
+	{NULL, (const char *[]) {NULL}}
 };
 
 const char *strip_name(char *path)
@@ -384,7 +386,7 @@ const char *strip_name(char *path)
 
 int main(int argc, char *argv[])
 {
-	unsigned int i;
+	unsigned int i, j;
 	struct data_node *res;
 
 	if (argc != 2) {
@@ -402,15 +404,23 @@ int main(int argc, char *argv[])
 
 	/* Normalize the result */
 	for (i = 0; implies[i].flag; i++) {
-		if (data_node_hash_get(res, implies[i].flag) &&
-		    data_node_hash_get(res, implies[i].implies))
-			fprintf(stderr, "%s: useless tag: %s\n", argv[1], implies[i].implies);
+		if (data_node_hash_get(res, implies[i].flag)) {
+			for (j = 0; implies[i].implies[j]; j++) {
+				if (data_node_hash_get(res, implies[i].implies[j]))
+					fprintf(stderr, "%s: useless tag: %s\n",
+						argv[1], implies[i].implies[j]);
+			}
+		}
 	}
 
 	for (i = 0; implies[i].flag; i++) {
-		if (data_node_hash_get(res, implies[i].flag) &&
-		    !data_node_hash_get(res, implies[i].implies))
-			data_node_hash_add(res, implies[i].implies, data_node_string("1"));
+		if (data_node_hash_get(res, implies[i].flag)) {
+			for (j = 0; implies[i].implies[j]; j++) {
+				if (!data_node_hash_get(res, implies[i].implies[j]))
+					data_node_hash_add(res, implies[i].implies[j],
+							   data_node_string("1"));
+			}
+		}
 	}
 
 	data_node_hash_add(res, "fname", data_node_string(argv[1]));
-- 
2.25.1



