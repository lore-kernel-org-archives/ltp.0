From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Fri,  3 Nov 2017 19:59:41 +0100
Subject: [LTP]  [PATCH 2/2] [mtest06] Rewrite mmap1 to use new library
In-Reply-To: <20171103185941.17651-1-vkabatov@redhat.com>
References: <20171103185941.17651-1-vkabatov@redhat.com>
Message-ID: <20171103185941.17651-2-vkabatov@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Veronika Kabatova <vkabatov@redhat.com>

* Use new tst_test framework
* Use safe macros
* Simplify signal handler && don't exit from it
* Wait for threads to finish before exiting the test function

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 381 +++++++++++++----------------------
 1 file changed, 144 insertions(+), 237 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 38f9ad793..cf01a3487 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -20,8 +20,7 @@
 /* the GNU General Public License for more details.			      */
 /*									      */
 /* You should have received a copy of the GNU General Public License	      */
-/* along with this program;  if not, write to the Free Software		      */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
+/* along with this program;  if not, see <http://www.gnu.org/licenses/>.      */
 /*									      */
 /******************************************************************************/
 /******************************************************************************/
@@ -36,82 +35,116 @@
 /*	        read must be a success between map and unmap of the region.   */
 /*									      */
 /******************************************************************************/
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sched.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/mman.h>
+#include <pthread.h>
 #include <sched.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <sys/time.h>
-#include <sys/wait.h>
 #include <setjmp.h>
-#include <pthread.h>
-#include <signal.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
-
-#define DISTANT_MMAP_SIZE (64*1024*1024)
-#define OPT_MISSING(prog, opt) do { \
-	fprintf(stderr, "%s: option -%c ", prog, opt); \
-        fprintf(stderr, "requires an argument\n"); \
-	usage(prog); \
-} while (0)
-
-static int verbose_print = 0;
+#include <stdlib.h>
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+
+#define DISTANT_MMAP_SIZE (64 * 1024 * 1024)
+
+static long file_size = 1024;
+static long num_iter = 1000;
+static float exec_time = 24;
+
+static char *opt_verbose_print;
+static char *opt_file_size;
+static char *opt_num_iter;
+static char *opt_exec_time;
+
 static char *volatile map_address;
 static jmp_buf jmpbuf;
 static sig_atomic_t volatile active_map;
+static sig_atomic_t volatile test_end;
 static void *distant_area;
 static pthread_mutex_t thread_lock = PTHREAD_MUTEX_INITIALIZER;
 
