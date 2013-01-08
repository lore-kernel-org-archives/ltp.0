Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1TsPz2-0005yB-S9
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 03:36:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TsPz0-0003ej-IL
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 03:36:12 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r083a4S5027210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jan 2013 22:36:04 -0500
From: Monson Shao <jshao@redhat.com>
Date: Tue,  8 Jan 2013 11:34:44 +0800
Message-Id: <1357616084-1705-1-git-send-email-jshao@redhat.com>
Subject: [LTP] [PATCH] containers: delete redundant newline in tst_resm()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Some output strings in tst_resm() have ending newline but some have not,
and it causes disordered blank line in logfile.
Deleting all ending newline makes it uniform and good to read.

Signed-off-by: Monson Shao <jshao@redhat.com>
---
 testcases/kernel/containers/mqns/mqns_01.c         | 16 +++++-----
 testcases/kernel/containers/mqns/mqns_02.c         | 18 ++++++------
 testcases/kernel/containers/mqns/mqns_04.c         | 24 +++++++--------
 testcases/kernel/containers/netns/par_chld_ipv6.c  | 10 +++----
 .../kernel/containers/netns/two_children_ns.c      | 10 +++----
 testcases/kernel/containers/pidns/pidns01.c        |  4 +--
 testcases/kernel/containers/pidns/pidns05.c        | 10 +++----
 testcases/kernel/containers/pidns/pidns16.c        |  4 +--
 testcases/kernel/containers/sysvipc/mesgq_nstest.c | 16 +++++-----
 testcases/kernel/containers/sysvipc/sem_nstest.c   | 20 ++++++-------
 testcases/kernel/containers/sysvipc/semtest_2ns.c  | 34 +++++++++++-----------
 testcases/kernel/containers/sysvipc/shmnstest.c    | 16 +++++-----
 testcases/kernel/containers/utsname/utstest.c      | 32 ++++++++++----------
 13 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index cd7c05f..5bdabf1 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -84,11 +84,11 @@ int main(int argc, char *argv[])
 
 	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
 		tst_resm(TINFO,
-			 "Testing posix mq namespaces through clone(2).\n");
+			 "Testing posix mq namespaces through clone(2).");
 		use_clone = T_CLONE;
 	} else
 		tst_resm(TINFO,
-			 "Testing posix mq namespaces through unshare(2).\n");
+			 "Testing posix mq namespaces through unshare(2).");
 
 	if (pipe(p1) == -1 || pipe(p2) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
@@ -99,15 +99,15 @@ int main(int argc, char *argv[])
 		    NULL);
 	if (mqd == -1) {
 		perror("mq_open");
-		tst_resm(TFAIL, "mq_open failed\n");
+		tst_resm(TFAIL, "mq_open failed");
 		tst_exit();
 	}
 
-	tst_resm(TINFO, "Checking namespaces isolation from parent to child\n");
+	tst_resm(TINFO, "Checking namespaces isolation from parent to child");
 	/* fire off the test */
 	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
 	if (r < 0) {
-		tst_resm(TFAIL, "failed clone/unshare\n");
+		tst_resm(TFAIL, "failed clone/unshare");
 		mq_close(mqd);
 		syscall(__NR_mq_unlink, NOSLASH_MQ1);
 		tst_exit();
@@ -121,11 +121,11 @@ int main(int argc, char *argv[])
 		tst_resm(TBROK | TERRNO, "read(p2[0], buf, ...) failed");
 	else {
 		if (!strcmp(buf, "exists")) {
-			tst_resm(TFAIL, "child process found mqueue\n");
+			tst_resm(TFAIL, "child process found mqueue");
 		} else if (!strcmp(buf, "notfnd")) {
-			tst_resm(TPASS, "child process didn't find mqueue\n");
+			tst_resm(TPASS, "child process didn't find mqueue");
 		} else {
-			tst_resm(TFAIL, "UNKNOWN RESULT\n");
+			tst_resm(TFAIL, "UNKNOWN RESULT");
 		}
 	}
 
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index 932ce3c..65cff40 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -26,7 +26,7 @@
 * Check that mq1 is not readable from father
 *
 * Changelog:
-* 	Dec 16: accomodate new mqns semantics (Serge Hallyn)
+*	Dec 16: accomodate new mqns semantics (Serge Hallyn)
 
 ***************************************************************************/
 
@@ -117,11 +117,11 @@ int main(int argc, char *argv[])
 
 	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
 		tst_resm(TINFO,
-			 "Testing posix mq namespaces through clone(2).\n");
+			 "Testing posix mq namespaces through clone(2).");
 		use_clone = T_CLONE;
 	} else
 		tst_resm(TINFO,
-			 "Testing posix mq namespaces through unshare(2).\n");
+			 "Testing posix mq namespaces through unshare(2).");
 
 	if (pipe(p1) == -1 || pipe(p2) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL, "pipe");
