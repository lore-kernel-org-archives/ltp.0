From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 9 Dec 2020 18:35:46 +0800
Subject: [LTP] [PATCH 1/2] docparse/docparse.c: Split the process of implied
 flags
Message-ID: <20201209103547.1343502-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check implied flags in one loop and set implied flags in another
loop so that the following false positive can be avoided:
----------------------------------------------------
# docparse/docparse testcases/kernel/syscalls/chdir/chdir01.c
testcases/kernel/syscalls/chdir/chdir01.c: useless tag: needs_device
...
----------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 docparse/docparse.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docparse/docparse.c b/docparse/docparse.c
index be6125353..22c5c6f2c 100644
--- a/docparse/docparse.c
+++ b/docparse/docparse.c
@@ -401,15 +401,15 @@ int main(int argc, char *argv[])
 
 	/* Normalize the result */
 	for (i = 0; implies[i].flag; i++) {
-		if (!data_node_hash_get(res, implies[i].flag))
-			continue;
-
-		if (data_node_hash_get(res, implies[i].implies)) {
+		if (data_node_hash_get(res, implies[i].flag) &&
+		    data_node_hash_get(res, implies[i].implies))
 			fprintf(stderr, "%s: useless tag: %s\n", argv[1], implies[i].implies);
-			continue;
-		}
+	}
 
-		data_node_hash_add(res, implies[i].implies, data_node_string("1"));
+	for (i = 0; implies[i].flag; i++) {
+		if (data_node_hash_get(res, implies[i].flag) &&
+		    !data_node_hash_get(res, implies[i].implies))
+			data_node_hash_add(res, implies[i].implies, data_node_string("1"));
 	}
 
 	data_node_hash_add(res, "fname", data_node_string(argv[1]));
-- 
2.25.1



