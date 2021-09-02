From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 2 Sep 2021 18:45:33 +0200
Subject: [LTP] [PATCH 1/1] net/route: Rewrite route-rmmod to new API
In-Reply-To: <a07de84c-5251-9e46-afac-84544247534b@bell-sw.com>
References: <20201116220325.413764-1-pvorel@suse.cz>
 <689bea29-9717-1b2a-a53f-4b3a7f9f4e9b@oracle.com>
 <YS9u/k/b7lM/l1ki@pevik>
 <a07de84c-5251-9e46-afac-84544247534b@bell-sw.com>
Message-ID: <YTD/rU/ohgp8p5Zc@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

<snip>
> >> BTW, why not using add_macvlan() in route_lib.sh (or gre, vxlan, etc.)
> >> and remove that driver, so that this test can be run with custom setup, and
> >> with remote host setup?

> > Looking into this old patch, it looked to me quite bad approach to move
> > add_macvlan() into tst_net.sh to be reused (you didn't suggested that, that's
> > what I'd do to prevent the duplicity).

> Why not move add_macvlan() to the virt_lib.sh, I think this lib is better
> suited for creating macvlan?
Well, route-change-if.sh and route-change-netlink-if.sh depends on helpers from
route-lib.sh. Using both libraries would require little changes, but sure it's
possible (+ add obviously add $virt_type).

It's just a bit strange to add this special purpose function when there is
virt_add() and virt_add_rhost(). Best will be probably to add macvlan to these
functions and migrate router tests which needs macvlan to use virt_lib.sh before
route-rmmod.sh using it.

In the long term I'd really prefer to add some TST_NET* variable (due doc
generation via docparse), but that can be postponed as another effort after the
release (I thought it'd have to be in tst_net.sh so that tests does not care
about including virt_lib.sh when declaring it, but variable could also have
prefix TST_NET_VIRT_ to make it obvious, that virt_lib.sh must be loaded. But I
still prefer moving to tst_net.sh when implementing this approach).

BTW you consider ok to use macvlan for testing this? I suppose this test was
intended to be used on the real hardware not on virtualization. But I don't have
proper setup and give up on this approach.

Kind regards,
Petr

> > But much better approach would be IMHO to move virt_add() and virt_add_rhost()
> > from virt_lib.sh to tst_net.sh and adjust it not to be too tight to virt_lib.sh.
> > I suppose $virt_type should became $2 (second parameter).

> > Also there could be moved from virt_lib.sh to tst_net.sh: e.g. add flag
> > TST_NET_ADD_VIRT_TYPE (e.g. macvlan, gre, ...) and doing setup and cleanup
> > there. We could reduce code and document which virt drivers are used.

> > route-change-netlink-if is the only test which needs to call tst_init_iface()
> > (to add routes), virt_lib.sh does not need it.

> > Kind regards,
> > Petr


