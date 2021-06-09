From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  9 Jun 2021 13:46:56 +0200
Subject: [LTP] [PATCH 1/4] lib: tst_supported_fs_types: Add
 tst_fs_max_types()
In-Reply-To: <20210609114659.2445-1-chrubis@suse.cz>
References: <20210609114659.2445-1-chrubis@suse.cz>
Message-ID: <20210609114659.2445-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tst_fs_max_types() returns an upper bound on the number of supported
filesystems.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_fs.h             | 5 +++++
 lib/tst_supported_fs_types.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 36d4b46f0..d1ed78cb5 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -195,6 +195,11 @@ const char **tst_get_supported_fs_types(const char *const *skiplist);
  */
 int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist);
 
+/*
+ * Returns maximal number of supported filesystem types.
+ */
+unsigned int tst_fs_max_types(void);
+
 /*
  * Check whether device supports FS quotas. Negative return value means that
  * quotas appear to be broken.
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 592a526ae..1de0f30b2 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -29,6 +29,11 @@ static const char *const fs_type_whitelist[] = {
 
 static const char *fs_types[ARRAY_SIZE(fs_type_whitelist)];
 
+unsigned int tst_fs_max_types(void)
+{
+	return ARRAY_SIZE(fs_type_whitelist) - 1;
+}
+
 static int has_mkfs(const char *fs_type)
 {
 	char buf[128];
-- 
2.31.1