@@ -130,10 +130,10 @@ int main(int argc, char *argv[])
 	/* fire off the test */
 	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
 	if (r < 0) {
-		tst_brkm(TFAIL, NULL, "failed clone/unshare\n");
+		tst_brkm(TFAIL, NULL, "failed clone/unshare");
 	}
 
-	tst_resm(TINFO, "Checking namespaces isolation (child to parent)\n");
+	tst_resm(TINFO, "Checking namespaces isolation (child to parent)");
 
 	close(p1[0]);
 	close(p2[1]);
@@ -144,19 +144,19 @@ int main(int argc, char *argv[])
 	if (read(p2[0], buf, 7) < 0) {
 		tst_resm(TBROK | TERRNO, "read(p2[0], ..) failed");
 	} else if (!strcmp(buf, "mqfail")) {
-		tst_resm(TFAIL, "child process could not create mqueue\n");
+		tst_resm(TFAIL, "child process could not create mqueue");
 		umount(DEV_MQUEUE);
 	} else if (strcmp(buf, "mqopen")) {
-		tst_resm(TFAIL, "child process could not create mqueue\n");
+		tst_resm(TFAIL, "child process could not create mqueue");
 		umount(DEV_MQUEUE);
 	} else {
 		mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
 		if (mqd == -1) {
 			tst_resm(TPASS,
-				 "Parent process can't see the mqueue\n");
+				 "Parent process can't see the mqueue");
 		} else {
 			tst_resm(TFAIL | TERRNO,
-				 "Parent process found mqueue\n");
+				 "Parent process found mqueue");
 			mq_close(mqd);
 		}
 		if (write(p1[1], "cont", 5) < 0) {
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index c883544..3ecf3e5 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -94,11 +94,11 @@ int main(int argc, char *argv[])
 
 	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
 		tst_resm(TINFO,
-			 "Testing posix mq namespaces through clone(2).\n");
+			 "Testing posix mq namespaces through clone(2).");
 		use_clone = T_CLONE;
 	} else
 		tst_resm(TINFO,
-			 "Testing posix mq namespaces through unshare(2).\n");
+			 "Testing posix mq namespaces through unshare(2).");
 
 	if (pipe(p1) == -1) {
 		perror("pipe");
@@ -111,12 +111,12 @@ int main(int argc, char *argv[])
 
 	mkdir(DEV_MQUEUE2, 0755);
 
-	tst_resm(TINFO, "Checking mqueue filesystem lifetime\n");
+	tst_resm(TINFO, "Checking mqueue filesystem lifetime");
 
 	/* fire off the test */
 	rc = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
 	if (rc < 0) {
-		tst_resm(TFAIL, "failed clone/unshare\n");
+		tst_resm(TFAIL, "failed clone/unshare");
 		goto fail;
 	}
 
@@ -126,10 +126,10 @@ int main(int argc, char *argv[])
 
 	read(p2[0], buf, 7);
 	if (!strcmp(buf, "mqfail")) {
-		tst_resm(TFAIL, "child process could not create mqueue\n");
+		tst_resm(TFAIL, "child process could not create mqueue");
 		goto fail;
 	} else if (!strcmp(buf, "mount")) {
-		tst_resm(TFAIL, "child process could not mount mqueue\n");
+		tst_resm(TFAIL, "child process could not mount mqueue");
 		goto fail;
 	}
 
@@ -137,7 +137,7 @@ int main(int argc, char *argv[])
 	if (rc == -1) {
 		perror("stat");
 		write(p1[1], "go", 3);
-		tst_resm(TFAIL, "parent could not see child's created mq\n");
+		tst_resm(TFAIL, "parent could not see child's created mq");
 		goto fail;
 	}
 	write(p1[1], "go", 3);
@@ -145,29 +145,29 @@ int main(int argc, char *argv[])
 	rc = wait(&status);
 	if (rc == -1) {
 		perror("wait");
-		tst_resm(TFAIL, "error while parent waited on child to exit\n");
+		tst_resm(TFAIL, "error while parent waited on child to exit");
 		goto fail;
 	}
 	if (!WIFEXITED(status)) {
-		tst_resm(TFAIL, "Child did not exit normally (status %d)\n",
+		tst_resm(TFAIL, "Child did not exit normally (status %d)",
 			 status);
 		goto fail;
 	}
 	rc = stat(FNAM1, &statbuf);
 	if (rc == -1) {
 		tst_resm(TFAIL,
-			 "parent's view of child's mq died with child\n");
+			 "parent's view of child's mq died with child");
 		goto fail;
 	}
 
 	rc = creat(FNAM2, 0755);
 	if (rc != -1) {
 		tst_resm(TFAIL,
-			 "parent was able to create a file in dead child's mqfs\n");
+			 "parent was able to create a file in dead child's mqfs");
 		goto fail;
 	}
 
