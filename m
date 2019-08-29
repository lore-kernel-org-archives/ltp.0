From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Aug 2019 21:35:04 +0200
Subject: [LTP] [PATCH] tst_net.sh: Fix root detection on netns on new
 shell API
In-Reply-To: <20190829192120.GA14614@dell5510>
References: <20190826141101.10144-1-pvorel@suse.cz>
 <888e8f74-278c-ae3f-c8c5-3b8790f634d3@oracle.com>
 <20190829192120.GA14614@dell5510>
Message-ID: <20190829193504.GC1197@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > >  init_ltp_netspace()
> > >  {
> > >  	tst_test_cmds ip
> > > -	tst_require_root_
> > > +	[ -z "$TST_USE_LEGACY_API" ] && _tst_require_root || tst_require_root

> > Can we fix tst_require_root_() instead?
> I'll do.
> I wanted to use API variable than call internal function. It's not a big issue
> and this function is called in _tst_require_root anyway.

> NOTE: I've posted a patch which move variable and link setup to separate
> function, but I'm going to reject it myself. It's not an improvement and does
> not solve this solution. Sorry for the noise.
Merged, with your ack and suggested-by tags.

Kind regards,
Petr
