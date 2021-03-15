From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 15 Mar 2021 11:24:36 +0800
Subject: [LTP] [PATCH] log style: Remove redundancy '\n'
Message-ID: <20210315032436.24360-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove redundancy '\n' to make the log style consistency since
the functions tst_* have added a '\n' at the end of the string.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/containers/share/ns_ifmove.c |  2 +-
 .../controllers/cpuctl/cpuctl_def_task01.c    |  4 +-
 .../controllers/cpuctl/cpuctl_def_task02.c    |  6 +--
 .../controllers/cpuctl/cpuctl_def_task03.c    |  6 +--
 .../controllers/cpuctl/cpuctl_def_task04.c    |  6 +--
 .../kernel/controllers/cpuctl/cpuctl_test01.c |  4 +-
 .../kernel/controllers/cpuctl/cpuctl_test02.c |  6 +--
 .../kernel/controllers/cpuctl/cpuctl_test03.c |  6 +--
 .../kernel/controllers/cpuctl/cpuctl_test04.c |  6 +--
 testcases/kernel/fs/inode/inode02.c           | 14 +++---
 testcases/kernel/io/aio/aio02.c               | 10 ++--
 testcases/kernel/logging/kmsg/kmsg01.c        |  2 +-
 .../kernel/mem/mmapstress/mmap-corruption01.c |  2 +-
 .../kernel/mem/mmapstress/mmapstress01.c      |  2 +-
 .../kernel/mem/mmapstress/mmapstress02.c      |  2 +-
 .../kernel/mem/mmapstress/mmapstress05.c      |  4 +-
 .../kernel/mem/mmapstress/mmapstress06.c      |  4 +-
 .../kernel/mem/mmapstress/mmapstress07.c      |  4 +-
 .../kernel/mem/mmapstress/mmapstress08.c      |  4 +-
 .../kernel/mem/mmapstress/mmapstress09.c      |  4 +-
 .../kernel/mem/mmapstress/mmapstress10.c      |  4 +-
 testcases/kernel/mem/mtest05/mmstress.c       |  2 +-
 testcases/kernel/mem/mtest06/mmap1.c          |  2 +-
 testcases/kernel/mem/mtest07/mallocstress.c   |  2 +-
 testcases/kernel/mem/page/page01.c            | 24 +++++-----
 testcases/kernel/mem/page/page02.c            | 24 +++++-----
 testcases/kernel/mem/shmt/shmt02.c            |  8 ++--
 testcases/kernel/mem/shmt/shmt03.c            | 12 ++---
 testcases/kernel/mem/shmt/shmt04.c            | 20 ++++----
 testcases/kernel/mem/shmt/shmt06.c            | 30 ++++++------
 testcases/kernel/mem/shmt/shmt07.c            | 10 ++--
 testcases/kernel/mem/shmt/shmt09.c            | 18 +++----
 testcases/kernel/mem/shmt/shmt10.c            |  8 ++--
 testcases/kernel/mem/vmtests/data_space.c     | 14 +++---
 testcases/kernel/mem/vmtests/stack_space.c    | 20 ++++----
 testcases/kernel/sched/pthreads/pth_str01.c   | 20 ++++----
 .../kernel/security/cap_bound/cap_bounds_rw.c | 24 +++++-----
 .../security/cap_bound/cap_bset_inh_bounds.c  | 24 +++++-----
 .../kernel/security/cap_bound/check_pe.c      | 14 +++---
 .../kernel/security/cap_bound/exec_with_inh.c | 12 ++---
 .../security/cap_bound/exec_without_inh.c     |  8 ++--
 .../kernel/security/filecaps/inh_capped.c     |  4 +-
 .../security/filecaps/verify_caps_exec.c      | 48 +++++++++----------
 .../security/prot_hsymlinks/prot_hsymlinks.c  |  6 +--
 .../kernel/syscalls/ipc/msgrcv/msgrcv08.c     |  4 +-
 testcases/kernel/syscalls/madvise/madvise06.c |  2 +-
 .../syscalls/memfd_create/memfd_create04.c    |  4 +-
 .../kernel/syscalls/move_pages/move_pages01.c |  2 +-
 .../kernel/syscalls/move_pages/move_pages02.c |  2 +-
 .../kernel/syscalls/move_pages/move_pages03.c |  2 +-
 .../kernel/syscalls/move_pages/move_pages04.c |  2 +-
 .../kernel/syscalls/move_pages/move_pages05.c |  2 +-
 .../kernel/syscalls/mprotect/mprotect04.c     |  2 +-
 testcases/kernel/syscalls/profil/profil01.c   |  2 +-
 .../syscalls/rt_sigaction/rt_sigaction01.c    |  2 +-
 .../syscalls/rt_sigaction/rt_sigaction03.c    |  2 +-
 .../network/tcp_cmds/sendfile/testsf_s.c      | 20 ++++----
 57 files changed, 252 insertions(+), 252 deletions(-)

diff --git a/testcases/kernel/containers/share/ns_ifmove.c b/testcases/kernel/containers/share/ns_ifmove.c
index f2a1b0f6a..12642c6f4 100644
--- a/testcases/kernel/containers/share/ns_ifmove.c
+++ b/testcases/kernel/containers/share/ns_ifmove.c
@@ -81,7 +81,7 @@ int main(int argc, char **argv)
 	int intf_index, pid, rtnetlink_socket;

 	if (argc != 3) {
-		tst_resm(TINFO, "%s <INTERFACE_NAME> <NAMESPACE_PID>\n",
+		tst_resm(TINFO, "%s <INTERFACE_NAME> <NAMESPACE_PID>",
 			 argv[0]);
 		return 1;
 	}
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index 578c60c89..4856f3372 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -117,14 +117,14 @@ int main(int argc, char *argv[])
 	    ((scriptpid = atoi(argv[3])) <= 0) ||
 	    ((num_cpus = atoi(argv[4])) <= 0) ||
 	    (test_num = atoi(argv[5])) <= 0)
-		tst_brkm(TBROK, cleanup, "Invalid input parameters\n");
+		tst_brkm(TBROK, cleanup, "Invalid input parameters");

 	if (test_num == 1)
 		myshares *= my_group_num;
 	else if (test_num == 3)
 		myshares = baseshares;
 	else
-		tst_brkm(TBROK, cleanup, "Wrong Test num passed. Exiting.\n");
+		tst_brkm(TBROK, cleanup, "Wrong Test num passed. Exiting.");

 	sprintf(mygroup, "%s", argv[2]);
 	sprintf(mytaskfile, "%s", mygroup);
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index 5e48c9415..3c19a7719 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -134,10 +134,10 @@ int main(void)
 			sprintf(mygroup, "%s", mygroup_p);
 		} else {
 			tst_brkm(TBROK, cleanup,
-				 "Invalid other input parameters\n");
+				 "Invalid other input parameters");
 		}
 	} else {
-		tst_brkm(TBROK, cleanup, "Invalid test number passed\n");
+		tst_brkm(TBROK, cleanup, "Invalid test number passed");
 	}

 	sprintf(mytaskfile, "%s", mygroup);
@@ -242,7 +242,7 @@ int main(void)
 				break;
 			default:
 				tst_brkm(TBROK, cleanup,
-					 "Invalid test number passed\n");
+					 "Invalid test number passed");
 				break;

 			}	/* end switch */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index b64cfcd3e..63aec0d2a 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -130,10 +130,10 @@ int main(void)
 			sprintf(mygroup, "%s", mygroup_p);
 		} else {
 			tst_brkm(TBROK, cleanup,
-				 "Invalid other input parameters\n");
+				 "Invalid other input parameters");
 		}
 	} else {
-		tst_brkm(TBROK, cleanup, "Invalid test number passed\n");
+		tst_brkm(TBROK, cleanup, "Invalid test number passed");
 	}

 	sprintf(mytaskfile, "%s", mygroup);
@@ -233,7 +233,7 @@ int main(void)
 				break;
 			default:
 				tst_brkm(TBROK, cleanup,
-					 "Invalid test num passed\n");
+					 "Invalid test num passed");
 				break;

 			}	/* end switch */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
index a3338fcd7..9a56d7b49 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
@@ -133,10 +133,10 @@ int main(void)
 			sprintf(mygroup, "%s", mygroup_p);
 		} else {
 			tst_brkm(TBROK, cleanup,
-				 "Invalid other input parameters\n");
+				 "Invalid other input parameters");
 		}
 	} else {
-		tst_brkm(TBROK, cleanup, "Invalid test number passed\n");
+		tst_brkm(TBROK, cleanup, "Invalid test number passed");
 	}

 	sprintf(mytaskfile, "%s", mygroup);
@@ -243,7 +243,7 @@ int main(void)
 				break;
 			default:
 				tst_brkm(TBROK, cleanup,
-					 "Invalid test number passed\n");
+					 "Invalid test number passed");
 				break;

 			}	/* end switch */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
index 8f6d11de0..9370f7eb8 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
@@ -117,7 +117,7 @@ int main(int argc, char *argv[])
 	    || ((scriptpid = atoi(argv[3])) <= 0)
 	    || ((num_cpus = atoi(argv[4])) <= 0)
 	    || (test_num = atoi(argv[5])) <= 0) {
-		tst_brkm(TBROK, cleanup, "Invalid input parameters\n");
+		tst_brkm(TBROK, cleanup, "Invalid input parameters");
 	}

 	if (test_num == 1)	/* Test 01 & Test 02 */
@@ -126,7 +126,7 @@ int main(int argc, char *argv[])
 		myshares = baseshares;
 	else {
 		tst_brkm(TBROK, cleanup,
-			 "Wrong Test number passed. Exiting Test...\n");
+			 "Wrong Test number passed. Exiting Test...");
 	}

 	sprintf(mygroup, "%s", argv[2]);
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
index 52ad8aa2f..a9b90d6b6 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
@@ -138,10 +138,10 @@ int main(void)
 			sprintf(mygroup, "%s", mygroup_p);
 		} else {
 			tst_brkm(TBROK, cleanup,
-				 "Invalid other input parameters\n");
+				 "Invalid other input parameters");
 		}
 	} else {
-		tst_brkm(TBROK, cleanup, "Invalid test number passed\n");
+		tst_brkm(TBROK, cleanup, "Invalid test number passed");
 	}

 	sprintf(mytaskfile, "%s", mygroup);
@@ -240,7 +240,7 @@ with %u(shares) in %lu (s) INTERVAL\n", mygroup_num, task_num, delta_cpu_time,
 				break;
 			default:
 				tst_brkm(TBROK, cleanup,
-					 "Invalid test number passed\n");
+					 "Invalid test number passed");
 				break;

 			}	/* end switch */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index 93cb26d3e..a81370085 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -133,10 +133,10 @@ int main(void)
 			sprintf(mygroup, "%s", mygroup_p);
 		} else {
 			tst_brkm(TBROK, cleanup,
-				 "Invalid other input parameters\n");
+				 "Invalid other input parameters");
 		}
 	} else {
-		tst_brkm(TBROK, cleanup, "Invalid test number passed\n");
+		tst_brkm(TBROK, cleanup, "Invalid test number passed");
 	}

 	sprintf(mytaskfile, "%s", mygroup);
@@ -223,7 +223,7 @@ int main(void)
 				break;
 			default:
 				tst_brkm(TBROK, cleanup,
-					 "Invalid test number passed\n");
+					 "Invalid test number passed");
 				break;

 			}	/* end switch */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