-	tst_resm(TPASS, "Child mqueue fs still visible for parent\n");
+	tst_resm(TPASS, "Child mqueue fs still visible for parent");
 
 fail:
 	umount(DEV_MQUEUE2);
diff --git a/testcases/kernel/containers/netns/par_chld_ipv6.c b/testcases/kernel/containers/netns/par_chld_ipv6.c
index c4b54ae..f0d17ba 100644
--- a/testcases/kernel/containers/netns/par_chld_ipv6.c
+++ b/testcases/kernel/containers/netns/par_chld_ipv6.c
@@ -65,9 +65,9 @@ int main()
 	ltproot = getenv("LTPROOT");
 
 	if (!ltproot) {
-		tst_resm(TINFO, "LTPROOT env variable is not set\n");
+		tst_resm(TINFO, "LTPROOT env variable is not set");
 		tst_resm(TINFO,
-			 "Please set LTPROOT and re-run the test.. Thankyou\n");
+			 "Please set LTPROOT and re-run the test.. Thankyou");
 		return -1;
 	}
 
@@ -89,7 +89,7 @@ int main()
 		if (ret < 0) {
 			perror("unshare");
 			tst_resm(TFAIL,
-				 "Error:Unshare syscall failed for network namespace\n");
+				 "Error:Unshare syscall failed for network namespace");
 			return 1;
 		}
 #else
@@ -104,7 +104,7 @@ int main()
 		if (ret == -1 || status != 0) {
 			tst_resm(TFAIL,
 				 "Error: While running the IPv6 tests between \
-parent & child NS\n");
+parent & child NS");
 			fflush(stdout);
 			exit(1);
 		}
@@ -113,7 +113,7 @@ parent & child NS\n");
 		ret = waitpid(pid, &status, __WALL);
 		status = WEXITSTATUS(status);
 		if (status != 0 || ret == -1) {
-			tst_resm(TFAIL, "waitpid() returns %d, errno %d\n", ret,
+			tst_resm(TFAIL, "waitpid() returns %d, errno %d", ret,
 				 errno);
 			status = errno;
 		}
diff --git a/testcases/kernel/containers/netns/two_children_ns.c b/testcases/kernel/containers/netns/two_children_ns.c
index 2e8834d..235d9c4 100644
--- a/testcases/kernel/containers/netns/two_children_ns.c
+++ b/testcases/kernel/containers/netns/two_children_ns.c
@@ -73,9 +73,9 @@ int main()
 
 	ltproot = getenv("LTPROOT");
 	if (!ltproot) {
-		tst_resm(TINFO, "LTPROOT env variable is not set\n");
+		tst_resm(TINFO, "LTPROOT env variable is not set");
 		tst_resm(TINFO,
-			 "Please set LTPROOT and re-run the test.. Thankyou\n");
+			 "Please set LTPROOT and re-run the test.. Thankyou");
 		return -1;
 	}
 
@@ -105,7 +105,7 @@ int main()
 			if (ret < 0) {
 				perror("Unshare");
 				tst_resm(TFAIL,
-					 "Error:Unshare syscall failed for network namespace\n");
+					 "Error:Unshare syscall failed for network namespace");
 				return ret;
 			}
 #endif
@@ -117,7 +117,7 @@ int main()
 			status = WEXITSTATUS(ret);
 			if (ret == -1 || status != 0) {
 				tst_resm(TFAIL,
-					 "Error while running the scripts\n");
+					 "Error while running the scripts");
 				exit(status);
 			}
 		}
