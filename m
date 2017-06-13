From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jun 2017 16:35:36 +0200
Subject: [LTP] [RFC PATCH v6 07/11] network/stress: Fix and cleanup part
 of multicast IPv4 tests
In-Reply-To: <184ea8ef-2e95-90e3-198f-0d36e95a947e@oracle.com>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-8-pvorel@suse.cz>
 <184ea8ef-2e95-90e3-198f-0d36e95a947e@oracle.com>
Message-ID: <20170613143536.2tvva3t4cs7m2lmf@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Thanks for you review and comments! I'll be more radical when I do shell test rewrite :-).
I understand and agree with most of your comments for these two tests rewrite commits,
just some notes and questions below.

> > +
> > +	lhost_ifname=$(tst_iface lhost $LINK_NUM)
> > +	rhost_ifname=$(tst_iface rhost $LINK_NUM)
> > +
> > +	set_lhost_rhost_ipv4addr $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST $RHOST_IPV4_HOST

> There is no need for using these variables, also they are deprecated.

> $IPV4_NETWORK $LHOST_IPV4_HOST $RHOST_IPV4_HOST
Variables IPV4_NETWORK LHOST_IPV4_HOST RHOST_IPV4_HOST were used as the cleanup is done
*before* using variables from tst_net_vars. This is my deliberate decision (to easily see
whether fix in test was caused by cleanup or by using tst_net_vars), but if you don't like
it I can squash test cleanup and using tst_net_vars into one commit (i.e. do cleanup in
commit after adding tst_net_vars.c).


> This function should accept single address and optionally a link number.
set_ipv4addr_check in test_stress_net.sh (previous commit) uses these values for ifconfig.
Of course, I change it for ip, but is the best way how to do it?  tst_restore_ipaddr or
tst_init_iface would probably be the best for init iface (as you mentioned before, but tst_add_ipaddr takes IP from tst_ipaddr

set_ipv4addr_check()
{
	local type="${1}"
	local link_num="$2"
	local network_part="$3"
	local host_part="$4"
	local addr broadcast cmd ifname netmask ret

	addr=${network_part}.${host_part}
	netmask=$(echo $network_part | sed "s/[[:digit:]]*/255/g").$(echo $host_part | sed "s/[[:digit:]]*/0/g")
	broadcast=${network_part}.$(echo $host_part | sed "s/[[:digit:]]*/255/g")
	ifname=$(tst_iface $type $link_num)

	# TODO: use tst_init_iface and tst_add_ipaddr (tst_add_ipaddr must be
	# adjusted to take mask as parameter).
	for cmd in "ifconfig $ifname up" \
		"ifconfig $ifname $addr netmask $netmask broadcast $broadcast"; do
		[ $type = "lhost" ] && sh -c "$cmd" || tst_rhost_run -c "$cmd"
		ret=$?
		[ $ret -ne 0 ] && tst_brkm TBROK "failed to set IP '$addr' to '$ifname' at $type ('$cmd': $ret)"
	done
}

> > +
> > +	lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
> > +	rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"

> IPV4_NETWORK, LHOST_IPV4_* shouldn't be used.
I got it from your previous comment => use IPV4_NET16_UNUSED + the rest of IPs.


Kind regards,
Petr
