Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FE1C77B73
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 08:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 810543CB279
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 10:27:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEF5B3C9956
 for <ltp@lists.linux.it>; Wed, 24 May 2023 10:26:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00B316008F9
 for <ltp@lists.linux.it>; Wed, 24 May 2023 10:26:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C9D1223B6;
 Wed, 24 May 2023 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684916813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IvJjaGH95K4LBrNd9oCcXpl0PSXHUafxCmRq+Dazue0=;
 b=bRK4vPiOjGMESdqLN766B76xv4GAkzhXrFB2bDIa68/4XmHIp/AwsEPC7BDGXw9/bJGEkj
 h8c7NqEllr6XaG89YjXVK+XDD2DNDzclHcwdpCe68EBkUHoyKpejV2AI3HjvFMy7LaggTg
 UgpagKOgX4sPNcc3FgIZ3IQ4hSXFwtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684916813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IvJjaGH95K4LBrNd9oCcXpl0PSXHUafxCmRq+Dazue0=;
 b=T5B/tsHDpgdxrgtUY8fCBu0lRC4REfAdXwR9dCDe09EDnXangZwN++U6RWIx88r8yXumXv
 YNC44VAM4FWvENDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76CF7133E6;
 Wed, 24 May 2023 08:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lMneG03KbWTLXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 24 May 2023 08:26:53 +0000
Date: Wed, 24 May 2023 10:28:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZG3Kk5KbhtRdktYL@yuki>
References: <20230508084616.21322-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508084616.21322-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Remove libclone dependency from pidns05 test
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
> +// SPDX-License-Identifier: GPL-2.0

The original test was GPL-2.0-or-later, please pay a bit more attention
on the licenses, it's tedious and boring but it helps us avoid a trouble
in the long term.