@@ -128,7 +128,7 @@ int main()
 		ret = waitpid(pid[i], &status, __WALL);
 		status = WEXITSTATUS(status);
 		if (status != 0 || ret == -1) {
-			tst_resm(TFAIL, "waitpid() returns %d, errno %d\n", ret,
+			tst_resm(TFAIL, "waitpid() returns %d, errno %d", ret,
 				 status);
 			fflush(stdout);
 			exit(status);
diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index 97322fb..02b4251 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -42,7 +42,7 @@
 *
 * History:
 *
-* FLAG DATE     	NAME	   		DESCRIPTION
+* FLAG DATE		NAME			DESCRIPTION
 * 27/12/07  RISHIKESH K RAJAK <risrajak@in.ibm.com> Created this test
 *
 *******************************************************************************************/
@@ -75,7 +75,7 @@ int child_fn1(void *ttype)
 	cpid = getpid();
 	ppid = getppid();
 
-	tst_resm(TINFO, "PIDNS test is running inside container\n");
+	tst_resm(TINFO, "PIDNS test is running inside container");
 	if (cpid == CHILD_PID && ppid == PARENT_PID) {
 		printf("Got expected cpid and ppid\n");
 		exit_val = 0;
diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index a2181a1..e70031d 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -35,8 +35,8 @@
 *
 * History:
 *
-* FLAG DATE     	NAME	   			DESCRIPTION
-* 31/10/08  Veerendra C <vechandr@in.ibm.com> 	Verifies killing of NestedCont's
+* FLAG DATE		NAME				DESCRIPTION
+* 31/10/08  Veerendra C <vechandr@in.ibm.com>	Verifies killing of NestedCont's
 *
 *******************************************************************************/
 #define _GNU_SOURCE 1
@@ -75,7 +75,7 @@ int max_pid(void)
 		fscanf(fp, "%d", &ret);
 		fclose(fp);
 	} else {
-		tst_resm(TBROK, "Cannot open /proc/sys/kernel/pid_max \n");
+		tst_resm(TBROK, "Cannot open /proc/sys/kernel/pid_max");
 		ret = -1;
 	}
 	return ret;
@@ -178,11 +178,11 @@ void kill_nested_containers()
 	}
 
 	if (status == 0)
-		tst_resm(TPASS, "The number of containers killed are %d\n",
+		tst_resm(TPASS, "The number of containers killed are %d",
 			 orig_count - new_count);
 	else
 		tst_resm(TFAIL, "Failed to kill the sub-containers of "
-			 "the container %d\n", pids[MAX_DEPTH - 3]);
+			 "the container %d", pids[MAX_DEPTH - 3]);
 
 	/* Loops through the containers created to exit from sleep() */
 	for (i = 0; i < MAX_DEPTH; i++) {
diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index 3a077c9..70548e8 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -20,7 +20,7 @@
 * *	- from the parent process and also inside a container
 * *	- Where init has defined a custom handler for USR1
 * *	- Should call the handler and
-* * 	- Verify whether the signal handler is called from the proper process.
+* *	- Verify whether the signal handler is called from the proper process.
 * *
 * * Description:
 * *  Create PID namespace container.
@@ -155,7 +155,7 @@ int main(int argc, char *argv[])
 
 	if ((WIFEXITED(status)) && (WEXITSTATUS(status) == 10))
 		tst_resm(TPASS, "container init continued successfuly, "
-			 "after handling signal -USR1\n");
+			 "after handling signal -USR1");
 	else
 		tst_resm(TFAIL, "c-init failed to continue after "
 			 "passing kill -USR1");
diff --git a/testcases/kernel/containers/sysvipc/mesgq_nstest.c b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
index c318a65..5e5a74f 100644
--- a/testcases/kernel/containers/sysvipc/mesgq_nstest.c
+++ b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
@@ -17,7 +17,7 @@
 *
 * In Parent Process , create mesgq with key 154326L
 * Now create container by passing 1 of the flag values..
-* 	Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
+*	Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
 * In cloned process, try to access the created mesgq
 * Test PASS: If the mesgq is readable when flag is None.
 * Test FAIL: If the mesgq is readable when flag is Unshare or Clone.
@@ -57,7 +57,7 @@ void mesgq_read(id)
 	if (n == -1)
 		perror("msgrcv"), tst_exit();
 
-	tst_resm(TINFO, "Mesg read of %d bytes; Type %ld: Msg: %.*s\n",
+	tst_resm(TINFO, "Mesg read of %d bytes; Type %ld: Msg: %.*s",
 		 n, msg.mtype, n, msg.mtext);
 }
 
@@ -89,7 +89,7 @@ int main(int argc, char *argv[])
 	char buf[7];
 
 	if (argc != 2) {
-		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>\n", argv[0]);
+		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
 		tst_resm(TFAIL, " where clone, unshare, or fork specifies"
 			 " unshare method.");
 		tst_exit();
@@ -130,11 +130,11 @@ int main(int argc, char *argv[])
 	if (n == -1)
 		perror("msgsnd"), tst_exit();
 
-	tst_resm(TINFO, "mesgq namespaces test : %s\n", tsttype);
+	tst_resm(TINFO, "mesgq namespaces test : %s", tsttype);
 	/* fire off the test */
 	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
 	if (ret < 0) {
-		tst_resm(TFAIL, "%s failed\n", tsttype);
+		tst_resm(TFAIL, "%s failed", tsttype);
 		tst_exit();
 	}
 
@@ -146,15 +146,15 @@ int main(int argc, char *argv[])
 	if (strcmp(buf, "exists") == 0) {
 		if (use_clone == T_NONE)
 			tst_resm(TPASS, "Plain cloned process found mesgq "
-				 "inside container\n");
+				 "inside container");
 		else
 			tst_resm(TFAIL,
-				 "%s: Container init process found mesgq\n",
+				 "%s: Container init process found mesgq",
 				 tsttype);
 	} else {
 		if (use_clone == T_NONE)
 			tst_resm(TFAIL,
-				 "Plain cloned process didn't find mesgq\n");
+				 "Plain cloned process didn't find mesgq");
 		else
 			tst_resm(TPASS, "%s: Container didn't find mesgq",
 				 tsttype);
diff --git a/testcases/kernel/containers/sysvipc/sem_nstest.c b/testcases/kernel/containers/sysvipc/sem_nstest.c
index 305ca55..2405b24 100644
--- a/testcases/kernel/containers/sysvipc/sem_nstest.c
+++ b/testcases/kernel/containers/sysvipc/sem_nstest.c
@@ -17,7 +17,7 @@
 *
 * In Parent Process , create semaphore with key 154326L
 * Now create container by passing 1 of the below flag values..
-* 	clone(NONE), clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
+*	clone(NONE), clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
 * In cloned process, try to access the created semaphore
 * Test PASS: If the semaphore is readable when flag is None.
 * Test FAIL: If the semaphore is readable when flag is Unshare or Clone.
@@ -57,7 +57,7 @@ int check_semaphore(void *vtest)
 		write(p2[1], "notfnd", 7);
 	else {
 		write(p2[1], "exists", 7);
-		tst_resm(TINFO, "PID %d: Fetched existing semaphore..id = %d\n",
+		tst_resm(TINFO, "PID %d: Fetched existing semaphore..id = %d",
 			 getpid(), id);
 	}
 	tst_exit();
@@ -72,7 +72,7 @@ int main(int argc, char *argv[])
 	char buf[7];
 
 	if (argc != 2) {
-		tst_resm(TFAIL, "Usage: %s <clone| unshare| none>\n", argv[0]);
+		tst_resm(TFAIL, "Usage: %s <clone| unshare| none>", argv[0]);
 		tst_resm(TFAIL, " where clone, unshare, or fork specifies"
 			 " unshare method.");
 		tst_exit();
@@ -102,24 +102,24 @@ int main(int argc, char *argv[])
 		perror("Semaphore create");
 		if (errno != EEXIST) {
 			perror("semget failure");
-			tst_resm(TBROK, "Semaphore creation failed\n");
+			tst_resm(TBROK, "Semaphore creation failed");
 			tst_exit();
 		}
 		id = semget(MY_KEY, 1, 0);
 		if (id == -1) {
 			perror("Semaphore create");
-			tst_resm(TBROK, "Semaphore operation failed\n");
+			tst_resm(TBROK, "Semaphore operation failed");
 			tst_exit();
 		}
 	}
 
-	tst_resm(TINFO, "Semaphore namespaces Isolation test : %s\n", tsttype);
+	tst_resm(TINFO, "Semaphore namespaces Isolation test : %s", tsttype);
 	/* fire off the test */
 	ret =
 	    do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_semaphore,
 				  NULL);
 	if (ret < 0) {
-		tst_resm(TFAIL, "%s failed\n", tsttype);
+		tst_resm(TFAIL, "%s failed", tsttype);
 		tst_exit();
 	}
 
@@ -131,15 +131,15 @@ int main(int argc, char *argv[])
 	if (strcmp(buf, "exists") == 0) {
 		if (use_clone == T_NONE)
 			tst_resm(TPASS, "Plain cloned process found semaphore "
-				 "inside container\n");
+				 "inside container");
 		else
 			tst_resm(TFAIL,
-				 "%s: Container init process found semaphore\n",
+				 "%s: Container init process found semaphore",
 				 tsttype);
 	} else {
 		if (use_clone == T_NONE)
 			tst_resm(TFAIL,
-				 "Plain cloned process didn't find semaphore\n");
+				 "Plain cloned process didn't find semaphore");
 		else
 			tst_resm(TPASS, "%s: Container didn't find semaphore",
 				 tsttype);
