From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 19 Nov 2020 12:52:29 +0100
Subject: [LTP] [PATCH v4 2/3] Add tst_secureboot_enabled() helper function
In-Reply-To: <20201119115230.8829-1-mdoucha@suse.cz>
References: <20201119115230.8829-1-mdoucha@suse.cz>
Message-ID: <20201119115230.8829-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also check for SecureBoot status in tst_lockdown_enabled() if the lockdown
sysfile is not available/readable and the kernel is configured to enable
lockdown automatically under SecureBoot.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_lockdown.h |  1 +
 lib/tst_lockdown.c     | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/tst_lockdown.h b/include/tst_lockdown.h
index 78eaeccea..172a7daf5 100644
--- a/include/tst_lockdown.h
+++ b/include/tst_lockdown.h
@@ -5,6 +5,7 @@
 
 #define PATH_LOCKDOWN	"/sys/kernel/security/lockdown"
 
+int tst_secureboot_enabled(void);
 int tst_lockdown_enabled(void);
 
 #endif /* TST_LOCKDOWN_H */
diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
index e7c19813c..a753ca752 100644
--- a/lib/tst_lockdown.c
+++ b/lib/tst_lockdown.c
@@ -9,14 +9,52 @@
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "tst_safe_stdio.h"
+#include "tst_kconfig.h"
 #include "tst_lockdown.h"
 
+#define EFIVAR_SECUREBOOT "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
+
+int tst_secureboot_enabled(void)
+{
+	int fd;
+	char data[5];
+
+	if (access(EFIVAR_SECUREBOOT, F_OK)) {
+		tst_res(TINFO, "Efivar FS not available");
+		return -1;
+	}
+
+	fd = open(EFIVAR_SECUREBOOT, O_RDONLY);
+
+	if (fd == -1) {
+		tst_res(TINFO | TERRNO,
+			"Cannot open SecureBoot Efivar sysfile");
+		return -1;
+	} else if (fd < 0) {
+		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
+		return -1;
+	}
+
+	SAFE_READ(1, fd, data, 5);
+	SAFE_CLOSE(fd);
+	tst_res(TINFO, "SecureBoot: %s", data[4] ? "on" : "off");
+	return data[4];
+}
+
 int tst_lockdown_enabled(void)
 {
 	char line[BUFSIZ];
 	FILE *file;
 
 	if (access(PATH_LOCKDOWN, F_OK) != 0) {
+		char flag;
+
+		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN");
+
+		/* SecureBoot enabled could mean integrity lockdown */
+		if (flag == 'y' && tst_secureboot_enabled() > 0)
+			return 1;
+
 		tst_res(TINFO, "Unable to determine system lockdown state");
 		return 0;
 	}
-- 
2.29.2