-char *TCID = "mmap1";
-int TST_TOTAL = 1;
-
 static void sig_handler(int signal, siginfo_t * info, void *ut)
 {
 	switch (signal) {
-	case SIGALRM:
-		tst_resm(TPASS, "Test ended, success");
-		_exit(TPASS);
 	case SIGSEGV:
 		if (active_map) {
-			tst_resm(TINFO, "[%lu] Unexpected page fault at %p",
+			tst_res(TINFO, "[%lu] Unexpected page fault at %p",
 				 pthread_self(), info->si_addr);
-			_exit(TFAIL);
+			test_end = signal;
+			break;
 		}
 		longjmp(jmpbuf, 1);
 		break;
 	default:
-		fprintf(stderr, "Unexpected signal - %d --- exiting\n", signal);
-		_exit(TBROK);
+		test_end = signal;
+		break;
 	}
 }
 
-int mkfile(int size)
+static struct tst_option mmap1_options[] = {
+	{"l:", &opt_num_iter, "Number of mmap/write/unmap loops, default: 1000"},
+	{"s:", &opt_file_size, "Size of the file to be mapped, default: 1024 bytes"},
+	{"x:", &opt_exec_time, "Test execution time, default: 24 hours"},
+	{"v", &opt_verbose_print, "Verbose output, default: quiet"},
+	{NULL, NULL, NULL}
+};
+
+static void mmap1_setup(void)
 {
-	char template[] = "/tmp/ashfileXXXXXX";
-	int fd, i;
+	int i;
+	int siglist[] = {SIGSEGV, SIGALRM, -1};
+	struct sigaction sigptr;
 
-	if ((fd = mkstemp(template)) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "mkstemp() failed");
+	if (tst_parse_long(opt_file_size, &file_size, 1, LONG_MAX))
+		tst_brk(TBROK, "Invalid file size: %s", opt_file_size);
+	if (tst_parse_long(opt_num_iter, &num_iter, 1, LONG_MAX))
+		tst_brk(TBROK, "Invalid number of interations: %s",
+				opt_num_iter);
+	if (tst_parse_float(opt_exec_time, &exec_time, 0.0005, INT_MAX))
+		tst_brk(TBROK, "Invalid execution time: %s", opt_exec_time);
+
+	if (opt_verbose_print)
+		tst_res(TINFO, "Input parameters are: File size: %ld; "
+			 "Scheduled to run: %lf hours; "
+			 "Number of mmap/write/read: %ld",
+			 file_size, exec_time, num_iter);
+
+	tst_set_timeout(exec_time * 3600 + 300);
+
+	sigptr.sa_sigaction = sig_handler;
+	sigptr.sa_flags = SA_SIGINFO | SA_NODEFER;
+	sigemptyset(&sigptr.sa_mask);
 
-	unlink(template);
+	for (i = 0; siglist[i] != -1; i++) {
+		if (sigaction(siglist[i], &sigptr, NULL) == -1) {
+			tst_brk(TBROK | TERRNO, "could not set handler for %s",
+					tst_strsig(siglist[i]));
+		}
+	}
 
-	for (i = 0; i < size; i++)
-		if (write(fd, "a", 1) == -1)
-			tst_brkm(TBROK | TERRNO, NULL, "write() failed");
+	/* We don't want other mmap calls to map into same area as is
+	 * used for test (mmap_address). The test expects read to return
+	 * test pattern or read must fail with SIGSEGV. Find an area
+	 * that we can use, which is unlikely to be chosen for other
+	 * mmap calls. */
+	distant_area = SAFE_MMAP(NULL, DISTANT_MMAP_SIZE,
+			PROT_WRITE | PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE,
+			-1, 0);
+	SAFE_MUNMAP(distant_area, (size_t)DISTANT_MMAP_SIZE);
+	distant_area += DISTANT_MMAP_SIZE / 2;
+}
+
+static int mkfile(int size)
+{
+	char template[] = "ashfileXXXXXX";
+	int fd, i;
 
-	if (write(fd, "\0", 1) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "write() failed");
+	if ((fd = mkstemp(template)) == -1)
+		tst_brk(TBROK | TERRNO, "mkstemp() failed");
+	SAFE_UNLINK(template);
 
-	if (fsync(fd) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "fsync() failed");
+	for (i = 0; i < size; i++) {
+		SAFE_WRITE(1, fd, "a", 1);
+	}
+	SAFE_WRITE(1, fd, "\0", 1);
+	SAFE_FSYNC(fd);
 
 	return fd;
 }
@@ -119,14 +152,13 @@ int mkfile(int size)
 void *map_write_unmap(void *ptr)
 {
 	long *args = ptr;
-	long i;
-	int j;
+	long i, j;
 
-	tst_resm(TINFO, "[%lu] - map, change contents, unmap files %ld times",
+	tst_res(TINFO, "[%lu] - map, change contents, unmap files %ld times",
 		 pthread_self(), args[2]);
 
-	if (verbose_print)
-		tst_resm(TINFO, "map_write_unmap() arguments are: "
+	if (opt_verbose_print)
+		tst_res(TINFO, "map_write_unmap() arguments are: "
 			 "fd - arg[0]: %ld; "
 			 "size of file - arg[1]: %ld; "
 			 "num of map/write/unmap - arg[2]: %ld",
@@ -134,19 +166,14 @@ void *map_write_unmap(void *ptr)
 
 	for (i = 0; i < args[2]; i++) {
 		pthread_mutex_lock(&thread_lock);
-		map_address = mmap(distant_area, (size_t) args[1],
-			PROT_WRITE | PROT_READ, MAP_SHARED, (int)args[0], 0);
-
-		if (map_address == (void *)-1) {
-			perror("map_write_unmap(): mmap()");
-			pthread_mutex_unlock(&thread_lock);
-			pthread_exit((void *)1);
-		}
+		map_address = SAFE_MMAP(distant_area, (size_t)args[1],
+				PROT_WRITE | PROT_READ, MAP_SHARED,
+				(int)args[0], 0);
 		active_map = 1;
 		pthread_mutex_unlock(&thread_lock);
 
-		if (verbose_print)
-			tst_resm(TINFO, "map address = %p", map_address);
+		if (opt_verbose_print)
+			tst_res(TINFO, "map address = %p", map_address);
 
 		j = 0;
 		while (j < args[1]) {
@@ -159,19 +186,15 @@ void *map_write_unmap(void *ptr)
 				sched_yield();
 		}
 
-		if (verbose_print)
-			tst_resm(TINFO,
-				 "[%ld] times done: of total [%ld] iterations, "
-				 "map_write_unmap():memset() content of memory = %s",
-				 i, args[2], (char *)map_address);
+		if (opt_verbose_print)
+			tst_res(TINFO, "[%ld] times done: of total [%ld] "
+					"iterations, map_write_unmap(), "
+					"contents of memory: %s",
+					i, args[2], map_address);
 
 		pthread_mutex_lock(&thread_lock);
 		active_map = 0;
-		if (munmap(map_address, (size_t) args[1]) == -1) {
-			perror("map_write_unmap(): mmap()");
-			pthread_mutex_unlock(&thread_lock);
-			pthread_exit((void *)1);
-		}
+		SAFE_MUNMAP(map_address, (size_t) args[1]);
 		pthread_mutex_unlock(&thread_lock);
 	}
 
@@ -180,36 +203,35 @@ void *map_write_unmap(void *ptr)
 
 void *read_mem(void *ptr)
 {
-	long i;
 	long *args = ptr;
-	int j;
+	long i, j;
 
-	tst_resm(TINFO, "[%lu] - read contents of memory %p %ld times",
+	tst_res(TINFO, "[%lu] - read contents of memory %p %ld times",
 		 pthread_self(), map_address, args[2]);
 
-	if (verbose_print)
-		tst_resm(TINFO, "read_mem() arguments are: "
+	if (opt_verbose_print)
+		tst_res(TINFO, "read_mem() arguments are: "
 			 "number of reads to be performed - arg[2]: %ld; "
 			 "read from address %p", args[2], map_address);
 
 	for (i = 0; i < args[2]; i++) {
-		if (verbose_print)
-			tst_resm(TINFO, "read_mem() in while loop %ld times "
+		if (opt_verbose_print)
+			tst_res(TINFO, "read_mem() in while loop %ld times "
 				 "to go %ld times", i, args[2]);
 
 		if (setjmp(jmpbuf) == 1) {
 			pthread_mutex_unlock(&thread_lock);
-			if (verbose_print)
-				tst_resm(TINFO, "page fault occurred due to "
+			if (opt_verbose_print)
+				tst_res(TINFO, "page fault occurred due to "
 					 "a read after an unmap");
 		} else {
-			if (verbose_print) {
+			if (opt_verbose_print) {
 				pthread_mutex_lock(&thread_lock);
-				tst_resm(TINFO,
-					 "read_mem(): content of memory: %s",
-					 (char *)map_address);
+				tst_res(TINFO, "read_mem(): contents of "
+						"memory: %s", map_address);
 				pthread_mutex_unlock(&thread_lock);
 			}
+
 			for (j = 0; j < args[1]; j++) {
 				pthread_mutex_lock(&thread_lock);
 				if (map_address[j] != 'a') {
@@ -222,175 +244,60 @@ void *read_mem(void *ptr)
 			}
 		}
 	}
-
 	pthread_exit(NULL);
 }
 
-static void usage(char *progname)
-{
-	fprintf(stderr, "Usage: %s -d -l -s -v -x\n"
-		"\t -h help, usage message.\n"
-		"\t -l number of mmap/write/unmap     default: 1000\n"
-		"\t -s size of the file to be mmapped default: 1024 bytes\n"
-		"\t -v print more info.               default: quiet\n"
-		"\t -x test execution time            default: 24 Hrs\n",
-		progname);
-
-	exit(-1);
-}
-
-struct signal_info {
-	int signum;
-	char *signame;
-};
-
-static struct signal_info sig_info[] = {
-	{SIGHUP, "SIGHUP"},
-	{SIGINT, "SIGINT"},
-	{SIGQUIT, "SIGQUIT"},
-	{SIGABRT, "SIGABRT"},
-	{SIGBUS, "SIGBUS"},
-	{SIGSEGV, "SIGSEGV"},
-	{SIGALRM, "SIGALRM"},
-	{SIGUSR1, "SIGUSR1"},
-	{SIGUSR2, "SIGUSR2"},
-	{-1, "ENDSIG"}
-};
-
-int main(int argc, char **argv)
+static void test_mmap1(void)
 {
-	int c, i;
-	int file_size;
-	int num_iter;
-	double exec_time;
-	int fd;
+	int i, fd;
 	void *status;
 	pthread_t thid[2];
 	long chld_args[3];
-	extern char *optarg;
-	struct sigaction sigptr;
-	int ret;
-
-	/* set up the default values */
-	file_size = 1024;
-	num_iter = 1000;
-	exec_time = 24;
-
-	while ((c = getopt(argc, argv, "hvl:s:x:")) != -1) {
-		switch (c) {
-		case 'h':
-			usage(argv[0]);
-			break;
-		case 'l':
-			if ((num_iter = atoi(optarg)) == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (num_iter < 0)
-				printf
-				    ("WARNING: bad argument. Using default %d\n",
-				     (num_iter = 1000));
-			break;
-		case 's':
-			if ((file_size = atoi(optarg)) == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (file_size < 0)
-				printf
-				    ("WARNING: bad argument. Using default %d\n",
-				     (file_size = 1024));
-			break;
-		case 'v':
-			verbose_print = 1;
-			break;
-		case 'x':
-			exec_time = atof(optarg);
-			if (exec_time == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (exec_time < 0)
-				printf
-				    ("WARNING: bad argument. Using default %.0f\n",
-				     (exec_time = 24));
-			break;
-		default:
-			usage(argv[0]);
-			break;
-		}
-	}
-
-	/* We don't want other mmap calls to map into same area as is
-	 * used for test (mmap_address). The test expects read to return
-	 * test pattern or read must fail with SIGSEGV. Find an area
-	 * that we can use, which is unlikely to be chosen for other
-	 * mmap calls. */
-	distant_area = mmap(0, DISTANT_MMAP_SIZE, PROT_WRITE | PROT_READ,
-		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (distant_area == (void *)-1)
-		tst_brkm(TBROK | TERRNO, NULL, "distant_area: mmap()");
-	SAFE_MUNMAP(NULL, distant_area, (size_t)DISTANT_MMAP_SIZE);
-	distant_area += DISTANT_MMAP_SIZE / 2;
-
-	if (verbose_print)
-		tst_resm(TINFO, "Input parameters are: File size:  %d; "
-			 "Scheduled to run:  %lf hours; "
-			 "Number of mmap/write/read:  %d",
-			 file_size, exec_time, num_iter);
 
+	test_end = 0;
 	alarm(exec_time * 3600);
 
-	/* Do not mask SIGSEGV, as we are interested in handling it. */
-	sigptr.sa_sigaction = sig_handler;
-	sigfillset(&sigptr.sa_mask);
-	sigdelset(&sigptr.sa_mask, SIGSEGV);
-	sigptr.sa_flags = SA_SIGINFO | SA_NODEFER;
-
-	for (i = 0; sig_info[i].signum != -1; i++) {
-		if (sigaction(sig_info[i].signum, &sigptr, NULL) == -1) {
-			perror("man(): sigaction()");
-			fprintf(stderr,
-				"could not set handler for %s, errno = %d\n",
-				sig_info[i].signame, errno);
-			exit(-1);
-		}
-	}
-
 	for (;;) {
 		if ((fd = mkfile(file_size)) == -1)
-			tst_brkm(TBROK, NULL,
-				 "main(): mkfile(): Failed to create temp file");
-
-		if (verbose_print)
-			tst_resm(TINFO, "Tmp file created");
+			tst_brk(TBROK, "main(): mkfile(): "
+					"Failed to create temp file");
+		if (opt_verbose_print)
+			tst_res(TINFO, "Tmp file created");
 
 		chld_args[0] = fd;
 		chld_args[1] = file_size;
 		chld_args[2] = num_iter;
 
-		if ((ret =
-		     pthread_create(&thid[0], NULL, map_write_unmap,
-				    chld_args)))
-			tst_brkm(TBROK, NULL, "main(): pthread_create(): %s",
-				 strerror(ret));
-
-		tst_resm(TINFO, "created writing thread[%lu]", thid[0]);
-
-		if ((ret = pthread_create(&thid[1], NULL, read_mem, chld_args)))
-			tst_brkm(TBROK, NULL, "main(): pthread_create(): %s",
-				 strerror(ret));
-
-		tst_resm(TINFO, "created reading thread[%lu]", thid[1]);
+		SAFE_PTHREAD_CREATE(&thid[0], NULL, map_write_unmap, chld_args);
+		tst_res(TINFO, "created writing thread[%lu]", thid[0]);
+		SAFE_PTHREAD_CREATE(&thid[1], NULL, read_mem, chld_args);
+		tst_res(TINFO, "created reading thread[%lu]", thid[1]);
 
 		for (i = 0; i < 2; i++) {
-			if ((ret = pthread_join(thid[i], &status)))
-				tst_brkm(TBROK, NULL,
-					 "main(): pthread_join(): %s",
-					 strerror(ret));
-
+			SAFE_PTHREAD_JOIN(thid[i], &status);
 			if (status)
-				tst_brkm(TFAIL, NULL,
-					 "thread [%lu] - process exited "
+				tst_res(TFAIL, "thread [%lu] - process exited "
 					 "with %ld", thid[i], (long)status);
 		}
-
-		close(fd);
+		SAFE_CLOSE(fd);
+
+		switch (test_end) {
+		case 0:
+			continue;
+		case SIGALRM:
+			tst_res(TPASS, "Test ended, success");
+			return;
+		default:
+			tst_res(TFAIL, "Test failed with unexpected signal %s",
+					tst_strsig(test_end));
+			return;
+		}
 	}
-
-	exit(0);
 }
+
+static struct tst_test test = {
+	.test_all = test_mmap1,
+	.setup = mmap1_setup,
+	.options = mmap1_options,
+	.needs_tmpdir = 1,
+};
-- 
2.13.6