diff --git a/testcases/kernel/containers/sysvipc/semtest_2ns.c b/testcases/kernel/containers/sysvipc/semtest_2ns.c
index f80f6dc..d9afc25 100644
--- a/testcases/kernel/containers/sysvipc/semtest_2ns.c
+++ b/testcases/kernel/containers/sysvipc/semtest_2ns.c
@@ -25,14 +25,14 @@
 * In Cont1, create semaphore with key 124326L
 * In Cont2, try to access the semaphore created in Cont1.
 * PASS :
-* 		If flag = None and the semaphore is accessible in Cont2.
+*		If flag = None and the semaphore is accessible in Cont2.
 *		If flag = unshare/clone and the semaphore is not accessible in Cont2.
-* 		If semaphore is not accessible in Cont2, creates new semaphore with
+*		If semaphore is not accessible in Cont2, creates new semaphore with
 *		the same key to double check isloation in IPCNS.
 *
 * FAIL :
-* 		If flag = none and the semaphore is not accessible.
-* 		If flag = unshare/clone and semaphore is accessible in Cont2.
+*		If flag = none and the semaphore is not accessible.
+*		If flag = unshare/clone and semaphore is accessible in Cont2.
 *		If the new semaphore creation Fails.
 ***************************************************************************/
 
@@ -74,14 +74,14 @@ void sem_lock(int id)
 	/* Checking the semlock and simulating as if the crit-sec is updated */
 	if (semop(id, &semop_lock[0], 2) < 0) {
 		perror("sem lock error");
-		tst_resm(TBROK, "semop failed\n");
+		tst_resm(TBROK, "semop failed");
 		tst_exit();
 	}
