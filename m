From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Apr 2017 14:53:27 +0200
Subject: [LTP] [RFC PATCH v4 0/3] Simplify network setup
In-Reply-To: <7ec9883c-7b9a-42ff-b49f-a5732d59a9fb@oracle.com>
References: <20170405204418.3240-1-pvorel@suse.cz>
 <5d196274-519f-fb5c-f971-29ece892330d@oracle.com>
 <20170406155005.smxqad2aqkcwecmz@dell5510>
 <7ec9883c-7b9a-42ff-b49f-a5732d59a9fb@oracle.com>
Message-ID: <20170410125326.e35n77a7wfraupfg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 06.04.2017 18:50, Petr Vorel wrote:
> > ...
> >> Given that the number of such tests are really small (stress/route,
> >> stress/multicast) and they don't source test_net.sh (only through
> >> network.sh), may be it is time to get rid of these variables inside
> >> test_net.sh and use just one, for reverse addresses as well?
> > testcases/network/stress/dns/dns-stress sources test_net.sh. I suppose we can
> > "fix it" by removing test_net.sh and setting necessary variables directly in
> > the script like other scripts do (e.g.
> > testcases/network/stress/route/route6-change-dst).
> > I agree that this would simplify things greatly (tst_net_vars.c would be much
> > smaller and use mainly glibc network related functions), but on the other hand I
> > wanted all network tests using test_net.sh. I don't like the idea that part of
> > the tests which are using the same variables, but their values are hardwired
> > into the script.

> And if we convert them to use test_net.sh and add missing interfaces
> like the ones
> needed for dns-stress tests, i.e. tst_ip_reverse(), etc., there would be
> no need to
> use them directly in the tests.

> Actually, we can still update tst_ipaddr() to use IP_HOSTs variables
> without adding
> together two variables :)

IMHO it's not about what is in tst_ipaddr(), but that we need IPV{4,6}_NETWORK and
IPV{4,6}_NET_REV variables in some scripts:

* testcases/network/stress/dns/dns-stress (which already sources test_net.sh) needs
IPV{4,6}_NETWORK and IPV{4,6}_NET_REV variables. This is the only test which uses all
of these variables.
	if [ "$TST_IPV6" ]; then
		record="AAAA"
		net="$IPV6_NETWORK"
		net_rev="$IPV6_NET_REV"
	else
		record="A"
		net="$IPV4_NETWORK"
		net_rev="$IPV4_NET_REV"
	fi
...
	zone "$net_rev.$ip_zone_opt.arpa" {
		type master;
		file "ltp-ns.rev";
	};

* testcases/network/stress/ns-tools/set_ipv4addr requires IPV4_NETWORK (called here as
network_part). This script is used by 29 tests.

netmask=`echo $network_part | sed "s/[[:digit:]]*/255/g"`.`echo $host_part | sed "s/[[:digit:]]*/0/g"`
broadcast=${network_part}.`echo $host_part | sed "s/[[:digit:]]*/255/g"`

Given this info, I'd keep IPV{4,6}_NETWORK and IPV{4,6}_NET_REV variables and fix
tst_net_vars.c according to your requirements.
But I agree it's better to use IP_HOSTs variables where possible (at least in
tst_ipaddr()). But it's up to you to decide. Or do you see any solution which allows us to
drop these variables?

> I guess subnet mask should be set as a separate variable, similar to
> stress/multicast
> tests (to support these tests),
I agree. Something like IPV6_NETWORK_MASK=64

> and if not provided, we can get it with getifaddr(), or at least set to predefined
> default value, for IPv6 it is almost always /64.
Ok if not set directly in IP_HOST variables I'd do try to get it with getifaddr() and if
it fail for any reason I'd use default (64 for IPv6 and 24 for IPv4).


Kind regards,
Petr
