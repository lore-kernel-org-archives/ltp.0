From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 15:07:58 +0100
Subject: [LTP] [PATCH 1/1] if-mtu-change.sh: Lower CHANGE_INTERVAL to 1
In-Reply-To: <d7eba485-08db-1cc7-abe6-38d23c244bfb@oracle.com>
References: <20210107120247.31465-1-pvorel@suse.cz>
 <d7eba485-08db-1cc7-abe6-38d23c244bfb@oracle.com>
Message-ID: <X/7+vk6WsJ2LDJlC@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 07.01.2021 15:02, Petr Vorel wrote:
> > to make testing faster.

> > Tested only on netns based testing.


> Hi Petr,

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Alexey,

> > any reason why CHANGE_INTERVAL was set 5s?

> It's more or less safe time for default setup. Not sure why we don't
> have tst_sleep in if_updown.sh though. I think this is for preventing
> link-flap errors on the switch...
Thanks for info.

BTW do you consider sleep $NS_DURATION as needed in
testcases/network/stress/multicast/{packet-flood,query-flood}?
It's before killing utils (ns-mcast_receiver, ns-udpsender),
thus it could be removed during rewrite [1]

> For netns it's can be set far less of cause by overriding CHANGE_INTERVAL.

> > It'd be nice to speedup the tests, which were slow even before
> > 2d422edbf ("if-mtu-change.sh: Add max packet size detection for IPv4")
> > which added 25% slowdown.

> > Could you please test this on two host based setup?

> > Kind regards,
> > Petr

> >  testcases/network/stress/interface/if-mtu-change.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
> > index d2816606b..3efe00461 100755
> > --- a/testcases/network/stress/interface/if-mtu-change.sh
> > +++ b/testcases/network/stress/interface/if-mtu-change.sh
> > @@ -11,7 +11,7 @@ TST_CLEANUP="do_cleanup"
> >  . if-lib.sh

> >  # The interval of the mtu change [second]
> > -CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
> > +CHANGE_INTERVAL=${CHANGE_INTERVAL:-1}

> >  TST_TIMEOUT=$(((CHANGE_INTERVAL + 30) * MTU_CHANGE_TIMES))


> It's better to remove TST_TIMEOUT so that CHANGE_INTERVAL can be set,
> for example, to "100ms" for netns setup.
How about keeping it, but consider CHANGE_INTERVAL as 1 if not a number
(i.e. containing "ms", check with tst_is_int would be IMHO enough).
I'll send a patch.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=216562
