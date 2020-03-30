From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Mar 2020 16:21:42 +0200
Subject: [LTP] [COMMITTED] [PATCH] tst_test: Print tags only when defined.
Message-ID: <20200330142142.26858-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We were printing the Tags heading even when no tags were defined.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index dae3fa1b5..e502c2c1a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -447,18 +447,19 @@ static void print_test_tags(void)
 	unsigned int i;
 	const struct tst_tag *tags = tst_test->tags;
 
+	if (!tags)
+		return;
+
 	printf("\nTags\n");
 	printf("----\n");
 
-	if (tags) {
-		for (i = 0; tags[i].name; i++) {
-			if (!strcmp(tags[i].name, "CVE"))
-				printf(CVE_DB_URL "%s\n", tags[i].value);
-			else if (!strcmp(tags[i].name, "linux-git"))
-				printf(LINUX_GIT_URL "%s\n", tags[i].value);
-			else
-				printf("%s: %s\n", tags[i].name, tags[i].value);
-		}
+	for (i = 0; tags[i].name; i++) {
+		if (!strcmp(tags[i].name, "CVE"))
+			printf(CVE_DB_URL "%s\n", tags[i].value);
+		else if (!strcmp(tags[i].name, "linux-git"))
+			printf(LINUX_GIT_URL "%s\n", tags[i].value);
+		else
+			printf("%s: %s\n", tags[i].name, tags[i].value);
 	}
 
 	printf("\n");
-- 
2.24.1

