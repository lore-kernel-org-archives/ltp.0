From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  9 Sep 2021 17:51:21 +0200
Subject: [LTP] [PATCH 3/8] Add tst_check_resuid() and tst_check_resgid()
 helper functions
In-Reply-To: <20210909155126.2720-1-mdoucha@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
Message-ID: <20210909155126.2720-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 include/tst_uid.h | 13 ++++++++++++
 lib/tst_uid.c     | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/tst_uid.h b/include/tst_uid.h
index b653d0a1e..e604effce 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -24,4 +24,17 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip);
 void tst_get_uids(uid_t *buf, unsigned int start, unsigned int size);
 void tst_get_gids(gid_t *buf, unsigned int start, unsigned int size);
 
+/*
+ * Helper functions for checking current proces UIDs/GIDs.
+ */
+int tst_check_resuid_(const char *file, const int lineno, const char *callstr,
+	uid_t exp_ruid, uid_t exp_euid, uid_t exp_suid);
+#define tst_check_resuid(cstr, ruid, euid, suid) \
+	tst_check_resuid_(__FILE__, __LINE__, (cstr), (ruid), (euid), (suid))
+
+int tst_check_resgid_(const char *file, const int lineno, const char *callstr,
+	gid_t exp_rgid, gid_t exp_egid, gid_t exp_sgid);
+#define tst_check_resgid(cstr, rgid, egid, sgid) \
+	tst_check_resgid_(__FILE__, __LINE__, (cstr), (rgid), (egid), (sgid))
+
 #endif /* TST_UID_H_ */
diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index 08855ba46..af4ef8cf7 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -68,3 +68,53 @@ void tst_get_gids(gid_t *buf, unsigned int start, unsigned int count)
 			buf[i++] = id;
 	}
 }
+
+int tst_check_resuid_(const char *file, const int lineno, const char *callstr,
+	uid_t exp_ruid, uid_t exp_euid, uid_t exp_suid)
+{
+	uid_t ruid, euid, suid;
+
+	SAFE_GETRESUID(&ruid, &euid, &suid);
+
+	if (ruid == exp_ruid && euid == exp_euid && suid == exp_suid)
+		return 1;
+
+	if (callstr) {
+		tst_res_(file, lineno, TFAIL, "Unexpected process UID after %s",
+			callstr);
+	} else {
+		tst_res_(file, lineno, TFAIL, "Unexpected process UID");
+	}
+
+	tst_res_(file, lineno, TINFO, "Got: ruid = %d, euid = %d, suid = %d",
+		(int)ruid, (int)euid, (int)suid);
+	tst_res_(file, lineno, TINFO,
+		"Expected: ruid = %d, euid = %d, suid = %d",
+		(int)exp_ruid, (int)exp_euid, (int)exp_suid);
+	return 0;
+}
+
+int tst_check_resgid_(const char *file, const int lineno, const char *callstr,
+	gid_t exp_rgid, gid_t exp_egid, gid_t exp_sgid)
+{
+	gid_t rgid, egid, sgid;
+
+	SAFE_GETRESGID(&rgid, &egid, &sgid);
+
+	if (rgid == exp_rgid && egid == exp_egid && sgid == exp_sgid)
+		return 1;
+
+	if (callstr) {
+		tst_res_(file, lineno, TFAIL, "Unexpected process GID after %s",
+			callstr);
+	} else {
+		tst_res_(file, lineno, TFAIL, "Unexpected process GID");
+	}
+
+	tst_res_(file, lineno, TINFO, "Got: rgid = %d, egid = %d, sgid = %d",
+		(int)rgid, (int)egid, (int)sgid);
+	tst_res_(file, lineno, TINFO,
+		"Expected: rgid = %d, egid = %d, sgid = %d",
+		(int)exp_rgid, (int)exp_egid, (int)exp_sgid);
+	return 0;
+}
-- 
2.33.0