index eb8558021..d166aa4d3 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
@@ -134,10 +134,10 @@ int main(void)
 			sprintf(mygroup, "%s", mygroup_p);
 		} else {
 			tst_brkm(TBROK, cleanup,
-				 "Invalid other input parameters\n");
+				 "Invalid other input parameters");
 		}
 	} else {
-		tst_brkm(TBROK, cleanup, "Invalid test number passed\n");
+		tst_brkm(TBROK, cleanup, "Invalid test number passed");
 	}

 	/*
@@ -235,7 +235,7 @@ with %3u shares in %lu (s) INTERVAL\n", mygroup_num, task_num, delta_cpu_time,
 				break;
 			default:
 				tst_brkm(TBROK, cleanup,
-					 "Invalid test number passed\n");
+					 "Invalid test number passed");
 				break;

 			}	/* end switch */
diff --git a/testcases/kernel/fs/inode/inode02.c b/testcases/kernel/fs/inode/inode02.c
index 85598b2fc..43e406d54 100644
--- a/testcases/kernel/fs/inode/inode02.c
+++ b/testcases/kernel/fs/inode/inode02.c
@@ -122,7 +122,7 @@ int main(int argc, char *argv[])
 	parent_pid = getpid();

 	if (sigset(SIGTERM, (void (*)())term) == SIG_ERR) {
-		tst_resm(TBROK, "\tSIGTERM sigset set failed, errno=%d\n",
+		tst_resm(TBROK, "\tSIGTERM sigset set failed, errno=%d",
 			 errno);
 		exit(1);
 	}
@@ -140,7 +140,7 @@ int main(int argc, char *argv[])
 		file_length = 8;
 		nchild = 5;
 	} else if (argc < 5) {
-		tst_resm(TCONF, "Bad argument count.\n");
+		tst_resm(TCONF, "Bad argument count.");
 		printf
 		    ("\tinode02 max_depth max_breadth file_length #children\n\tdefault: inode02 6 5 8 5\n");
 		exit(1);
@@ -198,8 +198,8 @@ int main(int argc, char *argv[])
 	}

 	if (count != nchild) {
-		tst_resm(TFAIL, "Wrong number of children waited on!\n");
-		tst_resm(TFAIL, "Saw %d, expected %d\n", count, nchild);
+		tst_resm(TFAIL, "Wrong number of children waited on!");
+		tst_resm(TFAIL, "Saw %d, expected %d", count, nchild);
 		local_flag = FAILED;
 	}

@@ -837,7 +837,7 @@ void setup(void)
  */
 void fail_exit(void)
 {
-	tst_brkm(TFAIL, tst_rmdir, "Test failed\n");
+	tst_brkm(TFAIL, tst_rmdir, "Test failed");
 }

 /*
@@ -872,7 +872,7 @@ void ok_exit(void)
  */
 void forkfail(void)
 {
-	tst_brkm(TBROK, tst_rmdir, "Reason: %s\n", strerror(errno));
+	tst_brkm(TBROK, tst_rmdir, "Reason: %s", strerror(errno));
 }

 /*
@@ -884,7 +884,7 @@ void forkfail(void)
  */
 void terror(char *message)
 {
-	tst_resm(TBROK, "Reason: %s:%s\n", message, strerror(errno));
+	tst_resm(TBROK, "Reason: %s:%s", message, strerror(errno));
 	return;
 }

diff --git a/testcases/kernel/io/aio/aio02.c b/testcases/kernel/io/aio/aio02.c
index 439ab6e3a..fbbfe27bf 100644
--- a/testcases/kernel/io/aio/aio02.c
+++ b/testcases/kernel/io/aio/aio02.c
@@ -54,11 +54,11 @@ struct testcase {
 static void io_error(const char *func, int rc)
 {
 	if (rc == -ENOSYS)
-		tst_brk(TCONF, "AIO not in this kernel\n");
+		tst_brk(TCONF, "AIO not in this kernel");
 	else if (rc < 0)
-		tst_brk(TFAIL, "%s: %s\n", func, strerror(-rc));
+		tst_brk(TFAIL, "%s: %s", func, strerror(-rc));
 	else
-		tst_brk(TFAIL, "%s: error %d\n", func, rc);
+		tst_brk(TFAIL, "%s: error %d", func, rc);
 }

 /*
@@ -72,7 +72,7 @@ static void work_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
 		io_error("aio write", res2);

 	if (res != (long)iocb->u.c.nbytes)
-		tst_brk(TFAIL, "write missed bytes expect %lu got %ld\n",
+		tst_brk(TFAIL, "write missed bytes expect %lu got %ld",
 			iocb->u.c.nbytes, res);

 	wait_count--;
@@ -155,7 +155,7 @@ static int io_tio(char *pathname, int flag, int operation)
 			offset += AIO_BLKSIZE;
 			break;
 		default:
-			tst_res(TFAIL, "Command failed; opcode returned: %d\n", operation);
+			tst_res(TFAIL, "Command failed; opcode returned: %d", operation);
 			return -1;
 			break;
 		}
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index 57eee949a..34c6073c6 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -376,7 +376,7 @@ static void test_read_returns_first_message(void)
 	} else {
 		tst_res(TFAIL, "readers got different messages");
 		for (i = 0; i < NUM_READ_MSGS; i++)
-			tst_res(TINFO, "msg%d: %lu\n", i, seqno[i]);
+			tst_res(TINFO, "msg%d: %lu", i, seqno[i]);
 	}
 }

diff --git a/testcases/kernel/mem/mmapstress/mmap-corruption01.c b/testcases/kernel/mem/mmapstress/mmap-corruption01.c
index 262bc97e7..ccc0797d2 100644
--- a/testcases/kernel/mem/mmapstress/mmap-corruption01.c
+++ b/testcases/kernel/mem/mmapstress/mmap-corruption01.c
@@ -67,7 +67,7 @@ char *usage = "-h hours -m minutes -s secs\n";

 int anyfail(void)
 {
-	tst_brkm(TFAIL, tst_rmdir, "Test failed\n");
+	tst_brkm(TFAIL, tst_rmdir, "Test failed");
 }

 int main(int argc, char **argv)
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index d2df6122b..3b4b1ac24 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -163,7 +163,7 @@ int main(int argc, char *argv[])
 	progname = *argv;
 	tst_tmpdir();
 	if (argc < 2) {
-		tst_brkm(TBROK, NULL, "usage: %s %s\n", progname, usage);
+		tst_brkm(TBROK, NULL, "usage: %s %s", progname, usage);
 	}

 	while ((c = getopt(argc, argv, "S:omdlrf:p:t:")) != -1) {
diff --git a/testcases/kernel/mem/mmapstress/mmapstress02.c b/testcases/kernel/mem/mmapstress/mmapstress02.c
index d0e99ec58..9ea73edee 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress02.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress02.c
@@ -176,7 +176,7 @@ int main(int argc, char *argv[])
 /*****  LTP Port        *****/
 void ok_exit(void)
 {
-	tst_resm(TPASS, "Test passed\n");
+	tst_resm(TPASS, "Test passed");
 	tst_rmdir();
 	tst_exit();
 }
diff --git a/testcases/kernel/mem/mmapstress/mmapstress05.c b/testcases/kernel/mem/mmapstress/mmapstress05.c
index a8e6a44a3..e255a5049 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress05.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress05.c
@@ -204,12 +204,12 @@ int main(int argc, char *argv[])

 void ok_exit(void)
 {
-	tst_resm(TPASS, "Test passed\n");
+	tst_resm(TPASS, "Test passed");
 	tst_rmdir();
 	tst_exit();
 }

 int anyfail(void)
 {
-	tst_brkm(TFAIL, tst_rmdir, "Test failed\n");
+	tst_brkm(TFAIL, tst_rmdir, "Test failed");
 }
diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
index 133ba7479..37b7edc84 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -104,13 +104,13 @@ int main(int argc, char *argv[])
 /*****	LTP Port	*****/
 void ok_exit(void)
 {
-	tst_resm(TPASS, "Test passed\n");
+	tst_resm(TPASS, "Test passed");
 	tst_exit();
 }

 int anyfail(void)
 {
-	tst_brkm(TFAIL, NULL, "Test failed\n");
+	tst_brkm(TFAIL, NULL, "Test failed");
 }

 /*****	**	**	*****/
diff --git a/testcases/kernel/mem/mmapstress/mmapstress07.c b/testcases/kernel/mem/mmapstress/mmapstress07.c
index f99bc09e8..101c159a0 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress07.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress07.c
@@ -313,12 +313,12 @@ static int checkchars(int fd, char val, int n)
 /*****	**	LTP Port	**	*****/
 int anyfail(void)
 {
-	tst_brkm(TFAIL, tst_rmdir, "Test failed\n");
+	tst_brkm(TFAIL, tst_rmdir, "Test failed");
 }

 void ok_exit(void)
 {
-	tst_resm(TPASS, "Test passed\n");
+	tst_resm(TPASS, "Test passed");
 	tst_rmdir();
 	tst_exit();
 }
diff --git a/testcases/kernel/mem/mmapstress/mmapstress08.c b/testcases/kernel/mem/mmapstress/mmapstress08.c
index c5cf0fb9b..d4937271c 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress08.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress08.c
@@ -107,13 +107,13 @@ extern long sysconf(int name);
 /*****  LTP Port        *****/
 void ok_exit(void)
 {
-	tst_resm(TPASS, "Test passed\n");
+	tst_resm(TPASS, "Test passed");
 	tst_exit();
 }

 int anyfail(void)
 {
-	tst_brkm(TFAIL, NULL, "Test failed\n");
+	tst_brkm(TFAIL, NULL, "Test failed");
 }

 #else /* defined(__i386__) || defined(__x86_64__) */
diff --git a/testcases/kernel/mem/mmapstress/mmapstress09.c b/testcases/kernel/mem/mmapstress/mmapstress09.c
index 59033b720..2c710df1e 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress09.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress09.c
@@ -488,13 +488,13 @@ unsigned int initrand(void)
 /*****  LTP Port        *****/
 void ok_exit(void)
 {
-	tst_resm(TPASS, "Test passed\n");
+	tst_resm(TPASS, "Test passed");
 	tst_exit();
 }

 int anyfail(void)
 {
-	tst_brkm(TFAIL, NULL, "Test failed\n");
+	tst_brkm(TFAIL, NULL, "Test failed");
 }

 /*****  **      **      *****/
diff --git a/testcases/kernel/mem/mmapstress/mmapstress10.c b/testcases/kernel/mem/mmapstress/mmapstress10.c
index cf8403ef4..26ea98bc1 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress10.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress10.c
@@ -928,14 +928,14 @@ unsigned int initrand(void)
 /*****  LTP Port        *****/
 void ok_exit(void)
 {
-	tst_resm(TPASS, "Test passed\n");
+	tst_resm(TPASS, "Test passed");
 	tst_rmdir();
 	tst_exit();
 }

 int anyfail(void)
 {
-	tst_brkm(TFAIL, tst_rmdir, "Test failed\n");
+	tst_brkm(TFAIL, tst_rmdir, "Test failed");
 }

 /*****  **      **      *****/
diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
index 4d8efdb6b..e5d0ce867 100644
--- a/testcases/kernel/mem/mtest05/mmstress.c
+++ b/testcases/kernel/mem/mtest05/mmstress.c
@@ -688,7 +688,7 @@ int main(int argc, char **argv)
 				argv[0], optopt);
 			break;
 		default:
-			tst_brkm(TBROK, NULL, "%s: getopt() failed!!!\n",
+			tst_brkm(TBROK, NULL, "%s: getopt() failed!!!",
 				 argv[0]);
 		}
 	}
diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 18c4e67e2..56588e1eb 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -86,7 +86,7 @@ static void sig_handler(int signal, siginfo_t *info,
 		longjmp(jmpbuf, 1);
 		break;
 	default:
-		tst_res(TFAIL, "Unexpected signal - %d, addr: %p, exiting\n",
+		tst_res(TFAIL, "Unexpected signal - %d, addr: %p, exiting",
 			signal, info->si_addr);
 		_exit(TBROK);
 	}
diff --git a/testcases/kernel/mem/mtest07/mallocstress.c b/testcases/kernel/mem/mtest07/mallocstress.c
index 83a216dbb..fa7494e7d 100644
--- a/testcases/kernel/mem/mtest07/mallocstress.c
+++ b/testcases/kernel/mem/mtest07/mallocstress.c
@@ -167,7 +167,7 @@ static void stress_malloc(void)

 		SAFE_PTHREAD_JOIN(thread_id[thread_index], &status);
 		if ((intptr_t)status != 0) {
-			tst_res(TFAIL, "thread [%d] - exited with errors\n",
+			tst_res(TFAIL, "thread [%d] - exited with errors",
 				thread_index);
 		}
 	}
diff --git a/testcases/kernel/mem/page/page01.c b/testcases/kernel/mem/page/page01.c
index a5a11894f..9c7f3d487 100644
--- a/testcases/kernel/mem/page/page01.c
+++ b/testcases/kernel/mem/page/page01.c
@@ -89,7 +89,7 @@ char *argv[];
 			bd_arg(argv[2]);
 	} else {
 		printf("page01 [memory size (words)]  [nchild]\n");
-		tst_resm(TCONF, "\tBad arg count.\n");
+		tst_resm(TCONF, "\tBad arg count.");
 		exit(1);
 	}

@@ -121,18 +121,18 @@ char *argv[];
 			memory_pointer = malloc(memory_size * sizeof(int));
 			if (memory_pointer == 0) {
 				tst_resm(TBROK,
-					 "Cannot allocate memory - malloc failed.\n");
+					 "Cannot allocate memory - malloc failed.");
 				if (i < 2) {
 					tst_resm(TBROK,
-						 "This should not happen for first two children.\n");
+						 "This should not happen for first two children.");
 					tst_brkm(TFAIL, NULL,
-						 "Child %d - fail.\n",
+						 "Child %d - fail.",
 						 i);
 				} else {
 					tst_resm(TCONF,
-						 "This is ok for all but first two children.\n");
+						 "This is ok for all but first two children.");
 					tst_brkm(TCONF, NULL,
-						 "Child %d - ok.\n", i);
+						 "Child %d - ok.", i);
 				}
 			}
 			number_pointer = memory_pointer;
@@ -183,8 +183,8 @@ char *argv[];
 	}

 	if (count != nchild) {
-		tst_resm(TWARN, "Wrong number of children waited on.\n");
-		tst_resm(TWARN, "Count = %d, expected = %d.\n", count, nchild);
+		tst_resm(TWARN, "Wrong number of children waited on.");
+		tst_resm(TWARN, "Count = %d, expected = %d.", count, nchild);
 	}

 	anyfail();
@@ -195,7 +195,7 @@ char *argv[];
 int bd_arg(str)
 char *str;
 {
-	tst_resm(TCONF, "\tCannot parse %s as a number.\n", str);
+	tst_resm(TCONF, "\tCannot parse %s as a number.", str);
 	exit(1);
 }

@@ -254,7 +254,7 @@ void ok_exit()
  */
 void forkfail()
 {
-	tst_brkm(TBROK, tst_rmdir, "Reason: %s\n", strerror(errno));
+	tst_brkm(TBROK, tst_rmdir, "Reason: %s", strerror(errno));
 }

 /*
@@ -266,7 +266,7 @@ void forkfail()
  */
 void terror(char *message)
 {
-	tst_resm(TBROK, "Reason: %s:%s\n", message, strerror(errno));
+	tst_resm(TBROK, "Reason: %s:%s", message, strerror(errno));
 	return;
 }

@@ -279,6 +279,6 @@ void terror(char *message)
 int instress()
 {
 	tst_resm(TINFO, "System resource may be too low, fork() malloc()"
-		 " etc are likely to fail.\n");
+		 " etc are likely to fail.");
 	return 1;
 }
diff --git a/testcases/kernel/mem/page/page02.c b/testcases/kernel/mem/page/page02.c
index 08f159640..cc08ee317 100644
--- a/testcases/kernel/mem/page/page02.c
+++ b/testcases/kernel/mem/page/page02.c
@@ -95,7 +95,7 @@ char *argv[];
 			bd_arg(argv[2]);
 	} else {
 		printf("page02 [memory size (words)]  [nchild]\n");
-		tst_resm(TCONF, "\tBad arg count.\n");
+		tst_resm(TCONF, "\tBad arg count.");
 		exit(1);
 	}
 	half_memory_size = memory_size / 2;
