From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 7 Jun 2017 13:03:58 +0300
Subject: [LTP] [RFC PATCH v6 06/11] network/stress: Add library
 test_stress_net.sh for general usage
In-Reply-To: <20170606134322.lkz6mmjxxmceeepb@dell5510>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-7-pvorel@suse.cz>
 <f1376e76-b9bf-8386-8a40-0a374fdf1697@oracle.com>
 <20170606134322.lkz6mmjxxmceeepb@dell5510>
Message-ID: <98827b85-b027-65ca-6ce5-5b149fb5a676@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/06/2017 04:45 PM, Petr Vorel wrote:
> Hi Alexey,
>
>>> +tst_check_cmds ifconfig killall
>> ifconfig is deprecated, it's not a good idea to have it in
>> the library. Moreover, I think the new tests or updated ones
>> shouldn't test it too. The same for 'route' command.
> I know, it's deprecated for Linux. Although we're testing Linux kernel, and net-tools for
> linux are IMHO abandoned project, there are still people using it (see Ted Ts'o reaction
> in Debian ML [1]).
> Is it using removing ifconfig and route the only concern about these tests you have?

I've not looked at the other patches yet.

> Wouldn't be worth to rewrite these test into C, using netlink/rtnetlink/libnfnetlink/libnl API?

Interesting, may be that would stress more this Linux subsystem as there
will be less latency when adding/removing interfaces, routes, etc.
i.e. without starting a bunch of 'ip' commands in the shell.

Thanks,
Alexey

>
>>> +
>>> +# NOTE: More information about these network variables can be found
>>> +# in testcases/network/stress/README
>>> +
>>> +# TODO: Test expects prefix to be 24, which can get wrong when called
>>> +# with different prefix for IPV4_NETWORK.
>>> +
>>> +# Netmask of for the tested network
>>> +IPV4_NETMASK="255.255.255.0"
>>> +IPV4_NETMASK_NUM=24
>>> +
>>> +# Broadcast address of the tested network
>>> +IPV4_BROADCAST=${IPV4_NETWORK}.255
>> We shouldn't use IPV4_NETWORK for broadcast or adding
>> new addresses on the interface, this might affect other
>> hosts on this network, this is why we have IPV4_NET16_UNUSED
>> and IPV6_NET32_UNUSED variables. This also simplifies adding
>> new addresses/routes as we have fixed network with needed IP
>> address range that doesn't overlap with IP_RHOST/IP_LHOST
>> addresses.
> Good point, thanks! Actually, I've experienced problems with local network affected by the
> tests. Silly mistake :-(.
>
>
> Kind regards,
> Petr
>
> [1] http://www.mail-archive.com/debian-devel@lists.debian.org/msg344777.html

