From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Jul 2018 17:35:40 +0200
Subject: [LTP] [PATCH 2/2] network/route: Rewrite route-change-gw into
 new API
In-Reply-To: <20180625140158.rvjasl7jq2m4blbc@dell5510>
References: <20180517103527.23542-1-pvorel@suse.cz>
 <20180517103527.23542-2-pvorel@suse.cz>
 <cfa4f035-9052-147b-4d6d-2b6ecfe4cf31@oracle.com>
 <20180518110110.zeabusjbiq2lq263@dell5510>
 <20180625140158.rvjasl7jq2m4blbc@dell5510>
Message-ID: <20180704153540.l2edpiia2k6yce7p@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > > > don't remember why the rewritten test is
> > > > not using background traffic and not changing gateway anymore?
> > > The current implementation was based on your suggestion for route-change-dst [1] (I'll
> > > mention that in commit message), which uses ns-udpsender.  The other patch [2] is
> > > changing gateway.
> 
> > > Tests used ns-udpsender in previous implementation and we decided to keep it as  use
> > > background traffic isn't sufficient enough [3].
> 
> > > But ns-udpsender isn't good enough, as it doesn't check whether destination receive it [4].
> > > And indeed you can pass it to any destination and it will not fail, e.g.:
> > > ns-udpsender -f 4 -D 1.2.3.4 -p 1 -o -s 1472
> 
> > > I guess we need to write another helper, which will listen for packets on remote side.
> > > Any recommendations/ideas on it?
> 
> It would be good to have this helper in order to extend the tests.
> Not sure if it can be used other than here...
Yes, I expect it to be suitable just for these 3 route tests.

> The other option is to configure a host on the other end as well,
> so that we get responses, and use the standard tools.
Sorry, don't understand this idea. Which tools do you mean? Some helper from
tst_net.sh?
Thanks for info.

Kind regards,
Petr