@@ -114,9 +114,9 @@ char *argv[];
 		if ((pid = fork()) == -1) {
 			tst_resm(TBROK,
 				 "Fork failed (may be OK if under stress)");
-			tst_resm(TINFO, "System resource may be too low.\n");
+			tst_resm(TINFO, "System resource may be too low.");
 			local_flag = PASSED;
-			tst_brkm(TBROK, tst_rmdir, "Reason: %s\n",
+			tst_brkm(TBROK, tst_rmdir, "Reason: %s",
 				 strerror(errno));
 		} else if (pid == 0) {
 			/********************************/
@@ -128,23 +128,23 @@ char *argv[];

 			memory_pointer = malloc(memory_size * sizeof(int));
 			if (memory_pointer == 0) {
-				tst_resm(TBROK, "\tCannot malloc memory.\n");
+				tst_resm(TBROK, "\tCannot malloc memory.");
 				if (i < 2) {
 					tst_resm(TBROK,
-						 "\tThis should not happen to first two children.\n");
-					tst_resm(TBROK, "\tChild %d - fail.\n",
+						 "\tThis should not happen to first two children.");
+					tst_resm(TBROK, "\tChild %d - fail.",
 						 i);
 				} else {
 					tst_resm(TBROK,
-						 "\tThis is ok for all but first two children.\n");
-					tst_resm(TBROK, "\tChild %d - ok.\n",
+						 "\tThis is ok for all but first two children.");
+					tst_resm(TBROK, "\tChild %d - ok.",
 						 i);
 					kill(parent_pid, SIGUSR1);
 					_exit(0);
 				}
 				tst_resm(TBROK, "malloc fail");
 				tst_resm(TFAIL,
-					 "\t\nImpossible to allocate memory of size %d in process %d\n",
+					 "\tImpossible to allocate memory of size %d in process %d",
 					 memory_size, i);
 				kill(parent_pid, SIGUSR1);
 				tst_exit();
@@ -209,8 +209,8 @@ char *argv[];
 	}

 	if (count != nchild) {
-		tst_resm(TFAIL, "\tWrong number of children waited on.\n");
-		tst_resm(TFAIL, "\tCount = %d, expected = %d.\n",
+		tst_resm(TFAIL, "\tWrong number of children waited on.");
+		tst_resm(TFAIL, "\tCount = %d, expected = %d.",
 			 count, nchild);
 	}

@@ -224,7 +224,7 @@ char *argv[];
 int bd_arg(str)
 char *str;
 {
-	tst_brkm(TCONF, NULL, "\tCannot parse %s as a number.\n", str);
+	tst_brkm(TCONF, NULL, "\tCannot parse %s as a number.", str);
 }

 int chld()
diff --git a/testcases/kernel/mem/shmt/shmt02.c b/testcases/kernel/mem/shmt/shmt02.c
index 2541452d4..b33a042f9 100644
--- a/testcases/kernel/mem/shmt/shmt02.c
+++ b/testcases/kernel/mem/shmt/shmt02.c
@@ -67,7 +67,7 @@ int main(void)
 	if ((shmid = shmget(key, 16 * K_1, IPC_CREAT | 0666)) < 0) {
 		perror("shmget");
 		tst_brkm(TFAIL, NULL,
-			 "shmget Failed: shmid = %d, errno = %d\n",
+			 "shmget Failed: shmid = %d, errno = %d",
 			 shmid, errno);
 	}

@@ -79,7 +79,7 @@ int main(void)

 	if (cp == (char *)-1) {
 		perror("shmat");
-		tst_resm(TFAIL, "shmat Failed: shmid = %d, errno = %d\n",
+		tst_resm(TFAIL, "shmat Failed: shmid = %d, errno = %d",
 			 shmid, errno);
 		rm_shm(shmid);
 		tst_exit();
@@ -96,7 +96,7 @@ int main(void)

 	if (*cp != '1' || *(cp + 1) != '2') {
 		tst_resm(TFAIL,
-			 "Error in shared memory contents: shmid = %d\n",
+			 "Error in shared memory contents: shmid = %d",
 			 shmid);
 	}

@@ -113,7 +113,7 @@ static int rm_shm(int shmid)
 		perror("shmctl");
 		tst_brkm(TFAIL,
 			 NULL,
-			 "shmctl Failed to remove: shmid = %d, errno = %d\n",
+			 "shmctl Failed to remove: shmid = %d, errno = %d",
 			 shmid, errno);
 	}
 	return (0);
diff --git a/testcases/kernel/mem/shmt/shmt03.c b/testcases/kernel/mem/shmt/shmt03.c
index ceb08d578..08c27ce02 100644
--- a/testcases/kernel/mem/shmt/shmt03.c
+++ b/testcases/kernel/mem/shmt/shmt03.c
@@ -68,7 +68,7 @@ int main(void)
 	if ((shmid = shmget(key, 16 * K_1, IPC_CREAT | 0666)) < 0) {
 		perror("shmget");
 		tst_brkm(TFAIL, NULL,
-			 "shmget Failed: shmid = %d, errno = %d\n",
+			 "shmget Failed: shmid = %d, errno = %d",
 			 shmid, errno);
 	}

@@ -78,7 +78,7 @@ int main(void)

 	if ((cp1 = shmat(shmid, NULL, 0)) == (char *)-1) {
 		perror("shmat");
-		tst_resm(TFAIL, "shmat Failed: shmid = %d, errno = %d\n",
+		tst_resm(TFAIL, "shmat Failed: shmid = %d, errno = %d",
 			 shmid, errno);
 	} else {
 		*cp1 = '1';
@@ -92,13 +92,13 @@ int main(void)

 	if ((cp2 = shmat(shmid, NULL, 0)) == (char *)-1) {
 		perror("shmat");
-		tst_resm(TFAIL, "shmat Failed: shmid = %d, errno = %d\n",
+		tst_resm(TFAIL, "shmat Failed: shmid = %d, errno = %d",
 			 shmid, errno);
 	} else {
 		second_attach = SUCCESSFUL;
 		if ((*cp2 != '1' || *(cp2 + 5 * K_1) != '2') &&
 		    first_attach == SUCCESSFUL) {
-			tst_resm(TFAIL, "Error: Shared memory contents\n");
+			tst_resm(TFAIL, "Error: Shared memory contents");
 		}
 	}

@@ -111,7 +111,7 @@ int main(void)
 	if (first_attach && second_attach) {
 		if (*cp2 != '1' || *(cp2 + 5 * K_1) != '2' ||
 		    *cp1 != '1' || *(cp1 + 5 * K_1) != '2') {
-			tst_resm(TFAIL, "Error: Shared memory contents\n");
+			tst_resm(TFAIL, "Error: Shared memory contents");
 		}
 	}

@@ -126,7 +126,7 @@ static int rm_shm(int shmid)
 		perror("shmctl");
 		tst_brkm(TFAIL,
 			 NULL,
-			 "shmctl Failed to remove: shmid = %d, errno = %d\n",
+			 "shmctl Failed to remove: shmid = %d, errno = %d",
 			 shmid, errno);
 	}
 	return (0);
diff --git a/testcases/kernel/mem/shmt/shmt04.c b/testcases/kernel/mem/shmt/shmt04.c
index b2682dac8..c9a654e7d 100644
--- a/testcases/kernel/mem/shmt/shmt04.c
+++ b/testcases/kernel/mem/shmt/shmt04.c
@@ -87,7 +87,7 @@ int main(void)

 	if ((shmid = shmget(key, SIZE, IPC_CREAT | 0666)) < 0) {
 		perror("shmget");
-		tst_resm(TFAIL, "Error: shmget: shmid = %d, errno = %d\n",
+		tst_resm(TFAIL, "Error: shmget: shmid = %d, errno = %d",
 			 shmid, errno);
 		/*
 		 * kill the child if parent failed to do the attach
@@ -99,7 +99,7 @@ int main(void)
 		if (cp == (char *)-1) {
 			perror("shmat");
 			tst_resm(TFAIL,
-				 "Error: shmat: shmid = %d, errno = %d\n",
+				 "Error: shmat: shmid = %d, errno = %d",
 				 shmid, errno);

 /* kill the child if parent failed to do the attch */
@@ -121,7 +121,7 @@ int main(void)
 		if (pid1 != pid) {
 			tst_resm(TFAIL, "Waited on the wrong child");
 			tst_resm(TFAIL,
-				 "Error: wait_status = %d, pid1= %d\n", status,
+				 "Error: wait_status = %d, pid1= %d", status,
 				 pid1);
 		}
 	}
@@ -155,7 +155,7 @@ int child(void)
 	if ((shmid = shmget(key, SIZE, 0)) < 0) {
 		perror("shmget:child process");
 		tst_resm(TFAIL,
-			 "Error: shmget: errno=%d, shmid=%d, child_pid=%d\n",
+			 "Error: shmget: errno=%d, shmid=%d, child_pid=%d",
 			 errno, shmid, chld_pid);
 	} else {
 		cp = shmat(shmid, NULL, 0);
@@ -163,20 +163,20 @@ int child(void)
 		if (cp == (char *)-1) {
 			perror("shmat:child process");
 			tst_resm(TFAIL,
-				 "Error: shmat: errno=%d, shmid=%d, child_pid=%d\n",
+				 "Error: shmat: errno=%d, shmid=%d, child_pid=%d",
 				 errno, shmid, chld_pid);
 		} else {
 			if (*cp != 'A') {
-				tst_resm(TFAIL, "child: not A\n");
+				tst_resm(TFAIL, "child: not A");
 			}
 			if (*(cp + 1) != 'B') {
-				tst_resm(TFAIL, "child: not B\n");
+				tst_resm(TFAIL, "child: not B");
 			}
 			if (*(cp + 2) != 'C') {
-				tst_resm(TFAIL, "child: not C\n");
+				tst_resm(TFAIL, "child: not C");
 			}
 			if (*(cp + 8192) != 0) {
-				tst_resm(TFAIL, "child: not 0\n");
+				tst_resm(TFAIL, "child: not 0");
 			}
 		}

@@ -190,7 +190,7 @@ static int rm_shm(int shmid)
 		perror("shmctl");
 		tst_brkm(TFAIL,
 			 NULL,
-			 "shmctl Failed to remove: shmid = %d, errno = %d\n",
+			 "shmctl Failed to remove: shmid = %d, errno = %d",
 			 shmid, errno);
 	}
 	return (0);
diff --git a/testcases/kernel/mem/shmt/shmt06.c b/testcases/kernel/mem/shmt/shmt06.c
index dd69de7e7..e88ac45c9 100644
--- a/testcases/kernel/mem/shmt/shmt06.c
+++ b/testcases/kernel/mem/shmt/shmt06.c
@@ -86,7 +86,7 @@ int main(void)

 	if ((shmid = shmget(key, SIZE, IPC_CREAT | 0666)) < 0) {
 		perror("shmget");
-		tst_resm(TFAIL, "Error: shmget: shmid = %d, errno = %d\n",
+		tst_resm(TFAIL, "Error: shmget: shmid = %d, errno = %d",
 			 shmid, errno);
 		/*
 		 * kill the child if parent failed to do the attach
@@ -98,7 +98,7 @@ int main(void)
 		if (cp == (char *)-1) {
 			perror("shmat");
 			tst_resm(TFAIL,
-				 "Error: shmat: shmid = %d, errno = %d\n",
+				 "Error: shmat: shmid = %d, errno = %d",
 				 shmid, errno);

 			/* kill the child if parent failed to do the attch */
@@ -120,7 +120,7 @@ int main(void)
 		if (pid1 != pid) {
 			tst_resm(TFAIL, "Waited on the wrong child");
 			tst_resm(TFAIL,
-				 "Error: wait_status = %d, pid1= %d\n", status,
+				 "Error: wait_status = %d, pid1= %d", status,
 				 pid1);
 		}
 	}
@@ -153,7 +153,7 @@ int child(void)
 	if ((shmid = shmget(key, SIZE, 0)) < 0) {
 		perror("shmget:child process");
 		tst_resm(TFAIL,
-			 "Error: shmget: errno=%d, shmid=%d, child_pid=%d\n",
+			 "Error: shmget: errno=%d, shmid=%d, child_pid=%d",
 			 errno, shmid, chld_pid);
 	} else {
 		cp = shmat(shmid, NULL, 0);
@@ -161,20 +161,20 @@ int child(void)
 		if (cp == (char *)-1) {
 			perror("shmat:child process");
 			tst_resm(TFAIL,
-				 "Error: shmat: errno=%d, shmid=%d, child_pid=%d\n",
+				 "Error: shmat: errno=%d, shmid=%d, child_pid=%d",
 				 errno, shmid, chld_pid);
 		} else {
 			if (*cp != 'A') {
-				tst_resm(TFAIL, "child: not A\n");
+				tst_resm(TFAIL, "child: not A");
 			}
 			if (*(cp + 1) != 'B') {
-				tst_resm(TFAIL, "child: not B\n");
+				tst_resm(TFAIL, "child: not B");
 			}
 			if (*(cp + 2) != 'C') {
-				tst_resm(TFAIL, "child: not C\n");
+				tst_resm(TFAIL, "child: not C");
 			}
 			if (*(cp + 8192) != 0) {
-				tst_resm(TFAIL, "child: not 0\n");
+				tst_resm(TFAIL, "child: not 0");
 			}
 		}

@@ -187,20 +187,20 @@ int child(void)
 		if (cp == (char *)-1) {
 			perror("shmat:child process");
 			tst_resm(TFAIL,
-				 "Error: shmat: errno=%d, shmid=%d, child_pid=%d\n",
+				 "Error: shmat: errno=%d, shmid=%d, child_pid=%d",
 				 errno, shmid, chld_pid);
 		} else {
 			if (*cp != 'A') {
-				tst_resm(TFAIL, "child: not A\n");
+				tst_resm(TFAIL, "child: not A");
 			}
 			if (*(cp + 1) != 'B') {
-				tst_resm(TFAIL, "child: not B\n");
+				tst_resm(TFAIL, "child: not B");
 			}
 			if (*(cp + 2) != 'C') {
-				tst_resm(TFAIL, "child: not C\n");
+				tst_resm(TFAIL, "child: not C");
 			}
 			if (*(cp + 8192) != 0) {
-				tst_resm(TFAIL, "child: not 0\n");
+				tst_resm(TFAIL, "child: not 0");
 			}
 		}
 	}
@@ -213,7 +213,7 @@ static int rm_shm(int shmid)
 		perror("shmctl");
 		tst_brkm(TFAIL,
 			 NULL,
-			 "shmctl Failed to remove: shmid = %d, errno = %d\n",
+			 "shmctl Failed to remove: shmid = %d, errno = %d",
 			 shmid, errno);
 	}
 	return (0);
diff --git a/testcases/kernel/mem/shmt/shmt07.c b/testcases/kernel/mem/shmt/shmt07.c
index e4aa9dc36..064343f5d 100644
--- a/testcases/kernel/mem/shmt/shmt07.c
+++ b/testcases/kernel/mem/shmt/shmt07.c
@@ -72,7 +72,7 @@ int main(void)
 	if ((shmid = shmget(key, SIZE, IPC_CREAT | 0666)) < 0) {
 		perror("shmget");
 		tst_brkm(TFAIL, NULL,
-			 "Error: shmget: shmid = %d, errno = %d\n",
+			 "Error: shmget: shmid = %d, errno = %d",
 			 shmid, errno);
 	}
 	cp = shmat(shmid, NULL, 0);
@@ -80,7 +80,7 @@ int main(void)
 	if (cp == (char *)-1) {
 		perror("shmat");
 		tst_resm(TFAIL,
-			 "Error: shmat: shmid = %d, errno = %d\n",
+			 "Error: shmat: shmid = %d, errno = %d",
 			 shmid, errno);
 		rm_shm(shmid);
 		tst_exit();
@@ -100,10 +100,10 @@ int main(void)

 	case 0:
 		if (*cp != '1') {
-			tst_resm(TFAIL, "Error: not 1\n");
+			tst_resm(TFAIL, "Error: not 1");
 		}
 		if (*(cp + 1) != '2') {
-			tst_resm(TFAIL, "Error: not 2\n");
+			tst_resm(TFAIL, "Error: not 2");
 		}
 		tst_exit();
 	}
@@ -124,7 +124,7 @@ static int rm_shm(int shmid)
 		perror("shmctl");
 		tst_brkm(TFAIL,
 			 NULL,
-			 "shmctl Failed to remove: shmid = %d, errno = %d\n",
+			 "shmctl Failed to remove: shmid = %d, errno = %d",
 			 shmid, errno);
 	}
 	return (0);
diff --git a/testcases/kernel/mem/shmt/shmt09.c b/testcases/kernel/mem/shmt/shmt09.c
index 5f8a08659..347244115 100644
--- a/testcases/kernel/mem/shmt/shmt09.c
+++ b/testcases/kernel/mem/shmt/shmt09.c
@@ -81,13 +81,13 @@ int main(void)

 	if ((unsigned long)sbrk(16384) >= (-4095UL)) {
 		perror("sbrk");
-		tst_brkm(TFAIL, NULL, "Error: sbrk failed, errno = %d\n",
+		tst_brkm(TFAIL, NULL, "Error: sbrk failed, errno = %d",
 			 errno);
 	}

 	if ((unsigned long)sbrk(-4097) >= (-4095UL)) {
 		perror("sbrk");
-		tst_brkm(TFAIL, NULL, "Error: sbrk failed, errno = %d\n",
+		tst_brkm(TFAIL, NULL, "Error: sbrk failed, errno = %d",
 			 errno);
 	}

@@ -95,7 +95,7 @@ int main(void)
 		perror("shmget");
 		tst_brkm(TFAIL,
 			 NULL,
-			 "Error: shmget Failed, shmid = %d, errno = %d\n",
+			 "Error: shmget Failed, shmid = %d, errno = %d",
 			 shmid, errno);
 	}

@@ -103,7 +103,7 @@ int main(void)
 	if (c1 == (char *)-1) {
 		perror("shmat");
 		tst_resm(TFAIL,
-			 "Error: shmat Failed, shmid = %d, errno = %d\n",
+			 "Error: shmat Failed, shmid = %d, errno = %d",
 			 shmid, errno);
 		rm_shm(shmid);
 		tst_exit();
@@ -115,7 +115,7 @@ int main(void)

 	if ((unsigned long)sbrk(32 * K_1) >= (-4095UL)) {
 		perror("sbrk");
-		tst_resm(TFAIL, "Error: sbrk failed, errno = %d\n", errno);
+		tst_resm(TFAIL, "Error: sbrk failed, errno = %d", errno);
 		rm_shm(shmid);
 		tst_exit();
 	}
@@ -135,7 +135,7 @@ int main(void)

 	if ((unsigned long)sbrk(-16000) >= (-4095UL)) {
 		perror("sbrk");
-		tst_resm(TFAIL, "Error: sbrk failed, errno = %d\n", errno);
+		tst_resm(TFAIL, "Error: sbrk failed, errno = %d", errno);
 		rm_shm(shmid);
 		tst_exit();
 	}
@@ -152,7 +152,7 @@ int main(void)
 	if (c3 == (char *)-1) {
 		perror("shmat1");
 		tst_resm(TFAIL,
-			 "Error: shmat Failed, shmid = %d, errno = %d\n",
+			 "Error: shmat Failed, shmid = %d, errno = %d",
 			 shmid, errno);
 		rm_shm(shmid);
 		tst_exit();
@@ -164,7 +164,7 @@ int main(void)
 #if defined (__ia64__) || defined(__mips__) || defined(__hppa__) || defined(__arm__) || defined(__aarch64__)
 	while ((vp = sbrk(INCREMENT)) != (void *)-1) ;
 	if (errno != ENOMEM) {
-		tst_resm(TFAIL, "Error: sbrk failed, errno = %d\n", errno);
+		tst_resm(TFAIL, "Error: sbrk failed, errno = %d", errno);
 		rm_shm(shmid);
 		tst_exit();
 	}
@@ -192,7 +192,7 @@ static int rm_shm(int shmid)
 		perror("shmctl");
 		tst_brkm(TFAIL,
 			 NULL,
-			 "shmctl Failed to remove: shmid = %d, errno = %d\n",
+			 "shmctl Failed to remove: shmid = %d, errno = %d",
 			 shmid, errno);
 	}
 	return (0);
diff --git a/testcases/kernel/mem/shmt/shmt10.c b/testcases/kernel/mem/shmt/shmt10.c
index 9c4fcfffe..c63bb1592 100644
--- a/testcases/kernel/mem/shmt/shmt10.c
+++ b/testcases/kernel/mem/shmt/shmt10.c
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])

 	if ((shmid = shmget(key, SIZE, IPC_CREAT | 0666)) < 0) {
 		tst_resm(TFAIL, "shmget");
-		tst_brkm(TFAIL, NULL, "Error: shmid = %d\n", shmid);
+		tst_brkm(TFAIL, NULL, "Error: shmid = %d", shmid);
 	}

 	pid = fork();
@@ -110,7 +110,7 @@ int main(int argc, char *argv[])
 	for (i = 0; i < iter; i++) {
 		if ((c1 = shmat(shmid, NULL, 0)) == (char *)-1) {
 			tst_resm(TFAIL,
-				 "Error shmat: iter %d, shmid = %d\n", i,
+				 "Error shmat: iter %d, shmid = %d", i,
 				 shmid);
 			break;
 		}
@@ -133,7 +133,7 @@ static int rm_shm(int shmid)
 		perror("shmctl");
 		tst_brkm(TFAIL,
 			 NULL,
-			 "shmctl Failed to remove: shmid = %d, errno = %d\n",
+			 "shmctl Failed to remove: shmid = %d, errno = %d",
 			 shmid, errno);
 	}
 	return (0);
@@ -148,7 +148,7 @@ static int child(int iter)
 		if ((c1 = shmat(shmid, NULL, 0)) == (char *)-1) {
 			tst_brkm(TFAIL,
 				 NULL,
-				 "Error:child proc: shmat: iter %d, shmid = %d\n",
+				 "Error:child proc: shmat: iter %d, shmid = %d",
 				 i, shmid);
 		}
 		if (shmdt(c1) < 0) {
diff --git a/testcases/kernel/mem/vmtests/data_space.c b/testcases/kernel/mem/vmtests/data_space.c
index b873140b5..c0aa1bf0e 100644
--- a/testcases/kernel/mem/vmtests/data_space.c
+++ b/testcases/kernel/mem/vmtests/data_space.c
@@ -177,7 +177,7 @@ int runtest()
 			 status);
 #endif
 		if (status) {
-			tst_resm(TFAIL, "\tTest failed, expected 0 exit.\n");
+			tst_resm(TFAIL, "\tTest failed, expected 0 exit.");
 			local_flag = FAILED;
 		}
 		++count;
@@ -188,7 +188,7 @@ int runtest()
 	 */

 	if (count != nchild) {
-		tst_resm(TFAIL, "\tWrong # children waited on, count = %d\n",
+		tst_resm(TFAIL, "\tWrong # children waited on, count = %d",
 			 count);
 		local_flag = FAILED;
 	}
@@ -298,7 +298,7 @@ int me;
 			if ((bits[chunk / 8] & (1 << (chunk % 8))) == 0) {
 				if (memcmp(buf, zero_buf, csize)) {
 					tst_resm(TFAIL,
-						 "\t%s[%d] bad verify @ %d (%p) for val %d count %d, should be 0x%x.\n",
+						 "\t%s[%d] bad verify @ %d (%p) for val %d count %d, should be 0x%x.",
 						 prog, me, chunk, buf, val,
 						 count, val - 1);
 					tst_resm(TINFO, "\tPrev ");
@@ -315,7 +315,7 @@ int me;
 				++collide;
 				if (memcmp(buf, val_buf, csize)) {
 					tst_resm(TFAIL,
-						 "\t%s[%d] bad verify @ %d (%p) for val %d count %d.\n",
+						 "\t%s[%d] bad verify @ %d (%p) for val %d count %d.",
 						 prog, me, chunk, buf, val,
 						 count);
 					tst_resm(TINFO, "\tPrev ");
@@ -486,14 +486,14 @@ int okexit(me)
 int me;
 {
 	kill(parent_pid, SIGUSR1);
-	tst_resm(TINFO, "\tChild [%d] - cannot malloc buffer - exiting.\n", me);
+	tst_resm(TINFO, "\tChild [%d] - cannot malloc buffer - exiting.", me);
 	if (me) {
-		tst_resm(TINFO, "\tThis is ok - probably swap space limit.\n");
+		tst_resm(TINFO, "\tThis is ok - probably swap space limit.");
 		tst_exit();
 	} else {
 		tst_brkm(TBROK,
 			 NULL,
-			 "\tThis is not ok for first child - check parameters.\n");
+			 "\tThis is not ok for first child - check parameters.");
 	}

 	return 0;
diff --git a/testcases/kernel/mem/vmtests/stack_space.c b/testcases/kernel/mem/vmtests/stack_space.c
index b27c2825d..26f1c6fa7 100644
--- a/testcases/kernel/mem/vmtests/stack_space.c
+++ b/testcases/kernel/mem/vmtests/stack_space.c
@@ -103,14 +103,14 @@ char *argv[];
 			bd_arg(argv[i - 1]);
 		if (nchild > MAXCHILD) {
 			tst_brkm(TBROK, NULL,
-				 "Too many children, max is %d\n",
+				 "Too many children, max is %d",
 				 MAXCHILD);
 		}
 		if (sscanf(argv[i++], "%d", &csize) != 1)
 			bd_arg(argv[i - 1]);
 		if (csize > MAXSIZE) {
 			tst_brkm(TBROK, NULL,
-				 "Chunk size too large , max is %d\n",
+				 "Chunk size too large , max is %d",
 				 MAXSIZE);
 		}
 		if (sscanf(argv[i++], "%d", &iterations) != 1)
@@ -129,7 +129,7 @@ int bd_arg(str)
 char *str;
 {
 	tst_brkm(TCONF, NULL,
-		 "Bad argument - %s - could not parse as number.\n",
+		 "Bad argument - %s - could not parse as number.",
 		 str);
 }

@@ -148,8 +148,8 @@ int runtest()
 		if (child < 0) {
 			tst_resm(TBROK,
 				 "Fork failed (may be OK if under stress)");
-			tst_resm(TINFO, "System resource may be too low.\n");
-			tst_brkm(TBROK, tst_rmdir, "Reason: %s\n",
+			tst_resm(TINFO, "System resource may be too low.");
+			tst_brkm(TBROK, tst_rmdir, "Reason: %s",
 				 strerror(errno));

 		}
@@ -166,7 +166,7 @@ int runtest()
 			 status);
 #endif
 		if (status) {
-			tst_resm(TINFO, "\tFailed - expected 0 exit status.\n");
+			tst_resm(TINFO, "\tFailed - expected 0 exit status.");
 			local_flag = FAILED;
 		}
 		++count;
@@ -177,7 +177,7 @@ int runtest()
 	 */

 	if (count != nchild) {
-		tst_resm(TINFO, "\tWrong # children waited on, count = %d\n",
+		tst_resm(TINFO, "\tWrong # children waited on, count = %d",
 			 count);
 		local_flag = FAILED;
 	}
@@ -220,7 +220,7 @@ int dotest(int testers, int me)
 	zero_buf = (char *)(malloc(csize));

 	if (bits == 0 || val_buf == 0 || zero_buf == 0) {
-		tst_brkm(TFAIL, NULL, "\tmalloc failed, pid: %d\n", getpid());
+		tst_brkm(TFAIL, NULL, "\tmalloc failed, pid: %d", getpid());
 	}

 	/*
@@ -266,7 +266,7 @@ int dotest(int testers, int me)
 			if ((bits[chunk / 8] & (1 << (chunk % 8))) == 0) {
 				if (memcmp(buf, zero_buf, csize)) {
 					tst_resm(TFAIL,
-						 "%s[%d] bad verify @ %d (%p) for val %d count %d, should be 0.\n",
+						 "%s[%d] bad verify @ %d (%p) for val %d count %d, should be 0.",
 						 prog, me, chunk, buf, val,
 						 count);
 					tst_resm(TINFO, "Prev ");
@@ -283,7 +283,7 @@ int dotest(int testers, int me)
 				++collide;
 				if (memcmp(buf, val_buf, csize)) {
 					tst_resm(TFAIL,
-						 "%s[%d] bad verify @ %d (%p) for val %d count %d.\n",
+						 "%s[%d] bad verify @ %d (%p) for val %d count %d.",
 						 prog, me, chunk, buf, val,
 						 count);
 					tst_resm(TINFO, "Prev ");
diff --git a/testcases/kernel/sched/pthreads/pth_str01.c b/testcases/kernel/sched/pthreads/pth_str01.c
index 15e83600d..93843c22d 100644
--- a/testcases/kernel/sched/pthreads/pth_str01.c
+++ b/testcases/kernel/sched/pthreads/pth_str01.c
@@ -390,7 +390,7 @@ int doit(c_info * parent)
 			if ((rc =
 			     pthread_create(&(info_p->threads[child]), &attr,
 					    (void *)doit, (void *)info_p))) {
-				tst_resm(TINFO, "pthread_create (doit): %s\n",
+				tst_resm(TINFO, "pthread_create (doit): %s",
 					 strerror(rc));
 				testexit(3);
 			} else {
@@ -553,7 +553,7 @@ int main(int argc, char *argv[])
 	 * Initialize node mutex.
 	 */
 	if ((rc = pthread_mutex_init(&node_mutex, NULL))) {
-		tst_resm(TINFO, "pthread_mutex_init(node_mutex): %s\n",
+		tst_resm(TINFO, "pthread_mutex_init(node_mutex): %s",
 			 strerror(rc));
 		testexit(7);
 	}
@@ -562,7 +562,7 @@ int main(int argc, char *argv[])
 	 * Initialize node condition variable.
 	 */
 	if ((rc = pthread_cond_init(&node_condvar, NULL))) {
-		tst_resm(TINFO, "pthread_cond_init(node_condvar): %s\n",
+		tst_resm(TINFO, "pthread_cond_init(node_condvar): %s",
 			 strerror(rc));
 		testexit(8);
 	}
@@ -606,14 +606,14 @@ int main(int argc, char *argv[])

 		if ((rc = pthread_mutex_init(&child_info[ind].child_mutex,
 					     NULL))) {
-			tst_resm(TINFO, "pthread_mutex_init child_mutex: %s\n",
+			tst_resm(TINFO, "pthread_mutex_init child_mutex: %s",
 				 strerror(rc));
 			testexit(13);
 		}

 		if ((rc = pthread_mutex_init(&child_info[ind].talk_mutex,
 					     NULL))) {
-			tst_resm(TINFO, "pthread_mutex_init talk_mutex: %s\n",
+			tst_resm(TINFO, "pthread_mutex_init talk_mutex: %s",
 				 strerror(rc));
 			testexit(14);
 		}
@@ -628,7 +628,7 @@ int main(int argc, char *argv[])

 		if ((rc = pthread_cond_init(&child_info[ind].talk_condvar,
 					    NULL))) {
-			tst_resm(TINFO, "pthread_cond_init talk_condvar: %s\n",
+			tst_resm(TINFO, "pthread_cond_init talk_condvar: %s",
 				 strerror(rc));
 			testexit(16);
 		}
@@ -644,7 +644,7 @@ int main(int argc, char *argv[])
 		 "Creating root thread attributes via pthread_attr_init.");

 	if ((rc = pthread_attr_init(&attr))) {
-		tst_resm(TINFO, "pthread_attr_init: %s\n", strerror(rc));
+		tst_resm(TINFO, "pthread_attr_init: %s", strerror(rc));
 		testexit(17);
 	}

@@ -655,7 +655,7 @@ int main(int argc, char *argv[])
 	 */
 	if ((rc = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE))
 	    ) {
-		tst_resm(TINFO, "pthread_attr_setdetachstate: %s\n",
+		tst_resm(TINFO, "pthread_attr_setdetachstate: %s",
 			 strerror(rc));
 		testexit(18);
 	}
@@ -663,7 +663,7 @@ int main(int argc, char *argv[])
 	tst_resm(TINFO, "Creating root thread via pthread_create.");

 	if ((rc = pthread_create(&root_thread, &attr, (void *)doit, NULL))) {
-		tst_resm(TINFO, "pthread_create: %s\n", strerror(rc));
+		tst_resm(TINFO, "pthread_create: %s", strerror(rc));
 		testexit(19);
 	}

@@ -676,7 +676,7 @@ int main(int argc, char *argv[])
 	 * Wait for the root child to exit.
 	 */
 	if ((rc = pthread_join(root_thread, NULL))) {
-		tst_resm(TINFO, "pthread_join: %s\n", strerror(rc));
+		tst_resm(TINFO, "pthread_join: %s", strerror(rc));
 		testexit(20);
 	}

diff --git a/testcases/kernel/security/cap_bound/cap_bounds_rw.c b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
index f715c703d..503853c5b 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_rw.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
@@ -54,11 +54,11 @@ int check_remaining_caps(int lastdropped)
 		if (ret == -1) {
 			tst_brkm(TBROK,
 				 NULL,
-				 "Failed to read bounding set during sanity check\n");
+				 "Failed to read bounding set during sanity check");
 		}
 		if (ret == 1) {
 			tst_resm(TFAIL,
-				 "Bit %d should have been dropped but wasn't\n",
+				 "Bit %d should have been dropped but wasn't",
 				 i);
 			return i;
 		}
@@ -74,11 +74,11 @@ int check_remaining_caps(int lastdropped)
 		if (ret == -1) {
 			tst_brkm(TBROK,
 				 NULL,
-				 "Failed to read bounding set during sanity check\n");
+				 "Failed to read bounding set during sanity check");
 		}
 		if (ret == 0) {
 			tst_resm(TFAIL,
-				 "Bit %d wasn't yet dropped, but isn't in bounding set\n",
+				 "Bit %d wasn't yet dropped, but isn't in bounding set",
 				 i);
 			return -i;
 		}
@@ -107,7 +107,7 @@ int main(void)
 #endif
 	if (ret != -1) {
 		tst_brkm(TFAIL, NULL,
-			 "prctl(PR_CAPBSET_DROP, -1) returned %d\n",
+			 "prctl(PR_CAPBSET_DROP, -1) returned %d",
 			 ret);
 	}
 	/* Ideally I'd check CAP_LAST_CAP+1, but userspace
@@ -123,9 +123,9 @@ int main(void)
 	ret = -1;
 #endif
 	if (ret != -1) {
-		tst_resm(TFAIL, "prctl(PR_CAPBSET_DROP, %d) returned %d\n",
+		tst_resm(TFAIL, "prctl(PR_CAPBSET_DROP, %d) returned %d",
 			 max(INSANE, CAP_LAST_CAP + 1), ret);
-		tst_resm(TINFO, " %d is should not exist\n",
+		tst_resm(TINFO, " %d is should not exist",
 			 max(INSANE, CAP_LAST_CAP + 1));
 		tst_exit();
 	}
@@ -138,26 +138,26 @@ int main(void)
 #endif
 		if (ret != 0) {
 			tst_resm(TFAIL,
-				 "prctl(PR_CAPBSET_DROP, %d) returned %d\n", i,
+				 "prctl(PR_CAPBSET_DROP, %d) returned %d", i,
 				 ret);
 			if (ret == -1)
-				tst_resm(TINFO, "errno was %d\n", errno);
+				tst_resm(TINFO, "errno was %d", errno);
 			tst_exit();
 		}
 		ret = check_remaining_caps(i);
 		if (ret > 0) {
 			tst_brkm(TFAIL,
 				 NULL,
-				 "after dropping bits 0..%d, %d was still in bounding set\n",
+				 "after dropping bits 0..%d, %d was still in bounding set",
 				 i, ret);
 		} else if (ret < 0) {
 			tst_brkm(TFAIL,
 				 NULL,
-				 "after dropping bits 0..%d, %d was not in bounding set\n",
+				 "after dropping bits 0..%d, %d was not in bounding set",
 				 i, -ret);
 		}
 	}
-	tst_resm(TPASS, "PR_CAPBSET_DROP tests passed\n");
+	tst_resm(TPASS, "PR_CAPBSET_DROP tests passed");
 #else
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
diff --git a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
index 744c5d430..5378907aa 100644
--- a/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
+++ b/testcases/kernel/security/cap_bound/cap_bset_inh_bounds.c
@@ -52,7 +52,7 @@ int main(void)
 	/* make sure we have the capability now */
 	ret = prctl(PR_CAPBSET_READ, CAP_SYS_ADMIN);
 	if (ret != 1) {
-		tst_brkm(TBROK, NULL, "Not starting with CAP_SYS_ADMIN\n");
+		tst_brkm(TBROK, NULL, "Not starting with CAP_SYS_ADMIN");
 	}

 	/* Make sure it's in pI */
@@ -60,21 +60,21 @@ int main(void)
 	if (!cur) {
 		tst_brkm(TBROK,
 			 NULL,
-			 "Failed to create cap_sys_admin+i cap_t (errno %d)\n",
+			 "Failed to create cap_sys_admin+i cap_t (errno %d)",
 			 errno);
 	}
 	ret = cap_set_proc(cur);
 	if (ret) {
 		tst_brkm(TBROK,
 			 NULL,
-			 "Failed to cap_set_proc with cap_sys_admin+i (ret %d errno %d)\n",
+			 "Failed to cap_set_proc with cap_sys_admin+i (ret %d errno %d)",
 			 ret, errno);
 	}
 	cap_free(cur);
 	cur = cap_get_proc();
 	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
 	if (ret || f != CAP_SET) {
-		tst_brkm(TBROK, NULL, "Failed to add CAP_SYS_ADMIN to pI\n");
+		tst_brkm(TBROK, NULL, "Failed to add CAP_SYS_ADMIN to pI");
 	}
 	cap_free(cur);

@@ -82,8 +82,8 @@ int main(void)
 	ret = prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN);
 	if (ret) {
 		tst_resm(TFAIL,
-			 "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
-		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
+			 "Failed to drop CAP_SYS_ADMIN from bounding set.");
+		tst_resm(TINFO, "(ret=%d, errno %d)", ret, errno);
 		tst_exit();
 	}

@@ -93,22 +93,22 @@ int main(void)
 	if (ret || f != CAP_SET) {
 		tst_brkm(TFAIL,
 			 NULL,
-			 "CAP_SYS_ADMIN not in pI after dropping from bounding set\n");
+			 "CAP_SYS_ADMIN not in pI after dropping from bounding set");
 	}
 	tst_resm(TPASS,
-		 "CAP_SYS_ADMIN remains in pI after removing from bounding set\n");
+		 "CAP_SYS_ADMIN remains in pI after removing from bounding set");

 	tmpcap = cap_dup(cur);
 	v[0] = CAP_SYS_ADMIN;
 	ret = cap_set_flag(tmpcap, CAP_INHERITABLE, 1, v, CAP_CLEAR);
 	if (ret) {
 		tst_brkm(TFAIL, NULL,
-			 "Failed to drop CAP_SYS_ADMIN from cap_t\n");
+			 "Failed to drop CAP_SYS_ADMIN from cap_t");
 	}
 	ret = cap_set_proc(tmpcap);
 	if (ret) {
 		tst_brkm(TFAIL, NULL,
-			 "Failed to drop CAP_SYS_ADMIN from pI\n");
+			 "Failed to drop CAP_SYS_ADMIN from pI");
 	}
 	cap_free(tmpcap);
 	/* test 2: can we put it back in pI? */
@@ -116,12 +116,12 @@ int main(void)
 	if (ret == 0) {		/* success means pI was not bounded by X */
 		tst_brkm(TFAIL,
 			 NULL,
-			 "Managed to put CAP_SYS_ADMIN back into pI though not in X\n");
+			 "Managed to put CAP_SYS_ADMIN back into pI though not in X");
 	}
 	cap_free(cur);

 	tst_resm(TPASS,
-		 "Couldn't put CAP_SYS_ADMIN back into pI when not in bounding set\n");
+		 "Couldn't put CAP_SYS_ADMIN back into pI when not in bounding set");
 #else /* HAVE_LIBCAP */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
diff --git a/testcases/kernel/security/cap_bound/check_pe.c b/testcases/kernel/security/cap_bound/check_pe.c
index c4453ecf8..560d70ff0 100644
--- a/testcases/kernel/security/cap_bound/check_pe.c
+++ b/testcases/kernel/security/cap_bound/check_pe.c
@@ -49,33 +49,33 @@ int main(int argc, char *argv[])
 	int n;

 	if (argc != 2) {
-		tst_brkm(TBROK, NULL, "Usage: check_pe [0|1]\n");
+		tst_brkm(TBROK, NULL, "Usage: check_pe [0|1]");
 	}
 	n = atoi(argv[1]);
 	if (n != 0 && n != 1) {
-		tst_brkm(TBROK, NULL, "Usage: check_pe [0|1]\n");
+		tst_brkm(TBROK, NULL, "Usage: check_pe [0|1]");
 	}

 	cur = cap_get_proc();
 	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_EFFECTIVE, &f);
 	if (ret) {
-		tst_brkm(TBROK, NULL, "cap_get_flag failed (errno %d)\n",
+		tst_brkm(TBROK, NULL, "cap_get_flag failed (errno %d)",
 			 errno);
 	}

 	cap_free(cur);
 	if (n == 1) {
 		if (f == CAP_SET) {
-			tst_resm(TPASS, "cap is in pE\n");
+			tst_resm(TPASS, "cap is in pE");
 			tst_exit();
 		}
-		tst_brkm(TFAIL, NULL, "cap is not in pE\n");
+		tst_brkm(TFAIL, NULL, "cap is not in pE");
 	}
 	if (f == CAP_CLEAR) {
-		tst_resm(TPASS, "cap is not in pE\n");
+		tst_resm(TPASS, "cap is not in pE");
 		tst_exit();
 	}
-	tst_resm(TFAIL, "Cap is in pE\n");
+	tst_resm(TFAIL, "Cap is in pE");
 #else /* libcap */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
diff --git a/testcases/kernel/security/cap_bound/exec_with_inh.c b/testcases/kernel/security/cap_bound/exec_with_inh.c
index 13814798e..01b755808 100644
--- a/testcases/kernel/security/cap_bound/exec_with_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_with_inh.c
@@ -52,21 +52,21 @@ int main(int argc, char *argv[])
 	if (!cur) {
 		tst_brkm(TBROK,
 			 NULL,
-			 "Failed to create cap_sys_admin+i cap_t (errno %d)\n",
+			 "Failed to create cap_sys_admin+i cap_t (errno %d)",
 			 errno);
 	}
 	ret = cap_set_proc(cur);
 	if (ret) {
 		tst_brkm(TBROK,
 			 NULL,
-			 "Failed to cap_set_proc with cap_sys_admin+i (ret %d errno %d)\n",
+			 "Failed to cap_set_proc with cap_sys_admin+i (ret %d errno %d)",
 			 ret, errno);
 	}
 	cap_free(cur);
 	cur = cap_get_proc();
 	ret = cap_get_flag(cur, CAP_SYS_ADMIN, CAP_INHERITABLE, &f);
 	if (ret || f != CAP_SET) {
-		tst_brkm(TBROK, NULL, "Failed to add CAP_SYS_ADMIN to pI\n");
+		tst_brkm(TBROK, NULL, "Failed to add CAP_SYS_ADMIN to pI");
 	}
 	cap_free(cur);

@@ -74,14 +74,14 @@ int main(int argc, char *argv[])
 	ret = prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN);
 	if (ret) {
 		tst_resm(TFAIL,
-			 "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
-		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
+			 "Failed to drop CAP_SYS_ADMIN from bounding set.");
+		tst_resm(TINFO, "(ret=%d, errno %d)", ret, errno);
 		tst_exit();
 	}

 	/* execute "check_pe 1" */
 	execl("check_pe", "check_pe", "1", NULL);
-	tst_resm(TBROK, "Failed to execute check_pe (errno %d)\n", errno);
+	tst_resm(TBROK, "Failed to execute check_pe (errno %d)", errno);
 #else /* HAVE_LIBCAP */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
diff --git a/testcases/kernel/security/cap_bound/exec_without_inh.c b/testcases/kernel/security/cap_bound/exec_without_inh.c
index 5c6a9f825..10220e10e 100644
--- a/testcases/kernel/security/cap_bound/exec_without_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_without_inh.c
@@ -59,7 +59,7 @@ int main(void)
 		if (ret) {
 			tst_brkm(TBROK,
 				 NULL,
-				 "Failed to drop cap_sys_admin from pI\n");
+				 "Failed to drop cap_sys_admin from pI");
 		}
 	} else if (ret) {
 		tst_brkm(TBROK | TERRNO, NULL, "Failed to add \
@@ -71,14 +71,14 @@ int main(void)
 	ret = prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN);
 	if (ret) {
 		tst_resm(TFAIL,
-			 "Failed to drop CAP_SYS_ADMIN from bounding set.\n");
-		tst_resm(TINFO, "(ret=%d, errno %d)\n", ret, errno);
+			 "Failed to drop CAP_SYS_ADMIN from bounding set.");
+		tst_resm(TINFO, "(ret=%d, errno %d)", ret, errno);
 		tst_exit();
 	}

 	/* execute "check_pe 0" */
 	execl("check_pe", "check_pe", "0", NULL);
-	tst_resm(TBROK, "Failed to execute check_pe (errno %d)\n", errno);
+	tst_resm(TBROK, "Failed to execute check_pe (errno %d)", errno);
 #else /* libcap */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
diff --git a/testcases/kernel/security/filecaps/inh_capped.c b/testcases/kernel/security/filecaps/inh_capped.c
index 4bbe184aa..d273d0c80 100644
--- a/testcases/kernel/security/filecaps/inh_capped.c
+++ b/testcases/kernel/security/filecaps/inh_capped.c
@@ -50,7 +50,7 @@ int set_caps_from_text(char *capstr)
 	int ret;

 	if (!caps) {
-		tst_resm(TFAIL, "Bad capability name: %s\n", capstr);
+		tst_resm(TFAIL, "Bad capability name: %s", capstr);
 		return 1;
 	}
 	ret = cap_set_proc(caps);
@@ -100,7 +100,7 @@ int main(void)
 	ret = set_caps_from_text("all=iep cap_sys_admin-ep+i cap_setpcap-e+ip");
 	debug_print_caps("final");
 	if (ret) {
-		tst_resm(TPASS, "pI is properly capped\n");
+		tst_resm(TPASS, "pI is properly capped");
 		tst_exit();
 	}

diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 3e6794102..4cabcc542 100644
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
@@ -80,7 +80,7 @@ static void drop_root(int keep_perms)
 		prctl(PR_SET_KEEPCAPS, 1);
 	ret = setresuid(1000, 1000, 1000);
 	if (ret) {
-		tst_brkm(TFAIL | TERRNO, NULL, "Error dropping root privs\n");
+		tst_brkm(TFAIL | TERRNO, NULL, "Error dropping root privs");
 		tst_exit();
 	}
 	if (keep_perms) {
@@ -88,10 +88,10 @@ static void drop_root(int keep_perms)
 		int ret;
 		if (!cap)
 			tst_brkm(TBROK | TERRNO, NULL,
-				 "cap_from_text failed\n");
+				 "cap_from_text failed");
 		ret = cap_set_proc(cap);
 		if (ret < 0)
-			tst_brkm(TBROK | TERRNO, NULL, "cap_set_proc failed\n");
+			tst_brkm(TBROK | TERRNO, NULL, "cap_set_proc failed");
 		cap_free(cap);
 	}
 }
@@ -104,15 +104,15 @@ static int perms_test(void)
 	drop_root(DROP_PERMS);
 	cap = cap_from_text("all=eip");
 	if (!cap) {
-		tst_resm(TFAIL, "could not get cap from text for perms test\n");
+		tst_resm(TFAIL, "could not get cap from text for perms test");
 		return 1;
 	}
 	ret = cap_set_file(TSTPATH, cap);
 	if (ret) {
-		tst_resm(TPASS, "could not set capabilities as non-root\n");
+		tst_resm(TPASS, "could not set capabilities as non-root");
 		ret = 0;
 	} else {
-		tst_resm(TFAIL, "could set capabilities as non-root\n");
+		tst_resm(TFAIL, "could set capabilities as non-root");
 		ret = 1;
 	}

@@ -126,7 +126,7 @@ static void create_fifo(void)

 	ret = mkfifo(get_caps_fifo(), S_IRWXU | S_IRWXG | S_IRWXO);
 	if (ret == -1 && errno != EEXIST)
-		tst_brkm(TFAIL | TERRNO, NULL, "failed creating %s\n",
+		tst_brkm(TFAIL | TERRNO, NULL, "failed creating %s",
 			 get_caps_fifo());
 }

@@ -146,7 +146,7 @@ static void read_from_fifo(char *buf)
 	memset(buf, 0, 200);
 	fd = open(get_caps_fifo(), O_RDONLY);
 	if (fd < 0)
-		tst_brkm(TFAIL | TERRNO, NULL, "Failed opening fifo\n");
+		tst_brkm(TFAIL | TERRNO, NULL, "Failed opening fifo");
 	read(fd, buf, 199);
 	close(fd);
 }
