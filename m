Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3122C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:59:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E696109E
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3E696109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CA613C6A67
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 13:59:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDEC93C0CEE
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:59:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CF7D91001957
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:59:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B74171FD45;
 Wed, 27 Oct 2021 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635335977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPwyvNoGCRU48VQvnC4ng7HvefxVjPt+EIvDuQJnN74=;
 b=sTwqmNDozW8NbCW6WF/IS+TcrH5DuKN3Uh0o0B5m9z0GZ7RUi/PxE9cypw6yKNoIOvBT1e
 8SO775PfPK6BeVwiO2j2dxmuLooMGNpbjjli3X1s2o3KTRFhnJEJ9Q2tUX3N+riuvyvCGh
 kAgDFe7vxCaGG8oahF912ccRsb8pi1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635335977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPwyvNoGCRU48VQvnC4ng7HvefxVjPt+EIvDuQJnN74=;
 b=Vik5jxSxnVP56g6cHw0QE4bmZAg+BSCxF0tKz9p3vedNXrbJCBITplA6/Sk5ccXfEoeruO
 oS62MuqQKhxvOLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9561413C2B;
 Wed, 27 Oct 2021 11:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1OESIyk/eWEzeAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 27 Oct 2021 11:59:37 +0000
Date: Wed, 27 Oct 2021 14:00:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YXk/WyJ0a4dio1Sr@yuki>
References: <20211014012533.18205-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211014012533.18205-1-zhanglianjie@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/5] syscalls/clone02: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * [Description]

Ideally we should put one empty line after the description.

> + *   TEST1

And this could be slightly better described than TEST1, something as:

/*\
 * [Description]
 *
 * clone() share all test
 *
 * - call clone() with all resources shared
 * ...
 *
 * clone() share none test
 *
 * - call clone() no resources shared
 * ...
 */

> + * - call clone() with all resources shared.
> + * - child modify the shared resources.
> + * - parent wait for child to finish.
> + * - verify that the shared resourses are modified.
> + * - if the parent shared resource is modified, then pass.
>   *	 TEST2
> - *	 -----
> - *		Call clone() with no resources shared.
> - *
> - *		CHILD:
> - *			modify the resources in child's address space
> - *			return 1 on success
> - *		PARENT:
> - *			wait for child to finish
> - *			verify that the parent's resourses are not modified
> - *			return 1 on success
> - *		If parent & child returns successfully
> - *			test passed
> - *		else
> - *			test failed
> + * - call clone() with no resources shared.
> + * - modify the resources in child's address space.
> + * - parent wait for child to finish.
> + * - verify that the parent's resourses are not modified.
> + * - if the parent shared resource are modified, then pass.
                 ^
This is actually wrong, this case passes if resources are not modified

Also we can omit the last sentence completely in both cases it does not
add anything over the line that says "- verify ..."


