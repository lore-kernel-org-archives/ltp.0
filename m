From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 13 May 2021 15:49:41 +0200
Subject: [LTP] [PATCH] Skip tmpfs in all-filesystem shell tests
Message-ID: <20210513134941.27656-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All-filesystem shell tests like LVM currently don't support tmpfs. Remove it
from tst_supported_fs helper output for now.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/lib/tst_supported_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 154b12ece..43eac194f 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -22,6 +22,7 @@ static void usage(void)
 
 int main(int argc, char *argv[])
 {
+	const char *skiplist[] = {"tmpfs", NULL};
 	const char *const *filesystems;
 	int i;
 
@@ -39,7 +40,7 @@ int main(int argc, char *argv[])
 	if (argv[1])
 		return !tst_fs_is_supported(argv[1]);
 
-	filesystems = tst_get_supported_fs_types(NULL);
+	filesystems = tst_get_supported_fs_types(skiplist);
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
 
-- 
2.31.1