@@ -163,7 +163,7 @@ static int fork_drop_and_exec(int keepperms, cap_t expected_caps)

 	pid = fork();
 	if (pid < 0)
-		tst_brkm(TFAIL | TERRNO, NULL, "%s: failed fork\n", __func__);
+		tst_brkm(TFAIL | TERRNO, NULL, "%s: failed fork", __func__);
 	if (pid == 0) {
 		drop_root(keepperms);
 		print_my_caps();
@@ -173,7 +173,7 @@ static int fork_drop_and_exec(int keepperms, cap_t expected_caps)
 		snprintf(buf, 200, "failed to run as %s\n", capstxt);
 		cap_free(capstxt);
 		write_to_fifo(buf);
-		tst_brkm(TFAIL, NULL, "%s: exec failed\n", __func__);
+		tst_brkm(TFAIL, NULL, "%s: exec failed", __func__);
 	} else {
 		p = buf;
 		while (1) {
@@ -189,15 +189,15 @@ static int fork_drop_and_exec(int keepperms, cap_t expected_caps)
 		p = strchr(buf, '.');
 		if (!p)
 			tst_brkm(TFAIL, NULL,
-				 "got a bad message from print_caps\n");
+				 "got a bad message from print_caps");
 		p += 1;
 		actual_caps = cap_from_text(p);
 		if (cap_compare(actual_caps, expected_caps) != 0) {
 			capstxt = cap_to_text(expected_caps, NULL);
 			tst_resm(TINFO,
-				 "Expected to run as .%s., ran as .%s..\n",
+				 "Expected to run as .%s., ran as .%s..",
 				 capstxt, p);
-			tst_resm(TINFO, "those are not the same\n");
+			tst_resm(TINFO, "those are not the same");
 			cap_free(capstxt);
 			ret = -1;
 		}
@@ -251,13 +251,13 @@ static int caps_actually_set_test(void)
 		cap_set_flag(fcap, CAP_PERMITTED, 1, capvalue, CAP_SET);
 		ret = cap_set_file(TSTPATH, fcap);
 		if (ret) {
-			tst_resm(TINFO, "%d\n", whichcap);
+			tst_resm(TINFO, "%d", whichcap);
 			continue;
 		}
 		ret = fork_drop_and_exec(DROP_PERMS, fcap);
 		if (ret) {
 			tst_resm(TINFO,
-				 "Failed CAP_PERMITTED=%d CAP_EFFECTIVE=0\n",
+				 "Failed CAP_PERMITTED=%d CAP_EFFECTIVE=0",
 				 whichcap);
 			if (!finalret)
 				finalret = ret;
@@ -273,13 +273,13 @@ static int caps_actually_set_test(void)
 		cap_set_flag(fcap, CAP_EFFECTIVE, 1, capvalue, CAP_SET);
 		ret = cap_set_file(TSTPATH, fcap);
 		if (ret) {
-			tst_resm(TINFO, "%d\n", whichcap);
+			tst_resm(TINFO, "%d", whichcap);
 			continue;
 		}
 		ret = fork_drop_and_exec(DROP_PERMS, fcap);
 		if (ret) {
 			tst_resm(TINFO,
-				 "Failed CAP_PERMITTED=%d CAP_EFFECTIVE=1\n",
+				 "Failed CAP_PERMITTED=%d CAP_EFFECTIVE=1",
 				 whichcap);
 			if (!finalret)
 				finalret = ret;
@@ -300,7 +300,7 @@ static int caps_actually_set_test(void)
 	 */
 	ret = cap_set_proc(cap_fullpi);
 	if (ret)
-		tst_resm(TINFO, "Could not fill pI.  pI tests will fail.\n");
+		tst_resm(TINFO, "Could not fill pI.  pI tests will fail.");

 	/*
 	 * next try each bit in fI
@@ -330,13 +330,13 @@ static int caps_actually_set_test(void)
 		cap_set_flag(fcap, CAP_INHERITABLE, 1, capvalue, CAP_SET);
 		ret = cap_set_file(TSTPATH, fcap);
 		if (ret) {
-			tst_resm(TINFO, "%d\n", whichcap);
+			tst_resm(TINFO, "%d", whichcap);
 			continue;
 		}
 		ret = fork_drop_and_exec(KEEP_PERMS, pcap);
 		if (ret) {
 			tst_resm(TINFO, "Failed with_perms CAP_INHERITABLE=%d "
-				 "CAP_EFFECTIVE=0\n", whichcap);
+				 "CAP_EFFECTIVE=0", whichcap);
 			if (!finalret)
 				finalret = ret;
 		}
@@ -354,7 +354,7 @@ static int caps_actually_set_test(void)
 		cap_set_flag(pcap, CAP_EFFECTIVE, 1, capvalue, CAP_SET);
 		ret = cap_set_file(TSTPATH, fcap);
 		if (ret) {
-			tst_resm(TINFO, "%d\n", whichcap);
+			tst_resm(TINFO, "%d", whichcap);
 			continue;
 		}
 		/* The actual result will be a full pI, with
@@ -366,7 +366,7 @@ static int caps_actually_set_test(void)
 		cap_free(cmpcap);
 		if (ret) {
 			tst_resm(TINFO, "Failed with_perms CAP_INHERITABLE=%d "
-				 "CAP_EFFECTIVE=1\n", whichcap);
+				 "CAP_EFFECTIVE=1", whichcap);
 			if (!finalret)
 				finalret = ret;
 		}
@@ -411,9 +411,9 @@ int main(int argc, char *argv[])
 	case 1:
 		ret = caps_actually_set_test();
 		if (ret)
-			tst_resm(TFAIL, "Some tests failed\n");
+			tst_resm(TFAIL, "Some tests failed");
 		else
-			tst_resm(TPASS, "All tests passed\n");
+			tst_resm(TPASS, "All tests passed");
 		break;
 	default:
 		usage(argv[0]);
diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 058d7f982..ecb393297 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -234,7 +234,7 @@ static void setup(int argc, char *argv[])

 static int test_run(void)
 {
-	tst_resm(TINFO, " --- HARDLINKS AND SYMLINKS RESTRICTIONS TEST ---\n");
+	tst_resm(TINFO, " --- HARDLINKS AND SYMLINKS RESTRICTIONS TEST ---");

 	int	result_slink = 0,
 		result_hlink = 0,
@@ -256,8 +256,8 @@ static int test_run(void)
 	}

 	/* final results */
-	tst_resm(TINFO, "All test-cases have been completed, summary:\n"
-		" - symlinks  test:\t%s\n"
+	tst_resm(TINFO, "All test-cases have been completed, summary:"
+		" - symlinks  test:\t%s"
 		" - hardlinks test:\t%s",
 		(result_slink == 1) ? "FAIL" : "PASS",
 		(result_hlink == 1) ? "FAIL" : "PASS");
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
index 6bf7e729e..1ab6eba9f 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
@@ -49,11 +49,11 @@ static void verify_msgrcv(void)
 	}

 	if (rcv_buf.mtype != mtype) {
-		tst_res(TFAIL, "found mtype %ld, expected %ld\n", rcv_buf.mtype, mtype);
+		tst_res(TFAIL, "found mtype %ld, expected %ld", rcv_buf.mtype, mtype);
 		return;
 	}
 	if ((size_t)TST_RET != sizeof(snd_buf.mtext)) {
-		tst_res(TFAIL, "received %zi, expected %zu\n", (size_t)TST_RET, sizeof(snd_buf.mtext));
+		tst_res(TFAIL, "received %zi, expected %zu", (size_t)TST_RET, sizeof(snd_buf.mtext));
 		return;
 	}

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 2099df6c3..56e0700d6 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -61,7 +61,7 @@ static long init_swap, init_swap_cached, init_cached;
 static void check_path(const char *path)
 {
 	if (access(path, R_OK | W_OK))
-		tst_brk(TCONF, "file needed: %s\n", path);
+		tst_brk(TCONF, "file needed: %s", path);
 }

 #define READ_CGMEM(item)						\
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create04.c b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
index 659431cd9..add97c3c1 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create04.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
@@ -70,7 +70,7 @@ static void memfd_huge_x_controller(unsigned int n)
 	fd = sys_memfd_create("tfile", MFD_HUGETLB | tflag.flag);
 	if (fd < 0) {
 		if (errno == tflag.exp_err)
-			tst_res(TPASS, "Test failed as expected\n");
+			tst_res(TPASS, "Test failed as expected");
 		else
 			tst_brk(TFAIL | TERRNO,
 				"memfd_create() failed unexpectedly");
@@ -78,7 +78,7 @@ static void memfd_huge_x_controller(unsigned int n)
 	}

 	tst_res(TPASS,
-		"memfd_create succeeded for %s page size\n",
+		"memfd_create succeeded for %s page size",
 		tflag.h_size);
 }

diff --git a/testcases/kernel/syscalls/move_pages/move_pages01.c b/testcases/kernel/syscalls/move_pages/move_pages01.c
index 4a3a8efbb..f853928ac 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages01.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages01.c
@@ -94,7 +94,7 @@ int main(int argc, char **argv)
 			free_pages(pages, TEST_PAGES);
 			continue;
 		} else if (ret > 0) {
-			tst_resm(TINFO, "move_pages() returned %d\n", ret);
+			tst_resm(TINFO, "move_pages() returned %d", ret);
 		}

 		verify_pages_linear(pages, status, TEST_PAGES);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index 80fe6e60f..27d683bb0 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -108,7 +108,7 @@ int main(int argc, char **argv)
 			free_pages(pages, TEST_PAGES);
 			continue;
 		} else if (ret > 0) {
-			tst_resm(TINFO, "move_pages() returned %d\n", ret);
+			tst_resm(TINFO, "move_pages() returned %d", ret);
 		}

 		for (i = 0; i < TEST_PAGES; i++)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index d0f2294fb..fe849ec03 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL|TERRNO, "move_pages failed");
 			goto err_kill_child;
 		} else if (ret > 0) {
-			tst_resm(TINFO, "move_pages() returned %d\n", ret);
+			tst_resm(TINFO, "move_pages() returned %d", ret);
 		}

 		verify_pages_on_node(pages, status, TEST_PAGES, to_node);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index df5e334e2..f53453ab4 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -132,7 +132,7 @@ int main(int argc, char **argv)
 				 "move_pages unexpectedly failed");
 			goto err_free_pages;
 		} else if (ret > 0) {
-			tst_resm(TINFO, "move_pages() returned %d\n", ret);
+			tst_resm(TINFO, "move_pages() returned %d", ret);
 		}

 		if (status[UNTOUCHED_PAGE] == exp_status) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index 7db3c47a9..41f65ed39 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -176,7 +176,7 @@ int main(int argc, char **argv)
 				 "move_pages unexpectedly failed");
 			goto err_kill_child;
 		} else if (ret > 0) {
-			tst_resm(TINFO, "move_pages() returned %d\n", ret);
+			tst_resm(TINFO, "move_pages() returned %d", ret);
 		}

 		if (status[SHARED_PAGE] == -EACCES)
diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 1a0fa0e63..6c7f6bd01 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -214,7 +214,7 @@ static void *get_func(void *mem, uintptr_t *func_page_offset)
 		/* If the memory is still not accessible, then something must be
 		 * wrong. */
 		if (!page_present(page_to_copy))
-			tst_brkm(TBROK, cleanup, "page_to_copy not present\n");
+			tst_brkm(TBROK, cleanup, "page_to_copy not present");
 	}
 	memcpy(mem, page_to_copy, page_sz);

diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index 404f71517..a8254cb00 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -82,7 +82,7 @@ static void test_profil(void)
 	 * set scale to 2*65536 to have 1:1 mapping for $pc */
 	ret = profil(buf, sizeof(buf), offset, 2*65536);
 	if (ret)
-		tst_brkm(TBROK, NULL, "profil returned: %d\n", ret);
+		tst_brkm(TBROK, NULL, "profil returned: %d", ret);

 	signal(SIGALRM, alrm_handler);
 	alarm(PROFIL_TIME);
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index fa50af319..72286d99d 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -65,7 +65,7 @@ char *test_flags_list[] =

 static void handler(int sig)
 {
-	tst_resm(TINFO, "Signal Handler Called with signal number %d\n", sig);
+	tst_resm(TINFO, "Signal Handler Called with signal number %d", sig);
 	return;
 }

diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 6e7865c07..eabbcd9b9 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -71,7 +71,7 @@ static struct test_case_t {

 static void handler(int sig)
 {
-	tst_resm(TINFO, "Signal Handler Called with signal number %d\n", sig);
+	tst_resm(TINFO, "Signal Handler Called with signal number %d", sig);
 	return;
 }

diff --git a/testcases/network/tcp_cmds/sendfile/testsf_s.c b/testcases/network/tcp_cmds/sendfile/testsf_s.c
index bce8dd1e3..817ddb2b0 100644
--- a/testcases/network/tcp_cmds/sendfile/testsf_s.c
+++ b/testcases/network/tcp_cmds/sendfile/testsf_s.c
@@ -49,7 +49,7 @@ int main(int argc, char *argv[])

 	/* open socket */
 	if ((s = socket(AFI, SOCK_STREAM, 0)) < 0) {
-		tst_brkm(TBROK, NULL, "socket error = %d\n", errno);
+		tst_brkm(TBROK, NULL, "socket error = %d", errno);
 	}

 	signal(SIGCHLD, SIG_IGN);	/* ignore signals from children */
@@ -74,14 +74,14 @@ int main(int argc, char *argv[])

 	/* bind IP and port to socket */
 	if (bind(s, (sa_t *) & sa, sizeof(sa)) < 0) {
-		tst_resm(TBROK, "bind error = %d\n", errno);
+		tst_resm(TBROK, "bind error = %d", errno);
 		close(s);
 		tst_exit();
 	}

 	/* start to listen socket */
 	if (listen(s, LISTEN_BACKLOG) < 0) {
-		tst_resm(TBROK, "listen error = %d\n", errno);
+		tst_resm(TBROK, "listen error = %d", errno);
 		close(s);
 		tst_exit();
 	}
@@ -93,7 +93,7 @@ int main(int argc, char *argv[])

 		/* accept a connection from a client */
 		if ((as = accept(s, &from, &fromlen)) < 0) {
-			tst_resm(TBROK, "accept error = %d\n", errno);
+			tst_resm(TBROK, "accept error = %d", errno);
 			if (errno == EINTR)
 				continue;
 			close(s);
@@ -104,7 +104,7 @@ int main(int argc, char *argv[])

 		/* create a process to manage the connection */
 		if ((pid = fork()) < 0) {
-			tst_resm(TBROK, "fork error = %d\n", errno);
+			tst_resm(TBROK, "fork error = %d", errno);
 			close(as);
 			tst_exit();
 		}
@@ -119,7 +119,7 @@ int main(int argc, char *argv[])

 		/* get client request information */
 		if ((nbytes = read(as, rbuf, PATH_MAX)) <= 0) {
-			tst_resm(TBROK, "socket read error = %d\n", errno);
+			tst_resm(TBROK, "socket read error = %d", errno);
 			close(as);
 			tst_exit();
 		}
@@ -140,10 +140,10 @@ int main(int argc, char *argv[])
 		/* the file name */
 		lp++;

-		tst_resm(TINFO, "The file to send is %s\n", lp);
+		tst_resm(TINFO, "The file to send is %s", lp);
 		/* open requested file to send */
 		if ((fd = open(lp, O_RDONLY)) < 0) {
-			tst_resm(TBROK, "file open error = %d\n", errno);
+			tst_resm(TBROK, "file open error = %d", errno);
 			close(as);
 			tst_exit();
 		}
@@ -153,7 +153,7 @@ int main(int argc, char *argv[])
 			if ((rc = sendfile(as, fd, offset, flen)) != flen) {
 				if ((errno != EWOULDBLOCK) && (errno != EAGAIN)) {
 					tst_resm(TBROK,
-						 "sendfile error = %d, rc = %d\n",
+						 "sendfile error = %d, rc = %d",
 						 errno, rc);
 					close(as);
 					close(fd);
@@ -162,7 +162,7 @@ int main(int argc, char *argv[])
 			}
 			chunks++;
 		} while (rc != 0);
-		tst_resm(TINFO, "File %s sent in %d parts\n", lp, chunks);
+		tst_resm(TINFO, "File %s sent in %d parts", lp, chunks);

 		close(as);	/* close connection */
 		close(fd);	/* close requested file */
--
2.17.1

