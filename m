From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:53 +0200
Subject: [LTP] [COMMITTED] [PATCH 20/40] Make use of SAFE_WAITPID()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-20-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_res.c                                             |  4 ++--
 testcases/kernel/logging/kmsg/kmsg01.c                    |  3 +--
 testcases/kernel/mem/cpuset/cpuset01.c                    |  3 +--
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c      |  3 +--
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c    |  3 +--
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c    |  3 +--
 testcases/kernel/mem/swapping/swapping01.c                |  6 ++----
 testcases/kernel/mem/vma/vma01.c                          |  3 +--
 testcases/kernel/syscalls/cma/process_vm01.c              |  3 +--
 testcases/kernel/syscalls/cma/process_vm_readv02.c        |  6 ++----
 testcases/kernel/syscalls/cma/process_vm_readv03.c        |  6 ++----
 testcases/kernel/syscalls/cma/process_vm_writev02.c       |  6 ++----
 testcases/kernel/syscalls/fanotify/fanotify03.c           |  5 +----
 testcases/kernel/syscalls/fork/fork14.c                   |  3 +--
 testcases/kernel/syscalls/getrusage/getrusage03.c         | 15 +++++----------
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c           |  4 ++--
 testcases/kernel/syscalls/ipc/shmctl/shmctl03.c           |  5 ++---
 testcases/kernel/syscalls/ipc/shmget/shmget05.c           |  5 ++---
 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c |  3 +--
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c |  6 ++----
 testcases/kernel/syscalls/mprotect/mprotect02.c           |  7 ++-----
 testcases/kernel/syscalls/pipe/pipe09.c                   |  7 +++----
 testcases/kernel/syscalls/setns/setns02.c                 |  3 +--
 testcases/kernel/syscalls/setrlimit/setrlimit01.c         |  3 +--
 testcases/kernel/syscalls/waitid/waitid02.c               |  4 ++--
 25 files changed, 42 insertions(+), 77 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index 8cf5f0d4a..9e9aa2109 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -48,6 +48,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "usctest.h"
 #include "ltp_priv.h"
 #include "tst_ansi_color.h"
@@ -423,8 +424,7 @@ void tst_record_childstatus(void (*cleanup)(void), pid_t child)
 
 	NO_NEWLIB_ASSERT("Unknown", 0);
 
-	if (waitpid(child, &status, 0) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid(%d) failed", child);
+	SAFE_WAITPID(cleanup, child, &status, 0);
 
 	if (WIFEXITED(status)) {
 		ttype_result = WEXITSTATUS(status);
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index b20704551..58b62d517 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -234,8 +234,7 @@ static int timed_read_kmsg(int fd, int timeout_sec)
 	/* child is blocked, kill it */
 	if (TEST_RETURN == -2)
 		kill(child, SIGTERM);
-	if (waitpid(child, &status, 0) == -1)
-		tst_brk(TBROK | TERRNO, "waitpid");
+	SAFE_WAITPID(child, &status, 0);
 	if (WIFEXITED(status)) {
 		if (WEXITSTATUS(status) == 0) {
 			return 0;
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index e10124c17..3d68cc07a 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -71,8 +71,7 @@ static void test_cpuset(void)
 	snprintf(buf, BUFSIZ, "%d", nodes[1]);
 	write_cpuset_files(CPATH_NEW, "mems", buf);
 
-	if (waitpid(child, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brk(TBROK | TERRNO, "waitpid");
+	SAFE_WAITPID(child, &status, WUNTRACED | WCONTINUED);
 	if (WEXITSTATUS(status) != 0) {
 		tst_res(TFAIL, "child exit status is %d", WEXITSTATUS(status));
 		return;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 960bec184..83534e585 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -81,8 +81,7 @@ static void verify_hugeshmat(void)
 		}
 		break;
 	default:
-		if (waitpid(pid, &status, 0) == -1)
-			tst_brk(TBROK | TERRNO, "waitpid");
+		SAFE_WAITPID(pid, &status, 0);
 	}
 }
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index f58946fa0..0474b31e0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -89,8 +89,7 @@ static void test_hugeshmctl(void)
 		do_child();
 		exit(0);
 	default:
-		if (waitpid(pid, &status, 0) == -1)
-			tst_brk(TBROK | TERRNO, "waitpid");
+		SAFE_WAITPID(pid, &status, 0);
 	}
 }
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 22138e354..790d73603 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -57,8 +57,7 @@ static void test_hugeshmget(void)
 		exit(0);
 	default:
 		/* wait for the child to return */
-		if (waitpid(pid, &status, 0) == -1)
-			tst_brk(TBROK | TERRNO, "waitpid");
+		SAFE_WAITPID(pid, &status, 0);
 	}
 }
 
diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 561080691..6ac802b25 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -120,8 +120,7 @@ static void check_swapping(void)
 	long swap_free_now, swapped;
 
 	/* wait child stop */
-	if (waitpid(pid, &status, WUNTRACED) == -1)
-		tst_brk(TBROK | TERRNO, "waitpid");
+	SAFE_WAITPID(pid, &status, WUNTRACED);
 	if (!WIFSTOPPED(status))
 		tst_brk(TBROK, "child was not stopped.");
 
@@ -148,8 +147,7 @@ static void check_swapping(void)
 		 swapped / 1024);
 	kill(pid, SIGCONT);
 	/* wait child exit */
-	if (waitpid(pid, &status, 0) == -1)
-		tst_brk(TBROK | TERRNO, "waitpid");
+	SAFE_WAITPID(pid, &status, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index bafbfff46..31322918c 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -131,8 +131,7 @@ static void check_vma(void)
 		}
 		exit(255);
 	default:
-		if (waitpid(-1, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, -1, &status, 0);
 		if (!WIFEXITED(status))
 			tst_brkm(TBROK, cleanup, "child exited abnormally.");
 		check_status(WEXITSTATUS(status));
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 16a27e5b0..bc6b04f24 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -359,8 +359,7 @@ static void cma_test_invalid_perm(void)
 		cma_free_params(params);
 		exit(ret);
 	default:
-		if (waitpid(child_pid, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, child_pid, &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child returns %d", status);
 	}
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index 6bbfb62b0..f84f79ef7 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -79,16 +79,14 @@ int main(int argc, char **argv)
 		}
 
 		/* wait until child_invoke reads from child_alloc's VM */
-		if (waitpid(pids[1], &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, pids[1], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* child_alloc is free to exit now */
 		safe_semop(semid, 0, 1);
 
-		if (waitpid(pids[0], &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, pids[0], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child 0 returns %d", status);
 	}
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 07a72d97d..2e69f855f 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -98,16 +98,14 @@ int main(int argc, char **argv)
 		}
 
 		/* wait until child_invoke reads from child_alloc's VM */
-		if (waitpid(pids[1], &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, pids[1], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* child_alloc is free to exit now */
 		safe_semop(semid, 0, 1);
 
-		if (waitpid(pids[0], &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, pids[0], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child 0 returns %d", status);
 
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index c681f9f8b..952081811 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -92,16 +92,14 @@ int main(int argc, char **argv)
 
 		/* wait until child_write writes into
 		 * child_init_and_verify's VM */
-		if (waitpid(pids[1], &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, pids[1], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* signal child_init_and_verify to verify its VM now */
 		safe_semop(semid, 0, 1);
 
-		if (waitpid(pids[0], &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, pids[0], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child 0 returns %d", status);
 	}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 3a75ac252..1ab879843 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -130,10 +130,7 @@ static void check_child(void)
 		tst_brk(TBROK | TERRNO,
 			 "sigaction(SIGCHLD, &child_action, NULL) failed");
 	}
-	if (waitpid(-1, &child_ret, 0) < 0) {
-		tst_brk(TBROK | TERRNO,
-				 "waitpid(-1, &child_ret, 0) failed");
-	}
+	SAFE_WAITPID(-1, &child_ret, 0);
 
 	if (WIFSIGNALED(child_ret)) {
 		tst_res(TFAIL, "child exited due to signal %d",
diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
index bbc1d3d74..6ea92e0c2 100644
--- a/testcases/kernel/syscalls/fork/fork14.c
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -121,8 +121,7 @@ static int fork_test(void)
 		case 0:
 			exit(0);
 		default:
-			if (waitpid(-1, NULL, 0) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+			SAFE_WAITPID(cleanup, -1, NULL, 0);
 
 			if (prev_failed > 0 && i >= LARGE) {
 				tst_resm(TFAIL, "Fork succeeds incorrectly");
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 54cdc8322..125acfc64 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -112,8 +112,7 @@ static void inherit_fork(void)
 		break;
 	}
 
-	if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
 	check_return(WEXITSTATUS(status), "initial.self ~= child.self",
 		     "initial.self !~= child.self");
 }
@@ -142,8 +141,7 @@ static void inherit_fork2(void)
 		break;
 	}
 
-	if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
 	check_return(WEXITSTATUS(status), "child.children == 0",
 		     "child.children != 0");
 }
@@ -171,8 +169,7 @@ static void fork_malloc(void)
 		break;
 	}
 
-	if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
 	check_return(WEXITSTATUS(status), "initial.self + 50MB ~= child.self",
 		     "initial.self + 50MB !~= child.self");
 }
@@ -198,8 +195,7 @@ static void grandchild_maxrss(void)
 		break;
 	}
 
-	if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
 	if (WEXITSTATUS(status) != 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "child exit status is not 0");
 
@@ -241,8 +237,7 @@ static void zombie(void)
 	else
 		tst_resm(TFAIL, "initial.children !~= pre_wait.children");
 
-	if (waitpid(pid, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
 	if (WEXITSTATUS(status) != 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "child exit status is not 0");
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index ac66ceb83..ac3660f4a 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -47,6 +47,7 @@
 #define _GNU_SOURCE
 #endif
 #include "ipcshm.h"
+#include "safe_macros.h"
 
 char *TCID = "shmctl01";
 
@@ -348,8 +349,7 @@ void stat_cleanup(void)
 	}
 
 	for (i = 0; i < N_ATTACH; i++) {
-		if (waitpid(pid_arr[i], NULL, 0) == -1)
-			tst_brkm(TBROK, cleanup, "waitpid failed");
+		SAFE_WAITPID(cleanup, pid_arr[i], NULL, 0);
 	}
 
 	stat_time++;
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index a66db3baf..97cf27baf 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -60,6 +60,7 @@
 #include "ipcshm.h"
 #include <sys/types.h>
 #include <sys/wait.h>
+#include "safe_macros.h"
 
 char *TCID = "shmctl03";
 int shm_id_1 = -1;
@@ -110,9 +111,7 @@ int main(int ac, char **av)
 		do_child();
 	} else {
 		/* wait for the child to return */
-		if (waitpid(pid, NULL, 0) == -1) {
-			tst_brkm(TBROK, cleanup, "waitpid failed");
-		}
+		SAFE_WAITPID(cleanup, pid, NULL, 0);
 
 		/* if it exists, remove the shared memory resource */
 		rm_shm(shm_id_1);
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
index 09ec5b190..01770ba7d 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
@@ -59,6 +59,7 @@
 #include "ipcshm.h"
 #include <sys/types.h>
 #include <sys/wait.h>
+#include "safe_macros.h"
 
 char *TCID = "shmget05";
 int TST_TOTAL = 1;
@@ -94,9 +95,7 @@ int main(int ac, char **av)
 
 	} else {		/* parent */
 		/* wait for the child to return */
-		if (waitpid(pid, NULL, 0) == -1) {
-			tst_brkm(TBROK, cleanup, "waitpid failed");
-		}
+		SAFE_WAITPID(cleanup, pid, NULL, 0);
 
 		/* if it exists, remove the shared memory resource */
 		rm_shm(shm_id_1);
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index c68f95d83..32c78b29a 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -189,8 +189,7 @@ static void test_invalid_perm(void)
 		ret |= check_errno(EPERM);
 		exit(ret);
 	default:
-		if (waitpid(child_pid, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, child_pid, &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child returns %d", status);
 	}
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index d18458972..6755a384d 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -217,8 +217,7 @@ static void test_migrate_current_process(int node1, int node2, int cap_sys_nice)
 		munmap(testp2, getpagesize());
 		exit(ret);
 	default:
-		if (waitpid(child, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, child, &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child returns %d", status);
 		if (cap_sys_nice)
@@ -295,8 +294,7 @@ static void test_migrate_other_process(int node1, int node2, int cap_sys_nice)
 		if (write(pages_migrated[1], &tmp, 1) != 1)
 			tst_brkm(TBROK | TERRNO, NULL, "write #2 failed");
 
-		if (waitpid(child, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		SAFE_WAITPID(cleanup, child, &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child returns %d", status);
 		close(child_ready[0]);
diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index 31455c7b9..de9b4ea00 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -96,8 +96,7 @@ int main(int ac, char **av)
 			exit(255);
 		}
 
-		if (waitpid(pid, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid failed");
+		SAFE_WAITPID(cleanup, pid, &status, 0);
 		if (!WIFEXITED(status))
 			tst_brkm(TBROK, cleanup, "child exited abnormally "
 				 "with status: %d", status);
@@ -127,9 +126,7 @@ int main(int ac, char **av)
 				exit(0);
 			}
 
-			if (waitpid(pid, &status, 0) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "waitpid failed");
+			SAFE_WAITPID(cleanup, pid, &status, 0);
 
 			if (WIFEXITED(status) &&
 			    WEXITSTATUS(status) == 0)
diff --git a/testcases/kernel/syscalls/pipe/pipe09.c b/testcases/kernel/syscalls/pipe/pipe09.c
index 226083b31..a4b2f8231 100644
--- a/testcases/kernel/syscalls/pipe/pipe09.c
+++ b/testcases/kernel/syscalls/pipe/pipe09.c
@@ -51,6 +51,7 @@
 #include <sys/wait.h>
 #include <errno.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define	PIPEWRTCNT	100	/* must be an even number */
 
@@ -119,8 +120,7 @@ int main(int ac, char **av)
 
 		/* parent */
 
-		if (waitpid(fork_1, &wtstatus, 0) == -1)
-			tst_brkm(TBROK, cleanup, "waitpid failed");
+		SAFE_WAITPID(cleanup, fork_1, &wtstatus, 0);
 		if (WIFEXITED(wtstatus) && WEXITSTATUS(wtstatus) != 0) {
 			tst_brkm(TBROK, cleanup, "child exited abnormally");
 		}
@@ -146,8 +146,7 @@ int main(int ac, char **av)
 
 		/* parent */
 
-		if (waitpid(fork_2, &wtstatus, 0) == -1)
-			tst_brkm(TBROK, cleanup, "waitpid failed");
+		SAFE_WAITPID(cleanup, fork_2, &wtstatus, 0);
 		if (WEXITSTATUS(wtstatus) != 0) {
 			tst_brkm(TBROK, cleanup, "problem detected in child, "
 				 "wait status %d, errno = %d", wtstatus, errno);
diff --git a/testcases/kernel/syscalls/setns/setns02.c b/testcases/kernel/syscalls/setns/setns02.c
index 58a02a65b..0f4902845 100644
--- a/testcases/kernel/syscalls/setns/setns02.c
+++ b/testcases/kernel/syscalls/setns/setns02.c
@@ -150,8 +150,7 @@ static void test_flag(int clone_flag, int ns_flag, int (*fn) (void *arg))
 	if (ret == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "ltp_clone");
 
-	if (waitpid(ret, &status, 0) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	SAFE_WAITPID(cleanup, ret, &status, 0);
 	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 		tst_resm(TFAIL, "child returns %d", status);
 	else
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index 3118782f3..05b4cf948 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -162,8 +162,7 @@ static void test2(void)
 	}
 
 	/* parent */
-	if (waitpid(pid, &status, 0) == -1)
-		tst_brkm(TBROK, cleanup, "waitpid() failed");
+	SAFE_WAITPID(cleanup, pid, &status, 0);
 
 	switch (WEXITSTATUS(status)) {
 	case 0:
diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index 431e91060..dced6fadc 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -48,6 +48,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/syscalls.h"
 
 struct testcase_t {
@@ -162,8 +163,7 @@ static void makechild(struct testcase_t *t, void (*childfn)(void))
 static void wait4child(pid_t pid)
 {
 	int status;
-	if (waitpid(pid, &status, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	SAFE_WAITPID(cleanup, pid, &status, 0);
 	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 		tst_resm(TFAIL, "child returns %d", status);
 }
-- 
2.13.5

