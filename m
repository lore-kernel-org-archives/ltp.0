From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  9 Sep 2021 17:51:20 +0200
Subject: [LTP] [PATCH 2/8] Add SAFE_SETRESUID()/SAFE_SETRESGID() helper
 functions
In-Reply-To: <20210909155126.2720-1-mdoucha@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
Message-ID: <20210909155126.2720-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_macros.h | 10 ++++++++++
 lib/tst_safe_macros.c     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 6fd618597..d99441c86 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -120,6 +120,16 @@ int safe_setreuid(const char *file, const int lineno,
 #define SAFE_SETREUID(ruid, euid) \
 	safe_setreuid(__FILE__, __LINE__, (ruid), (euid))
 
+int safe_setresgid(const char *file, const int lineno,
+	gid_t rgid, gid_t egid, gid_t sgid);
+#define SAFE_SETRESGID(rgid, egid, sgid) \
+	safe_setresgid(__FILE__, __LINE__, (rgid), (egid), (sgid))
+
+int safe_setresuid(const char *file, const int lineno,
+		  uid_t ruid, uid_t euid, uid_t suid);
+#define SAFE_SETRESUID(ruid, euid, suid) \
+	safe_setresuid(__FILE__, __LINE__, (ruid), (euid), (suid))
+
 #define SAFE_GETRESUID(ruid, euid, suid) \
 	safe_getresuid(__FILE__, __LINE__, NULL, (ruid), (euid), (suid))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index fcff6d161..36b5da66f 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -145,6 +145,45 @@ int safe_setreuid(const char *file, const int lineno,
 	return rval;
 }
 
+int safe_setresgid(const char *file, const int lineno,
+	gid_t rgid, gid_t egid, gid_t sgid)
+{
+	int ret;
+
+	ret = setresgid(rgid, egid, sgid);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"setregid(%li, %li, %li) failed", (long)rgid,
+			(long)egid, (long)sgid);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setregid(%li, %li, %li) return value %d",
+			(long)rgid, (long)egid, (long)sgid, ret);
+	}
+
+	return ret;
+}
+
+int safe_setresuid(const char *file, const int lineno,
+	uid_t ruid, uid_t euid, uid_t suid)
+{
+	int ret;
+
+	ret = setresuid(ruid, euid, suid);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"setreuid(%li, %li, %li) failed", (long)ruid,
+			(long)euid, (long)suid);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setreuid(%li, %li, %li) return value %d",
+			(long)ruid, (long)euid, (long)suid, ret);
+	}
+
+	return ret;
+}
 
 int safe_sigaction(const char *file, const int lineno,
                    int signum, const struct sigaction *act,
-- 
2.33.0

