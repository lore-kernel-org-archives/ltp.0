From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 Sep 2021 14:15:58 +0200
Subject: [LTP] [PATCH 1/1] net/route: Rewrite route-rmmod to new API
In-Reply-To: <689bea29-9717-1b2a-a53f-4b3a7f9f4e9b@oracle.com>
References: <20201116220325.413764-1-pvorel@suse.cz>
 <689bea29-9717-1b2a-a53f-4b3a7f9f4e9b@oracle.com>
Message-ID: <YS9u/k/b7lM/l1ki@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> > diff --git a/testcases/network/stress/route/route-rmmod.sh b/testcases/network/stress/route/route-rmmod.sh
...
> > +setup()
> > +{
> > +	tst_res TINFO "adding IPv$TST_IPVER route destination and delete network driver $ROUTE_CHANGE_IP times"
> > +}

> It is probably unsafe to go straight to the do_test() and removing
> the veth... it would be nice to check that it is indeed using default
> ltp netns, and veth not used for other interfaces, TCONF otherwise...

> Perhaps in init_ltp_netspace(), create a special symlink in the if block,
> where the default ltp netns created:

> if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
>    ...
>    ROD ln -s /var/run/netns/ltp_ns /var/run/netns/ltp_ns_default
>    ...
> }

> then check via this function:

> is_ltp_ns_default()
> {
> 	test -f /var/run/netns/ltp_ns_default
> }


> BTW, why not using add_macvlan() in route_lib.sh (or gre, vxlan, etc.)
> and remove that driver, so that this test can be run with custom setup, and
> with remote host setup?

Looking into this old patch, it looked to me quite bad approach to move
add_macvlan() into tst_net.sh to be reused (you didn't suggested that, that's
what I'd do to prevent the duplicity).

But much better approach would be IMHO to move virt_add() and virt_add_rhost()
from virt_lib.sh to tst_net.sh and adjust it not to be too tight to virt_lib.sh.
I suppose $virt_type should became $2 (second parameter).

Also there could be moved from virt_lib.sh to tst_net.sh: e.g. add flag
TST_NET_ADD_VIRT_TYPE (e.g. macvlan, gre, ...) and doing setup and cleanup
there. We could reduce code and document which virt drivers are used.

route-change-netlink-if is the only test which needs to call tst_init_iface()
(to add routes), virt_lib.sh does not need it.

Kind regards,
Petr
