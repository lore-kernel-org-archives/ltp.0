From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 12 Jan 2021 10:57:57 +0100
Subject: [LTP] [PATCH v6 1/3] Add tst_kconfig_get() helper function
Message-ID: <20210112095759.11910-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v3:
- new patch

Changes since v4:
- moved tst_kconfig_get() declaration to tst_private.h

 include/tst_private.h |  8 ++++++++
 lib/tst_kconfig.c     | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/tst_private.h b/include/tst_private.h
index e30d34740..fe0955f3b 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -29,4 +29,12 @@ void tst_print_svar_change(const char *name, const char *val);
 
 int tst_get_prefix(const char *ip_str, int is_ipv6);
 
+/*
+ * Checks kernel config for a single configuration option and returns its
+ * state if found. The possible return values are the same as for
+ * tst_kconfig_var.choice, with the same meaning. See tst_kconfig_read()
+ * description in tst_kconfig.h.
+ */
+char tst_kconfig_get(const char *confname);
+
 #endif
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 734039e37..2b1087a8d 100644
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

