Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfCzX-00043f-Cy
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 14:57:03 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfCzU-0003aV-PS
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 14:57:03 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0IEus1C019638
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Jan 2011 09:56:54 -0500
Date: Tue, 18 Jan 2011 09:56:54 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <2071432981.37105.1295362614543.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2082571725.37099.1295362583766.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37104_611669014.1295362614542"
Subject: [LTP] [PATCH 1/3] rework code for oom and ksm tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_37104_611669014.1295362614542
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Mainly to reduce code duplication. Also, to add an option for ksm01 to
use a different memory allocation unit size to take advantage of
THP. In addition, adjust ksm01 according the latest upstream
development effort,
http://marc.info/?l=linux-mm&m=129473104716901&w=2
http://marc.info/?l=linux-mm&m=129442718808733&w=2

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/ksm/ksm01.c |  448 +------------------------------------
 testcases/kernel/mem/oom/oom01.c |    4 +-
 testcases/kernel/mem/oom/oom02.c |    4 +-
 testcases/kernel/mem/oom/oom03.c |    4 +-
 testcases/kernel/mem/oom/oom04.c |   36 +---
 5 files changed, 17 insertions(+), 479 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 09f71d7..26c5aa7 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -1,5 +1,5 @@
 /*
- * functional testing for Kernel Samepage Merging (KSM)
+ * Kernel Samepage Merging (KSM)
  *
  * Basic tests were to start several programs with same and different
  * memory contents and ensure only to merge the ones with the same
@@ -69,9 +69,7 @@
 #include <errno.h>
 #include "test.h"
 #include "usctest.h"
-
-#define _PATH_KSM        "/sys/kernel/mm/ksm/"
-#define MB                (1024 * 1024)
+#include "../include/mem.h"
 
 char *TCID = "ksm01";
 int TST_TOTAL = 1;
@@ -85,455 +83,35 @@ static option_t options[] = {
         { "s:", &opt_size,        &opt_sizestr},
         { NULL, NULL,                NULL}
 };
-static void setup(void);
-static void ksmtest(void);
-static void usage(void);
-static void check(char *path, char *path2, long int value);
-static void verify(char value, int proc, int start, int end, int start2,
-                int end2);
-static void group_check(int run, int pages_shared, int pages_sharing,
-                        int pages_volatile, int pages_unshared,
-                        int sleep_millisecs, int pages_to_scan);
 
 int main(int argc, char *argv[])
 {
         int lc;
         char *msg;
+        int size = 128, num = 3, unit = 1;
 
-        msg = parse_opts(argc, argv, options, usage);
-        if (msg != (char *)NULL)
-                tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+        msg = parse_opts(argc, argv, ksm_options, ksm_usage);
+        if (msg != NULL)
+                tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
         setup();
         for (lc = 0; TEST_LOOPING(lc); lc++) {
                 Tst_count = 0;
-                ksmtest();
+                check_ksm_options(&size, &num, &unit);
+                create_same_memory(size, num, unit);
         }
-        tst_exit();
-}
-
-void ksmtest(void)
-{
-        char buf[BUFSIZ], buf2[BUFSIZ];
-        int i, j, status, k, fd, *child;
-        int size = 128, num = 3;
-
-        if (opt_size) {
-                size = atoi(opt_sizestr);
-                if (size < 1)
-                        tst_brkm(TBROK, NULL,
-                                "size cannot be less than 1.");
-        }
-        if (opt_num) {
-                num = atoi(opt_numstr);
-                if (num < 3)
-                        tst_brkm(TBROK, NULL,
-                                "process number cannot be less 3.");
-        }
-        child = malloc(num);
-        if (child == NULL)
-                tst_brkm(TBROK|TERRNO, NULL, "malloc");
-
-        memory = malloc(num * sizeof(**memory));
-        if (memory == NULL)
-                tst_brkm(TBROK|TERRNO, NULL, "malloc");
-
-        switch (child[0] = fork()) {
-        case -1:
-                tst_brkm(TBROK|TERRNO, NULL, "fork");
-        case 0:
-                tst_resm(TINFO, "child 0 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-
-                tst_resm(TINFO, "child 0 continues...");
-
-                /* Avoid TransparentHugePage allocation which can't ksm at the
-                   moment. */
-                tst_resm(TINFO, "child 0 allocates %d MB filled with 'c'.",
-                        size);
-                memory[0] = malloc(size * sizeof(*memory));
-                if (memory[0] == NULL)
-                        tst_brkm(TBROK|TERRNO, NULL, "malloc");
-                for (j = 0; j < size; j++) {
-                        memory[0][j] = mmap(NULL, MB, PROT_READ|PROT_WRITE,
-                                        MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-                        if (memory[0][j] == MAP_FAILED)
-                                tst_brkm(TBROK|TERRNO, NULL, "mmap");
-                        if (madvise(memory[0][j], MB, MADV_MERGEABLE) == -1)
-                                tst_brkm(TBROK|TERRNO, NULL, "madvise");
-                        for (i = 0; i < MB; i++)
-                                memory[0][j][i] = 'c';
-                }
-                tst_resm(TINFO, "child 0 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-
-                tst_resm(TINFO, "child 0 continues...");
-                verify('c', 0, 0, size, 0, MB);
-                tst_resm(TINFO, "child 0 changes memory content to 'd'.");
-                for (j = 0; j < size; j++) {
-                        for (i = 0; i < MB; i++)
-                                memory[0][j][i] = 'd';
-                }
-                /* Unmerge. */
-                tst_resm(TINFO, "child 0 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-
-                tst_resm(TINFO, "child 0 continues...");
-                verify('d', 0, 0, size, 0, MB);
-                /* Stop. */
-                tst_resm(TINFO, "child 0 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-                tst_resm(TINFO, "child 0 continues...");
-                exit(0);
-        }
-        switch (child[1] = fork()) {
-        case -1:
-                tst_brkm(TBROK|TERRNO, NULL, "fork");
-        case 0:
-                tst_resm(TINFO, "child 1 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-                tst_resm(TINFO, "child 1 continues...");
-                tst_resm(TINFO, "child 1 allocates %d MB filled with 'a'.",
-                        size);
-                memory[1] = malloc(size * sizeof(*memory));
-                if (memory[1] == NULL)
-                        tst_brkm(TBROK|TERRNO, NULL, "malloc");
-                for (j = 0; j < size; j++) {
-                        memory[1][j] = mmap(NULL, MB, PROT_READ|PROT_WRITE,
-                                        MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-                        if (memory[1][j] == MAP_FAILED)
-                                tst_brkm(TBROK|TERRNO, NULL, "mmap");
-                        if (madvise(memory[1][j], MB, MADV_MERGEABLE) == -1)
-                                tst_brkm(TBROK|TERRNO, NULL, "madvise");
-                        for (i = 0; i < MB; i++)
-                                memory[1][j][i] = 'a';
-                }
-
-                tst_resm(TINFO, "child 1 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-                tst_resm(TINFO, "child 1 continues...");
-                verify('a', 1, 0, size, 0, MB);
-                tst_resm(TINFO, "child 1 changes memory content to 'b'.");
-                for (j = 0; j < size; j++) {
-                        for (i = 0; i < MB; i++)
-                                memory[1][j][i] = 'b';
-                }
-
-                tst_resm(TINFO, "child 1 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-                tst_resm(TINFO, "child 1 continues...");
-                verify('b', 1, 0, size, 0, MB);
-                tst_resm(TINFO, "child 1 changes memory content to 'd'");
-                for (j = 0; j < size; j++) {
-                        for (i = 0; i < MB; i++)
-                                memory[1][j][i] = 'd';
-                }
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-
-                tst_resm(TINFO, "child 1 continues...");
-                verify('d', 1, 0, size, 0, MB);
-                tst_resm(TINFO, "child 1 changes one page to 'e'.");
-                memory[1][size - 1][MB - 1] = 'e';
-
-                /* Unmerge. */
-                tst_resm(TINFO, "child 1 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-                tst_resm(TINFO, "child 1 continues...");
-                verify('e', 1, size - 1, size, MB - 1, MB);
-                verify('d', 1, 0, size - 1, 0, MB - 1);
-
-                /* Stop. */
-                tst_resm(TINFO, "child 1 stops.");
-                if (raise(SIGSTOP) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill");
-                tst_resm(TINFO, "child 1 continues...");
-                exit(0);
-        }
-        for (k = 2; k < num; k++) {
-                switch (child[k] = fork()) {
-                case -1:
-                        tst_brkm(TBROK|TERRNO, NULL, "fork");
-                case 0:
-                        tst_resm(TINFO, "child %d stops.", k);
-                        if (raise(SIGSTOP) == -1)
-                                tst_brkm(TBROK|TERRNO, NULL, "kill");
-                        tst_resm(TINFO, "child %d continues...", k);
-                        tst_resm(TINFO, "child %d allocates %d "
-                                "MB filled with 'a'.", k, size);
-                        memory[k] = malloc(size * sizeof(*memory));
-                        if (memory[k] == NULL)
-                                tst_brkm(TBROK|TERRNO, NULL, "malloc");
-                        for (j = 0; j < size; j++) {
-                                memory[k][j] = mmap(NULL, MB,
-                                                PROT_READ|PROT_WRITE,
-                                                MAP_ANONYMOUS
-                                                |MAP_PRIVATE, -1, 0);
-                                if (memory[k][j] == MAP_FAILED)
-                                        tst_brkm(TBROK|TERRNO, NULL,
-                                                "mmap");
-                                if (madvise(memory[k][j], MB,
-                                                MADV_MERGEABLE) == -1)
-                                        tst_brkm(TBROK|TERRNO, NULL,
-                                                "madvise");
-                                for (i = 0; i < MB; i++)
-                                        memory[k][j][i] = 'a';
-                        }
-                        tst_resm(TINFO, "child %d stops.", k);
-                        if (raise(SIGSTOP) == -1)
-                                tst_brkm(TBROK|TERRNO, NULL, "kill");
-                        tst_resm(TINFO, "child %d continues...", k);
-                        tst_resm(TINFO, "child %d changes memory content to "
-                                "'d'", k);
-                        for (j = 0; j < size; j++) {
-                                for (i = 0; i < MB; i++)
-                                        memory[k][j][i] = 'd';
-                        }
-                        /* Unmerge. */
-                        tst_resm(TINFO, "child %d stops.", k);
-                        if (raise(SIGSTOP) == -1)
-                                tst_brkm(TBROK|TERRNO, NULL, "kill");
-                        tst_resm(TINFO, "child %d continues...", k);
-
-                        /* Stop. */
-                        tst_resm(TINFO, "child %d stops.", k);
-                        if (raise(SIGSTOP) == -1)
-                                tst_brkm(TBROK|TERRNO, NULL, "kill");
-                        tst_resm(TINFO, "child %d continues...", k);
-                        exit(0);
-                }
-        }
-        tst_resm(TINFO, "KSM merging...");
-        snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
-        fd = open(buf, O_WRONLY);
-        if (fd == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "open");
-        if (write(fd, "1", 1) != 1)
-                tst_brkm(TBROK|TERRNO, NULL, "write");
-        close(fd);
-        snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "pages_to_scan");
-        snprintf(buf2, BUFSIZ, "%d", size * 256 * num);
-        fd = open(buf, O_WRONLY);
-        if (fd == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "open");
-        if (write(fd, buf2, strlen(buf2)) != strlen(buf2))
-                tst_brkm(TBROK|TERRNO, NULL, "write");
-        close(fd);
-
-        snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "sleep_millisecs");
-        fd = open(buf, O_WRONLY);
-        if (fd == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "open");
-        if (write(fd, "0", 1) != 1)
-                tst_brkm(TBROK|TERRNO, NULL, "write");
-        close(fd);
-
-        tst_resm(TINFO, "wait for all children to stop.");
-        for (k = 0; k < num; k++) {
-                if (waitpid(child[k], &status, WUNTRACED) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-                if (!WIFSTOPPED(status))
-                        tst_brkm(TBROK, NULL, "child %d was not stopped.",
-                                k);
-        }
-        tst_resm(TINFO, "resume all children.");
-        for (k = 0; k < num; k++) {
-                if (kill(child[k], SIGCONT) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill child[%d]", k);
-        }
-        group_check(1, 2, size * num * 256 - 2, 0, 0, 0, size * 256 * num);
-
-        tst_resm(TINFO, "wait for child 1 to stop.");
-        if (waitpid(child[1], &status, WUNTRACED) == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-        if (!WIFSTOPPED(status))
-                tst_brkm(TBROK, NULL, "child 1 was not stopped.");
-
-        /* Child 1 changes all pages to 'b'. */
-        tst_resm(TINFO, "resume child 1.");
-        if (kill(child[1], SIGCONT) == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "kill");
-        group_check(1, 3, size * num * 256 - 3, 0, 0, 0, size * 256 * num);
-
-        tst_resm(TINFO, "wait for child 1 to stop.");
-        if (waitpid(child[1], &status, WUNTRACED) == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-        if (!WIFSTOPPED(status))
-                tst_brkm(TBROK, NULL, "child 1 was not stopped.");
-
-        /* All children change pages to 'd'. */
-        tst_resm(TINFO, "resume all children.");
-        for (k = 0; k < num; k++) {
-                if (kill(child[k], SIGCONT) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill child[%d]", k);
-        }
-        group_check(1, 1, size * num * 256 - 1, 0, 0, 0, size * 256 * num);
-
-        tst_resm(TINFO, "wait for all children to stop.");
-        for (k = 0; k < num; k++) {
-                if (waitpid(child[k], &status, WUNTRACED) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-                if (!WIFSTOPPED(status))
-                        tst_brkm(TBROK, NULL, "child %d was not stopped.",
-                                k);
-        }
-        /* Child 1 changes pages to 'e'. */
-        tst_resm(TINFO, "resume child 1.");
-        if (kill(child[1], SIGCONT) == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "kill");
-        group_check(1, 1, size * num * 256 - 2, 0, 1, 0, size * 256 * num);
-
-        tst_resm(TINFO, "wait for child 1 to stop.");
-        if (waitpid(child[1], &status, WUNTRACED) == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-        if (!WIFSTOPPED(status))
-                tst_brkm(TBROK, NULL, "child 1 was not stopped.");
-
-        tst_resm(TINFO, "resume all children.");
-        for (k = 0; k < num; k++) {
-                if (kill(child[k], SIGCONT) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill child[%d]", k);
-        }
-        tst_resm(TINFO, "KSM unmerging...");
-        snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
-        fd = open(buf, O_WRONLY);
-        if (fd == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "open");
-        if (write(fd, "2", 1) != 1)
-                tst_brkm(TBROK|TERRNO, NULL, "write");
-        group_check(2, 0, 0, 0, 0, 0, size * 256 * num);
-
-        tst_resm(TINFO, "wait for all children to stop.");
-        for (k = 0; k < num; k++) {
-                if (waitpid(child[k], &status, WUNTRACED) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-                if (!WIFSTOPPED(status))
-                        tst_brkm(TBROK, NULL, "child %d was not stopped.",
-                                k);
-        }
-        tst_resm(TINFO, "resume all children.");
-        for (k = 0; k < num; k++) {
-                if (kill(child[k], SIGCONT) == -1)
-                        tst_brkm(TBROK|TERRNO, NULL, "kill child[%d]", k);
-        }
-        tst_resm(TINFO, "stop KSM.");
-        if (lseek(fd, 0, SEEK_SET) == -1)
-                tst_brkm(TBROK|TERRNO, NULL, "lseek");
-        if (write(fd, "0", 1) != 1)
-                tst_brkm(TBROK|TERRNO, NULL, "write");
-        close(fd);
-        group_check(0, 0, 0, 0, 0, 0, size * 256 * num);
-        while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
-                if (WEXITSTATUS(status) != 0)
-                        tst_resm(TFAIL, "child exit status is %d",
-                                WEXITSTATUS(status));
+        cleanup();
 }
 
 void setup(void)
 {
-        char buf[BUFSIZ];
-        struct stat new;
+        tst_require_root(tst_exit);
 
-        snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
-        if (stat(buf, &new) == -1) {
-                if (errno == ENOENT)
-                        tst_brkm(TCONF, NULL, "no KSM.");
-                else
-                        tst_brkm(TBROK, NULL, "stat");
-        }
-        /*
-         * setup a default signal hander and a
-         * temporary working directory.
-         */
         tst_sig(FORK, DEF_HANDLER, NULL);
         TEST_PAUSE;
 }
 
-void usage(void)
+void cleanup(void)
 {
-        printf("  -n      Number of processes\n");
-        printf("  -s      Memory allocation size in MB\n");
-}
-
-/* There is currently a bug will cause the test failure - *
- http://marc.info/?l=linux-mm&m=128928530308526&w=2 .  Since it has
- still been discussed upstream, the interface here was added some
- flexiblity with path2, so it is possible to make changes here depends
- on the future implementation in kernel. For example, to verify
- (pages_sharing + pages_volatile) instead of a single item. */
-void check(char *path, char *path2, long int value)
-{
-        FILE *fp;
-        char buf[BUFSIZ], buf2[BUFSIZ];
-
-        snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, path);
-        fp = fopen(buf, "r");
-        if (fp == NULL)
-                tst_brkm(TBROK|TERRNO, NULL, "fopen");
-        if (fgets(buf, BUFSIZ, fp) == NULL)
-                tst_brkm(TBROK|TERRNO, NULL, "fgets");
-        fclose(fp);
-
-        tst_resm(TINFO, "%s is %ld.", path, atol(buf));
-        if (path2 != NULL) {
-                snprintf(buf2, BUFSIZ, "%s%s", _PATH_KSM, path2);
-                fp = fopen(buf2, "r");
-                if (fp == NULL)
-                        tst_brkm(TBROK|TERRNO, NULL, "fopen");
-                if (fgets(buf2, BUFSIZ, fp) == NULL)
-                        tst_brkm(TBROK|TERRNO, NULL, "fgets");
-                fclose(fp);
-
-                tst_resm(TINFO, "%s is %ld.", path2, atol(buf2));
-                if (atol(buf) + atol(buf2) != value)
-                        tst_resm(TFAIL, "%s + %s is not %ld.", path, path2,
-                                value);
-        } else
-                if (atol(buf) != value)
-                        tst_resm(TFAIL, "%s is not %ld.", path, value);
-}
-
-void verify(char value, int proc, int start, int end, int start2, int end2)
-{
-        int i, j;
-        void *s = NULL;
-
-        s = malloc((end - start) * (end2 - start2));
-        if (s == NULL)
-                tst_brkm(TBROK|TERRNO, NULL, "malloc");
-
-        tst_resm(TINFO, "child %d verifies memory content.", proc);
-        memset(s, value, (end - start) * (end2 - start2));
-        if (memcmp(memory[proc][start], s, (end - start) * (end2 - start2)) != 0)
-                for (j = start; j < end; j++)
-                        for (i = start2; i < end2; i++)
-                                if (memory[proc][j][i] != value)
-                                        tst_resm(TFAIL, "child %d has %c at "
-                                                "%d,%d,%d.",
-                                                proc, memory[proc][j][i], proc,
-                                                j, i);
-        free(s);
+        TEST_CLEANUP;
+        tst_exit();
 }
-
-void group_check(int run, int pages_shared, int pages_sharing,
-                int pages_volatile, int pages_unshared,
-                int sleep_millisecs, int pages_to_scan)
-{
-        /* 5 seconds for ksm to scan pages. */
-        sleep(5);
-        tst_resm(TINFO, "check!");
-        check("run", NULL, run);
-        check("pages_shared", NULL, pages_shared);
-        check("pages_sharing", NULL, pages_sharing);
-        check("pages_volatile", NULL, pages_volatile);
-        check("pages_unshared", NULL, pages_unshared);
-        check("sleep_millisecs", NULL, sleep_millisecs);
-        check("pages_to_scan", NULL, pages_to_scan);
-}
\ No newline at end of file
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index c670d90..8c31458 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -38,14 +38,12 @@
 #include <unistd.h>
 #include "test.h"
 #include "usctest.h"
-#include "lib/oom.h"
+#include "../include/mem.h"
 
 char *TCID = "oom01";
 int TST_TOTAL = 1;
 extern int Tst_count;
 
-static void setup(void);
-
 int main(int argc, char *argv[])
 {
         char *msg;
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 68ed1ef..04c6507 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -42,9 +42,7 @@ int TST_TOTAL = 1;
 #include <fcntl.h>
 #include 
 #include <errno.h>
-#include "lib/oom.h"
-
-static void setup(void);
+#include "../include/mem.h"
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index dd09467..3c16018 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -35,14 +35,12 @@
 #include <errno.h>
 #include "test.h"
 #include "usctest.h"
-#include "lib/oom.h"
+#include "../include/mem.h"
 
 char *TCID = "oom03";
 int TST_TOTAL = 1;
 extern int Tst_count;
 
-static void setup(void);
-
 int main(int argc, char *argv[])
 {
         char *msg;
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 1dff85e..ce3161c 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -48,41 +48,7 @@ extern int Tst_count;
 #include 
 #include <unistd.h>
 #include <errno.h>
-#include <stdlib.h>
-#include 
-#include <errno.h>
-#include 
-#include <unistd.h>
-#include <stdarg.h>
-
-#define MAXNODES                512
-#define CPATH                        "/dev/cpuset"
-#define CPATH_NEW                CPATH "/1"
-#define MEMCG_PATH                "/dev/cgroup"
-#define MEMCG_PATH_NEW                MEMCG_PATH "/1"
-#define _PATH_SYS_SYSTEM        "/sys/devices/system"
-#define LENGTH                        (3UL<<30)
-#define TESTMEM                        (1UL<<30)
-#define MB                        (1UL<<20)
-#define NORMAL                        1
-#define MLOCK                        2
-#define KSM                        3
-#define SYSFS_OVER                "/proc/sys/vm/overcommit_memory"
-
-static char overcommit[BUFSIZ];
-
-static void setup(void);
-static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
-static void oom(int testcase, int mempolicy, int lite);
-static long count_numa(void);
-static int path_exist(const char *path, ...);
-static void testoom(int mempolicy, int lite);
-static void alloc_mem(long int length, int testcase);
-static void test_alloc(int testcase, int lite);
-static void gather_cpus(char *cpus);
-static void umount_mem(char *path, char *path_new);
-static void mount_mem(char *name, char *fs, char *options, char *path,
-                char *path_new);
+#include "../include/mem.h"
 
 int main(int argc, char *argv[])
 {
-- 
1.7.3.2
------=_Part_37104_611669014.1295362614542
Content-Type: text/x-patch; name=0001-rework-code-for-oom-and-ksm-tests.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-rework-code-for-oom-and-ksm-tests.patch

RnJvbSBlNjY3MDk0ODg5ODdhNWRmYzVjMzYyMTUyOTMzYzY4Nzk2MDkwYzA3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDE4IEphbiAyMDExIDExOjA3OjQ0ICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzNdIHJld29y
ayBjb2RlIGZvciBvb20gYW5kIGtzbSB0ZXN0cwoKTWFpbmx5IHRvIHJlZHVjZSBjb2RlIGR1cGxp
Y2F0aW9uLiBBbHNvLCB0byBhZGQgYW4gb3B0aW9uIGZvciBrc20wMSB0bwp1c2UgYSBkaWZmZXJl
bnQgbWVtb3J5IGFsbG9jYXRpb24gdW5pdCBzaXplIHRvIHRha2UgYWR2YW50YWdlIG9mClRIUC4g
SW4gYWRkaXRpb24sIGFkanVzdCBrc20wMSBhY2NvcmRpbmcgdGhlIGxhdGVzdCB1cHN0cmVhbQpk
ZXZlbG9wbWVudCBlZmZvcnQsCmh0dHA6Ly9tYXJjLmluZm8vP2w9bGludXgtbW0mbT0xMjk0NzMx
MDQ3MTY5MDEmdz0yCmh0dHA6Ly9tYXJjLmluZm8vP2w9bGludXgtbW0mbT0xMjk0NDI3MTg4MDg3
MzMmdz0yCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgotLS0K
IHRlc3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wMS5jIHwgIDQ0OCArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDEuYyB8
ICAgIDQgKy0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMi5jIHwgICAgNCArLQogdGVz
dGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMgfCAgICA0ICstCiB0ZXN0Y2FzZXMva2VybmVs
L21lbS9vb20vb29tMDQuYyB8ICAgMzYgKy0tLQogNSBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCA0NzkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0va3NtL2tzbTAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDEuYwppbmRleCAw
OWY3MWQ3Li4yNmM1YWE3IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3Nt
MDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDEuYwpAQCAtMSw1ICsxLDUg
QEAKIC8qCi0gKiBmdW5jdGlvbmFsIHRlc3RpbmcgZm9yIEtlcm5lbCBTYW1lcGFnZSBNZXJnaW5n
IChLU00pCisgKiBLZXJuZWwgU2FtZXBhZ2UgTWVyZ2luZyAoS1NNKQogICoKICAqIEJhc2ljIHRl
c3RzIHdlcmUgdG8gc3RhcnQgc2V2ZXJhbCBwcm9ncmFtcyB3aXRoIHNhbWUgYW5kIGRpZmZlcmVu
dAogICogbWVtb3J5IGNvbnRlbnRzIGFuZCBlbnN1cmUgb25seSB0byBtZXJnZSB0aGUgb25lcyB3
aXRoIHRoZSBzYW1lCkBAIC02OSw5ICs2OSw3IEBACiAjaW5jbHVkZSA8ZXJybm8uaD4KICNpbmNs
dWRlICJ0ZXN0LmgiCiAjaW5jbHVkZSAidXNjdGVzdC5oIgotCi0jZGVmaW5lIF9QQVRIX0tTTQki
L3N5cy9rZXJuZWwvbW0va3NtLyIKLSNkZWZpbmUgTUIJCSgxMDI0ICogMTAyNCkKKyNpbmNsdWRl
ICIuLi9pbmNsdWRlL21lbS5oIgogCiBjaGFyICpUQ0lEID0gImtzbTAxIjsKIGludCBUU1RfVE9U
QUwgPSAxOwpAQCAtODUsNDU1ICs4MywzNSBAQCBzdGF0aWMgb3B0aW9uX3Qgb3B0aW9uc1tdID0g
ewogCXsgInM6IiwgJm9wdF9zaXplLAkmb3B0X3NpemVzdHJ9LAogCXsgTlVMTCwgTlVMTCwJCU5V
TEx9CiB9Owotc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7Ci1zdGF0aWMgdm9pZCBrc210ZXN0KHZv
aWQpOwotc3RhdGljIHZvaWQgdXNhZ2Uodm9pZCk7Ci1zdGF0aWMgdm9pZCBjaGVjayhjaGFyICpw
YXRoLCBjaGFyICpwYXRoMiwgbG9uZyBpbnQgdmFsdWUpOwotc3RhdGljIHZvaWQgdmVyaWZ5KGNo
YXIgdmFsdWUsIGludCBwcm9jLCBpbnQgc3RhcnQsIGludCBlbmQsIGludCBzdGFydDIsCi0JCWlu
dCBlbmQyKTsKLXN0YXRpYyB2b2lkIGdyb3VwX2NoZWNrKGludCBydW4sIGludCBwYWdlc19zaGFy
ZWQsIGludCBwYWdlc19zaGFyaW5nLAotCQkJaW50IHBhZ2VzX3ZvbGF0aWxlLCBpbnQgcGFnZXNf
dW5zaGFyZWQsCi0JCQlpbnQgc2xlZXBfbWlsbGlzZWNzLCBpbnQgcGFnZXNfdG9fc2Nhbik7CiAK
IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiB7CiAJaW50IGxjOwogCWNoYXIgKm1z
ZzsKKwlpbnQgc2l6ZSA9IDEyOCwgbnVtID0gMywgdW5pdCA9IDE7CiAKLQltc2cgPSBwYXJzZV9v
cHRzKGFyZ2MsIGFyZ3YsIG9wdGlvbnMsIHVzYWdlKTsKLQlpZiAobXNnICE9IChjaGFyICopTlVM
TCkKLQkJdHN0X2Jya20oVEJST0ssIE5VTEwsICJPUFRJT04gUEFSU0lORyBFUlJPUiAtICVzIiwg
bXNnKTsKKwltc2cgPSBwYXJzZV9vcHRzKGFyZ2MsIGFyZ3YsIGtzbV9vcHRpb25zLCBrc21fdXNh
Z2UpOworCWlmIChtc2cgIT0gTlVMTCkKKwkJdHN0X2Jya20oVEJST0ssIHRzdF9leGl0LCAiT1BU
SU9OIFBBUlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7CiAJc2V0dXAoKTsKIAlmb3IgKGxjID0gMDsg
VEVTVF9MT09QSU5HKGxjKTsgbGMrKykgewogCQlUc3RfY291bnQgPSAwOwotCQlrc210ZXN0KCk7
CisJCWNoZWNrX2tzbV9vcHRpb25zKCZzaXplLCAmbnVtLCAmdW5pdCk7CisJCWNyZWF0ZV9zYW1l
X21lbW9yeShzaXplLCBudW0sIHVuaXQpOwogCX0KLQl0c3RfZXhpdCgpOwotfQotCi12b2lkIGtz
bXRlc3Qodm9pZCkKLXsKLQljaGFyIGJ1ZltCVUZTSVpdLCBidWYyW0JVRlNJWl07Ci0JaW50IGks
IGosIHN0YXR1cywgaywgZmQsICpjaGlsZDsKLQlpbnQgc2l6ZSA9IDEyOCwgbnVtID0gMzsKLQot
CWlmIChvcHRfc2l6ZSkgewotCQlzaXplID0gYXRvaShvcHRfc2l6ZXN0cik7Ci0JCWlmIChzaXpl
IDwgMSkKLQkJCXRzdF9icmttKFRCUk9LLCBOVUxMLAotCQkJCSJzaXplIGNhbm5vdCBiZSBsZXNz
IHRoYW4gMS4iKTsKLQl9Ci0JaWYgKG9wdF9udW0pIHsKLQkJbnVtID0gYXRvaShvcHRfbnVtc3Ry
KTsKLQkJaWYgKG51bSA8IDMpCi0JCQl0c3RfYnJrbShUQlJPSywgTlVMTCwKLQkJCQkicHJvY2Vz
cyBudW1iZXIgY2Fubm90IGJlIGxlc3MgMy4iKTsKLQl9Ci0JY2hpbGQgPSBtYWxsb2MobnVtKTsK
LQlpZiAoY2hpbGQgPT0gTlVMTCkKLQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAibWFs
bG9jIik7Ci0KLQltZW1vcnkgPSBtYWxsb2MobnVtICogc2l6ZW9mKCoqbWVtb3J5KSk7Ci0JaWYg
KG1lbW9yeSA9PSBOVUxMKQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJtYWxsb2Mi
KTsKLQotCXN3aXRjaCAoY2hpbGRbMF0gPSBmb3JrKCkpIHsKLQljYXNlIC0xOgotCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIE5VTEwsICJmb3JrIik7Ci0JY2FzZSAwOgotCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkIDAgc3RvcHMuIik7Ci0JCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKLQkJCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQotCQl0c3RfcmVzbShUSU5GTywg
ImNoaWxkIDAgY29udGludWVzLi4uIik7Ci0KLQkJLyogQXZvaWQgVHJhbnNwYXJlbnRIdWdlUGFn
ZSBhbGxvY2F0aW9uIHdoaWNoIGNhbid0IGtzbSBhdCB0aGUKLQkJICAgbW9tZW50LiAqLwotCQl0
c3RfcmVzbShUSU5GTywgImNoaWxkIDAgYWxsb2NhdGVzICVkIE1CIGZpbGxlZCB3aXRoICdjJy4i
LAotCQkJc2l6ZSk7Ci0JCW1lbW9yeVswXSA9IG1hbGxvYyhzaXplICogc2l6ZW9mKCptZW1vcnkp
KTsKLQkJaWYgKG1lbW9yeVswXSA9PSBOVUxMKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBO
VUxMLCAibWFsbG9jIik7Ci0JCWZvciAoaiA9IDA7IGogPCBzaXplOyBqKyspIHsKLQkJCW1lbW9y
eVswXVtqXSA9IG1tYXAoTlVMTCwgTUIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLAotCQkJCQlNQVBf
QU5PTllNT1VTfE1BUF9QUklWQVRFLCAtMSwgMCk7Ci0JCQlpZiAobWVtb3J5WzBdW2pdID09IE1B
UF9GQUlMRUQpCi0JCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAibW1hcCIpOwotCQkJ
aWYgKG1hZHZpc2UobWVtb3J5WzBdW2pdLCBNQiwgTUFEVl9NRVJHRUFCTEUpID09IC0xKQotCQkJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIm1hZHZpc2UiKTsKLQkJCWZvciAoaSA9IDA7
IGkgPCBNQjsgaSsrKQotCQkJCW1lbW9yeVswXVtqXVtpXSA9ICdjJzsKLQkJfQotCQl0c3RfcmVz
bShUSU5GTywgImNoaWxkIDAgc3RvcHMuIik7Ci0JCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkK
LQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQotCQl0c3RfcmVzbShU
SU5GTywgImNoaWxkIDAgY29udGludWVzLi4uIik7Ci0JCXZlcmlmeSgnYycsIDAsIDAsIHNpemUs
IDAsIE1CKTsKLQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAwIGNoYW5nZXMgbWVtb3J5IGNvbnRl
bnQgdG8gJ2QnLiIpOwotCQlmb3IgKGogPSAwOyBqIDwgc2l6ZTsgaisrKSB7Ci0JCQlmb3IgKGkg
PSAwOyBpIDwgTUI7IGkrKykKLQkJCQltZW1vcnlbMF1bal1baV0gPSAnZCc7Ci0JCX0KLQkJLyog
VW5tZXJnZS4gKi8KLQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAwIHN0b3BzLiIpOwotCQlpZiAo
cmFpc2UoU0lHU1RPUCkgPT0gLTEpCi0JCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJr
aWxsIik7Ci0KLQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAwIGNvbnRpbnVlcy4uLiIpOwotCQl2
ZXJpZnkoJ2QnLCAwLCAwLCBzaXplLCAwLCBNQik7Ci0JCS8qIFN0b3AuICovCi0JCXRzdF9yZXNt
KFRJTkZPLCAiY2hpbGQgMCBzdG9wcy4iKTsKLQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQot
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAia2lsbCIpOwotCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkIDAgY29udGludWVzLi4uIik7Ci0JCWV4aXQoMCk7Ci0JfQotCXN3aXRjaCAoY2hp
bGRbMV0gPSBmb3JrKCkpIHsKLQljYXNlIC0xOgotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5V
TEwsICJmb3JrIik7Ci0JY2FzZSAwOgotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgc3RvcHMu
Iik7Ci0JCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgTlVMTCwgImtpbGwiKTsKLQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIGNvbnRpbnVlcy4u
LiIpOwotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgYWxsb2NhdGVzICVkIE1CIGZpbGxlZCB3
aXRoICdhJy4iLAotCQkJc2l6ZSk7Ci0JCW1lbW9yeVsxXSA9IG1hbGxvYyhzaXplICogc2l6ZW9m
KCptZW1vcnkpKTsKLQkJaWYgKG1lbW9yeVsxXSA9PSBOVUxMKQotCQkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBOVUxMLCAibWFsbG9jIik7Ci0JCWZvciAoaiA9IDA7IGogPCBzaXplOyBqKyspIHsK
LQkJCW1lbW9yeVsxXVtqXSA9IG1tYXAoTlVMTCwgTUIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLAot
CQkJCQlNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFLCAtMSwgMCk7Ci0JCQlpZiAobWVtb3J5WzFd
W2pdID09IE1BUF9GQUlMRUQpCi0JCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAibW1h
cCIpOwotCQkJaWYgKG1hZHZpc2UobWVtb3J5WzFdW2pdLCBNQiwgTUFEVl9NRVJHRUFCTEUpID09
IC0xKQotCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIm1hZHZpc2UiKTsKLQkJCWZv
ciAoaSA9IDA7IGkgPCBNQjsgaSsrKQotCQkJCW1lbW9yeVsxXVtqXVtpXSA9ICdhJzsKLQkJfQot
Ci0JCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBzdG9wcy4iKTsKLQkJaWYgKHJhaXNlKFNJR1NU
T1ApID09IC0xKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAia2lsbCIpOwotCQl0
c3RfcmVzbShUSU5GTywgImNoaWxkIDEgY29udGludWVzLi4uIik7Ci0JCXZlcmlmeSgnYScsIDEs
IDAsIHNpemUsIDAsIE1CKTsKLQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIGNoYW5nZXMgbWVt
b3J5IGNvbnRlbnQgdG8gJ2InLiIpOwotCQlmb3IgKGogPSAwOyBqIDwgc2l6ZTsgaisrKSB7Ci0J
CQlmb3IgKGkgPSAwOyBpIDwgTUI7IGkrKykKLQkJCQltZW1vcnlbMV1bal1baV0gPSAnYic7Ci0J
CX0KLQotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgc3RvcHMuIik7Ci0JCWlmIChyYWlzZShT
SUdTVE9QKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsK
LQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIGNvbnRpbnVlcy4uLiIpOwotCQl2ZXJpZnkoJ2In
LCAxLCAwLCBzaXplLCAwLCBNQik7Ci0JCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBjaGFuZ2Vz
IG1lbW9yeSBjb250ZW50IHRvICdkJyIpOwotCQlmb3IgKGogPSAwOyBqIDwgc2l6ZTsgaisrKSB7
Ci0JCQlmb3IgKGkgPSAwOyBpIDwgTUI7IGkrKykKLQkJCQltZW1vcnlbMV1bal1baV0gPSAnZCc7
Ci0JCX0KLQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQotCQkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBOVUxMLCAia2lsbCIpOwotCi0JCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBjb250aW51
ZXMuLi4iKTsKLQkJdmVyaWZ5KCdkJywgMSwgMCwgc2l6ZSwgMCwgTUIpOwotCQl0c3RfcmVzbShU
SU5GTywgImNoaWxkIDEgY2hhbmdlcyBvbmUgcGFnZSB0byAnZScuIik7Ci0JCW1lbW9yeVsxXVtz
aXplIC0gMV1bTUIgLSAxXSA9ICdlJzsKLQotCQkvKiBVbm1lcmdlLiAqLwotCQl0c3RfcmVzbShU
SU5GTywgImNoaWxkIDEgc3RvcHMuIik7Ci0JCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKLQkJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQkJdHN0X3Jlc20oVElORk8s
ICJjaGlsZCAxIGNvbnRpbnVlcy4uLiIpOwotCQl2ZXJpZnkoJ2UnLCAxLCBzaXplIC0gMSwgc2l6
ZSwgTUIgLSAxLCBNQik7Ci0JCXZlcmlmeSgnZCcsIDEsIDAsIHNpemUgLSAxLCAwLCBNQiAtIDEp
OwotCi0JCS8qIFN0b3AuICovCi0JCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBzdG9wcy4iKTsK
LQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBO
VUxMLCAia2lsbCIpOwotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgY29udGludWVzLi4uIik7
Ci0JCWV4aXQoMCk7Ci0JfQotCWZvciAoayA9IDI7IGsgPCBudW07IGsrKykgewotCQlzd2l0Y2gg
KGNoaWxkW2tdID0gZm9yaygpKSB7Ci0JCWNhc2UgLTE6Ci0JCQl0c3RfYnJrbShUQlJPS3xURVJS
Tk8sIE5VTEwsICJmb3JrIik7Ci0JCWNhc2UgMDoKLQkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQg
JWQgc3RvcHMuIiwgayk7Ci0JCQlpZiAocmFpc2UoU0lHU1RPUCkgPT0gLTEpCi0JCQkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBOVUxMLCAia2lsbCIpOwotCQkJdHN0X3Jlc20oVElORk8sICJjaGls
ZCAlZCBjb250aW51ZXMuLi4iLCBrKTsKLQkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgYWxs
b2NhdGVzICVkICIKLQkJCQkiTUIgZmlsbGVkIHdpdGggJ2EnLiIsIGssIHNpemUpOwotCQkJbWVt
b3J5W2tdID0gbWFsbG9jKHNpemUgKiBzaXplb2YoKm1lbW9yeSkpOwotCQkJaWYgKG1lbW9yeVtr
XSA9PSBOVUxMKQotCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIm1hbGxvYyIpOwot
CQkJZm9yIChqID0gMDsgaiA8IHNpemU7IGorKykgewotCQkJCW1lbW9yeVtrXVtqXSA9IG1tYXAo
TlVMTCwgTUIsCi0JCQkJCQlQUk9UX1JFQUR8UFJPVF9XUklURSwKLQkJCQkJCU1BUF9BTk9OWU1P
VVMKLQkJCQkJCXxNQVBfUFJJVkFURSwgLTEsIDApOwotCQkJCWlmIChtZW1vcnlba11bal0gPT0g
TUFQX0ZBSUxFRCkKLQkJCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLAotCQkJCQkJIm1t
YXAiKTsKLQkJCQlpZiAobWFkdmlzZShtZW1vcnlba11bal0sIE1CLAotCQkJCQkJTUFEVl9NRVJH
RUFCTEUpID09IC0xKQotCQkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsCi0JCQkJCQki
bWFkdmlzZSIpOwotCQkJCWZvciAoaSA9IDA7IGkgPCBNQjsgaSsrKQotCQkJCQltZW1vcnlba11b
al1baV0gPSAnYSc7Ci0JCQl9Ci0JCQl0c3RfcmVzbShUSU5GTywgImNoaWxkICVkIHN0b3BzLiIs
IGspOwotCQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQotCQkJCXRzdF9icmttKFRCUk9LfFRF
UlJOTywgTlVMTCwgImtpbGwiKTsKLQkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgY29udGlu
dWVzLi4uIiwgayk7Ci0JCQl0c3RfcmVzbShUSU5GTywgImNoaWxkICVkIGNoYW5nZXMgbWVtb3J5
IGNvbnRlbnQgdG8gIgotCQkJCSInZCciLCBrKTsKLQkJCWZvciAoaiA9IDA7IGogPCBzaXplOyBq
KyspIHsKLQkJCQlmb3IgKGkgPSAwOyBpIDwgTUI7IGkrKykKLQkJCQkJbWVtb3J5W2tdW2pdW2ld
ID0gJ2QnOwotCQkgICAgICAgIH0KLQkJCS8qIFVubWVyZ2UuICovCi0JCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkICVkIHN0b3BzLiIsIGspOwotCQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQot
CQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQkJCXRzdF9yZXNtKFRJ
TkZPLCAiY2hpbGQgJWQgY29udGludWVzLi4uIiwgayk7Ci0KLQkJCS8qIFN0b3AuICovCi0JCQl0
c3RfcmVzbShUSU5GTywgImNoaWxkICVkIHN0b3BzLiIsIGspOwotCQkJaWYgKHJhaXNlKFNJR1NU
T1ApID09IC0xKQotCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQkJ
CXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgY29udGludWVzLi4uIiwgayk7Ci0JCQlleGl0KDAp
OwotCQl9Ci0JfQotCXRzdF9yZXNtKFRJTkZPLCAiS1NNIG1lcmdpbmcuLi4iKTsKLQlzbnByaW50
ZihidWYsIEJVRlNJWiwgIiVzJXMiLCBfUEFUSF9LU00sICJydW4iKTsKLQlmZCA9IG9wZW4oYnVm
LCBPX1dST05MWSk7Ci0JaWYgKGZkID09IC0xKQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5V
TEwsICJvcGVuIik7Ci0JaWYgKHdyaXRlKGZkLCAiMSIsIDEpICE9IDEpCi0JCXRzdF9icmttKFRC
Uk9LfFRFUlJOTywgTlVMTCwgIndyaXRlIik7Ci0JY2xvc2UoZmQpOwotCXNucHJpbnRmKGJ1Ziwg
QlVGU0laLCAiJXMlcyIsIF9QQVRIX0tTTSwgInBhZ2VzX3RvX3NjYW4iKTsKLQlzbnByaW50Zihi
dWYyLCBCVUZTSVosICIlZCIsIHNpemUgKiAyNTYgKiBudW0pOwotCWZkID0gb3BlbihidWYsIE9f
V1JPTkxZKTsKLQlpZiAoZmQgPT0gLTEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwg
Im9wZW4iKTsKLQlpZiAod3JpdGUoZmQsIGJ1ZjIsIHN0cmxlbihidWYyKSkgIT0gc3RybGVuKGJ1
ZjIpKQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJ3cml0ZSIpOwotCWNsb3NlKGZk
KTsKLQotCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMlcyIsIF9QQVRIX0tTTSwgInNsZWVwX21p
bGxpc2VjcyIpOwotCWZkID0gb3BlbihidWYsIE9fV1JPTkxZKTsKLQlpZiAoZmQgPT0gLTEpCi0J
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIm9wZW4iKTsKLQlpZiAod3JpdGUoZmQsICIw
IiwgMSkgIT0gMSkKLQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAid3JpdGUiKTsKLQlj
bG9zZShmZCk7Ci0KLQl0c3RfcmVzbShUSU5GTywgIndhaXQgZm9yIGFsbCBjaGlsZHJlbiB0byBz
dG9wLiIpOwotCWZvciAoayA9IDA7IGsgPCBudW07IGsrKykgewotCQlpZiAod2FpdHBpZChjaGls
ZFtrXSwgJnN0YXR1cywgV1VOVFJBQ0VEKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgTlVMTCwgIndhaXRwaWQiKTsKLQkJaWYgKCFXSUZTVE9QUEVEKHN0YXR1cykpCi0JCQl0c3Rf
YnJrbShUQlJPSywgTlVMTCwgImNoaWxkICVkIHdhcyBub3Qgc3RvcHBlZC4iLAotCQkJCWspOwot
CX0KLQl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBhbGwgY2hpbGRyZW4uIik7Ci0JZm9yIChrID0g
MDsgayA8IG51bTsgaysrKSB7Ci0JCWlmIChraWxsKGNoaWxkW2tdLCBTSUdDT05UKSA9PSAtMSkK
LQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwgY2hpbGRbJWRdIiwgayk7Ci0J
fQotCWdyb3VwX2NoZWNrKDEsIDIsIHNpemUgKiBudW0gKiAyNTYgLSAyLCAwLCAwLCAwLCBzaXpl
ICogMjU2ICogbnVtKTsKLQotCXRzdF9yZXNtKFRJTkZPLCAid2FpdCBmb3IgY2hpbGQgMSB0byBz
dG9wLiIpOwotCWlmICh3YWl0cGlkKGNoaWxkWzFdLCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0x
KQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJ3YWl0cGlkIik7Ci0JaWYgKCFXSUZT
VE9QUEVEKHN0YXR1cykpCi0JCXRzdF9icmttKFRCUk9LLCBOVUxMLCAiY2hpbGQgMSB3YXMgbm90
IHN0b3BwZWQuIik7Ci0KLQkvKiBDaGlsZCAxIGNoYW5nZXMgYWxsIHBhZ2VzIHRvICdiJy4gKi8K
LQl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBjaGlsZCAxLiIpOwotCWlmIChraWxsKGNoaWxkWzFd
LCBTSUdDT05UKSA9PSAtMSkKLQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAia2lsbCIp
OwotCWdyb3VwX2NoZWNrKDEsIDMsIHNpemUgKiBudW0gKiAyNTYgLSAzLCAwLCAwLCAwLCBzaXpl
ICogMjU2ICogbnVtKTsKLQotCXRzdF9yZXNtKFRJTkZPLCAid2FpdCBmb3IgY2hpbGQgMSB0byBz
dG9wLiIpOwotCWlmICh3YWl0cGlkKGNoaWxkWzFdLCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0x
KQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJ3YWl0cGlkIik7Ci0JaWYgKCFXSUZT
VE9QUEVEKHN0YXR1cykpCi0JCXRzdF9icmttKFRCUk9LLCBOVUxMLCAiY2hpbGQgMSB3YXMgbm90
IHN0b3BwZWQuIik7Ci0KLQkvKiBBbGwgY2hpbGRyZW4gY2hhbmdlIHBhZ2VzIHRvICdkJy4gKi8K
LQl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBhbGwgY2hpbGRyZW4uIik7Ci0JZm9yIChrID0gMDsg
ayA8IG51bTsgaysrKSB7Ci0JCWlmIChraWxsKGNoaWxkW2tdLCBTSUdDT05UKSA9PSAtMSkKLQkJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwgY2hpbGRbJWRdIiwgayk7Ci0JfQot
CWdyb3VwX2NoZWNrKDEsIDEsIHNpemUgKiBudW0gKiAyNTYgLSAxLCAwLCAwLCAwLCBzaXplICog
MjU2ICogbnVtKTsKLQotCXRzdF9yZXNtKFRJTkZPLCAid2FpdCBmb3IgYWxsIGNoaWxkcmVuIHRv
IHN0b3AuIik7Ci0JZm9yIChrID0gMDsgayA8IG51bTsgaysrKSB7Ci0JCWlmICh3YWl0cGlkKGNo
aWxkW2tdLCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0xKQotCQkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBOVUxMLCAid2FpdHBpZCIpOwotCQlpZiAoIVdJRlNUT1BQRUQoc3RhdHVzKSkKLQkJCXRz
dF9icmttKFRCUk9LLCBOVUxMLCAiY2hpbGQgJWQgd2FzIG5vdCBzdG9wcGVkLiIsCi0JCQkJayk7
Ci0JfQotCS8qIENoaWxkIDEgY2hhbmdlcyBwYWdlcyB0byAnZScuICovCi0JdHN0X3Jlc20oVElO
Rk8sICJyZXN1bWUgY2hpbGQgMS4iKTsKLQlpZiAoa2lsbChjaGlsZFsxXSwgU0lHQ09OVCkgPT0g
LTEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQlncm91cF9jaGVj
aygxLCAxLCBzaXplICogbnVtICogMjU2IC0gMiwgMCwgMSwgMCwgc2l6ZSAqIDI1NiAqIG51bSk7
Ci0KLQl0c3RfcmVzbShUSU5GTywgIndhaXQgZm9yIGNoaWxkIDEgdG8gc3RvcC4iKTsKLQlpZiAo
d2FpdHBpZChjaGlsZFsxXSwgJnN0YXR1cywgV1VOVFJBQ0VEKSA9PSAtMSkKLQkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCBOVUxMLCAid2FpdHBpZCIpOwotCWlmICghV0lGU1RPUFBFRChzdGF0dXMp
KQotCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgImNoaWxkIDEgd2FzIG5vdCBzdG9wcGVkLiIpOwot
Ci0JdHN0X3Jlc20oVElORk8sICJyZXN1bWUgYWxsIGNoaWxkcmVuLiIpOwotCWZvciAoayA9IDA7
IGsgPCBudW07IGsrKykgewotCQlpZiAoa2lsbChjaGlsZFtrXSwgU0lHQ09OVCkgPT0gLTEpCi0J
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJraWxsIGNoaWxkWyVkXSIsIGspOwotCX0K
LQl0c3RfcmVzbShUSU5GTywgIktTTSB1bm1lcmdpbmcuLi4iKTsKLQlzbnByaW50ZihidWYsIEJV
RlNJWiwgIiVzJXMiLCBfUEFUSF9LU00sICJydW4iKTsKLQlmZCA9IG9wZW4oYnVmLCBPX1dST05M
WSk7Ci0JaWYgKGZkID09IC0xKQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJvcGVu
Iik7Ci0JaWYgKHdyaXRlKGZkLCAiMiIsIDEpICE9IDEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgTlVMTCwgIndyaXRlIik7Ci0JZ3JvdXBfY2hlY2soMiwgMCwgMCwgMCwgMCwgMCwgc2l6ZSAq
IDI1NiAqIG51bSk7Ci0KLQl0c3RfcmVzbShUSU5GTywgIndhaXQgZm9yIGFsbCBjaGlsZHJlbiB0
byBzdG9wLiIpOwotCWZvciAoayA9IDA7IGsgPCBudW07IGsrKykgewotCQlpZiAod2FpdHBpZChj
aGlsZFtrXSwgJnN0YXR1cywgV1VOVFJBQ0VEKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRF
UlJOTywgTlVMTCwgIndhaXRwaWQiKTsKLQkJaWYgKCFXSUZTVE9QUEVEKHN0YXR1cykpCi0JCQl0
c3RfYnJrbShUQlJPSywgTlVMTCwgImNoaWxkICVkIHdhcyBub3Qgc3RvcHBlZC4iLAotCQkJCWsp
OwotCX0KLQl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBhbGwgY2hpbGRyZW4uIik7Ci0JZm9yIChr
ID0gMDsgayA8IG51bTsgaysrKSB7Ci0JCWlmIChraWxsKGNoaWxkW2tdLCBTSUdDT05UKSA9PSAt
MSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwgY2hpbGRbJWRdIiwgayk7
Ci0JfQotCXRzdF9yZXNtKFRJTkZPLCAic3RvcCBLU00uIik7Ci0JaWYgKGxzZWVrKGZkLCAwLCBT
RUVLX1NFVCkgPT0gLTEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImxzZWVrIik7
Ci0JaWYgKHdyaXRlKGZkLCAiMCIsIDEpICE9IDEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywg
TlVMTCwgIndyaXRlIik7Ci0JY2xvc2UoZmQpOwotCWdyb3VwX2NoZWNrKDAsIDAsIDAsIDAsIDAs
IDAsIHNpemUgKiAyNTYgKiBudW0pOwotCXdoaWxlICh3YWl0cGlkKC0xLCAmc3RhdHVzLCBXVU5U
UkFDRUQgfCBXQ09OVElOVUVEKSA+IDApCi0JCWlmIChXRVhJVFNUQVRVUyhzdGF0dXMpICE9IDAp
Ci0JCQl0c3RfcmVzbShURkFJTCwgImNoaWxkIGV4aXQgc3RhdHVzIGlzICVkIiwKLQkJCQlXRVhJ
VFNUQVRVUyhzdGF0dXMpKTsKKwljbGVhbnVwKCk7CiB9CiAKIHZvaWQgc2V0dXAodm9pZCkKIHsK
LQljaGFyIGJ1ZltCVUZTSVpdOwotCXN0cnVjdCBzdGF0IG5ldzsKKwl0c3RfcmVxdWlyZV9yb290
KHRzdF9leGl0KTsKIAotCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMlcyIsIF9QQVRIX0tTTSwg
InJ1biIpOwotCWlmIChzdGF0KGJ1ZiwgJm5ldykgPT0gLTEpIHsKLQkJaWYgKGVycm5vID09IEVO
T0VOVCkKLQkJCXRzdF9icmttKFRDT05GLCBOVUxMLCAibm8gS1NNLiIpOwotCQllbHNlCi0JCQl0
c3RfYnJrbShUQlJPSywgTlVMTCwgInN0YXQiKTsKLQl9Ci0JLyoKLQkgKiBzZXR1cCBhIGRlZmF1
bHQgc2lnbmFsIGhhbmRlciBhbmQgYQotCSAqIHRlbXBvcmFyeSB3b3JraW5nIGRpcmVjdG9yeS4K
LQkgKi8KIAl0c3Rfc2lnKEZPUkssIERFRl9IQU5ETEVSLCBOVUxMKTsKIAlURVNUX1BBVVNFOwog
fQogCi12b2lkIHVzYWdlKHZvaWQpCit2b2lkIGNsZWFudXAodm9pZCkKIHsKLQlwcmludGYoIiAg
LW4gICAgICBOdW1iZXIgb2YgcHJvY2Vzc2VzXG4iKTsKLQlwcmludGYoIiAgLXMgICAgICBNZW1v
cnkgYWxsb2NhdGlvbiBzaXplIGluIE1CXG4iKTsKLX0KLQotLyogVGhlcmUgaXMgY3VycmVudGx5
IGEgYnVnIHdpbGwgY2F1c2UgdGhlIHRlc3QgZmFpbHVyZSAtICoKLSBodHRwOi8vbWFyYy5pbmZv
Lz9sPWxpbnV4LW1tJm09MTI4OTI4NTMwMzA4NTI2Jnc9MiAuICBTaW5jZSBpdCBoYXMKLSBzdGls
bCBiZWVuIGRpc2N1c3NlZCB1cHN0cmVhbSwgdGhlIGludGVyZmFjZSBoZXJlIHdhcyBhZGRlZCBz
b21lCi0gZmxleGlibGl0eSB3aXRoIHBhdGgyLCBzbyBpdCBpcyBwb3NzaWJsZSB0byBtYWtlIGNo
YW5nZXMgaGVyZSBkZXBlbmRzCi0gb24gdGhlIGZ1dHVyZSBpbXBsZW1lbnRhdGlvbiBpbiBrZXJu
ZWwuIEZvciBleGFtcGxlLCB0byB2ZXJpZnkKLSAocGFnZXNfc2hhcmluZyArIHBhZ2VzX3ZvbGF0
aWxlKSBpbnN0ZWFkIG9mIGEgc2luZ2xlIGl0ZW0uICovCi12b2lkIGNoZWNrKGNoYXIgKnBhdGgs
IGNoYXIgKnBhdGgyLCBsb25nIGludCB2YWx1ZSkKLXsKLQlGSUxFICpmcDsKLQljaGFyIGJ1ZltC
VUZTSVpdLCBidWYyW0JVRlNJWl07Ci0KLQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVzJXMiLCBf
UEFUSF9LU00sIHBhdGgpOwotCWZwID0gZm9wZW4oYnVmLCAiciIpOwotCWlmIChmcCA9PSBOVUxM
KQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJmb3BlbiIpOwotCWlmIChmZ2V0cyhi
dWYsIEJVRlNJWiwgZnApID09IE5VTEwpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwg
ImZnZXRzIik7Ci0JZmNsb3NlKGZwKTsKLQotCXRzdF9yZXNtKFRJTkZPLCAiJXMgaXMgJWxkLiIs
IHBhdGgsIGF0b2woYnVmKSk7Ci0JaWYgKHBhdGgyICE9IE5VTEwpIHsKLQkJc25wcmludGYoYnVm
MiwgQlVGU0laLCAiJXMlcyIsIF9QQVRIX0tTTSwgcGF0aDIpOwotCQlmcCA9IGZvcGVuKGJ1ZjIs
ICJyIik7Ci0JCWlmIChmcCA9PSBOVUxMKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxM
LCAiZm9wZW4iKTsKLQkJaWYgKGZnZXRzKGJ1ZjIsIEJVRlNJWiwgZnApID09IE5VTEwpCi0JCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJmZ2V0cyIpOwotCQlmY2xvc2UoZnApOwotCi0J
CXRzdF9yZXNtKFRJTkZPLCAiJXMgaXMgJWxkLiIsIHBhdGgyLCBhdG9sKGJ1ZjIpKTsKLQkJaWYg
KGF0b2woYnVmKSArIGF0b2woYnVmMikgIT0gdmFsdWUpCi0JCQl0c3RfcmVzbShURkFJTCwgIiVz
ICsgJXMgaXMgbm90ICVsZC4iLCBwYXRoLCBwYXRoMiwKLQkJCQl2YWx1ZSk7Ci0JfSBlbHNlCi0J
CWlmIChhdG9sKGJ1ZikgIT0gdmFsdWUpCi0JCQl0c3RfcmVzbShURkFJTCwgIiVzIGlzIG5vdCAl
bGQuIiwgcGF0aCwgdmFsdWUpOwotfQotCi12b2lkIHZlcmlmeShjaGFyIHZhbHVlLCBpbnQgcHJv
YywgaW50IHN0YXJ0LCBpbnQgZW5kLCBpbnQgc3RhcnQyLCBpbnQgZW5kMikKLXsKLQlpbnQgaSwg
ajsKLQl2b2lkICpzID0gTlVMTDsKLQotCXMgPSBtYWxsb2MoKGVuZCAtIHN0YXJ0KSAqIChlbmQy
IC0gc3RhcnQyKSk7Ci0JaWYgKHMgPT0gTlVMTCkKLQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBO
VUxMLCAibWFsbG9jIik7Ci0KLQl0c3RfcmVzbShUSU5GTywgImNoaWxkICVkIHZlcmlmaWVzIG1l
bW9yeSBjb250ZW50LiIsIHByb2MpOwotCW1lbXNldChzLCB2YWx1ZSwgKGVuZCAtIHN0YXJ0KSAq
IChlbmQyIC0gc3RhcnQyKSk7Ci0JaWYgKG1lbWNtcChtZW1vcnlbcHJvY11bc3RhcnRdLCBzLCAo
ZW5kIC0gc3RhcnQpICogKGVuZDIgLSBzdGFydDIpKSAhPSAwKQotCQlmb3IgKGogPSBzdGFydDsg
aiA8IGVuZDsgaisrKQotCQkJZm9yIChpID0gc3RhcnQyOyBpIDwgZW5kMjsgaSsrKQotCQkJCWlm
IChtZW1vcnlbcHJvY11bal1baV0gIT0gdmFsdWUpCi0JCQkJCXRzdF9yZXNtKFRGQUlMLCAiY2hp
bGQgJWQgaGFzICVjIGF0ICIKLQkJCQkJCSIlZCwlZCwlZC4iLAotCQkJCQkJcHJvYywgbWVtb3J5
W3Byb2NdW2pdW2ldLCBwcm9jLAotCQkJCQkJaiwgaSk7Ci0JZnJlZShzKTsKKwlURVNUX0NMRUFO
VVA7CisJdHN0X2V4aXQoKTsKIH0KLQotdm9pZCBncm91cF9jaGVjayhpbnQgcnVuLCBpbnQgcGFn
ZXNfc2hhcmVkLCBpbnQgcGFnZXNfc2hhcmluZywKLQkJaW50IHBhZ2VzX3ZvbGF0aWxlLCBpbnQg
cGFnZXNfdW5zaGFyZWQsCi0JCWludCBzbGVlcF9taWxsaXNlY3MsIGludCBwYWdlc190b19zY2Fu
KQotewotICAgICAgICAvKiA1IHNlY29uZHMgZm9yIGtzbSB0byBzY2FuIHBhZ2VzLiAqLwotCXNs
ZWVwKDUpOwotCXRzdF9yZXNtKFRJTkZPLCAiY2hlY2shIik7Ci0JY2hlY2soInJ1biIsIE5VTEws
IHJ1bik7Ci0JY2hlY2soInBhZ2VzX3NoYXJlZCIsIE5VTEwsIHBhZ2VzX3NoYXJlZCk7Ci0JY2hl
Y2soInBhZ2VzX3NoYXJpbmciLCBOVUxMLCBwYWdlc19zaGFyaW5nKTsKLQljaGVjaygicGFnZXNf
dm9sYXRpbGUiLCBOVUxMLCBwYWdlc192b2xhdGlsZSk7Ci0JY2hlY2soInBhZ2VzX3Vuc2hhcmVk
IiwgTlVMTCwgcGFnZXNfdW5zaGFyZWQpOwotCWNoZWNrKCJzbGVlcF9taWxsaXNlY3MiLCBOVUxM
LCBzbGVlcF9taWxsaXNlY3MpOwotCWNoZWNrKCJwYWdlc190b19zY2FuIiwgTlVMTCwgcGFnZXNf
dG9fc2Nhbik7Ci19ClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQpkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20v
b29tMDEuYwppbmRleCBjNjcwZDkwLi44YzMxNDU4IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL21lbS9vb20vb29tMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDEu
YwpAQCAtMzgsMTQgKzM4LDEyIEBACiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSAidGVz
dC5oIgogI2luY2x1ZGUgInVzY3Rlc3QuaCIKLSNpbmNsdWRlICJsaWIvb29tLmgiCisjaW5jbHVk
ZSAiLi4vaW5jbHVkZS9tZW0uaCIKIAogY2hhciAqVENJRCA9ICJvb20wMSI7CiBpbnQgVFNUX1RP
VEFMID0gMTsKIGV4dGVybiBpbnQgVHN0X2NvdW50OwogCi1zdGF0aWMgdm9pZCBzZXR1cCh2b2lk
KTsKLQogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIHsKIAljaGFyICptc2c7CmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDIuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvbWVtL29vbS9vb20wMi5jCmluZGV4IDY4ZWQxZWYuLjA0YzY1MDcgMTAwNjQ0Ci0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL29vbS9vb20wMi5jCkBAIC00Miw5ICs0Miw3IEBAIGludCBUU1RfVE9UQUwgPSAxOwogI2lu
Y2x1ZGUgPGZjbnRsLmg+CiAjaW5jbHVkZSA8c3RkaW8uaD4KICNpbmNsdWRlIDxlcnJuby5oPgot
I2luY2x1ZGUgImxpYi9vb20uaCIKLQotc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7CisjaW5jbHVk
ZSAiLi4vaW5jbHVkZS9tZW0uaCIKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkK
IHsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMy5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMKaW5kZXggZGQwOTQ2Ny4uM2MxNjAxOCAxMDA2NDQK
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMKKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9tZW0vb29tL29vbTAzLmMKQEAgLTM1LDE0ICszNSwxMiBAQAogI2luY2x1ZGUgPGVycm5v
Lmg+CiAjaW5jbHVkZSAidGVzdC5oIgogI2luY2x1ZGUgInVzY3Rlc3QuaCIKLSNpbmNsdWRlICJs
aWIvb29tLmgiCisjaW5jbHVkZSAiLi4vaW5jbHVkZS9tZW0uaCIKIAogY2hhciAqVENJRCA9ICJv
b20wMyI7CiBpbnQgVFNUX1RPVEFMID0gMTsKIGV4dGVybiBpbnQgVHN0X2NvdW50OwogCi1zdGF0
aWMgdm9pZCBzZXR1cCh2b2lkKTsKLQogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkK
IHsKIAljaGFyICptc2c7CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29t
MDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wNC5jCmluZGV4IDFkZmY4NWUuLmNl
MzE2MWMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wNC5jCisrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wNC5jCkBAIC00OCw0MSArNDgsNyBAQCBleHRl
cm4gaW50IFRzdF9jb3VudDsKICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPHVuaXN0ZC5o
PgogI2luY2x1ZGUgPGVycm5vLmg+Ci0jaW5jbHVkZSA8c3RkbGliLmg+Ci0jaW5jbHVkZSA8c3Ry
aW5nLmg+Ci0jaW5jbHVkZSA8ZXJybm8uaD4KLSNpbmNsdWRlIDxzaWduYWwuaD4KLSNpbmNsdWRl
IDx1bmlzdGQuaD4KLSNpbmNsdWRlIDxzdGRhcmcuaD4KLQotI2RlZmluZSBNQVhOT0RFUwkJNTEy
Ci0jZGVmaW5lIENQQVRICQkJIi9kZXYvY3B1c2V0IgotI2RlZmluZSBDUEFUSF9ORVcJCUNQQVRI
ICIvMSIKLSNkZWZpbmUgTUVNQ0dfUEFUSAkJIi9kZXYvY2dyb3VwIgotI2RlZmluZSBNRU1DR19Q
QVRIX05FVwkJTUVNQ0dfUEFUSCAiLzEiCi0jZGVmaW5lIF9QQVRIX1NZU19TWVNURU0JIi9zeXMv
ZGV2aWNlcy9zeXN0ZW0iCi0jZGVmaW5lIExFTkdUSAkJCSgzVUw8PDMwKQotI2RlZmluZSBURVNU
TUVNCQkJKDFVTDw8MzApCi0jZGVmaW5lIE1CCQkJKDFVTDw8MjApCi0jZGVmaW5lIE5PUk1BTAkJ
CTEKLSNkZWZpbmUgTUxPQ0sJCQkyCi0jZGVmaW5lIEtTTQkJCTMKLSNkZWZpbmUgU1lTRlNfT1ZF
UgkJIi9wcm9jL3N5cy92bS9vdmVyY29tbWl0X21lbW9yeSIKLQotc3RhdGljIGNoYXIgb3ZlcmNv
bW1pdFtCVUZTSVpdOwotCi1zdGF0aWMgdm9pZCBzZXR1cCh2b2lkKTsKLXN0YXRpYyB2b2lkIGNs
ZWFudXAodm9pZCkgTFRQX0FUVFJJQlVURV9OT1JFVFVSTjsKLXN0YXRpYyB2b2lkIG9vbShpbnQg
dGVzdGNhc2UsIGludCBtZW1wb2xpY3ksIGludCBsaXRlKTsKLXN0YXRpYyBsb25nIGNvdW50X251
bWEodm9pZCk7Ci1zdGF0aWMgaW50IHBhdGhfZXhpc3QoY29uc3QgY2hhciAqcGF0aCwgLi4uKTsK
LXN0YXRpYyB2b2lkIHRlc3Rvb20oaW50IG1lbXBvbGljeSwgaW50IGxpdGUpOwotc3RhdGljIHZv
aWQgYWxsb2NfbWVtKGxvbmcgaW50IGxlbmd0aCwgaW50IHRlc3RjYXNlKTsKLXN0YXRpYyB2b2lk
IHRlc3RfYWxsb2MoaW50IHRlc3RjYXNlLCBpbnQgbGl0ZSk7Ci1zdGF0aWMgdm9pZCBnYXRoZXJf
Y3B1cyhjaGFyICpjcHVzKTsKLXN0YXRpYyB2b2lkIHVtb3VudF9tZW0oY2hhciAqcGF0aCwgY2hh
ciAqcGF0aF9uZXcpOwotc3RhdGljIHZvaWQgbW91bnRfbWVtKGNoYXIgKm5hbWUsIGNoYXIgKmZz
LCBjaGFyICpvcHRpb25zLCBjaGFyICpwYXRoLAotCQljaGFyICpwYXRoX25ldyk7CisjaW5jbHVk
ZSAiLi4vaW5jbHVkZS9tZW0uaCIKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkK
IHsKLS0gCjEuNy4zLjIKCg==
------=_Part_37104_611669014.1295362614542
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_37104_611669014.1295362614542
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_37104_611669014.1295362614542--

