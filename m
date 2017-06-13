From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 13 Jun 2017 19:35:40 +0300
Subject: [LTP] [RFC PATCH v6 07/11] network/stress: Fix and cleanup part
 of multicast IPv4 tests
In-Reply-To: <20170613143536.2tvva3t4cs7m2lmf@dell5510>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-8-pvorel@suse.cz>
 <184ea8ef-2e95-90e3-198f-0d36e95a947e@oracle.com>
 <20170613143536.2tvva3t4cs7m2lmf@dell5510>
Message-ID: <2849d89a-436d-0600-3998-83c200281263@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/13/2017 05:35 PM, Petr Vorel wrote:

[...]
> $IPV4_NETWORK $LHOST_IPV4_HOST $RHOST_IPV4_HOST
> Variables IPV4_NETWORK LHOST_IPV4_HOST RHOST_IPV4_HOST were used as the cleanup is done
> *before* using variables from tst_net_vars. This is my deliberate decision (to easily see
> whether fix in test was caused by cleanup or by using tst_net_vars), but if you don't like
> it I can squash test cleanup and using tst_net_vars into one commit (i.e. do cleanup in
> commit after adding tst_net_vars.c).

Understand, but instead of IPV4_NETWORK + *_IPV4_HOST network tests,
which source test_net.sh, are using tst_ipaddr().

>
>
>> This function should accept single address and optionally a link number.
> set_ipv4addr_check in test_stress_net.sh (previous commit) uses these values for ifconfig.
> Of course, I change it for ip, but is the best way how to do it?  tst_restore_ipaddr or
> tst_init_iface would probably be the best for init iface (as you mentioned before, but tst_add_ipaddr takes IP from tst_ipaddr

What about invoking ip command directly? Plus it perfectly fine to pass
IPv6 address without changing the command:

ROD ip a add ${net}${host}/$mask dev $dev

Thanks,
Alexey


>
> set_ipv4addr_check()
> {
> 	local type="${1}"
> 	local link_num="$2"
> 	local network_part="$3"
> 	local host_part="$4"
> 	local addr broadcast cmd ifname netmask ret
>
> 	addr=${network_part}.${host_part}
> 	netmask=$(echo $network_part | sed "s/[[:digit:]]*/255/g").$(echo $host_part | sed "s/[[:digit:]]*/0/g")
> 	broadcast=${network_part}.$(echo $host_part | sed "s/[[:digit:]]*/255/g")
> 	ifname=$(tst_iface $type $link_num)
>
> 	# TODO: use tst_init_iface and tst_add_ipaddr (tst_add_ipaddr must be
> 	# adjusted to take mask as parameter).
> 	for cmd in "ifconfig $ifname up" \
> 		"ifconfig $ifname $addr netmask $netmask broadcast $broadcast"; do
> 		[ $type = "lhost" ] && sh -c "$cmd" || tst_rhost_run -c "$cmd"
> 		ret=$?
> 		[ $ret -ne 0 ] && tst_brkm TBROK "failed to set IP '$addr' to '$ifname' at $type ('$cmd': $ret)"
> 	done
> }
>
>>> +
>>> +	lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
>>> +	rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
>> IPV4_NETWORK, LHOST_IPV4_* shouldn't be used.
> I got it from your previous comment => use IPV4_NET16_UNUSED + the rest of IPs.
>
>
> Kind regards,
> Petr

