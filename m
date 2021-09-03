From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Sep 2021 10:55:40 +0200
Subject: [LTP] [PATCH 1/1] net/route: Rewrite route-rmmod to new API
In-Reply-To: <a0b2df49-b8bb-6968-fed8-50ff3fd33543@bell-sw.com>
References: <20201116220325.413764-1-pvorel@suse.cz>
 <689bea29-9717-1b2a-a53f-4b3a7f9f4e9b@oracle.com>
 <YS9u/k/b7lM/l1ki@pevik>
 <a07de84c-5251-9e46-afac-84544247534b@bell-sw.com>
 <YTD/rU/ohgp8p5Zc@pevik>
 <a0b2df49-b8bb-6968-fed8-50ff3fd33543@bell-sw.com>
Message-ID: <YTHjDNd3FUuaLo2S@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> >> Why not move add_macvlan() to the virt_lib.sh, I think this lib is better
> >> suited for creating macvlan?
> > Well, route-change-if.sh and route-change-netlink-if.sh depends on helpers from
> > route-lib.sh. Using both libraries would require little changes, but sure it's
> > possible (+ add obviously add $virt_type).

> > It's just a bit strange to add this special purpose function when there is
> > virt_add() and virt_add_rhost(). Best will be probably to add macvlan to these
> > functions and migrate router tests which needs macvlan to use virt_lib.sh before
> > route-rmmod.sh using it.

> Yes, it would be better to have the generic ones, moreover macvlan01/macvlan02
> tests are already calling virt_add().
+1.

> > In the long term I'd really prefer to add some TST_NET* variable (due doc
> > generation via docparse), but that can be postponed as another effort after the
> > release (I thought it'd have to be in tst_net.sh so that tests does not care
> > about including virt_lib.sh when declaring it, but variable could also have
> > prefix TST_NET_VIRT_ to make it obvious, that virt_lib.sh must be loaded. But I
> > still prefer moving to tst_net.sh when implementing this approach).

> > BTW you consider ok to use macvlan for testing this? I suppose this test was
> > intended to be used on the real hardware not on virtualization. But I don't have
> > proper setup and give up on this approach.

> I think we are not changing the purpose of this test using a virtual
> driver. Using the real drivers would complicate the test setup
> unnecessarily considering what it does with the driver...

+1

Thanks for your input!

Kind regards,
Petr
