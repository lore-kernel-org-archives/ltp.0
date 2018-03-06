From: Michael Moese <mmoese@suse.de>
Date: Tue, 6 Mar 2018 13:35:14 +0100
Subject: [LTP] [PATCH v4 3/3] Add regression test for CVE-2017-17053
In-Reply-To: <20180305163057.GB19862@rei.lan>
References: <20180212100341.23841-1-mmoese@suse.de>
 <20180212100341.23841-4-mmoese@suse.de>
 <20180305163057.GB19862@rei.lan>
Message-ID: <20180306123514.k7yxz77kxqm3tpnf@linux.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

On Mon, Mar 05, 2018 at 05:30:57PM +0100, Cyril Hrubis wrote:
> Hi!
> > +#include <asm/ldt.h>
> > +#include <pthread.h>
> > +#include <signal.h>
> > +#include <stdlib.h>
> > +#include <sys/syscall.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +
> > +#include "tst_test.h"
> > +#include "tst_taint.h"
> > +#include "tst_safe_pthread.h"
> > +#include "lapi/syscalls.h"
> > +
> > +#define EXEC_USEC   5000000
> > +
> > +static volatile sig_atomic_t *do_exit;
> > +
> > +static void handler(int sig, siginfo_t *si, void *unused)
> > +{
> > +	(void)(sig);
> > +	(void)(si);
> > +	(void)(unused);
> > +
> > +	*do_exit = -1;
> > +}
> > +
> > +static void install_sighandler(void)
> > +{
> > +	struct sigaction sa;
> > +
> > +	sa.sa_flags = SA_SIGINFO;
> > +	sigemptyset(&sa.sa_mask);
> > +	sa.sa_sigaction = handler;
> 
> Haven't I told to use sa.sa_handler instead? Since we are not using the
> extra two arguments anyway.
> 
I possibly forgot to change that - but corrected this.

> > +	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> > +
> > +	do_exit = SAFE_MMAP(NULL, sizeof(*do_exit), PROT_READ | PROT_WRITE,
> > +			    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > +
> > +	*do_exit = 0;
> 
> There is no need to zero it here as we have to reset the flag in the
> run() function as well.
> 
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	SAFE_MUNMAP(do_exit, sizeof(*do_exit));
> > +}
> > +
> > +static void *fork_thread(void *arg)
> > +{
> > +	SAFE_FORK();
> > +	return arg;
> > +}
> > +
> > +
> > +void run_test(void)
> > +{
> > +	struct user_desc desc = { .entry_number = 8191 };
> > +	install_sighandler();
> > +
> > +	syscall(__NR_modify_ldt, 1, &desc, sizeof(desc));
> > +
> > +	for (;;) {
> > +		if (*do_exit)
> > +			exit(0);
> > +
> > +		if (SAFE_FORK() == 0) {
> > +			pthread_t t;
> > +
> > +			srand(getpid());
> > +			SAFE_PTHREAD_CREATE(&t, NULL, fork_thread, NULL);
> > +			usleep(rand() % 10000);
> > +			syscall(__NR_exit_group, 0);
> > +		}
> > +	}
> > +}
> > +
> > +void run(void)
> > +{
> > +	int status;
> > +	pid_t pid;
> > +
> > +	*do_exit = 0;
> > +	pid = SAFE_FORK();
> > +
> > +	if (pid == 0) {
> > +		run_test();
> > +	} else {
> > +		usleep(EXEC_USEC);
> > +		*do_exit = 1;
> > +	}
> > +
> > +	SAFE_WAIT(&status);
> > +	if ((*do_exit == -1) || !WIFEXITED(status) || (tst_taint_check() != 0))
> > +		tst_res(TFAIL, "kernel is vulnerable");
> > +	else
> > +		tst_res(TPASS, "kernel survived");
> 
> We do overwrite the do_exit in the parent process unconditionally, hence
> it will always end up with 1 after we got to the SAFE_WAIT() here, or
> did I overlooked something?
> 
> We mmap() a page of shared memory in the test setup anyways so I suppose
> that adding a second int pointer called segfaulted or something similar
> that would be set from the signal handler would be cleanest solution.

Agreed. I changed the shared memory to a struct and added a second member to it 
for this. In this version, a value of -1 for do_exit was used to signal the 
segfault. However, having a second field is much cleaner. I will do some testing
that I did not break anything and then resend.

> > +}
> > +
> > +static struct tst_test test = {
> > +	.forks_child = 1,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = run,
> > +};
> > -- 
> > 2.13.6
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Michael

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
