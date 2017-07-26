From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Jul 2017 01:29:35 +0200
Subject: [LTP] [RFC PATCH v7 08/11] network/stress: Fix and cleanup
 route IPv4 tests
In-Reply-To: <40b7297a-c164-5427-5aa6-2a1ec4fc93f6@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-9-pvorel@suse.cz>
 <40b7297a-c164-5427-5aa6-2a1ec4fc93f6@oracle.com>
Message-ID: <20170726232935.lpy5tpz4wkxyee6m@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > diff --git a/testcases/network/stress/ns-tools/initialize_if b/testcases/network/stress/ns-tools/initialize_if
...
> > -# Initialize the specified interface
> > -command="ifconfig $ifname down mtu 1500 ; ip route flush dev $ifname ; ip addr flush dev $ifname ; ifconfig $ifname up"
> > -

> Again, why?
OK, I'll drop this part.
Why: I admit that this cleanup is unnecessary as initialize_if is deprecated I just didn't
consider cleaning initialize_if harmful (the script is still used).


> > +		# Down then up the interface
> > +		sh -c "$cmd_iface_down"

> Can be just $cmd_iface_down, or better ROD/EXPECT_PASS.
I'll have to split command into two, as only 'sh -c' can handle '&&' (and ROD_BASE doesn't
use 'sh -c')

> > +
> > +		tst_resm TINFO "adding first route"
> > +		ROD manipulate_route $cmd_name 'add' $first_route_net $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname

> Without 'ROD', in the new library it won't work with script functions,
> besides you have ROD on every command in that function already.
OK. I'm not sure, if it's best to have ROD inside manipulate_route, but I'll keep it for
simplicity.


> > +	while [ $cnt -lt $NS_TIMES ]; do
> > +		lhost_ifname2="$lhost_ifname"
> > +		gateway2="$gateway"
> > +
> > +		make_background_tcp_traffic $LHOST_IPV4_UNUSED
> > +
> > +		if [ "$test_field" = "dst" ]; then
> > +			dst_network_postfix="$(($cnt % 255))"
> > +			dst_addr="${IPV4_NET16_UNUSED}.${dst_network_postfix}.${DST_HOST}"
> > +			dst_network="${IPV4_NET16_UNUSED}.${dst_network_postfix}.0"
> > +		elif [ "$test_field" = "gw" ]; then
> > +			pre_rhost_part=$rhost_part
> > +			rhost_part=$(($rhost_part + 1))
> > +			[ $rhost_part -gt $rhost_part_last ] && rhost_part=$rhost_part_first
> > +			gateway="${IPV4_NET16_UNUSED}.${OCTET_3_IPV4_UNUSED}.${rhost_part}"
> > +			gateway2="${IPV4_NET16_UNUSED}.${OCTET_3_IPV4_UNUSED}.${pre_rhost_part}"
> > +		elif [ "$test_field" = "if" ]; then
> > +			link_num=$(($link_num + 1))
> > +			[ $link_num -ge $LINK_TOTAL ] && link_num=0
> > +			lhost_ifname="$(tst_iface lhost $link_num)"
> > +			gateway="${IPV4_NET16_UNUSED}.${link_num}.${RHOST_IPV4_HOST}"
> > +			rhost_ip="${IPV4_NET16_UNUSED}.${link_num}.${OCTET_4_RHOST_IPV4_HOST_UNUSED}"
> > +		fi
> > +
> > +		manipulate_route $cmd_name 'add' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname

> Looking at the original test-case, after new route added, the
> test tries to send a single UDP datagram in order to load it.
> But now all the tests have a background traffic on that
> interface and route not used, correct?
I intended to replace ns-udpsender with make_background_tcp_traffic call. But that
probably not covering the test scenario. But, even the code in ns-udpsender.c is very
simple I'm not sure if it's possible to do this replacement.
Generally, I'd like to get rid of these old C programs and use netstress as much as possible.

> > +		manipulate_route $cmd_name 'del' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway2 $lhost_ifname2
> > +
> > +		check_connectivity_interval $cnt false $lhost_ifname $rhost_ip || return
> > +
> > +		cnt=$(($cnt + 1))
> > +	done
> > +

...
> > -    # Set the variables for destination network
> > -    dst_addr=${DST_NETWORK}.${DST_HOST}
> > -    dst_network=${DST_NETWORK}.0
> > +	route_setup
> > +	tst_check_cmds ethtool
> > +
> > +	tst_add_ipaddr_stress

> tst_add_ipaddr_stress() should be after all the checks. Also I doubt
> that we need to add a new address in every test. Could you check again
> if we really need it?
I'll do.

> > +		# Remove and reload the network driver
> > +		rmmod $lhost_module && modprobe $lhost_module

> ROD modprobe -r $module
> ROD modprobe $module
OK.


> > +		if [ $? -ne 0 ]; then
> > +			tst_resm TFAIL "failed to unload/reload the network driver '$lhost_module'"
> > +			return
> > +		fi
> > +		tst_sleep 100ms

> Are you sure we need sleep here?
Yes. It's because loading driver takes some time, test was failing without that.


Kind regards,
Petr
