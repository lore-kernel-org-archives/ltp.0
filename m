From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 Jun 2021 11:32:32 +0200
Subject: [LTP] [PATCH 2/2] tst_ipaddr_un.sh: Properly disable netns
 initialization
In-Reply-To: <40cd7b4a-2988-963f-ead0-6f8ffea01692@bell-sw.com>
References: <20210603151012.14760-1-pvorel@suse.cz>
 <20210603151012.14760-2-pvorel@suse.cz>
 <40cd7b4a-2988-963f-ead0-6f8ffea01692@bell-sw.com>
Message-ID: <YL3nsHclCxBYmju4@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > -# workaround to disable netns initialization
> > -RHOST="foo"

> Could be TST_INIT_NETNS="no"
Good point.

> > +TST_NET_SKIP_VARIABLE_INIT=1
> > +

> OK, I think it's better than setting TST_INIT_NETNS and other vars
> (e.g. private _tst_net_parse_variables) here to actually skip init.

+1. Patchset merged with your Reviewed-by: tag. Thanks!

Kind regards,
Petr