-	tst_resm(TINFO, "Sem1: File locked, Critical section is updated...\n");
+	tst_resm(TINFO, "Sem1: File locked, Critical section is updated...");
 	sleep(2);
 	if (semop(id, &semop_unlock[0], 1) < 0) {
 		perror("sem unlock error");
-		tst_resm(TBROK, "semop failed\n");
+		tst_resm(TBROK, "semop failed");
 		tst_exit();
 	}
 }
@@ -100,13 +100,13 @@ int check_sem1(void *vtest)
 		perror("Semaphore create");
 		if (errno != EEXIST) {
 			perror("semget failure");
-			tst_resm(TBROK, "semget failure\n");
+			tst_resm(TBROK, "semget failure");
 			tst_exit();
 		}
 		id1 = semget(MY_KEY, 1, 0);
 		if (id1 == -1) {
 			perror("Semaphore create");
-			tst_resm(TBROK, "semget failure\n");
+			tst_resm(TBROK, "semget failure");
 			tst_exit();
 		}
 	}
@@ -141,7 +141,7 @@ int check_sem2(void *vtest)
 			perror("Semaphore create");
 			if (errno != EEXIST) {
 				perror("semget failure");
-				tst_resm(TBROK, "semget failure\n");
+				tst_resm(TBROK, "semget failure");
 			}
 		} else
 			tst_resm(TINFO,
@@ -163,7 +163,7 @@ int main(int argc, char *argv[])
 	if (argc != 2) {
 		tst_resm(TINFO, "Usage: %s <clone| unshare| none>", argv[0]);
 		tst_resm(TINFO, " where clone, unshare, or fork specifies"
-			 " unshare method.\n");
+			 " unshare method.");
 		tst_exit();
 	}
 
@@ -190,13 +190,13 @@ int main(int argc, char *argv[])
 	/* Create 2 containers */
 	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem1, NULL);
 	if (ret < 0) {
-		tst_resm(TFAIL, "clone/unshare failed\n");
+		tst_resm(TFAIL, "clone/unshare failed");
 		tst_exit();
 	}
 
 	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_sem2, NULL);
 	if (ret < 0) {
-		tst_resm(TFAIL, "clone/unshare failed\n");
+		tst_resm(TFAIL, "clone/unshare failed");
 		tst_exit();
 	}
 	close(p2[1]);
@@ -206,17 +206,17 @@ int main(int argc, char *argv[])
 		if (use_clone == T_NONE)
 			tst_resm(TPASS,
 				 "Plain cloned process able to access the semaphore "
-				 "created\n");
+				 "created");
 		else
 			tst_resm(TFAIL,
 				 "%s : In namespace2 found the semaphore "
-				 "created in Namespace1\n", tsttype);
+				 "created in Namespace1", tsttype);
 	else if (use_clone == T_NONE)
