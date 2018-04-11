From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Apr 2018 15:12:36 +0200
Subject: [LTP] [PATCH v7 0/7] Rewriting network tests into new shell API
In-Reply-To: <dc8cff97-5ef7-126a-26ad-ccb9ef272b67@oracle.com>
References: <20180411114131.30141-1-pvorel@suse.cz>
 <dc8cff97-5ef7-126a-26ad-ccb9ef272b67@oracle.com>
Message-ID: <20180411131236.tfwa4agg7nwqvgld@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > I did last final testing.

> > Changes v6->v7
> > * I addressed the issues you pointed out (removed TCID, TST_ID)
> > * Rename some more functions in tst_net.sh)
> > * Prevent useless restoring ip in ip-updown when command not found.
> > * Minor changes in test description (related to previous changes).

> > This is the final diff v6->v7, whole code also available at
> > https://github.com/pevik/ltp/commits/tst_net.sh.v7
> > (Not sending it here to spam the others.)
> > If you're ok with merging, I'll add to the commits your Acked-by.


> The changes looks good, thanks Petr!
Thanks a lot for your review, merged!


Kind regards,
Petr
