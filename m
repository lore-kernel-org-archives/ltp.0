From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Apr 2020 00:12:45 +0200
Subject: [LTP] [PATCH 1/1] net/sendfile01.sh: Check with timeout
In-Reply-To: <dab04fc5-5d20-3dbc-c21f-535112ab222f@oracle.com>
References: <20200421180002.11351-1-pvorel@suse.cz>
 <dab04fc5-5d20-3dbc-c21f-535112ab222f@oracle.com>
Message-ID: <20200423221245.GA1391884@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > I guess nothing controversial here as failure of starting server is
> > guarded by -s.
> > I was thinking about using TST_RETRY_FUNC, but passing command to it
> > leads to: tst_rhost_run: unknown option: l


> Hi Petr,

> eval might help in this case, take a look at tst_retry() in test.sh
Good point.

> old api, not sure why exactly it was removed in the new one...
It was designed from scratch I guess.
But this patch makes sense to me, I'll test it tomorrow.

> index 1d8a71d9f..e34edb26a 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -207,7 +207,7 @@ TST_RETRY_FN_EXP_BACKOFF()
>         fi

>         while true; do
> -               $tst_fun
> +               eval "$tst_fun"
>                 if [ "$?" = "$tst_exp" ]; then
>                         break
>                 fi

> > What bothers me more, that TST_NEEDS_CMDS does not check command on
> > rhost. Do we want to have something like TST_NEEDS_CMDS_RHOST or we just
> > don't care?

> In general, yes, we need to check if a command exists on the remote host.
> Yet another variable, what about checking what in TST_NEEDS_CMDS on the
> remote host? Though TST_NEEDS_CMDS_RHOST looks quite well.
In this case ss was needed only on rhost.
I don't know if SUT in two hosts configurations (ssh/rsh) are identical.
If yes, it'd be enough just to check TST_NEEDS_CMDS also on rhost.
I'm for this variant as it's a simpler change. I'll send a patch tomorrow.

Kind regards,
Petr
