Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68933C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1529A3CC892
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 13:26:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 785463CC88B
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:25:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CA4B4140013F
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 13:25:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669379155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=liWFoNIsNNLjv4nGtKxxgyAmtD3Kze55dpNV/DvZF+M=;
 b=idAZtygVaBEbshxn1TZk3TnKWdzVJuYd2yI5mLCUds9fxGGPVCFaBEKsn9uJSsrlFYR64U
 OBg0FYqBZu6JjBVhGSQ+St1R9DjnGaPQz2KO2XuPkI2aGI8KF/RYo25FmXNHBekDKjhVwE
 ropscxyGEfNAwWkZXt1lyczG7qkt1Ts=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-5KA9y76zPwa3IKcq3_kWCA-1; Fri, 25 Nov 2022 07:25:51 -0500
X-MC-Unique: 5KA9y76zPwa3IKcq3_kWCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7686F3C0F7E7;
 Fri, 25 Nov 2022 12:25:51 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E72892024CBE;
 Fri, 25 Nov 2022 12:25:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 25 Nov 2022 13:25:46 +0100
Message-Id: <20221125122546.99144-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] execl(),
 execlp() and execle() require proper termination of argument list
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The manpage of exec() says:
  "The list of arguments must be terminated by a null pointer, and, since
   these are variadic functions, this pointer must be cast (char *) NULL."

So let's fix all instances that either call these functions directly or
through the SAFE_EXEC* helpers.

Note that we don't have to worry about cases such as in prctl06.c,
whereby NULL is stored into a char * array first.

Reported-by: Martin Doucha <mdoucha@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Petr Vorel <pvorel@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 pan/ltp-pan.c                                            | 2 +-
 testcases/kernel/connectors/pec/event_generator.c        | 3 ++-
 testcases/kernel/controllers/freezer/fork_exec_loop.c    | 2 +-
 testcases/kernel/fs/fs_perms/fs_perms.c                  | 4 ++--
 testcases/kernel/fs/ftest/ftest01.c                      | 2 +-
 testcases/kernel/fs/ftest/ftest02.c                      | 4 ++--
 testcases/kernel/fs/ftest/ftest03.c                      | 2 +-
 testcases/kernel/fs/ftest/ftest05.c                      | 2 +-
 testcases/kernel/fs/ftest/ftest06.c                      | 4 ++--
 testcases/kernel/fs/ftest/ftest07.c                      | 2 +-
 testcases/kernel/sched/sched_stress/sched_driver.c       | 3 ++-
 testcases/kernel/sched/sched_stress/sched_tc6.c          | 2 +-
 testcases/kernel/security/cap_bound/exec_with_inh.c      | 2 +-
 testcases/kernel/security/cap_bound/exec_without_inh.c   | 2 +-
 testcases/kernel/security/dirtyc0w/dirtyc0w.c            | 2 +-
 .../kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c      | 3 ++-
 testcases/kernel/security/filecaps/verify_caps_exec.c    | 2 +-
 testcases/kernel/security/tomoyo/tomoyo_file_test.c      | 2 +-
 testcases/kernel/security/tomoyo/tomoyo_new_file_test.c  | 4 ++--
 testcases/kernel/syscalls/creat/creat07.c                | 2 +-
 testcases/kernel/syscalls/execl/execl01.c                | 2 +-
 testcases/kernel/syscalls/execle/execle01.c              | 3 ++-
 testcases/kernel/syscalls/execlp/execlp01.c              | 3 ++-
 testcases/kernel/syscalls/fanotify/fanotify10.c          | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify12.c          | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl07.c                | 2 +-
 testcases/kernel/syscalls/getrusage/getrusage03.c        | 9 +++++----
 testcases/kernel/syscalls/mount/mount03.c                | 4 ++--
 testcases/kernel/syscalls/open/open12.c                  | 2 +-
 testcases/kernel/syscalls/openat/openat02.c              | 2 +-
 testcases/kernel/syscalls/pipe2/pipe2_02.c               | 2 +-
 testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h    | 2 +-
 testcases/kernel/syscalls/setpgid/setpgid03.c            | 2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit04.c        | 2 +-
 testcases/network/nfsv4/acl/acl1.c                       | 2 +-
 .../conformance/interfaces/sem_unlink/2-2.c              | 2 +-
 .../conformance/interfaces/sigaltstack/9-1.c             | 2 +-
 .../conformance/interfaces/timer_create/9-1.c            | 2 +-
 38 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 0bdb51477..9f83033ed 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -1034,7 +1034,7 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
 		 * cmd directly.
 		 */
 		if (strpbrk(c_cmdline, "\"';|<>$\\")) {
-			execlp("sh", "sh", "-c", c_cmdline, NULL);
+			execlp("sh", "sh", "-c", c_cmdline, (char *)NULL);
 			errlen = sprintf(errbuf,
 					 "pan(%s): execlp of '%s' (tag %s) failed.  errno:%d %s",
 					 panname, c_cmdline, colle->name, errno,
diff --git a/testcases/kernel/connectors/pec/event_generator.c b/testcases/kernel/connectors/pec/event_generator.c
index 4945058ff..78bfd9e89 100644
--- a/testcases/kernel/connectors/pec/event_generator.c
+++ b/testcases/kernel/connectors/pec/event_generator.c
@@ -68,7 +68,8 @@ static void gen_exec(void)
 	 * the shell script, before the first exec.
 	 */
 	sprintf(buf, "%u", nr_event - 1);
-	SAFE_EXECLP(prog_name, prog_name, "-e", "exec", "-n", buf, NULL);
+	SAFE_EXECLP(prog_name, prog_name, "-e", "exec", "-n", buf,
+		    (char *)NULL);
 }
 
 /*
diff --git a/testcases/kernel/controllers/freezer/fork_exec_loop.c b/testcases/kernel/controllers/freezer/fork_exec_loop.c
index 6b6218501..8ef8504e0 100644
--- a/testcases/kernel/controllers/freezer/fork_exec_loop.c
+++ b/testcases/kernel/controllers/freezer/fork_exec_loop.c
@@ -31,7 +31,7 @@ int main(int argc, char **argv)
 
 		for (i = 0; i < count; i++)
 			if (fork() == 0)
-				execlp("/bin/true", "true", NULL);
+				execlp("/bin/true", "true", (char *)NULL);
 
 		for (i = 0; i < count; i++)
 			wait(&s);
diff --git a/testcases/kernel/fs/fs_perms/fs_perms.c b/testcases/kernel/fs/fs_perms/fs_perms.c
index e8c5f536f..3bd44a900 100644
--- a/testcases/kernel/fs/fs_perms/fs_perms.c
+++ b/testcases/kernel/fs/fs_perms/fs_perms.c
@@ -127,9 +127,9 @@ static int testfperm(const char *file_name, int flag, int user_id,
 			 * no binmft handler for it, execl does not.
 			 */
 			if (flag)
-				execl(file_name, file_name, NULL);
+				execl(file_name, file_name, (char *)NULL);
 			else
-				execlp(file_name, "test", NULL);
+				execlp(file_name, "test", (char *)NULL);
 
 			exit(1);
 			break;
diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index 31203d689..fa8fef638 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -218,7 +218,7 @@ static void runtest(void)
 	}
 
 	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
