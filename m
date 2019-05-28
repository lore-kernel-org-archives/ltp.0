From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 May 2019 15:22:51 +0200
Subject: [LTP] [PATCH v1 4/4] syscalls/pidfd_send_signal03
In-Reply-To: <20190515120116.11589-4-camann@suse.com>
References: <20190515120116.11589-1-camann@suse.com>
 <20190515120116.11589-4-camann@suse.com>
Message-ID: <20190528132251.GA25532@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define _GNU_SOURCE
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include "pidfd_send_signal.h"
> +#include "tst_safe_pthread.h"
> +
> +#define PIDTRIES	3
> +
> +static char *last_pid_file;
> +static int pidfd, last_pidfd;
> +
> +static void verify_pidfd_send_signal(void)
> +{
> +	pid_t pid, new_pid;
> +	char pid_filename[32];
> +	char pid_str[16];
> +	int i, fail;
> +
> +	fail = 1;
> +	for (i = 1; i <= PIDTRIES; i++) {
> +		pid = SAFE_FORK();
> +		if (pid == 0) {
> +			TST_CHECKPOINT_WAIT(0);
> +			return;
> +		}
> +
> +		sprintf(pid_filename, "/proc/%d", pid);
> +		pidfd = SAFE_OPEN(pid_filename, O_DIRECTORY | O_CLOEXEC);
> +
> +		TST_CHECKPOINT_WAKE(0);
> +		tst_reap_children();
> +
> +		/* Manipulate PID for next process */
> +		sprintf(pid_str, "%d", pid - 1);
> +		SAFE_LSEEK(last_pidfd, 0, SEEK_SET);
> +		SAFE_WRITE(1, last_pidfd, pid_str, strlen(pid_str));

		We do have SAFE_FILE_PRINTF() for this purpose.

> +		new_pid = SAFE_FORK();
> +		if (new_pid == 0) {
> +			TST_CHECKPOINT_WAIT(i);
> +			return;
> +		} else if (new_pid == pid) {

No need for else here if you do return in the if above.

> +			fail = 0;
> +			break;
> +		}
> +
> +		if (i < PIDTRIES)
> +			tst_res(TINFO,
> +				"Failed to set correct PID, trying again...");
> +		SAFE_CLOSE(pidfd);
> +		TST_CHECKPOINT_WAKE(i);

Do we really need to use checkpoint i here? The checkpoint 0 should be
unused at this point...

> +		tst_reap_children();
> +	}
> +	if (fail)
> +		tst_brk(TBROK,
> +			"Could not set new child to same PID as the old one!");
> +
> +	TEST(tst_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0));
> +	if (TST_RET == -1 && TST_ERR == ESRCH) {
> +		tst_res(TPASS,
> +			"Did not send signal to wrong process with same PID!");
> +	} else
> +		tst_res(TFAIL | TTERRNO,
> +			"pidf_send_signal() ended unexpectedly - return value: %ld, error",
> +			TST_RET);

Other obvious test would be opening the pidfd of the new pid and
comparing if they point out to the same file by comparing i-nodes, see
ioctl_ns05.c.

> +	TST_CHECKPOINT_WAKE(i);
> +	tst_reap_children();
> +
> +	SAFE_CLOSE(pidfd);
> +}
> +
> +static void setup(void)
> +{
> +	last_pid_file = "/proc/sys/kernel/ns_last_pid";
> +	if (access(last_pid_file, F_OK) == -1)
> +		tst_brk(TCONF, "%s does not exist, cannot set PIDs",
> +			last_pid_file);
> +	last_pidfd = SAFE_OPEN(last_pid_file, O_RDWR);
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_reap_children();
> +	if (pidfd > 0)
> +		SAFE_CLOSE(pidfd);
> +	if (last_pidfd > 0)
> +		SAFE_CLOSE(last_pidfd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_pidfd_send_signal,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +	.forks_child = 1,
> +	.timeout = 20,
> +};
> -- 
> 2.16.4
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
