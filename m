From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 13 Mar 2018 16:24:48 +0100
Subject: [LTP] [PATCH v2 2/2] cve-2015-3290: Handle 16-bit segments being
	disabled
In-Reply-To: <20180313105541.GB14611@rei>
References: <20180313105541.GB14611@rei>
Message-ID: <20180313152448.7480-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If modify_ldt fails with EINVAL then we can only assume the kernel has 16-bit
data segments disabled.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/cve/cve-2015-3290.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 87c9c956c..631702e2e 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -215,8 +215,13 @@ static void set_ldt(void)
 		.useable	 = 0
 	};
 
-	if (tst_syscall(__NR_modify_ldt, 1, &data_desc, sizeof(data_desc)) != 0)
-		tst_brk(TBROK | TERRNO, "modify_ldt");
+	TEST(tst_syscall(__NR_modify_ldt, 1, &data_desc, sizeof(data_desc)));
+	if (TEST_RETURN == -EINVAL) {
+		tst_brk(TCONF | TRERRNO,
+			"modify_ldt: 16-bit data segments are probably disabled");
+	} else if (TEST_RETURN != 0) {
+		tst_brk(TBROK | TRERRNO, "modify_ldt");
+	}
 }
 
 static void try_corrupt_stack(unsigned short orig_ss)
@@ -474,6 +479,8 @@ static void run(void)
 	SAFE_WAITPID(pid, &status, 0);
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
 		tst_res(TFAIL, "corrupted NMI stack");
+	else if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+		tst_res(WEXITSTATUS(status), "Propogate child status");
 }
 
 static struct tst_test test = {
-- 
2.16.2