+		execl("/bin/rm", "rm", "-rf", fuss, (char *)NULL);
 		exit(1);
 	}
 
diff --git a/testcases/kernel/fs/ftest/ftest02.c b/testcases/kernel/fs/ftest/ftest02.c
index a416a9884..80d8c6060 100644
--- a/testcases/kernel/fs/ftest/ftest02.c
+++ b/testcases/kernel/fs/ftest/ftest02.c
@@ -203,7 +203,7 @@ int main(void)
 	}
 
 	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", homedir, NULL);
+		execl("/bin/rm", "rm", "-rf", homedir, (char *)NULL);
 		exit(1);
 	} else
 		wait(&status);
@@ -220,7 +220,7 @@ int main(void)
 	}
 
 	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", dirname, NULL);
+		execl("/bin/rm", "rm", "-rf", dirname, (char *)NULL);
 		exit(1);
 	} else
 		wait(&status);
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ftest/ftest03.c
index ed69e5736..a9573af78 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -237,7 +237,7 @@ static void runtest(void)
 	}
 
 	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
+		execl("/bin/rm", "rm", "-rf", fuss, (char *)NULL);
 		exit(1);
 	} else
 		wait(&status);
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index 8d8e6d497..039f9efbb 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -218,7 +218,7 @@ static void runtest(void)
 	}
 
 	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
+		execl("/bin/rm", "rm", "-rf", fuss, (char *)NULL);
 		exit(1);
 	}
 
diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
index c3aebe5bb..ac7c91bb4 100644
--- a/testcases/kernel/fs/ftest/ftest06.c
+++ b/testcases/kernel/fs/ftest/ftest06.c
@@ -219,7 +219,7 @@ int main(int ac, char *av[])
 		}
 
 		if (pid == 0) {
-			execl("/bin/rm", "rm", "-rf", homedir, NULL);
+			execl("/bin/rm", "rm", "-rf", homedir, (char *)NULL);
 
 		} else
 			wait(&status);
@@ -234,7 +234,7 @@ int main(int ac, char *av[])
 			tst_brkm(TBROK | TERRNO, NULL, "fork failed");
 		}
 		if (pid == 0) {
-			execl("/bin/rm", "rm", "-rf", dirname, NULL);
+			execl("/bin/rm", "rm", "-rf", dirname, (char *)NULL);
 			exit(1);
 		} else
 			wait(&status);
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index 3b5b2a419..a865161cf 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -237,7 +237,7 @@ static void runtest(void)
 	}
 
 	if (pid == 0) {
-		execl("/bin/rm", "rm", "-rf", fuss, NULL);
+		execl("/bin/rm", "rm", "-rf", fuss, (char *)NULL);
 		exit(1);
 	} else
 		wait(&status);
diff --git a/testcases/kernel/sched/sched_stress/sched_driver.c b/testcases/kernel/sched/sched_stress/sched_driver.c
index 61573d788..cc5ccff3f 100644
--- a/testcases/kernel/sched/sched_stress/sched_driver.c
+++ b/testcases/kernel/sched/sched_stress/sched_driver.c
@@ -323,7 +323,8 @@ int start_testcase(char *name1, char *name2, char *param1, char *param2,
 	case -1:
 		exit(-1);
 	case 0:
-		execl(name1, name2, param1, param2, param3, param4, NULL);
+		execl(name1, name2, param1, param2, param3, param4,
+		      (char *)NULL);
 		printf("ERROR: start_testcase():  execl failed.\n");
 		exit(-1);
 	default:
diff --git a/testcases/kernel/sched/sched_stress/sched_tc6.c b/testcases/kernel/sched/sched_stress/sched_tc6.c
index e70e8f250..3128554e3 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc6.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc6.c
@@ -289,7 +289,7 @@ int fork_realtime(char **args)
 		/* child process */
 	case 0:
 		if (execl(*args, *args, REAL_TIME, results_file, priority,
-			  NO_FORK, NULL) < 0)
+			  NO_FORK, (char *)NULL) < 0)
 			sys_error("execl failed", __FILE__, __LINE__);
 
 		/* parent process */
diff --git a/testcases/kernel/security/cap_bound/exec_with_inh.c b/testcases/kernel/security/cap_bound/exec_with_inh.c
index 01b755808..966165898 100644
--- a/testcases/kernel/security/cap_bound/exec_with_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_with_inh.c
@@ -80,7 +80,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* execute "check_pe 1" */
-	execl("check_pe", "check_pe", "1", NULL);
+	execl("check_pe", "check_pe", "1", (char *)NULL);
 	tst_resm(TBROK, "Failed to execute check_pe (errno %d)", errno);
 #else /* HAVE_LIBCAP */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
diff --git a/testcases/kernel/security/cap_bound/exec_without_inh.c b/testcases/kernel/security/cap_bound/exec_without_inh.c
index 10220e10e..f31fce05b 100644
--- a/testcases/kernel/security/cap_bound/exec_without_inh.c
+++ b/testcases/kernel/security/cap_bound/exec_without_inh.c
@@ -77,7 +77,7 @@ int main(void)
 	}
 
 	/* execute "check_pe 0" */
-	execl("check_pe", "check_pe", "0", NULL);
+	execl("check_pe", "check_pe", "0", (char *)NULL);
 	tst_resm(TBROK, "Failed to execute check_pe (errno %d)", errno);
 #else /* libcap */
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index 487a52601..6d2fa7d6a 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -70,7 +70,7 @@ void dirtyc0w_test(void)
 	if (!pid) {
 		SAFE_SETGID(nobody_gid);
 		SAFE_SETUID(nobody_uid);
-		SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child", NULL);
+		SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child", (char *)NULL);
 	}
 
 	TST_CHECKPOINT_WAIT(0);
diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index f885a9283..1e3b194e7 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -69,7 +69,8 @@ static void dirtyc0w_shmem_test(void)
 	if (!pid) {
 		SAFE_SETGID(nobody_gid);
 		SAFE_SETUID(nobody_uid);
-		SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL);
+		SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child",
+			    (char *)NULL);
 	}
 
 	TST_CHECKPOINT_WAIT(0);
diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 4cabcc542..da5378aa4 100644
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
@@ -168,7 +168,7 @@ static int fork_drop_and_exec(int keepperms, cap_t expected_caps)
 		drop_root(keepperms);
 		print_my_caps();
 		sprintf(buf, "%d", seqno);
-		ret = execlp(TSTPATH, TSTPATH, buf, NULL);
+		ret = execlp(TSTPATH, TSTPATH, buf, (char *)NULL);
 		capstxt = cap_to_text(expected_caps, NULL);
 		snprintf(buf, 200, "failed to run as %s\n", capstxt);
 		cap_free(capstxt);
diff --git a/testcases/kernel/security/tomoyo/tomoyo_file_test.c b/testcases/kernel/security/tomoyo/tomoyo_file_test.c
index 003f47720..091812628 100644
--- a/testcases/kernel/security/tomoyo/tomoyo_file_test.c
+++ b/testcases/kernel/security/tomoyo/tomoyo_file_test.c
@@ -96,7 +96,7 @@ static void stage_file_test(void)
 		if (pipe(pipe_fd) == -1)
 			err(1, "pipe");
 		if (fork() == 0) {
-			execl("/bin/true", "/bin/true", NULL);
+			execl("/bin/true", "/bin/true", (char *)NULL);
 			if (write(pipe_fd[1], &errno, sizeof(errno)) == -1)
 				err(1, "write");
 			_exit(0);
diff --git a/testcases/kernel/security/tomoyo/tomoyo_new_file_test.c b/testcases/kernel/security/tomoyo/tomoyo_new_file_test.c
index eb912d726..fc6dc83b7 100644
--- a/testcases/kernel/security/tomoyo/tomoyo_new_file_test.c
+++ b/testcases/kernel/security/tomoyo/tomoyo_new_file_test.c
@@ -156,7 +156,7 @@ static void stage_file_test(void)
 	if (pipe(pipe_fd) == -1)
 		err(1, "pipe");
 	if (fork() == 0) {
-		execl("/bin/true", "/bin/true", NULL);
+		execl("/bin/true", "/bin/true", (char *)NULL);
 		if (write(pipe_fd[1], &errno, sizeof(errno)) == -1)
 			err(1, "write");
 		exit(0);
@@ -173,7 +173,7 @@ static void stage_file_test(void)
 	if (pipe(pipe_fd) == -1)
 		err(1, "pipe");
 	if (fork() == 0) {
-		execl("/bin/true", "/bin/true", NULL);
+		execl("/bin/true", "/bin/true", (char *)NULL);
 		if (write(pipe_fd[1], &errno, sizeof(errno)) == -1)
 			err(1, "write");
 		_exit(0);
diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 7bd32ab4d..f55de29af 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -25,7 +25,7 @@ static void verify_creat(void)
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
-		SAFE_EXECL(TEST_APP, TEST_APP, NULL);
+		SAFE_EXECL(TEST_APP, TEST_APP, (char *)NULL);
 		exit(1);
 	}
 
diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
index 9268d4976..47cc527b1 100644
--- a/testcases/kernel/syscalls/execl/execl01.c
+++ b/testcases/kernel/syscalls/execl/execl01.c
@@ -25,7 +25,7 @@ static void verify_execl(void)
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
-		TEST(execl(path, "execl01_child", "canary", NULL));
+		TEST(execl(path, "execl01_child", "canary", (char *)NULL));
 		tst_brk(TFAIL | TTERRNO,
 			"Failed to execute execl01_child");
 	}
diff --git a/testcases/kernel/syscalls/execle/execle01.c b/testcases/kernel/syscalls/execle/execle01.c
index 917dc892f..edad8ac3a 100644
--- a/testcases/kernel/syscalls/execle/execle01.c
+++ b/testcases/kernel/syscalls/execle/execle01.c
@@ -30,7 +30,8 @@ static void verify_execle(void)
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
-		TEST(execle(path, "execle01_child", "canary", NULL, envp));
+		TEST(execle(path, "execle01_child", "canary", (char *)NULL,
+			    envp));
 		tst_brk(TFAIL | TTERRNO,
 			"Failed to execute execl01_child");
 	}
