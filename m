From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Dec 2017 13:58:47 +0100
Subject: [LTP] [PATCH 2/2] pthread_create-14-1: avoid threads sharing
 stack
In-Reply-To: <0a71c4e2a415aacde674a25f13f762e856921a11.1512397856.git.jstancek@redhat.com>
References: <8075a8711d2f1a9e5449cd317f78ad5d312b9bca.1512397856.git.jstancek@redhat.com>
 <0a71c4e2a415aacde674a25f13f762e856921a11.1512397856.git.jstancek@redhat.com>
Message-ID: <20171206125846.GA26328@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Copyright (c) 2004, Bull S.A..  All rights reserved.
> + * Copyright (c) 2017, Linux Test Project
> + * Created by: Sebastien Decugis
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + *
> + * This sample test aims to check the following assertion:
> + * The function does not return EINTR
> + *
> + * The steps are:
> + * -> continuously send SIGUSR1 to a thread which runs pthread_create()
> + * -> check that EINTR is never returned
> + */
> +
> +/* We are testing conformance to IEEE Std 1003.1, 2003 Edition */
> +#define _POSIX_C_SOURCE 200112L
> +
> +/* Some routines are part of the XSI Extensions */
> +#ifndef WITHOUT_XOPEN
> +#define _XOPEN_SOURCE	600
> +#endif
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <pthread.h>
> +#include <semaphore.h>
> +#include <signal.h>
> +#include <sys/wait.h>
> +#include <sys/time.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include "../testfrmw/testfrmw.h"
> +#include "../testfrmw/testfrmw.c"
> +#include "../testfrmw/threads_scenarii.c"
> +#include "safe_helpers.h"
> +
> +#define RUN_TIME_USEC (2*1000*1000)
> +#define SIGNALS_WITHOUT_DELAY 100
> +
> +/* total number of signals sent */
> +static unsigned long count_sig;
> +/* sleep [us] in between signals */
> +static unsigned long sleep_time;
          ^
Shouldn't this be volatile too?

We reset it from the test() thread while it's used in a loop in the
sendsig() thread.

