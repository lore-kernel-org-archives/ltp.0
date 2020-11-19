From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 19 Nov 2020 12:52:28 +0100
Subject: [LTP] [PATCH v4 1/3] Add tst_kconfig_get() helper function
Message-ID: <20201119115230.8829-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_kconfig.h | 10 ++++++++++
 lib/tst_kconfig.c     | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 1bb21fea8..f56b12919 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -55,4 +55,14 @@ void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
  */
 void tst_kconfig_check(const char *const kconfigs[]);
 
+/**
+ * Checks kernel config for a single configuration option and returns its
+ * state if found. The possible return values are the same as for
+ * tst_kconfig_var.choice, with the same meaning. See tst_kconfig_read()
+ * description for details.
+ *
+ * @param confname The configuration option name to search for.
+ */
+char tst_kconfig_get(const char *confname);
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 35f20e7a4..4d231175f 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -511,3 +511,24 @@ void tst_kconfig_check(const char *const kconfigs[])
 	if (abort_test)
 		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
 }
+
+char tst_kconfig_get(const char *confname)
+{
+	struct tst_kconfig_var var;
+
+	var.id_len = strlen(confname);
+
+	if (var.id_len >= sizeof(var.id))
+		tst_brk(TBROK, "Kconfig var name \"%s\" too long", confname);
+
+	strcpy(var.id, confname);
+	var.choice = 0;
+	var.val = NULL;
+
+	tst_kconfig_read(&var, 1);
+
+	if (var.choice == 'v')
+		free(var.val);
+
+	return var.choice;
+}
-- 
2.29.2