diff --git a/testcases/kernel/syscalls/execlp/execlp01.c b/testcases/kernel/syscalls/execlp/execlp01.c
index 99ea59490..37d464a3a 100644
--- a/testcases/kernel/syscalls/execlp/execlp01.c
+++ b/testcases/kernel/syscalls/execlp/execlp01.c
@@ -23,7 +23,8 @@ static void verify_execlp(void)
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
-		TEST(execlp("execlp01_child", "execlp01_child", "canary", NULL));
+		TEST(execlp("execlp01_child", "execlp01_child", "canary",
+		     (char *)NULL));
 		tst_brk(TFAIL | TTERRNO,
 			"Failed to execute execlp01_child");
 	}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index d0e9194e7..b9af94116 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -711,7 +711,7 @@ static int generate_event(struct tcase *tc, unsigned long long expected_mask)
 
 		foreach_path(tc, path, event_path) {
 			if (expected_mask & FAN_OPEN_EXEC) {
-				SAFE_EXECL(path, path, NULL);
+				SAFE_EXECL(path, path, (char *)NULL);
 			} else {
 				fd = SAFE_OPEN(path, O_RDONLY);
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 7f8e97b17..5b15ba8e0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -118,7 +118,7 @@ static int generate_events(void)
 		if (fd > 0)
 			SAFE_CLOSE(fd);
 
-		SAFE_EXECL(TEST_APP, TEST_APP, NULL);
+		SAFE_EXECL(TEST_APP, TEST_APP, (char *)NULL);
 		exit(1);
 	}
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl07.c b/testcases/kernel/syscalls/fcntl/fcntl07.c
index 9108b79c1..16b23be6b 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl07.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl07.c
@@ -106,7 +106,7 @@ static void verify_cloexec(struct tcase *tc)
 		tst_resm(TBROK | TERRNO, "fork() failed");
 		return;
 	case 0:
-		execlp(TCID, TCID, "-T", pidname, NULL);
+		execlp(TCID, TCID, "-T", pidname, (char *)NULL);
 
 		/* the ONLY reason to do this is to get the errno printed out */
 		fprintf(stderr, "exec(%s, %s, -T, %s) failed.  Errno %s [%d]\n",
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 7e7a1f555..8ed0ce094 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -76,7 +76,7 @@ static void grandchild_maxrss(void)
 {
 	if (!SAFE_FORK())
 		SAFE_EXECLP("getrusage03_child", "getrusage03_child",
-			    "grand_consume", "300", NULL);
+			    "grand_consume", "300", (char *)NULL);
 	tst_reap_children();
 	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
 
@@ -96,7 +96,7 @@ static void zombie(void)
 
 	if (!pid)
 		SAFE_EXECLP("getrusage03_child", "getrusage03_child",
-			    "consume", "400", NULL);
+			    "consume", "400", (char *)NULL);
 
 	TST_PROCESS_STATE_WAIT(pid, 'Z', 0);
 	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
@@ -125,7 +125,7 @@ static void sig_ign(void)
 
 	if (!pid)
 		SAFE_EXECLP("getrusage03_child", "getrusage03_child",
-			    "consume", "500", NULL);
+			    "consume", "500", (char *)NULL);
 
 	TST_PROCESS_EXIT_WAIT(pid, 0);
 	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
@@ -149,7 +149,8 @@ static void inherit_exec(void)
 		sprintf(str_maxrss_child, "%ld", ru.ru_maxrss);
 
 		SAFE_EXECLP("getrusage03_child", "getrusage03_child",
-			    "compare", str_maxrss_self, str_maxrss_child, NULL);
+			    "compare", str_maxrss_self, str_maxrss_child,
+			    (char *)NULL);
 	}
 	tst_reap_children();
 }
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 397c1bf81..35d13b6c7 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -61,7 +61,7 @@ static void test_noexec(void)
 {
 	snprintf(file, PATH_MAX, "%s/noexec", MNTPOINT);
 	otfd = SAFE_OPEN(file, O_CREAT | O_RDWR, 0700);
-	TST_EXP_FAIL(execlp(file, basename(file), NULL), EACCES);
+	TST_EXP_FAIL(execlp(file, basename(file), (char *)NULL), EACCES);
 }
 
 static void test_remount(void)
@@ -88,7 +88,7 @@ static void test_nosuid(void)
 			SAFE_CHMOD(BIN_PATH, SUID_MODE);
 
 		SAFE_SETREUID(nobody_uid, nobody_uid);
