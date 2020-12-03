From: Li Wang <liwang@redhat.com>
Date: Thu,  3 Dec 2020 11:06:14 +0000
Subject: [LTP] [PATCH 1/3] lib: add .min_cpus in tst_test struct
Message-ID: <20201203110616.28302-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As the name implies, this new field is mainly to set minimum numbers
of CPU for LTP testcase. If system online CPUs are less than .min_cpus,
test will be exit with TCONF.

Note: I wouldn't add more description in test-writing-guidelines.txt,
because it is easy to understand the usage from the name.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_test.h | 3 +++
 lib/tst_test.c     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index c91d3f18a..64a0934dd 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -157,6 +157,9 @@ struct tst_test {
 	 */
 	int all_filesystems:1;
 
+	/* Minimal numbers of CPU online required by the test */
+	unsigned long min_cpus;
+
 	/*
 	 * If set non-zero number of request_hugepages, test will try to reserve the
 	 * expected number of hugepage for testing in setup phase. If system does not
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 535c0ff4c..90b69789c 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -918,6 +918,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->all_filesystems)
 		tst_test->needs_device = 1;
 
+	if (tst_test->min_cpus > tst_ncpus())
+		tst_brk(TCONF, "Test needs %lu CPUs online", tst_test->min_cpus);
+
 	if (tst_test->request_hugepages)
 		tst_request_hugepages(tst_test->request_hugepages);
 
-- 
2.21.3

