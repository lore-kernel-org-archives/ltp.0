From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 3 Mar 2016 15:37:04 +0800
Subject: [LTP] [PATCH v2] epoll_pwait/epoll_pwait01.c: add new testcase
In-Reply-To: <20160302153222.GD25763@rei>
References: <20160209140206.GB11823@rei.lan>
 <1455870804-11471-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20160302153222.GD25763@rei>
Message-ID: <56D7E9A0.4060701@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Thanks for your review!

OK, I will modify the test case according to your suggestion.

Best Regards,
Guangwen Feng

On 03/02/2016 11:32 PM, Cyril Hrubis wrote:
> Hi!
>> +/*
>> + * Description:
>> + *  Basic test for epoll_pwait(2).
>> + *  1) epoll_pwait(2) with sigmask argument allows the caller to
>> + *     safely wait until either a file descriptor becomes ready
>> + *     or the timeout expires.
>> + *  2) epoll_pwait(2) with NULL sigmask argument fails if
>> + *     interrupted by a signal handler, epoll_pwait(2) should
>> + *     return -1 and set errno to EINTR.
>> + */
>> +
>> +#include <sys/epoll.h>
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +
>> +#include "test.h"
>> +#include "epoll_pwait.h"
>> +#include "safe_macros.h"
>> +
>> +char *TCID = "epoll_pwait01";
>> +int TST_TOTAL = 2;
>> +
>> +static int epfd, fds[2];
>> +static const char buf[] = "Testing";
>> +static sigset_t sigset;
>> +static struct epoll_event epevs;
>> +static struct sigaction sa;
>> +
>> +static void setup(void);
>> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED);
>> +static void do_test(sigset_t *);
>> +static void do_child(void);
>> +static void cleanup(void);
>> +
>> +int main(int ac, char **av)
>> +{
>> +	int lc;
>> +
>> +	tst_parse_opts(ac, av, NULL, NULL);
>> +
>> +	setup();
>> +
>> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> +		tst_count = 0;
>> +
>> +		do_test(&sigset);
>> +		do_test(NULL);
>> +	}
>> +
>> +	cleanup();
>> +	tst_exit();
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	if ((tst_kvercmp(2, 6, 19)) < 0) {
>> +		tst_brkm(TCONF, NULL, "This test can only run on kernels "
>> +			 "that are 2.6.19 or higher");
>> +	}
>> +
>> +	tst_sig(FORK, DEF_HANDLER, cleanup);
>> +
>> +	TEST_PAUSE;
>> +
>> +	if (sigemptyset(&sigset) == -1)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "sigemptyset() failed");
>> +
>> +	if (sigaddset(&sigset, SIGUSR1) == -1)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "sigaddset() failed");
>> +
>> +	sa.sa_flags = 0;
>> +	sa.sa_handler = sighandler;
>> +	if (sigemptyset(&sa.sa_mask) == -1)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "sigemptyset() failed");
>> +
>> +	if (sigaction(SIGUSR1, &sa, NULL) == -1)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "sigaction() failed");
>> +
>> +	SAFE_PIPE(NULL, fds);
>> +
>> +	epfd = epoll_create(1);
>> +	if (epfd == -1) {
>> +		tst_brkm(TBROK | TERRNO, cleanup,
>> +			 "failed to create epoll instance");
>> +	}
>> +
>> +	epevs.events = EPOLLIN;
>> +	epevs.data.fd = fds[0];
>> +
>> +	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs) == -1) {
>> +		tst_brkm(TBROK | TERRNO, cleanup,
>> +			 "failed to register epoll target");
>> +	}
>> +}
>> +
>> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>> +{
>> +
>> +}
>> +
>> +static void do_test(sigset_t *sigmask)
>> +{
>> +	char read_buf[sizeof(buf)];
>> +	pid_t cpid;
>> +
>> +	cpid = tst_fork();
>> +	if (cpid < 0)
>> +		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
>> +
>> +	if (cpid == 0)
>> +		do_child();
>> +
>> +	TEST(epoll_pwait(epfd, &epevs, 1, -1, sigmask));
>> +
>> +	if (sigmask != NULL) {
>> +		if (TEST_RETURN == -1) {
>> +			tst_resm(TFAIL | TTERRNO, "epoll_pwait() failed");
>> +		} else if (TEST_RETURN != 1) {
>> +			tst_resm(TFAIL, "epoll_pwait() returned %li, "
>> +				 "expected 1", TEST_RETURN);
>> +		} else {
>> +			tst_resm(TPASS, "epoll_pwait(sigmask) blocked signal");
>> +		}
>> +	} else {
>> +		if (TEST_RETURN != -1) {
>> +			tst_resm(TFAIL, "epoll_wait() succeeded unexpectedly");
>> +		} else {
>> +			if (TEST_ERRNO == EINTR) {
>> +				tst_resm(TPASS | TTERRNO,
>> +					 "epoll_wait() failed as expected");
>> +			} else {
>> +				tst_resm(TFAIL | TTERRNO,
>> +					 "epoll_wait() failed unexpectedly, "
>> +					 "expected errno is EINTR");
>> +			}
>> +		}
>> +	}
> 
> 
> Can we put the checks in a separate functions and call them from here?
> 
>> +	tst_record_childstatus(cleanup, cpid);
>> +
>> +	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(buf));
>> +}
>> +
>> +static void do_child(void)
>> +{
>> +	if (tst_process_state_wait2(getppid(), 'S') != 0) {
>> +		tst_brkm(TBROK | TERRNO, cleanup,
>> +			 "failed to wait for parent process's state");
>> +	}
>> +
>> +	SAFE_KILL(cleanup, getppid(), SIGUSR1);
>> +
>> +	sleep(1);
> 
> One second is too much, 0.1 second should be more than enough for the
> test.
> 
>> +	SAFE_WRITE(cleanup, 1, fds[1], buf, sizeof(buf));
> 
> Technically we don't have to write anything here (and we could exit the
> child without sleeping as well) if we passed a timeout to the
> epoll_pwait() instead in the parent (we would have to check for timeout
> instead of success but that shouldn't matter in this test).
> 
>> +	cleanup();
>> +	tst_exit();
>> +}
> 
> Otherwise it looks good.
> 


