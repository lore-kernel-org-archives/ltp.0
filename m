From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 14 Nov 2017 15:59:25 +0000
Subject: [LTP] [PATCH v2 09/13] syscalls/mount03: Copy setuid_test to
	execute instead of 'TEST FILE'
In-Reply-To: <20171114155929.24237-1-punit.agrawal@arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
Message-ID: <20171114155929.24237-10-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Will Deacon <will.deacon@arm.com>

When testing the MS_NOSUID mount flag, mount03 forgets to copy
setuid_test into the new filesystem. Instead it writes 'TEST FILE' into
a new file and attempts to execute it with S_ISUID. This fails, but not
for the reasons ltp expects.

Signed-off-by: Will Deacon <will.deacon@arm.com>
[Added commit message, changed to use tst_resource_copy()]
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/mount/mount03.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index bf78c797f..abdef80fd 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -261,8 +261,10 @@ int test_rwflag(int i, int cnt)
 	case 5:
 		/* Validate MS_NOSUID flag of mount call */
 
+		tst_resource_copy(__FILE__, __LINE__, cleanup, "setuid_test",
+				  path_name);
+
 		snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
-		SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");
 
 		SAFE_STAT(cleanup, file, &file_stat);
 
-- 
2.14.2

