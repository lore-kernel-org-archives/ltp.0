From: Martin Doucha <mdoucha@suse.cz>
Date: Fri,  3 Sep 2021 17:48:44 +0200
Subject: [LTP] [PATCH 3/7] Add user/group ID lookup helper functions
In-Reply-To: <20210903154848.18705-1-mdoucha@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
Message-ID: <20210903154848.18705-4-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_macros.h |   6 +++
 include/tst_uid.h         |  17 +++++++
 lib/tst_uid.c             | 100 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 6fd618597..0238a5de7 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -625,4 +625,10 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info);
 #define SAFE_SYSINFO(info) \
 	safe_sysinfo(__FILE__, __LINE__, (info))
 
+struct passwd *safe_getpwent(const char *file, const int lineno);
+#define SAFE_GETPWENT() safe_getpwent(__FILE__, __LINE__)
+
+struct group *safe_getgrent(const char *file, const int lineno);
+#define SAFE_GETGRENT() safe_getgrent(__FILE__, __LINE__)
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/include/tst_uid.h b/include/tst_uid.h
index 7135a9cad..a3bacf64a 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -15,4 +15,21 @@
 gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip);
 #define tst_get_free_gid(skip) tst_get_free_gid_(__FILE__, __LINE__, (skip))
 
+/*
+ * Get a specific number of unique existing non-root user or group IDs.
+ * Multiple calls will return additional results, if any. Both functions call
+ * SAFE_GETPWENT() and SAFE_GETGRENT() respectively.
+ * Call endpwent()/endgrent() after the last use of these functions.
+ * Call setpwent()/setgrent() to read user/group IDs from the beginning again.
+ */
+int tst_get_uids_(const char *file, const int lineno, unsigned int count,
+	uid_t *buf);
+#define tst_get_uids(count, buf) \
+	tst_get_uids_(__FILE__, __LINE__, (count), (buf))
+
+int tst_get_gids_(const char *file, const int lineno, unsigned int count,
+	gid_t *buf);
+#define tst_get_gids(count, buf) \
+	tst_get_gids_(__FILE__, __LINE__, (count), (buf))
+
 #endif /* TST_UID_H_ */
diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index dd719d312..915a5bc34 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -3,8 +3,10 @@
  * Copyright (c) 2021 Linux Test Project
  */
 
+#define _XOPEN_SOURCE 500
 #include <sys/types.h>
 #include <grp.h>
+#include <pwd.h>
 #include <errno.h>
 
 #define TST_NO_DEFAULT_MAIN
@@ -36,3 +38,101 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 	tst_brk_(file, lineno, TBROK, "No free group ID found");
 	return (gid_t)-1;
 }
+
+struct passwd *safe_getpwent(const char *file, const int lineno)
+{
+	struct passwd *ret;
+
+	errno = 0;
+	ret = getpwent();
+
+	if (!ret) {
+		if (errno) {
+			tst_brk_(file, lineno, TBROK | TERRNO,
+				"getpwent() failed");
+		} else {
+			tst_brk_(file, lineno, TBROK,
+				"getpwent() failed: end of file");
+		}
+	}
+
+	return ret;
+}
+
+struct group *safe_getgrent(const char *file, const int lineno)
+{
+	struct group *ret;
+
+	errno = 0;
+	ret = getgrent();
+
+	if (!ret) {
+		if (errno) {
+			tst_brk_(file, lineno, TBROK | TERRNO,
+				"getgrent() failed");
+		} else {
+			tst_brk_(file, lineno, TBROK,
+				"getgrent() failed: end of file");
+		}
+	}
+
+	return ret;
+}
+
+int tst_get_uids_(const char *file, const int lineno, unsigned int count,
+	uid_t *buf)
+{
+	struct passwd *pw;
+	unsigned int i, j;
+
+	for (i = 0; i < count;) {
+		pw = safe_getpwent(file, lineno);
+
+		if (!pw)
+			return -1;
+
+		if (!pw->pw_uid)
+			continue;
+
+		for (j = 0; j < i; j++) {
+			if (buf[j] == pw->pw_uid)
+				break;
+		}
+
+		if (j < i)
+			continue;
+
+		buf[i++] = pw->pw_uid;
+	}
+
+	return 0;
+}
+
+int tst_get_gids_(const char *file, const int lineno, unsigned int count,
+	gid_t *buf)
+{
+	struct group *gr;
+	unsigned int i, j;
+
+	for (i = 0; i < count;) {
+		gr = safe_getgrent(file, lineno);
+
+		if (!gr)
+			return -1;
+
+		if (!gr->gr_gid)
+			continue;
+
+		for (j = 0; j < i; j++) {
+			if (buf[j] == gr->gr_gid)
+				break;
+		}
+
+		if (j < i)
+			continue;
+
+		buf[i++] = gr->gr_gid;
+	}
+
+	return 0;
+}
-- 
2.33.0