> +/* signal thread active flag */
> +static volatile int sendsig_active;
> +/* number of pthread_create scenarios tested */
> +static unsigned long count_ope;
> +
> +static unsigned long current_time_usec(void)
> +{
> +	struct timeval now;
> +
> +	SAFE_FUNC(gettimeofday(&now, NULL));
> +	return now.tv_sec * 1000000 + now.tv_usec;
> +}
> +
> +/* the following function keeps sending signal to the process */
> +static void *sendsig(void *arg)
> +{
> +	static sigset_t usersigs;
> +
> +	(void)arg;
> +	pid_t process = getpid();
> +
> +	/* block the signal SIGUSR1 for this THREAD */
> +	SAFE_FUNC(sigemptyset(&usersigs));
> +	SAFE_FUNC(sigaddset(&usersigs, SIGUSR1));
> +	SAFE_PFUNC(pthread_sigmask(SIG_BLOCK, &usersigs, NULL));
> +
> +	while (sendsig_active) {
> +		if (!sendsig_active)
> +			break;

Why do we have the condition for sendsig_active twice here?

> +		/*
> +		 * Keep increasing sleeptime to make sure we progress
> +		 * allow SIGNALS_WITHOUT_DELAY signals without any pause,
> +		 * then start increasing sleep_time to make sure all threads
> +		 * can progress.
> +		 */
> +		sleep_time++;
> +		if (sleep_time / SIGNALS_WITHOUT_DELAY > 0)
> +			usleep(sleep_time / SIGNALS_WITHOUT_DELAY);
> +
> +		count_sig++;
> +		SAFE_FUNC(kill(process, SIGUSR1));
> +	}
> +	return NULL;
> +}
> +
> +static void sighdl1(int sig)
> +{
> +	(void)sig;
> +}
> +
> +static void *threaded(void *arg)
> +{
> +	int ret;
> +
> +	/* Signal we're done (especially in case of a detached thread) */
> +	do {
> +		ret = sem_post(&scenarii[sc].sem);
> +	} while ((ret == -1) && (errno == EINTR));
> +
> +	if (ret == -1)
> +		UNRESOLVED(errno, "Failed to wait for the semaphore");
> +
> +	return arg;
> +}
> +
> +/* create threads and check that EINTR is never returned */
> +static void test(void)
> +{
> +	int ret = 0;
> +	pthread_t child;
> +	pthread_t th_sig1;
> +	struct sigaction sa;
> +
> +	sigemptyset(&sa.sa_mask);
> +	sa.sa_flags = 0;
> +	sa.sa_handler = sighdl1;
> +	SAFE_FUNC(sigaction(SIGUSR1, &sa, NULL));
> +
> +	sendsig_active = 1;
> +	SAFE_PFUNC(pthread_create(&th_sig1, NULL, sendsig, NULL));
> +
> +	for (sc = 0; sc < NSCENAR; sc++) {
> +		/* reset sleep time for signal thread */
> +		sleep_time = 0;
> +
> +		ret = pthread_create(&child, &scenarii[sc].ta, threaded, NULL);
> +		if (ret == EINTR)
> +			FAILED("pthread_create returned EINTR");
> +
> +		switch (scenarii[sc].result) {
> +		case 0:	/* Operation was expected to succeed */
> +			if (ret != 0)
> +				UNRESOLVED(ret, "Failed to create this thread");
> +			break;
> +		case 1:	/* Operation was expected to fail */
> +			if (ret == 0) {
> +				UNRESOLVED(-1, "An error was expected but"
> +					" the thread creation succeeded");
> +			}
> +			break;
> +		case 2:	/* We did not know the expected result */
> +		default:
> +			break;
> +		}
> +
> +		if (ret != 0)
> +			continue;
> +
> +		/* The new thread is running */
> +		/* Just wait for the thread to terminate */
> +		do {
> +			ret = sem_wait(&scenarii[sc].sem);
> +		} while ((ret == -1) && (errno == EINTR));
> +		if (ret == -1)
> +			UNRESOLVED(errno, "Failed to wait for the semaphore");
> +		if (scenarii[sc].detached == 0)
> +			SAFE_PFUNC(pthread_join(child, NULL));
> +	}
> +	sendsig_active = 0;

We may possibly simplify the whole thread that sends the signals by
letting it run in an infinite loop, it will be reaped by the exit() int
the main_loop() anyway.

Or does disabling it here make the test faster (do we get more
iterations)?

> +	SAFE_PFUNC(pthread_join(th_sig1, NULL));
> +}
> +
> +static void main_loop(void)
> +{
> +	int child_count = 0;
> +	int ret;
> +	int status;
> +	int stat_pipe[2];
> +	pid_t child;
> +	unsigned long usec_start, usec;
> +	unsigned long child_count_sig;
> +
> +	usec_start = current_time_usec();
> +	do {
> +		fflush(stdout);
> +		SAFE_FUNC(pipe(stat_pipe));
> +		child = fork();

We should handle the fork() failures here as well, even if it's quite
unlikely to happen.

> +		if (child == 0) {
> +			count_sig = 0;
> +			close(stat_pipe[0]);
> +			test();
> +			SAFE_FUNC(write(stat_pipe[1], &count_sig,
> +				sizeof(count_sig)));
> +			close(stat_pipe[1]);
> +			exit(0);
> +		}
> +		close(stat_pipe[1]);
> +		SAFE_FUNC(read(stat_pipe[0], &child_count_sig,
> +			sizeof(count_sig)));
> +		close(stat_pipe[0]);
> +		count_sig += child_count_sig;
> +
> +		ret = waitpid(child, &status, 0);
> +		if (ret != child)
> +			UNRESOLVED(errno, "Waitpid returned the wrong PID");
> +		if (!WIFEXITED(status)) {
> +			output("status: %d\n", status);
> +			FAILED("Child exited abnormally");
> +		}
> +		if (WEXITSTATUS(status) != 0) {
> +			output("exit status: %d\n", WEXITSTATUS(status));
> +			FAILED("An error occurred in child");
> +		}
> +
> +		child_count++;
> +		count_ope += NSCENAR;
> +		usec = current_time_usec();
> +	} while ((usec - usec_start) < RUN_TIME_USEC);
> +
> +	output("Test spawned %d child processes.\n", child_count);
> +	output("Test finished after %lu usec.\n", usec - usec_start);
> +}
> +
> +int main(void)
> +{
> +	output_init();
> +	scenar_init();
> +	main_loop();
> +	scenar_fini();
> +
> +	output("Test executed successfully.\n");
> +	output("  %d thread creations.\n", count_ope);
> +	output("  %d signals were sent meanwhile.\n", count_sig);
> +	PASSED;
> +}

Other than that this looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
