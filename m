From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 30 Aug 2021 15:17:30 +0200
Subject: [LTP] [PATCH 2/2] tst_get_free_gid(): Skip GID 0
In-Reply-To: <20210830131730.31935-1-mdoucha@suse.cz>
References: <20210830131730.31935-1-mdoucha@suse.cz>
Message-ID: <20210830131730.31935-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_get_free_gid() may return GID 0 on systems where /etc/group (or another
database of user groups) does not exist. But GID 0 exists implicitly and
it may stay after setgid() as a supplemental group of the test process if it
was executed with root privileges. Skip GID 0 to avoid unexpected test
failures.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_uid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index 2163b1494..dd719d312 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -19,7 +19,7 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 
 	errno = 0;
 
-	for (ret = 0; ret < MAX_GID; ret++) {
+	for (ret = 1; ret < MAX_GID; ret++) {
 		if (ret == skip || getgrgid(ret))
 			continue;
 
-- 
2.32.0

