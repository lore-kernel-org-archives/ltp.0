From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 6 Jun 2017 16:15:23 +0300
Subject: [LTP] [RFC PATCH v6 06/11] network/stress: Add library
 test_stress_net.sh for general usage
In-Reply-To: <20170603120022.13415-7-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-7-pvorel@suse.cz>
Message-ID: <f1376e76-b9bf-8386-8a40-0a374fdf1697@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/03/2017 03:00 PM, Petr Vorel wrote:
> * This library is intended to be used throughout all stress tests reduce
> duplicity and use code test_net.sh where possible instead of legacy
> scripts in testcases/network/stress/ns-tools/.
>
> * check_connectivity() is split into general part (in test_stress_net.sh)
> ment as replacement of check_icmpv4_connectivity script and loop part
> wrapper check_connectivity_loop() (in if-lib.sh).
>
> * if-lib.sh sources test_stress_net.sh.
>
> ...
> +
> +# Library for all network/stress/ tests.
> +
> +# using variables IPV4_NETWORK LHOST_IPV4_HOST RHOST_IPV4_HOST and some functions
> +. test_net.sh
> +
> +tst_check_cmds ifconfig killall

ifconfig is deprecated, it's not a good idea to have it in
the library. Moreover, I think the new tests or updated ones
shouldn't test it too. The same for 'route' command.

> +
> +# NOTE: More information about these network variables can be found
> +# in testcases/network/stress/README
> +
> +# TODO: Test expects prefix to be 24, which can get wrong when called
> +# with different prefix for IPV4_NETWORK.
> +
> +# Netmask of for the tested network
> +IPV4_NETMASK="255.255.255.0"
> +IPV4_NETMASK_NUM=24
> +
> +# Broadcast address of the tested network
> +IPV4_BROADCAST=${IPV4_NETWORK}.255

We shouldn't use IPV4_NETWORK for broadcast or adding
new addresses on the interface, this might affect other
hosts on this network, this is why we have IPV4_NET16_UNUSED
and IPV6_NET32_UNUSED variables. This also simplifies adding
new addresses/routes as we have fixed network with needed IP
address range that doesn't overlap with IP_RHOST/IP_LHOST
addresses.

Thanks,
Alexey