-		tst_resm(TFAIL, "Plain cloned process didn't find semaphore\n");
+		tst_resm(TFAIL, "Plain cloned process didn't find semaphore");
 	else
 		tst_resm(TPASS,
 			 "%s : In namespace2 unable to access the semaphore "
-			 "created in Namespace1\n", tsttype);
+			 "created in Namespace1", tsttype);
 
 	/* Delete the semaphore */
 	id = semget(MY_KEY, 1, 0);
diff --git a/testcases/kernel/containers/sysvipc/shmnstest.c b/testcases/kernel/containers/sysvipc/shmnstest.c
index 3ceaefa..2188183 100644
--- a/testcases/kernel/containers/sysvipc/shmnstest.c
+++ b/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -72,7 +72,7 @@ int main(int argc, char *argv[])
 	char buf[7];
 
 	if (argc != 2) {
-		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>\n", argv[0]);
+		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
 		tst_resm(TFAIL,
 			 " where clone, unshare, or fork specifies unshare method.");
 		tst_exit();
@@ -98,15 +98,15 @@ int main(int argc, char *argv[])
 	id = shmget(TESTKEY, 100, IPC_CREAT);
 	if (id == -1) {
 		perror("shmget");
-		tst_resm(TFAIL, "shmget failed\n");
+		tst_resm(TFAIL, "shmget failed");
 		tst_exit();
 	}
 
-	tst_resm(TINFO, "shmid namespaces test : %s\n", tsttype);
+	tst_resm(TINFO, "shmid namespaces test : %s", tsttype);
 	/* fire off the test */
 	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_shmid, NULL);
 	if (r < 0) {
-		tst_resm(TFAIL, "%s failed\n", tsttype);
+		tst_resm(TFAIL, "%s failed", tsttype);
 		tst_exit();
 	}
 
