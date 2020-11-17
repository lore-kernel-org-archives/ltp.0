From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Nov 2020 17:16:36 +0100
Subject: [LTP] [PATCH 1/1] net/route: Rewrite route-rmmod to new API
In-Reply-To: <689bea29-9717-1b2a-a53f-4b3a7f9f4e9b@oracle.com>
References: <20201116220325.413764-1-pvorel@suse.cz>
 <689bea29-9717-1b2a-a53f-4b3a7f9f4e9b@oracle.com>
Message-ID: <20201117161636.GA44486@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your comments.

> > +module='veth'
> > +TST_NEEDS_DRIVERS="$module"
> > +
> > +. route-lib.sh
> > +TST_CNT=$ROUTE_CHANGE_IP
> > +
> > +setup()
> > +{
> > +	tst_res TINFO "adding IPv$TST_IPVER route destination and delete network driver $ROUTE_CHANGE_IP times"
> > +}

> It is probably unsafe to go straight to the do_test() and removing
> the veth... it would be nice to check that it is indeed using default
> ltp netns, and veth not used for other interfaces, TCONF otherwise...
I had this in old version and thought it's not necessary. OK, with check (or
better custom setup you suggest later) is safer for paralel run, which LTP
hopefully sooner or later support).

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

Interesting.

> BTW, why not using add_macvlan() in route_lib.sh (or gre, vxlan, etc.)
> and remove that driver, so that this test can be run with custom setup, and
> with remote host setup?
I actually had version with add_macvlan(), but than I thought using netns is
enough. OK, I'll move back to that version (paralel run).

I also had a concert, that only virtualized drivers are tested.
Hope this simplification is ok.

> > +
> > +cleanup()
> > +{
> > +	modprobe $module
> > +	route_cleanup
> > +}
> > +
> > +do_test()
> > +{
> > +	local iface="$(tst_iface)"
> > +	local rt="$(tst_ipaddr_un -p $1)"
> > +	local rhost="$(tst_ipaddr_un $1 1)"
> > +
> > +	tst_res TINFO "testing route '$rt'"
> > +
> > +	tst_add_ipaddr -s -q -a $rhost rhost
> > +	ROD ip route add $rt dev $iface
> > +	EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $(tst_ipaddr) $rhost \>/dev/null
> > +
> > +	ROD rmmod $module

> ROD modprobe -r $module

+1, thanks!

> > +	ROD modprobe $module
> > +	reset_ltp_netspace

> should be in cleanup too, in case of test timeout or TBROK?
You mean reset_ltp_netspace? IMHO route_cleanup is enough, but I'll have a
closer look.

Kind regards,
Petr