-		SAFE_EXECL(BIN_PATH, BIN_PATH, NULL);
+		SAFE_EXECL(BIN_PATH, BIN_PATH, (char *)NULL);
 		tst_brk(TFAIL | TTERRNO, "Failed to execute %s", BIN_PATH);
 	}
 
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 02ef5b5b0..abb252ada 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -205,7 +205,7 @@ static void test_cloexec(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 
 	if (pid == 0) {
-		if (execlp("open12_child", "open12_child", buf, NULL))
+		if (execlp("open12_child", "open12_child", buf, (char *)NULL))
 			exit(2);
 	}
 
diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
index b0a6ff78f..13c805bfd 100644
--- a/testcases/kernel/syscalls/openat/openat02.c
+++ b/testcases/kernel/syscalls/openat/openat02.c
@@ -165,7 +165,7 @@ void testfunc_cloexec(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 
 	if (pid == 0) {
-		if (execlp(TEST_APP, TEST_APP, buf, NULL))
+		if (execlp(TEST_APP, TEST_APP, buf, (char *)NULL))
 			exit(2);
 	}
 
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02.c b/testcases/kernel/syscalls/pipe2/pipe2_02.c
index ee317668b..84eb08b36 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_02.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_02.c
@@ -34,7 +34,7 @@ static void verify_pipe2(void)
 	sprintf(buf, "%d", fds[1]);
 	pid = SAFE_FORK();
 	if (pid == 0)
-		SAFE_EXECLP(TESTBIN, TESTBIN, buf, NULL);
+		SAFE_EXECLP(TESTBIN, TESTBIN, buf, (char *)NULL);
 
 	SAFE_WAIT(&status);
 	if (WIFEXITED(status)) {
diff --git a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
index 83de9b447..dd6b68948 100644
--- a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
+++ b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
@@ -95,7 +95,7 @@ static void make_a_baby(int argc, char *argv[])
 		tst_exit();
 	}
 
-	execlp(argv[0], argv[0], "child", NULL);
+	execlp(argv[0], argv[0], "child", (char *)NULL);
 	tst_resm(TFAIL, "execlp() failed");
 	tst_exit();
 }
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 79ca23e08..941a7e5af 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -49,7 +49,7 @@ static void run(void)
 	/* child after exec() we are no longer allowed to set pgid */
 	child_pid = SAFE_FORK();
 	if (!child_pid)
-		SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
+		SAFE_EXECLP(TEST_APP, TEST_APP, (char *)NULL);
 
 	TST_CHECKPOINT_WAIT(0);
 
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit04.c b/testcases/kernel/syscalls/setrlimit/setrlimit04.c
index 5648f5103..c897b643a 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit04.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit04.c
@@ -35,7 +35,7 @@ static void test_setrlimit(void)
 
 	child = SAFE_FORK();
 	if (child == 0)
-		SAFE_EXECLP("/bin/true", "/bin/true", NULL);
+		SAFE_EXECLP("/bin/true", "/bin/true", (char *)NULL);
 	SAFE_WAITPID(child, &status, 0);
 
 	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
diff --git a/testcases/network/nfsv4/acl/acl1.c b/testcases/network/nfsv4/acl/acl1.c
index ad778cd33..ea71cf977 100644
--- a/testcases/network/nfsv4/acl/acl1.c
+++ b/testcases/network/nfsv4/acl/acl1.c
@@ -52,7 +52,7 @@ int do_file_op(char *filename)
 	uid = geteuid();
 	strcat(str, filename);
 
-	exe = execl(str, NULL, NULL);
+	exe = execl(str, NULL, (char *)NULL);
 	if (exe == -1 && errno != EACCES)
 		result = result + OP_EXEC;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c
index 1e9096b23..bd8b4f92e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c
@@ -183,7 +183,7 @@ int main(void)
 
 	if (p3 == 0) {		/* child */
 		sem = common();
-		ret = execl("/bin/ls", "ls", NULL);
+		ret = execl("/bin/ls", "ls", (char *)NULL);
 		UNRESOLVED(errno, "Failed to exec");
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
index e9f9a8f71..aee0c9b94 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
@@ -68,7 +68,7 @@ int main(int argc, char *argv[])
 		} else {
 			strcpy(path, argv[0]);
 		}
-		execl(path, argv[0], "verify", NULL);
+		execl(path, argv[0], "verify", (char *)NULL);
 		printf("Failed: execl() errno: %s\n", strerror(errno));
 		exit(PTS_UNRESOLVED);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/9-1.c
index a68879389..8c65da322 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/9-1.c
@@ -71,7 +71,7 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	if (execl("/bin/sleep", "sleep", "3", NULL) == -1) {
+	if (execl("/bin/sleep", "sleep", "3", (char *)NULL) == -1) {
 		printf("Test FAILED\n");
 		return PTS_FAIL;
 	}
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