@@ -116,16 +116,16 @@ int main(int argc, char *argv[])
 	read(p2[0], buf, 7);
 	if (strcmp(buf, "exists") == 0) {
 		if (use_clone == T_NONE)
-			tst_resm(TPASS, "plain cloned process found shmid\n");
+			tst_resm(TPASS, "plain cloned process found shmid");
 		else
-			tst_resm(TFAIL, "%s: child process found shmid\n",
+			tst_resm(TFAIL, "%s: child process found shmid",
 				 tsttype);
 	} else {
 		if (use_clone == T_NONE)
 			tst_resm(TFAIL,
-				 "plain cloned process didn't find shmid\n");
+				 "plain cloned process didn't find shmid");
 		else
-			tst_resm(TPASS, "%s: child process didn't find shmid\n",
+			tst_resm(TPASS, "%s: child process didn't find shmid",
 				 tsttype);
 	}
 
diff --git a/testcases/kernel/containers/utsname/utstest.c b/testcases/kernel/containers/utsname/utstest.c
index 727488c..a399605 100644
--- a/testcases/kernel/containers/utsname/utstest.c
+++ b/testcases/kernel/containers/utsname/utstest.c
@@ -109,10 +109,10 @@ int P1(void *vtest)
 		zeroize(rhostname);
 		len = read(p1fd[0], rhostname, HLEN);
 		if (strcmp(hostname, rhostname) == 0) {
-			tst_resm(TPASS, "test 1 (%s): success\n", tsttype);
+			tst_resm(TPASS, "test 1 (%s): success", tsttype);
 			tst_exit();
 		}
-		tst_resm(TFAIL, "test 1 (%s): hostname 1 %s, hostname 2 %s\n",
+		tst_resm(TFAIL, "test 1 (%s): hostname 1 %s, hostname 2 %s",
 			 tsttype, hostname, rhostname);
 		tst_exit();
 	case 2:
@@ -128,10 +128,10 @@ int P1(void *vtest)
 		zeroize(rhostname);
 		len = read(p1fd[0], rhostname, HLEN);
 		if (strcmp(newhostname, rhostname) == 0) {
-			tst_resm(TPASS, "test 2 (%s): success\n", tsttype);
+			tst_resm(TPASS, "test 2 (%s): success", tsttype);
 			tst_exit();
 		}
-		tst_resm(TFAIL, "test 2 (%s) hostname 1 %s, hostname 2 %s\n",
+		tst_resm(TFAIL, "test 2 (%s) hostname 1 %s, hostname 2 %s",
 			 tsttype, newhostname, rhostname);
 		tst_exit();
 	case 3:
@@ -149,16 +149,16 @@ int P1(void *vtest)
 		len = read(p1fd[0], rhostname, HLEN);
 		if (strcmp(newhostname, rhostname) == 0) {
 			tst_resm(TFAIL,
-				 "test 3 (%s): hostname 1 %s, hostname 2 %s, these should have been different\n",
+				 "test 3 (%s): hostname 1 %s, hostname 2 %s, these should have been different",
 				 tsttype, newhostname, rhostname);
 			tst_exit();
 		}
 		if (strcmp(hostname, rhostname) == 0) {
-			tst_resm(TPASS, "test 3 (%s): success\n", tsttype);
+			tst_resm(TPASS, "test 3 (%s): success", tsttype);
 			tst_exit();
 		}
 		tst_resm(TFAIL,
-			 "test 3 (%s): hostname 1 %s, hostname 2 %s, should have been same\n",
+			 "test 3 (%s): hostname 1 %s, hostname 2 %s, should have been same",
 			 tsttype, hostname, rhostname);
 		tst_exit();
 
@@ -170,7 +170,7 @@ int P1(void *vtest)
 		gethostname(newhostname, HLEN);
 		if (strcmp(hostname, newhostname) != 0) {
 			tst_resm(TFAIL,
-				 "test 4 (%s): hostname 1 %s, hostname 2 %s, should be same\n",
+				 "test 4 (%s): hostname 1 %s, hostname 2 %s, should be same",
 				 tsttype, hostname, newhostname);
 			tst_exit();
 		}
@@ -180,7 +180,7 @@ int P1(void *vtest)
 				 tsttype, hostname, rhostname);
 			tst_exit();
 		}
-		tst_resm(TPASS, "test 4 (%s): successful\n", tsttype);
+		tst_resm(TPASS, "test 4 (%s): successful", tsttype);
 		tst_exit();
 	case 5:
 		write(p2fd[1], "1", 1);	/* tell p2 to go ahead and sethostname */
@@ -189,7 +189,7 @@ int P1(void *vtest)
 		gethostname(newhostname, HLEN);
 		if (strcmp(rhostname, newhostname) != 0) {
 			tst_resm(TFAIL,
-				 "test 5 (%s): hostnames %s and %s should be same\n",
+				 "test 5 (%s): hostnames %s and %s should be same",
 				 tsttype, rhostname, newhostname);
 			tst_exit();
 		}
@@ -233,7 +233,7 @@ int P2(void *vtest)
 			len = read(p2fd[0], hostname, 1);
 		}
 		if (hostname[0] == '0') {
-			tst_resm(TPASS, "P2: P1 claims error\n");
+			tst_resm(TPASS, "P2: P1 claims error");
 			tst_exit();
 			exit(0);
 		}
@@ -243,7 +243,7 @@ int P2(void *vtest)
 		write(p1fd[1], newhostname, strlen(newhostname));
 		break;
 	default:
-		tst_resm(TFAIL, "undefined test: %d\n", testnum);
+		tst_resm(TFAIL, "undefined test: %d", testnum);
 		break;
 	}
 	tst_exit();
@@ -259,11 +259,11 @@ int main(int argc, char *argv[])
 	void *vtest;
 
 	if (argc != 3) {
-		tst_resm(TFAIL, "Usage: %s <clone|unshare> <testnum>\n",
+		tst_resm(TFAIL, "Usage: %s <clone|unshare> <testnum>",
 			 argv[0]);
 		tst_resm(TFAIL,
 			 " where clone or unshare specifies unshare method,");
-		tst_resm(TFAIL, " and testnum is between 1 and 5 inclusive\n");
+		tst_resm(TFAIL, " and testnum is between 1 and 5 inclusive");
 		exit(2);
 	}
 	if (pipe(p1fd) == -1) {
@@ -302,7 +302,7 @@ int main(int argc, char *argv[])
 		}
 		if (pid == 0) {
 			if (!drop_root()) {
-				tst_resm(TFAIL, "failed to drop root.\n");
+				tst_resm(TFAIL, "failed to drop root.");
 				tst_exit();
 				exit(1);
 			}
@@ -316,7 +316,7 @@ int main(int argc, char *argv[])
 		break;
 	default:
 		tst_resm(TFAIL,
-			 "testnum should be between 1 and 5 inclusive.\n");
+			 "testnum should be between 1 and 5 inclusive.");
 		break;
 	}
 
-- 
1.7.11.7


------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