>   */
> 
> -#if defined UCLINUX && !__THROW
> -/* workaround for libc bug */
> -#define __THROW
> -#endif
> -
>  #define _GNU_SOURCE
> 
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <sys/wait.h>
> -#include <sys/types.h>
> -#include <sys/syscall.h>
>  #include <sched.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "clone_platform.h"
> 
> +#define TESTFILE "testfile"
> +#define TESTDIR "testdir"
>  #define FLAG_ALL (CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|SIGCHLD)
>  #define FLAG_NONE SIGCHLD
>  #define PARENT_VALUE 1
>  #define CHILD_VALUE 2
> -#define TRUE 1
> -#define FALSE 0
> -
> -#include "clone_platform.h"
> -
> -static void setup(void);
> -static int test_setup(void);
> -static void cleanup(void);
> -static void test_cleanup(void);
> -static int child_fn();
> -static int parent_test1(void);
> -static int parent_test2(void);
> -static int test_VM(void);
> -static int test_FS(void);
> -static int test_FILES(void);
> -static int test_SIG(void);
> -static int modified_VM(void);
> -static int modified_FS(void);
> -static int modified_FILES(void);
> -static int modified_SIG(void);
> -static void sig_child_defined_handler(int);
> -static void sig_default_handler();
> 
>  static int fd_parent;
> -static char file_name[25];
>  static int parent_variable;
> -static char cwd_parent[FILENAME_MAX];
> +static char *cwd_parent;
>  static int parent_got_signal, child_pid;
> -
> -char *TCID = "clone02";
> -
> -struct test_case_t {
> -	int flags;
> -	int (*parent_fn) ();
> -} test_cases[] = {
> -	{
> -	FLAG_ALL, parent_test1}, {
> -	FLAG_NONE, parent_test2}
> +static void *child_stack;
> +static char cwd_child[FILENAME_MAX];
> +
> +static char *res_name[] = {
> +	[1] = "CLONE_VM",
> +	[2] = "CLONE_FS",
> +	[4] = "CLONE_FILES",
> +	[8] = "CLONE_SIGHAND",
>  };
> 
> -int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
> -
> -int main(int ac, char **av)
> -{
> -
> -	int lc;
> -	void *child_stack;
> -	int status, i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	child_stack = malloc(CHILD_STACK_SIZE);
> -	if (child_stack == NULL)
> -		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; ++i) {
> -			if (test_setup() != 0) {
> -				tst_resm(TWARN, "test_setup() failed, skipping this test case");
> -				continue;
> -			}
> -
> -			/* Test the system call */
> -			TEST(ltp_clone(test_cases[i].flags, child_fn, NULL,
> -				       CHILD_STACK_SIZE, child_stack));
> -
> -			/* check return code */
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL | TTERRNO, "clone() failed");
> -				/* Cleanup & continue with next test case */
> -				test_cleanup();
> -				continue;
> -			}
> -
> -			/* Wait for child to finish */
> -			if ((wait(&status)) == -1) {
> -				tst_resm(TWARN | TERRNO,
> -					 "wait failed; skipping testcase");
> -				/* Cleanup & continue with next test case */
> -				test_cleanup();
> -				continue;
> -			}
> -
> -			if (WTERMSIG(status))
> -				tst_resm(TWARN, "child exitied with signal %d",
> -					 WTERMSIG(status));
> -
> -			/*
> -			 * Check the return value from child function and
> -			 * parent function. If both functions returned
> -			 * successfully, test passed, else failed
> -			 */
> -			if (WIFEXITED(status) && WEXITSTATUS(status) == 0 &&
> -			    test_cases[i].parent_fn())
> -				tst_resm(TPASS, "Test Passed");
> -			else
> -				tst_resm(TFAIL, "Test Failed");
> -
> -			/* Do test specific cleanup */
> -			test_cleanup();
> -		}
> -	}
> -
> -	free(child_stack);
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> +static void sig_child_defined_handler(int pid LTP_ATTRIBUTE_UNUSED)
>  {
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -
> -	/* Get unique file name for each child process */
> -	if ((sprintf(file_name, "parent_file_%ld", syscall(__NR_gettid))) <= 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "sprintf() failed");
> +	TEST(tst_syscall(__NR_gettid));

There is no point in using the TEST() macro here, we do not need to save
the errno at all, just do:

	int tid = tst_syscall(__NR_gettid);

> +	if (TST_RET == child_pid)
> +		tst_res(TWARN, "Child got SIGUSR2 signal");
> +	else
> +		parent_got_signal = 1;
>  }
> 
> -static void cleanup(void)
> +static void modify_resources(void)
>  {
> -	if (unlink(file_name) == -1)
> -		tst_resm(TWARN | TERRNO, "unlink(%s) failed", file_name);
> -	tst_rmdir();
> -}
> +	struct sigaction new_act;
> 
> -static int test_setup(void)
> -{
> +	parent_variable = CHILD_VALUE;
> 
> -	struct sigaction def_act;
> +	close(fd_parent);

Please use SAFE_CLOSE() here as well. The SAFE_CLOSE() also sets the fd
to -1 after it has been closed so we can use this to detect that the
file have been closed in the reset_resource();

> -	/* Save current working directory of parent */
> -	if (getcwd(cwd_parent, sizeof(cwd_parent)) == NULL) {
> -		tst_resm(TWARN | TERRNO, "getcwd() failed in test_setup()");
> -		return -1;
> -	}
> +	SAFE_CHDIR(cwd_child);
> 
> -	/*
> -	 * Set value for parent_variable in parent, which will be
> -	 * changed by child in test_VM(), for testing CLONE_VM flag
> -	 */
> -	parent_variable = PARENT_VALUE;
> +	new_act.sa_handler = sig_child_defined_handler;
> +	new_act.sa_flags = SA_RESTART;
> +	SAFE_SIGEMPTYSET(&new_act.sa_mask);
> 
> -	/*
> -	 * Open file from parent, which will be closed by
> -	 * child in test_FILES(), used for testing CLONE_FILES flag
> -	 */
> -	fd_parent = open(file_name, O_CREAT | O_RDWR, 0777);
> -	if (fd_parent == -1) {
> -		tst_resm(TWARN | TERRNO, "open() failed in test_setup()");
> -		return -1;
> -	}
> +	SAFE_SIGACTION(SIGUSR2, &new_act, NULL);
> +	SAFE_KILL(getppid(), SIGUSR2);
> +}
> 
> -	/*
> -	 * set parent_got_signal to FALSE, used for testing
> -	 * CLONE_SIGHAND flag
> -	 */
> -	parent_got_signal = FALSE;
> +static int verify_resources(void)
> +{
> +	char buff[20];
> +	char cwd[FILENAME_MAX];
> 
> -	/* Setup signal handler for SIGUSR2 */
> -	def_act.sa_handler = sig_default_handler;
> -	def_act.sa_flags = SA_RESTART;
> -	sigemptyset(&def_act.sa_mask);
> +	unsigned int changed = 0;
> 
> -	if (sigaction(SIGUSR2, &def_act, NULL) == -1) {
> -		tst_resm(TWARN | TERRNO, "sigaction() failed in test_setup()");
> -		return -1;
> -	}
> +	if (parent_variable == CHILD_VALUE)
> +		changed |= CLONE_VM;
> 
> -	return 0;
> -}
> +	if (((read(fd_parent, buff, sizeof(buff))) == -1) && (errno == EBADF))
> +		changed |= CLONE_FS;
> +	else
> +		SAFE_CLOSE(fd_parent);
> 
> -static void test_cleanup(void)
> -{
> +	SAFE_GETCWD(cwd, sizeof(cwd));
> +	if (strcmp(cwd, cwd_parent))
> +		changed |= CLONE_FILES;
> 
> -	/* Restore parent's working directory */
> -	SAFE_CHDIR(cleanup, cwd_parent);
> +	if (parent_got_signal)
> +		changed |= CLONE_SIGHAND;
> 
> +	return changed;
>  }
> 
> -static int child_fn(void)
> +static void sig_parent_default_handler(int pid LTP_ATTRIBUTE_UNUSED)
>  {
> 
> -	/* save child pid */
> -	child_pid = syscall(__NR_gettid);
> -
> -	if (test_VM() == 0 && test_FILES() == 0 && test_FS() == 0 &&
> -	    test_SIG() == 0)
> -		_exit(0);
> -	_exit(1);
>  }
> 
> -static int parent_test1(void)
> +static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
> +	TEST(tst_syscall(__NR_gettid));
> +	child_pid = TST_RET;

