From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 Oct 2019 14:56:26 +0200
Subject: [LTP] [Patch v4.1] fzsync: revoke thread_b if parent hits
 accidental break
In-Reply-To: <20190926093921.21247-1-liwang@redhat.com>
References: <20190926093921.21247-1-liwang@redhat.com>
Message-ID: <20191008125625.GA6180@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi LI,

> We shouldn't rely entirely on the pair->exit flag in tst_fzsync_pair_cleanup()
> since there is possible to call tst_brk() at anyplace of thread_a, that will
> lead to timeout eventually because of thread_b(tst_fzsync_wait_b) fall into
> an infinite(no explicit condition to exit) loop.

> Thread_a path trace:
>   tst_brk()
>     cleanup()
>       tst_fzsync_pair_cleanup()
>         SAFE_PTHREAD_JOIN(pair->thread_b, NULL)
>         #Or pthread_cancel(pair->thread_b)

> We fix the problem via a way to kill thread_b with pthread_cancel. With new
> thread wrapper involves enabling thread cancel at the start of the thread B,
> then do asynchronous cancellation in tst_fzsync_pair_cleanup if pair->exit
> is not being set to 1.

> Workaround: [commit 2e74d996: Check recvmmsg exists before entering fuzzy loop]
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
