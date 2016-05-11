From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 May 2016 14:23:52 +0200
Subject: [LTP] [PATCH 1/2] checkpoints: avoid unnecesasry sleep in
 checkpoint_wake
In-Reply-To: <b1cd0d1691b4d5416fdc34dd6b35dee1b7909a7c.1462968075.git.jstancek@redhat.com>
References: <b1cd0d1691b4d5416fdc34dd6b35dee1b7909a7c.1462968075.git.jstancek@redhat.com>
Message-ID: <20160511122352.GC24701@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> checkpoint_wake is currently sleeping also in case when
> it wakes up all processes. This creates problem for combination
> of checkpoints and process_state_wait, because it creates
> false impression, that child is sleeping on operation
> following checkpoint_wake (#2), while it really sleeps inside
> checkpoint_wake (#1).
> 
>       child                      parent
> TST_CHECKPOINT_WAKE #1
>                                TST_CHECKPOINT_WAIT
>                                TST_PROCESS_STATE_WAIT(child, 'S')
>                                kill(child, SIGINT)
> sleep() #2
> 
> This patch avoids sleep in checkpoint_wake if all processes has been
> already woken up.

Good catch.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  lib/tst_checkpoint.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 8f23ead26a8a..128e658153c6 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -109,6 +109,10 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
>  	do {
>  		waked += syscall(SYS_futex, &tst_futexes[id], FUTEX_WAKE,
>  				 INT_MAX, NULL);
> +
> +		if (waked == nr_wake)
> +			break;
> +
>  		usleep(1000);
>  		msecs++;

I guess that we can also change the do { } while (waked != nr_wake) loop
to for (;;) { } now.

-- 
Cyril Hrubis
chrubis@suse.cz