Here as well, just do:

	child_pid = tst_syscall(__NR_gettid);

> -	/*
> -	 * For first test case (with all flags set), all resources are
> -	 * shared between parent and child. So whatever changes made by
> -	 * child should get reflected in parent also. modified_*()
> -	 * functions check this. All of them should return 1 for
> -	 * parent_test1() to return 1
> -	 */
> -
> -	if (modified_VM() && modified_FILES() && modified_FS() &&
> -	    modified_SIG())
> -		return 0;
> -	return -1;
> +	modify_resources();
> +	_exit(0);
>  }
> 
> -static int parent_test2(void)
> +static void reset_resources(void)
>  {
> +	struct sigaction def_act;
> 
> -	/*
> -	 * For second test case (with no resouce shared), all of the
> -	 * modified_*() functions should return 0 for parent_test2()
> -	 * to return 1
> -	 */
> -	if (modified_VM() || modified_FILES() || modified_FS() ||
> -	    modified_SIG())
> -		return 0;
> +	parent_variable = PARENT_VALUE;
> +	fd_parent = SAFE_OPEN(TESTFILE, O_CREAT | O_RDWR, 0777);

I guess that we may as well drop the SAFE_CLOSE() from the
verify_resouce() and reopen the fd only when it was actually closed.

If we use SAFE_CLOSE() in the child we can simply check if the fd is
valid with:

	if (fd_parent <= 0)
		fd_parent = SAFE_OPEN(...);

> +	parent_got_signal = 0;
> +	SAFE_CHDIR(cwd_parent);
> 
> -	return -1;
> +	def_act.sa_handler = sig_parent_default_handler;
> +	def_act.sa_flags = SA_RESTART;
> +	SAFE_SIGEMPTYSET(&def_act.sa_mask);
> +	SAFE_SIGACTION(SIGUSR2, &def_act, NULL);
>  }
> 
> -/*
> - * test_VM() - function to change parent_variable from child's
> - *	       address space. If CLONE_VM flag is set, child shares
> - *	       the memory space with parent so this will be visible
> - *	       to parent also.
> - */
> -
> -static int test_VM(void)
> -{
> -	parent_variable = CHILD_VALUE;
> -	return 0;
> -}
> +struct tcase {
> +	unsigned long flags;
> +	char *desc;
> +} tcases[] = {
> +	{FLAG_ALL, "clone() with all resources shared"},
> +	{FLAG_NONE, "clone() with all no resources shared"}
> +};
> 
> -/*
> - * test_FILES() - This function closes a file descriptor opened by
> - *		  parent. If CLONE_FILES flag is set, the parent and
> - *		  the child process share the same file descriptor
> - *		  table. so this affects the parent also
> - */
> -static int test_FILES(void)
> +static void verify_clone(unsigned int tc)
>  {
> -	if (close(fd_parent) == -1) {
> -		tst_resm(TWARN | TERRNO, "close failed in test_FILES");
> -		return -1;
> -	}
> -	return 0;
> -}
> +	unsigned int flag;
> +	unsigned int i;
> 
> -/*
> - * test_FS() -  This function changes the current working directory
> - *		of the child process. If CLONE_FS flag is set, this
> - *		will be visible to parent also.
> - */
> -static int test_FS(void)
> -{
> -	char *test_tmpdir;
> -	int rval;
> -
> -	test_tmpdir = tst_get_tmpdir();
> -	if (test_tmpdir == NULL) {
> -		tst_resm(TWARN | TERRNO, "tst_get_tmpdir failed");
> -		rval = -1;
> -	} else if (chdir(test_tmpdir) == -1) {
> -		tst_resm(TWARN | TERRNO, "chdir failed in test_FS");
> -		rval = -1;
> -	} else {
> -		rval = 0;
> -	}
> +	tst_res(TINFO, "%s", tcases[tc].desc);
> 
> -	free(test_tmpdir);
> -	return rval;
> -}
> +	reset_resources();
> 
> -/*
> - * test_SIG() - This function changes the signal handler for SIGUSR2
> - *		signal for child. If CLONE_SIGHAND flag is set, this
> - *		affects parent also.
> - */
> -static int test_SIG(void)
> -{
> +	TST_EXP_PID_SILENT(ltp_clone(tcases[tc].flags, child_fn, NULL,
> +				CHILD_STACK_SIZE, child_stack));
> 
> -	struct sigaction new_act;
> +	if (!TST_PASS)
> +		return;
> 
> -	new_act.sa_handler = sig_child_defined_handler;
> -	new_act.sa_flags = SA_RESTART;
> -	sigemptyset(&new_act.sa_mask);
> +	tst_reap_children();
> 
> -	/* Set signal handler to sig_child_defined_handler */
> -	if (sigaction(SIGUSR2, &new_act, NULL) == -1) {
> -		tst_resm(TWARN | TERRNO, "signal failed in test_SIG");
> -		return -1;
> -	}
> +	flag = verify_resources();
> 
> -	/* Send SIGUSR2 signal to parent */
> -	if (kill(getppid(), SIGUSR2) == -1) {
> -		tst_resm(TWARN | TERRNO, "kill failed in test_SIG");
> -		return -1;
> +	for (i = CLONE_VM; i <= CLONE_SIGHAND; i <<= 1) {
> +		if (tcases[tc].flags == FLAG_ALL) {
> +			if (flag & i)
> +				tst_res(TPASS, "The resource %s of the parent process has changed", res_name[i >> 8]);
> +			else
> +				tst_res(TFAIL, "The resource %s of the parent process has not changed", res_name[i >> 8]);

I would make the messages less verbose and more to the point something
as:

		if (flag & i)
			tst_res(TPASS, "%s was shared with child");
		else
			tst_res(TFAIL, "%s was not shared with child");

> +		} else {
> +			if (flag & i)
> +				tst_res(TFAIL, "The resource %s of the parent process has changed", res_name[i >> 8]);
> +			else
> +				tst_res(TPASS, "The resource %s of the parent process has not changed", res_name[i >> 8]);
> +		}
>  	}
> -
> -	return 0;
> -}
> -
> -/*
> - * modified_VM() - This function is called by parent process to check
> - *		   whether child's modification to parent_variable
> - *		   is visible to parent
> - */
> -
> -static int modified_VM(void)
> -{
> -
> -	if (parent_variable == CHILD_VALUE)
> -		/* child has modified parent_variable */
> -		return 1;
> -
> -	return 0;
>  }
> 
> -/*
> - * modified_FILES() - This function checks for file descriptor table
> - *		      modifications done by child
> - */
> -static int modified_FILES(void)
> +static void cleanup(void)
>  {
> -	char buff[20];
> -
> -	if (((read(fd_parent, buff, sizeof(buff))) == -1) && (errno == EBADF))
> -		/* Child has closed this file descriptor */
> -		return 1;
> -
> -	/* close fd_parent */
> -	if ((close(fd_parent)) == -1)
> -		tst_resm(TWARN | TERRNO, "close() failed in modified_FILES()");
> -
> -	return 0;
> +	SAFE_CHDIR(cwd_parent);
> +	SAFE_UNLINK(TESTFILE);

There is no need to unlink anything here, the test library will do that
for you.

> +	free(cwd_parent);
>  }
> 
> -/*
> - * modified_FS() - This function checks parent's current working directory
> - *		   to see whether its modified by child or not.
> - */
> -static int modified_FS(void)
> +static void setup(void)
>  {
> -	char cwd[FILENAME_MAX];
> -
> -	if ((getcwd(cwd, sizeof(cwd))) == NULL)
> -		tst_resm(TWARN | TERRNO, "getcwd() failed");
> -
> -	if (!(strcmp(cwd, cwd_parent)))
> -		/* cwd hasn't changed */
> -		return 0;
> -
> -	return 1;
> -}
> +	struct sigaction def_act;
> 
> -/*
> - * modified_SIG() - This function checks whether child has changed
> - *		    parent's signal handler for signal, SIGUSR2
> - */
> -static int modified_SIG(void)
> -{
> +	/* Save current working directory of parent */
> +	cwd_parent = tst_get_tmpdir();
> 
> -	if (parent_got_signal)
> -		/*
> -		 * parent came through sig_child_defined_handler()
> -		 * this means child has changed parent's handler
> -		 */
> -		return 1;
> +	/*
> +	 * Set value for parent_variable in parent, which will be
> +	 * changed by child for testing CLONE_VM flag
> +	 */
> +	parent_variable = PARENT_VALUE;
> 
> -	return 0;
> -}
> +	/*
> +	 * Open file from parent, which will be closed by
> +	 * child, used for testing CLONE_FILES flag
> +	 */
> +	fd_parent = SAFE_OPEN(TESTFILE, O_CREAT | O_RDWR, 0777);

Since we call reset_resources() in the verify_clone() function now, most
of the code can be removed from the setup.

> -/*
> - * sig_child_defined_handler()  - Signal handler installed by child
> - */
> -static void sig_child_defined_handler(int pid)
> -{
> -	if ((syscall(__NR_gettid)) == child_pid)
> -		/* Child got signal, give warning */
> -		tst_resm(TWARN, "Child got SIGUSR2 signal");
> -	else
> -		parent_got_signal = TRUE;
> -}
> +	/*
> +	 * set parent_got_signal to 0, used for testing
> +	 * CLONE_SIGHAND flag
> +	 */
> +	parent_got_signal = 0;
> 
> -/* sig_default_handler() - Default handler for parent */
> -static void sig_default_handler(void)
> -{
> -}
> +	def_act.sa_handler = sig_parent_default_handler;
> +	def_act.sa_flags = SA_RESTART;
> +	SAFE_SIGEMPTYSET(&def_act.sa_mask);
> +	SAFE_SIGACTION(SIGUSR2, &def_act, NULL);
> +
> +	SAFE_MKDIR(TESTDIR, 0777);
> +	sprintf(cwd_child, "%s/%s", cwd_parent, TESTDIR);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_clone,
> +	.bufs = (struct tst_buffers []) {
> +		{&child_stack, .size = CHILD_STACK_SIZE},

The array is missing the terminating element {} without it the test will
crash randomly.

> +	},
> +	.needs_tmpdir = 1,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
