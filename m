From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 17 Dec 2019 12:28:32 +0100
Subject: [LTP] [PATCH v2] Make crash02 verbose in standard runfile
In-Reply-To: <20191213164847.GA18822@dell5510>
References: <20191213164847.GA18822@dell5510>
Message-ID: <20191217112832.12478-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verbose output from crash02 will be useful for actually reporting bugs
triggered by the test. With default verbosity level, it's difficult to figure
out which syscall arguments crashed the system even if you know the random seed
and can easily re-run `crash02 -xv 2` on a system that uses the same rand()
implementation.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
Changes in v2: Bring -x implementation in line with usage description.

 runtest/crashme                |  2 +-
 testcases/misc/crash/crash02.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/runtest/crashme b/runtest/crashme
index a4c5b41cc..14750749d 100644
--- a/runtest/crashme
+++ b/runtest/crashme
@@ -7,7 +7,7 @@ f00f f00f
 crash01 crash01
 # Generate random code and execute it. Read f00f comment,
 # this test lockup SunOS,WindowsNT,etc. in seconds..
-crash02 crash02
+crash02 crash02 -v 2
 # Generate random syscalls and execute them, less probability
 # to hose your system, but still.
 mem01 mem01 -r
diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index 00fee3493..cddedc102 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -430,13 +430,12 @@ void try_one_crash(int try_num)
 	arg6 = rand_long();
 	arg7 = rand_long();
 
-	if (x_opt) {
-		if (verbose_level >= 1)
-			printf("%04d: syscall(%ld, %#lx, %#lx, %#lx, %#lx, "
-			       "%#lx, %#lx, %#lx)\n",
-			       try_num, sysno, arg1, arg2, arg3, arg4, arg5,
-			       arg6, arg7);
-	} else {
+	if (x_opt || verbose_level >= 1)
+		printf("%04d: syscall(%ld, %#lx, %#lx, %#lx, %#lx, %#lx, "
+		       "%#lx, %#lx)\n", try_num, sysno, arg1, arg2, arg3,
+		       arg4, arg5, arg6, arg7);
+
+	if (!x_opt) {
 		syscall(sysno, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
 		record_errno(errno);
 	}
-- 
2.24.0

