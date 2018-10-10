From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 10 Oct 2018 08:41:35 -0300
Subject: [LTP] [PATCH v2 1/2] futex/futex_wake04.c: fix hugepages setup for
	test
In-Reply-To: <20181010104317.GB1990@rei>
References: <20181010104317.GB1990@rei>
Message-ID: <20181010114136.23957-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test was changing number of hugepages during setup()/cleanup() phase,
despite system having (or not) already configured hugepages. This was
causing some overhead - of destroying (or creating) hugepages - during
the test execution, and also changing amount of available hugepages to
the rest of the system.

Now, if system has > 0 hugepages available, the test doesn't touch it.

Link: https://bugs.linaro.org/show_bug.cgi?id=3984
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 testcases/kernel/syscalls/futex/futex_wake04.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 3c7038317..1ae9599ab 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -76,14 +76,17 @@ static void setup(void)
 	tst_tmpdir();
 
 	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
-	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
+
+	if (!orig_hugepages)
+		SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
 
 	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
-	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
+	if (!orig_hugepages)
+		SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 0);
 
 	tst_rmdir();
 }
-- 
2.19.1

