From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:52 +0000
Subject: [LTP] [PATCH v3 09/12] syscalls/mount03: Copy setuid_test to
	execute instead of 'TEST FILE'
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-10-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When testing the MS_NOSUID mount flag, mount03 forgets to copy
setuid_test into the new filesystem. Instead it writes 'TEST FILE' into
a new file and attempts to execute it with S_ISUID. This fails, but not
for the reasons ltp expects.

Fix this by copying the test helper binary instead.

While we're touching the test, also rename the helper to
mount03_setuid_test so as to follow current ltp convention.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/mount/mount03.c                     | 11 +++++++----
 .../syscalls/mount/{setuid_test.c => mount03_setuid_test.c}   |  0
 2 files changed, 7 insertions(+), 4 deletions(-)
 rename testcases/kernel/syscalls/mount/{setuid_test.c => mount03_setuid_test.c} (100%)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index bf78c797f..0319c6093 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -261,8 +261,8 @@ int test_rwflag(int i, int cnt)
 	case 5:
 		/* Validate MS_NOSUID flag of mount call */
 
-		snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
-		SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");
+		TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);
+		snprintf(file, PATH_MAX, "%smount03_setuid_test", path_name);
 
 		SAFE_STAT(cleanup, file, &file_stat);
 
@@ -291,9 +291,8 @@ int test_rwflag(int i, int cnt)
 				/* reset the setup_uid */
 				if (status)
 					return 0;
-				else
-					return 1;
 			}
+			return 1;
 		}
 	case 6:
 		/* Validate MS_NOATIME flag of mount call */
@@ -373,6 +372,10 @@ static void setup(void)
 	strncpy(path, path_name, PATH_MAX);
 	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
 
+	SAFE_MOUNT(cleanup, device, mntpoint, fs_type, 0, NULL);
+	TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);
+	SAFE_UMOUNT(cleanup, mntpoint);
+
 	TEST_PAUSE;
 }
 
diff --git a/testcases/kernel/syscalls/mount/setuid_test.c b/testcases/kernel/syscalls/mount/mount03_setuid_test.c
similarity index 100%
rename from testcases/kernel/syscalls/mount/setuid_test.c
rename to testcases/kernel/syscalls/mount/mount03_setuid_test.c
-- 
2.15.0

