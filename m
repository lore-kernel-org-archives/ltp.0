From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  7 Sep 2021 13:32:18 +0200
Subject: [LTP] [PATCH v2 1/5] Add user/group ID lookup helper functions
Message-ID: <20210907113222.5156-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Remove SAFE_GETPWENT() and SAFE_GETGRENT()
- Generate linear sequence of IDs in tst_get_uid/gid() without checking
  whether the UID/GID exists
- Add support for extending partially filled UID/GID buffer in
  tst_get_uid/gid()

 include/tst_uid.h |  9 +++++++++
 lib/tst_uid.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/tst_uid.h b/include/tst_uid.h
index 7135a9cad..b653d0a1e 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -15,4 +15,13 @@
 gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip);
 #define tst_get_free_gid(skip) tst_get_free_gid_(__FILE__, __LINE__, (skip))
 
+/*
+ * Get a specific number of unique existing non-root user or group IDs.
+ * The "start" parameter is the number of buffer entries that are already
+ * filled and will not be modified. The function will fill the remaining
+ * (size-start) entries with unique UID/GID values.
+ */
+void tst_get_uids(uid_t *buf, unsigned int start, unsigned int size);
+void tst_get_gids(gid_t *buf, unsigned int start, unsigned int size);
+
 #endif /* TST_UID_H_ */
diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index dd719d312..08855ba46 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -36,3 +36,35 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 	tst_brk_(file, lineno, TBROK, "No free group ID found");
 	return (gid_t)-1;
 }
+
+void tst_get_uids(uid_t *buf, unsigned int start, unsigned int count)
+{
+	unsigned int i, j;
+	uid_t id;
+
+	for (i = start, id = 1; i < count; id++) {
+		for (j = 0; j < start; j++) {
+			if (buf[j] == id)
+				break;
+		}
+
+		if (j >= start)
+			buf[i++] = id;
+	}
+}
+
+void tst_get_gids(gid_t *buf, unsigned int start, unsigned int count)
+{
+	unsigned int i, j;
+	gid_t id;
+
+	for (i = start, id = 1; i < count; id++) {
+		for (j = 0; j < start; j++) {
+			if (buf[j] == id)
+				break;
+		}
+
+		if (j >= start)
+			buf[i++] = id;
+	}
+}
-- 
2.33.0