> -	/* The loop breaks, when the loop counter reaches the parentpid value */
> -	for (i = parentpid + 1; i != parentpid; i++) {
> -		if (i > pid_max)
> -			i = 2;
> -
> +	for (i = parentpid + 1; i < pid_max; i++) {
>  		pgid2 = getpgid(i);

I do not think that this change is correct. The difference is that if
parentpid is close to pid_max the child pids would "overflow".

I suppose the easiest solution is to scan everything from 2 to pid_max
instead of depending on signed overflow, which I think is undefined to
begin with.

>  		if (pgid2 == pgid) {
>  			pids[next] = i;
>  			next++;
>  		}
>  	}
> +
>  	return next;
>  }
>  
> -/*
> -* create_nested_container() Recursively create MAX_DEPTH nested containers
> -*/
> -int create_nested_container(void *vtest)
> +static void setup(void)
>  {
> -	int exit_val;
> -	int ret, count, *level;
> -	pid_t cpid, ppid;
> -	cpid = getpid();
> -	ppid = getppid();
> -	char mesg[] = "Nested Containers are created";
> -
> -	level = (int *)vtest;
> -	count = *level;
> -
> -	/* Child process closes up read side of pipe */
> -	close(fd[0]);
> -
> -	/* Comparing the values to make sure pidns is created correctly */
> -	if (cpid != CINIT_PID || ppid != PARENT_PID) {
> -		printf("Got unexpected cpid and/or ppid (cpid=%d ppid=%d)\n",
> -		       cpid, ppid);
> -		exit_val = 1;
> -	}
> -	if (count > 1) {
> -		count--;
> -		ret = do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
> -					    create_nested_container,
> -					    (void *)&count);
> -		if (ret == -1) {
> -			printf("clone failed; errno = %d : %s\n",
> -			       ret, strerror(ret));
> -			exit_val = 1;
> -		} else
> -			exit_val = 0;
> -	} else {
> -		/* Sending mesg, 'Nested containers created' through the pipe */
> -		write(fd[1], mesg, (strlen(mesg) + 1));
> -		exit_val = 0;
> -	}
> -
> -	close(fd[1]);
> -	pause();
> -
> -	return exit_val;
> +	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
>  }
>  
> -void kill_nested_containers()
> +static void run(void)
>  {
> -	int orig_count, new_count, status = 0, i;
> -	pid_t pids[MAX_DEPTH];
> +	int i, status, children;
> +	int level = 0;
>  	pid_t pids_new[MAX_DEPTH];
> +	pid_t pids[MAX_DEPTH];
> +	pid_t pid;
>  
> -	orig_count = find_cinit_pids(pids);
> -	kill(pids[MAX_DEPTH - 3], SIGKILL);
> -	sleep(1);
> -
> -	/* After killing child container, getting the New PID list */
> -	new_count = find_cinit_pids(pids_new);
> -
> -	/* Verifying that the child containers were destroyed when parent is killed */
> -	if (orig_count - 2 != new_count)
> -		status = -1;
> -
> -	for (i = 0; i < new_count; i++) {
> -		if (pids[i] != pids_new[i])
> -			status = -1;
> +	pid = SAFE_CLONE(&clone_args);
> +	if (!pid) {
> +		child_func(&level);
> +		return;
>  	}
>  
> -	if (status == 0)
> -		tst_resm(TPASS, "The number of containers killed are %d",
> -			 orig_count - new_count);
> -	else
> -		tst_resm(TFAIL, "Failed to kill the sub-containers of "
> -			 "the container %d", pids[MAX_DEPTH - 3]);
> -
> -	/* Loops through the containers created to exit from sleep() */
> -	for (i = 0; i < MAX_DEPTH; i++) {
> -		kill(pids[i], SIGKILL);
> -		waitpid(pids[i], &status, 0);
> -	}
> -}
> +	TST_CHECKPOINT_WAIT(0);
>  
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newpid();
> -}
> +	find_cinit_pids(pids);
>  
> -int main(void)
> -{
> -	int ret, nbytes, status;
> -	char readbuffer[80];
> -	pid_t pid, pgid;
> -	int count = MAX_DEPTH;
> +	SAFE_KILL(pids[0], SIGKILL);

Why do we do the find_cinit_pids() here and kill(pids[0], ...) shouldn't
we just use the pid from the clone above?

> -	setup();
> +	TST_RETRY_FUNC(waitpid(0, &status, WNOHANG), TST_RETVAL_NOTNULL);

Why are we wrapping WNOHANG call to waitpid into RETRY_FUNC? Just do
SAFE_WAITPID() without the WNOHANG.

Are you trying to collect all children here? That will not work at all
with the retry func, as it will exit on first succesful waitpid.

The original code did waitpid() for the top level child only here if you
want to wait all of them, you have to loop with WNOHANG and you can
count them in the loop as well...

> -	/*
> -	 * XXX (garrcoop): why in the hell is this fork-wait written this way?
> -	 * This doesn't add up with the pattern used for the rest of the tests,
> -	 * so I'm pretty damn sure this test is written incorrectly.
> -	 */
> -	pid = fork();
> -	if (pid == -1) {
> -		tst_brkm(TBROK | TERRNO, NULL, "fork failed");
> -	} else if (pid != 0) {
> -		/*
> -		 * NOTE: use waitpid so that we know we're waiting for the
> -		 * _top-level_ child instead of a spawned subcontainer.
> -		 *
> -		 * XXX (garrcoop): Might want to mask SIGCHLD in the top-level
> -		 * child too, or not *shrugs*.
> -		 */
> -		if (waitpid(pid, &status, 0) == -1) {
> -			perror("wait failed");
> -		}
> -		if (WIFEXITED(status))
> -			exit(WEXITSTATUS(status));
> -		else
> -			exit(status);
> -	}
> +	children = find_cinit_pids(pids_new);
>  
> -	/* To make all the containers share the same PGID as its parent */
> -	setpgid(0, 0);
> +	if (children > 0) {
> +		tst_res(TFAIL, "%d children left after sending SIGKILL", children);
>  
> -	pid = getpid();
> -	pgid = getpgid(pid);
> -	SAFE_PIPE(NULL, fd);
> +		for (i = 0; i < MAX_DEPTH; i++) {
> +			kill(pids[i], SIGKILL);
> +			waitpid(pids[i], &status, 0);
> +		}
>  
> -	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
> -				   create_nested_container, (void *)&count));
> -	if (TEST_RETURN == -1) {
> -		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
> +		return;
>  	}
>  
> -	close(fd[1]);
> -	/* Waiting for the MAX_DEPTH number of containers to be created */
> -	nbytes = read(fd[0], readbuffer, sizeof(readbuffer));
> -	close(fd[0]);
> -	if (nbytes > 0)
> -		tst_resm(TINFO, " %d %s", MAX_DEPTH, readbuffer);
> -	else
> -		tst_brkm(TFAIL, NULL, "unable to create %d containers",
> -			 MAX_DEPTH);
> -
> -	/* Kill the container created */
> -	kill_nested_containers();
> -
> -	tst_exit();
> +	tst_res(TPASS, "No children left after sending SIGKILL to the first child");
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +	.forks_child = 1,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
