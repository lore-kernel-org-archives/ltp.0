From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Apr 2016 18:58:49 +0200
Subject: [LTP] [PATCH] syscalls/msgctl13: fix error when run on the new
 system
In-Reply-To: <1460187421-2578-1-git-send-email-cuibixuan@huawei.com>
References: <1460187421-2578-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <20160411165848.GA3466@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The msqid is 0 when a new message queue is created by msgget()
> on the new system. Then 'TEST(msgget(msg_q, MSG_RW))' succeed
> unexpectedly.
> 
> Run 'msg_q = msgget(IPC_PRIVATE, MSG_RW)', we get:
> 	msgget(IPC_PRIVATE, 0600)               = 0
> The msg_q is 0 when create it on the new system.Next:
> 	msgctl(0, IPC_RMID, 0)                  = 0
> 	msgget(IPC_PRIVATE, 0600)               = 32768
> 
> The msg_q is equal to IPC_PRIVATE which is defined at kernel,
> So msgget() will create a new message queue again and return
> success unexpectedly.

I've been able to reproduce the failure, for me the test failed on first
attempt after machine reboot then continued to work fine as the ID
returned from kernel seems to start at 0 and increases slowly.

I guess that we do not see the failure in LTP since there are other
msgctl() testcases executed before it.

Also running the testcase about 7000 times wraps around the msgid and
makes the test fail (you have to remove the message queue with key 0 by
hand since the test leaves it on the system).

> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
> ---
>  testcases/kernel/syscalls/ipc/msgctl/msgctl13.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
> index e170d6b..721dd88 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
> @@ -60,9 +60,11 @@ static void msgctl_verify(void)
>  {
>  	int msg_q;
>  
> -	msg_q = msgget(IPC_PRIVATE, MSG_RW);
> -	if (msg_q == -1)
> -		tst_brkm(TBROK, cleanup, "Can't create message queue");
> +	do {
> +		msg_q = msgget(IPC_PRIVATE, MSG_RW);
> +		if (msg_q == -1)
> +			tst_brkm(TBROK, cleanup, "Can't create message queue");
> +	} while (!msg_q);
>  
>  	TEST(msgctl(msg_q, IPC_RMID, NULL));

This change leaks memory (leaves the message queue with key = 0 on the
system) and relies on a fact that IPC_PRIVATE == 0 which may not be
necessarilly true. Can't we instead do IPC_STAT on the msg_q and expect
it to fail?

-- 
Cyril Hrubis
chrubis@suse.cz
