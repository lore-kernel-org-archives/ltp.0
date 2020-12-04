From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Dec 2020 06:33:04 +0000
Subject: [LTP] [PATCH v2 2/3] syscalls: make use of .min_cpus
In-Reply-To: <20201204063305.6820-1-liwang@redhat.com>
References: <20201203110616.28302-1-liwang@redhat.com>
 <20201204063305.6820-1-liwang@redhat.com>
Message-ID: <20201204063305.6820-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To set the minimum numbers of online CPU for test.

From Martin Doucha:

af_alg07 requires 2 CPUs, otherwise it'll report false positives.
The test will pass only if fchownat() hits a half-closed socket and
returns error. But IIRC the half-closed socket will be destroyed during
reschedule which means there's no race window to hit anymore. But it
would be better to put the TCONF condition into the test itself.

getcwd04: as itself requirements.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/crypto/af_alg07.c          | 1 +
 testcases/kernel/syscalls/getcwd/getcwd04.c | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
index 6ad86f4f3..539ebee11 100644
--- a/testcases/kernel/crypto/af_alg07.c
+++ b/testcases/kernel/crypto/af_alg07.c
@@ -110,6 +110,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "4.10.0",
+	.min_cpus = 2,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9060cb719e61"},
diff --git a/testcases/kernel/syscalls/getcwd/getcwd04.c b/testcases/kernel/syscalls/getcwd/getcwd04.c
index 2fa65fb2c..2e07e675f 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd04.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd04.c
@@ -68,9 +68,6 @@ static void verify_getcwd(void)
 
 static void setup(void)
 {
-	if (tst_ncpus() == 1)
-		tst_brk(TCONF, "This test needs two cpus at least");
-
 	SAFE_SIGNAL(SIGALRM, sigproc);
 
 	alarm(TIMEOUT);
@@ -101,5 +98,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = verify_getcwd,
 	.needs_tmpdir = 1,
-	.forks_child = 1
+	.forks_child = 1,
+	.min_cpus = 2
 };
-- 
2.21.3

