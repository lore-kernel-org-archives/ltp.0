From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Jul 2021 09:55:19 +0200
Subject: [LTP] [PATCH v2 2/2] msgget03: don't depend on existed shared
 resources
In-Reply-To: <20210712075223.10682-2-aleksei.kodanev@bell-sw.com>
References: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
 <20210712075223.10682-2-aleksei.kodanev@bell-sw.com>
Message-ID: <YPkkZ0Zq9DyHKBaT@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Li,

> It's unlikely, but still possible that some of them could be
> created/released during the test as well, so the patch only
> checks errno.

> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
> v2: * Move the loop to the test run function and try to get
>       ENOSPC errno there.

>  .../kernel/syscalls/ipc/msgget/msgget03.c     | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)

> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> index 76cf82cd3..1ade8f942 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> @@ -26,29 +26,30 @@ static key_t msgkey;

>  static void verify_msgget(void)
>  {
> -	TST_EXP_FAIL2(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL), ENOSPC,
> -		"msgget(%i, %i)", msgkey + maxmsgs, IPC_CREAT | IPC_EXCL);
> +	int res = 0, num;
> +
> +	errno = 0;
> +	for (num = 0; num <= maxmsgs; ++num) {
In different patch [1] (I forget you already send patches to fix this) I counted
items in /proc/sysvipc/shm. Not sure what is safer: <= looks a bit drastic
(how about bug which reports ENOSPC much earlier than it should be?), but
obviously new mapping from other program created in the middle of testing.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210722073523.5099-1-pvorel@suse.cz/
> +		res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
> +		if (res == -1)
> +			break;
> +		queues[queue_cnt++] = res;
> +	}
> +
> +	if (res != -1 || errno != ENOSPC)
> +		tst_brk(TFAIL | TERRNO, "Failed to trigger ENOSPC error");
> +
> +	tst_res(TPASS, "Maximum number of queues reached (%d), used by test %d",
> +		maxmsgs, queue_cnt);
>  }
...
