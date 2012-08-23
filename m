Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T4VGH-0001Xe-IR
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 11:07:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4VGG-0005nY-5u
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 11:07:41 +0000
Message-ID: <50360EF3.4020803@redhat.com>
Date: Thu, 23 Aug 2012 13:07:31 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <1624892809.9377039.1345705748634.JavaMail.root@redhat.com>
In-Reply-To: <1624892809.9377039.1345705748634.JavaMail.root@redhat.com>
Content-Type: multipart/mixed; boundary="------------050900060400010109060709"
Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment fault
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng Zhao <Zhenfeng.Zhao@windriver.com>

This is a multi-part message in MIME format.
--------------050900060400010109060709
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id
	q7NB7YAN006969

On 08/23/2012 09:09 AM, Jan Stancek wrote:
>=20
>=20
> ----- Original Message -----
>> From: "Kang Kai" <Kai.Kang@windriver.com>
>> To: "Jan Stancek" <jstancek@redhat.com>, gaowanlong@cn.fujitsu.com
>> Cc: ltp-list@lists.sourceforge.net, "Zhenfeng Zhao" <Zhenfeng.Zhao@win=
driver.com>
>> Sent: Thursday, 23 August, 2012 8:21:43 AM
>> Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment =
fault
>>
>> On 2012=E5=B9=B408=E6=9C=8822=E6=97=A5 22:20, Jan Stancek wrote:
>>> On 08/22/2012 10:58 AM, Jan Stancek wrote:
>>>>
>>>> ----- Original Message -----
>>>>> From: "Kang Kai"<Kai.Kang@windriver.com>
>>>>> To: "Jan Stancek"<jstancek@redhat.com>
>>>>> Cc: gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net,
>>>>> "Zhenfeng Zhao"<Zhenfeng.Zhao@windriver.com>
>>>>> Sent: Wednesday, 22 August, 2012 10:28:59 AM
>>>>> Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for
>>>>> segment fault
>>>>> Hi Jan,
>>>>>
>>>>>> Is the above output from mips or x86_64?
>>>>>> Are you running it as root user?
>>>>> This was tested on x86_64 with unprivileged  user. I retest it
>>>>> with
>>>>> root
>>>>> and test passes.
>>>> Your unprivileged user is hitting some resource limit, I'd be
>>>> interested
>>>> to see how many threads are actually running at the same time.
>>>>
>>>>> It passes on routerstation(mips) with your patch too.
>>>>> So it looks like a race condition issue about stack attribute
>>>>> between
>>>>> threads, right?
>>>> I think so. We can try different way of signalling when threaded()
>>>> is done
>>>> and try it again with all scenarios.
>>> I think this testcase is broken in more than 1 way. At least on my
>>> setup, I don't see
>>> a single pthread_detach() while signals are firing - which is
>>> exactly goal of this test.
>>>
>>> With following change:
>>>
>>> diff --git
>>> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detac=
h/4-3.c
>>> b/testcases/open_posix_testsuite/conforman
>>> index dfa6e19..48e1343 100644
>>> ---
>>> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detac=
h/4-3.c
>>> +++
>>> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detac=
h/4-3.c
>>> @@ -277,6 +276,7 @@ int main(int argc, char *argv[])
>>>                  do_it1 =3D 0;
>>>          } while (do_it1);
>>>
>>> +       output("  %d thread detached while signals were firing.\n",
>>> count_ope);
>>>          sleep(1);
>>>
>>>          do {
>>>
>>> I get:
>>> [16:11:23]  1 thread detached while signals are firing.
>>> [16:11:24]Test executed successfully.
>>> [16:11:24]  77865 thread detached.
>>>
>>> and that reported "1" is how many threads attempted to call
>>> pthread_detach, not how many actually
>>> succeeded. Signals are firing so frequently that threaded() can't
>>> progress at all.
>=20
>> Then how do we fix this case? sync sending the signals with
>> pthread_detach?
>=20
> I was thinking usleep(sleep_time) that progressively increases. So it
> starts firing signals as quickly as it can and slows down over time.
> Each pthread_detach() would reset the sleep_time.
>=20
> As for our original issue, idea I'm playing with is:
>=20
> main (procA) - do_child (procB) - send_sig (thread)
>                                 \=20
>                                   test (thread) - threaded (detached th=
read)
>=20
> - turn 'while' in test() to single 'for' loop
> - loop in main, fork and call do_child, wait for child to finish

Hi,

attached is v1 of the idea above. I ran it 100x times on various
setups as root and unprivileged user.=20

Kai, would you like to give a try?

Regards,
Jan

>=20
> This way we can be sure, that we don't reuse same stack for multiple th=
reads,
> and we can also be sure, there won't be more than NSCENAR threads, so u=
nprivileged
> user should not run out of resources.
>=20
> Regards,
> Jan
>=20
>>
>> Wanlong, any comments?
>>
>> Thanks,
>> Kai
>>
>>>
>>> Regards,
>>> Jan
>>>
>>
>>
>=20
> -----------------------------------------------------------------------=
-------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond. Discussio=
ns=20
> will include endpoint security, mobile security and the latest in malwa=
re=20
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--------------050900060400010109060709
Content-Type: text/x-csrc;
 name="4-3.c"
Content-Disposition: attachment;
 filename="4-3.c"
Content-Transfer-Encoding: 7bit

/*
 * Copyright (c) 2004, Bull S.A..  All rights reserved.
 * Created by: Sebastien Decugis
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it would be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write the Free Software Foundation, Inc., 59
 * Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * This sample test aims to check the following assertion:
 *
 * The function does not return EINTR
 *
 * The steps are:
 * -> kill a thread which calls pthread_detach()
 * -> check that EINTR is never returned
 *
 */

#define _POSIX_C_SOURCE 200112L

/* Some routines are part of the XSI Extensions */
#ifndef WITHOUT_XOPEN
#define _XOPEN_SOURCE	600
#endif

#include <sys/time.h>
#include <sys/wait.h>
#include <assert.h>
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <semaphore.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "../testfrmw/testfrmw.h"
#include "../testfrmw/testfrmw.c"

#define SAFE(op) if ((op) == -1) UNRESOLVED(errno, "unexpected failure");

#define SIGNALS_WITHOUT_DELAY 100
#ifndef VERBOSE
#define VERBOSE 1
#endif
#define WITH_SYNCHRO
#define RUN_TIME_USEC 2*1000*1000

#include "../testfrmw/threads_scenarii.c"

#ifdef WITH_SYNCHRO
static sem_t semsig1;
#endif
static unsigned long count_sig;
static volatile int do_it1 = 1;
static unsigned long sleep_time;
static unsigned long count_ope;
static sigset_t usersigs;

struct thestruct {
	int	sig;
#ifdef WITH_SYNCHRO
	sem_t	*sem;
#endif
};

unsigned long current_time_usec()
{
	struct timeval now;
	SAFE(gettimeofday(&now, NULL));
	return now.tv_sec * 1000000 + now.tv_usec;
}

/* the following function keeps on sending the signal to the process */
static void *sendsig(void *arg)
{
	struct thestruct *thearg = (struct thestruct *)arg;
	int ret;
	pid_t process;

	process = getpid();

	/* We block the signals SIGUSR1 and SIGUSR2 for this THREAD */
	ret = pthread_sigmask(SIG_BLOCK, &usersigs, NULL);
	if (ret != 0)
		UNRESOLVED(ret, "Unable to block SIGUSR1 and SIGUSR2"
			   " in signal thread");

	while (do_it1) {
#ifdef WITH_SYNCHRO
		ret = sem_wait(thearg->sem);
		if (ret)
			UNRESOLVED(errno, "Sem_wait in sendsig");
		if (!do_it1)
			break;

		count_sig++;
#endif
		/* keep increasing sleeptime to make sure we progress
		 * allow SIGNALS_WITHOUT_DELAY signals without any pause,
		 * then start increasing sleep_time to make sure all threads
		 * can progress */
		sleep_time++;
		if (sleep_time / SIGNALS_WITHOUT_DELAY > 0)
			usleep(sleep_time / SIGNALS_WITHOUT_DELAY);

		ret = kill(process, thearg->sig);
		if (ret != 0)
			UNRESOLVED(errno, "Kill in sendsig");
	}
	return NULL;
}

static void sighdl1(int sig)
{
#ifdef WITH_SYNCHRO
	if (sem_post(&semsig1))
		UNRESOLVED(errno, "Sem_post in signal handler 1");
#endif
}

static void *threaded(void *arg)
{
	int ret;

	/* We don't block the signals SIGUSR1 and SIGUSR2 for this THREAD */
	ret = pthread_sigmask(SIG_UNBLOCK, &usersigs, NULL);
	if (ret != 0)
		UNRESOLVED(ret, "Unable to unblock SIGUSR1 and SIGUSR2"
			   " in worker thread");

	ret = pthread_detach(pthread_self());
	if (ret == EINTR)
		FAILED("pthread_detach() returned EINTR");

	/* Signal we're done */
	do {
		ret = sem_post(&scenarii[sc].sem);
	} while ((ret == -1) && (errno == EINTR));
	if (ret == -1)
		UNRESOLVED(errno, "Failed to wait for the semaphore");

	return arg;
}

static void *test(void *arg)
{
	int ret = 0;
	pthread_t child;

	/* We block the signals SIGUSR1 and SIGUSR2 for this THREAD */
	ret = pthread_sigmask(SIG_BLOCK, &usersigs, NULL);
	if (ret != 0)
		UNRESOLVED(ret, "Unable to block SIGUSR1 and SIGUSR2"
			   " in signal thread");

	for (sc = 0; sc < NSCENAR; sc++) {
#if VERBOSE > 5
		output("-----\n");
		output("Starting test with scenario (%i): %s\n",
			sc, scenarii[sc].descr);
#endif
		/* reset sleep time for signal thread */
		sleep_time = 0;

		/* thread which is already detached is not interesting
		 * for this test, skip it */
		if (scenarii[sc].detached == 1)
			continue;

		ret = pthread_create(&child, &scenarii[sc].ta, threaded, NULL);
		switch (scenarii[sc].result) {
		case 0: /* Operation was expected to succeed */
			if (ret != 0)
				UNRESOLVED(ret, "Failed to create this thread");
			break;

		case 1: /* Operation was expected to fail */
			if (ret == 0)
				UNRESOLVED(-1, "An error was expected but the"
					   " thread creation succeeded");
			break;

		case 2: /* We did not know the expected result */
		default:
#if VERBOSE > 5
			if (ret == 0)
				output("Thread has been created successfully"
					" for this scenario\n");
			else
				output("Thread creation failed with the error:"
					" %s\n", strerror(ret));
#endif
			break;
		}
		if (ret == 0) {
			/* Just wait for the thread to terminate */
			do {
				ret = sem_wait(&scenarii[sc].sem);
			} while ((ret == -1) && (errno == EINTR));
			if (ret == -1)
				UNRESOLVED(errno, "Failed to wait for the"
					   " semaphore");
		}
	}

	return NULL;
}

void do_child()
{
	struct thestruct arg1;
	pthread_t th_work, th_sig1;
	struct sigaction sa;
	int ret;

	/* We prepare a signal set which includes SIGUSR1 and SIGUSR2 */
	sigemptyset(&usersigs);
	ret = sigaddset(&usersigs, SIGUSR1);
	/* ret |= sigaddset(&usersigs, SIGUSR2); */
	if (ret != 0)
		UNRESOLVED(ret, "Unable to add SIGUSR1 or 2 to a signal set");

	/* We now block the signals SIGUSR1 and SIGUSR2 for this THREAD */
	ret = pthread_sigmask(SIG_BLOCK, &usersigs, NULL);
	if (ret != 0)
		UNRESOLVED(ret, "Unable to block SIGUSR1 and SIGUSR2"
			   " in main thread");

	/* We need to register the signal handlers for the PROCESS */
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = 0;
	sa.sa_handler = sighdl1;

	ret = sigaction(SIGUSR1, &sa, NULL);
	if (ret)
		UNRESOLVED(ret, "Unable to register signal handler1");

	arg1.sig = SIGUSR1;
#ifdef WITH_SYNCHRO
	if (sem_init(&semsig1, 0, 1))
		UNRESOLVED(errno, "Semsig1  init");
	arg1.sem = &semsig1;
#endif

	count_sig = 0;
	ret = pthread_create(&th_sig1, NULL, sendsig, &arg1);
	if (ret)
		UNRESOLVED(ret, "Signal 1 sender thread creation failed");

	ret = pthread_create(&th_work, NULL, test, NULL);
	if (ret)
		UNRESOLVED(ret, "Worker thread creation failed");

	ret = pthread_join(th_work, NULL);
	if (ret)
		UNRESOLVED(ret, "Worker thread join failed");

	/* to be extra safe unblock signals in this thread,
	 * so signal thread won't get stuck on sem_wait */
	ret = pthread_sigmask(SIG_UNBLOCK, &usersigs, NULL);
	if (ret != 0)
		UNRESOLVED(ret, "Failed to unblock signals");
	do_it1 = 0;
#ifdef WITH_SYNCHRO
	/* if it's already stuck on sem_wait, up the semaphore */
	if (sem_post(&semsig1))
		UNRESOLVED(errno, "Sem_post in do_child");
#endif
	ret = pthread_join(th_sig1, NULL);
	if (ret)
		UNRESOLVED(ret, "Worker thread join failed");
}

void main_loop()
{
	int child_count = 0;
	int stat_pipe[2];
	int ret;
	int status;
	pid_t child;
	unsigned long usec_start, usec;
	unsigned long child_count_sig;

	usec_start = current_time_usec();
	do {
		SAFE(pipe(stat_pipe));

		child_count++;
		count_ope += NSCENAR;
		child = fork();
		if (child == 0) {
			close(stat_pipe[0]);
			do_child();
			SAFE(write(stat_pipe[1], &count_sig, sizeof(count_sig)));
			close(stat_pipe[1]);
			pthread_exit(0);
			UNRESOLVED(0, "Should not be reached");
			exit(0);
		}
		close(stat_pipe[1]);
		SAFE(read(stat_pipe[0], &child_count_sig, sizeof(count_sig)));
		close(stat_pipe[0]);
		count_sig += child_count_sig;

		ret = waitpid(child, &status, 0);
		if (ret != child)
			UNRESOLVED(errno, "Waitpid returned the wrong PID");

		if (!WIFEXITED(status)) {
			output("status: %d\n", status);
			FAILED("Child exited abnormally");
		}

		if (WEXITSTATUS(status) != 0) {
			output("exit status: %d\n", WEXITSTATUS(status));
			FAILED("An error occured in child");
		}

		usec = current_time_usec();
	} while ((usec - usec_start) < RUN_TIME_USEC);
	output("Test spawned %d child processes.\n", child_count);
	output("Test finished after %lu usec.\n", usec - usec_start);
}

int main(int argc, char *argv[])
{
	int ret;

	output_init();
	scenar_init();
	main_loop();
	scenar_fini();

#if VERBOSE > 0
	output("Test executed successfully.\n");
	output("  %d threads detached.\n", count_ope);
#ifdef WITH_SYNCHRO
	output("  %d signals were sent meanwhile.\n", count_sig);
#endif
#endif
	PASSED;
}

--------------050900060400010109060709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------050900060400010109060709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050900060400010109060709--

