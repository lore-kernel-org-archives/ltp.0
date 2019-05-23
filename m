From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 May 2019 15:05:47 +0200
Subject: [LTP] [RFC PATCH v2 1/6] net/route: Remove route{4, 6}-change-if
In-Reply-To: <25af53c5-dcfc-93b0-b9cb-4d179d485548@oracle.com>
References: <20190510183132.31039-1-pvorel@suse.cz>
 <20190510183132.31039-2-pvorel@suse.cz>
 <25af53c5-dcfc-93b0-b9cb-4d179d485548@oracle.com>
Message-ID: <20190523130547.GA18816@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,
> On 5/10/19 9:31 PM, Petr Vorel wrote:
> > These testsuites requires 3 NIC setup, which is not supported by network
> > namespace setup (single host configuration) and IMHO not common for two
> > host configuration either.

> I guess, the third interface can be easily created during the setup, on the
> lhost... this is what's required, right?

> For example, by adding macvlan to the test interface:

>   ip link add ltp_mv0 link $(tst_iface) type macvlan mode bridge


> Then, for the test route we can set either ltp_mv0 or $(tst_iface) interface.

Thanks for review. I'd prefer to have this support in tst_net.sh as it can be
needed for some tests in the future, so why reinvent a wheel? Probably via some
variable (e.g.: TST_NET_EXTRA_NETNS_IFACES=2 => would add 2 more interfaces).
But maybe not every single thing must be in the library...

Much more important thing is how to solve validation when route-change-dst
on IPv6 requires using rhost and whether using C brings a benefit (next
patches in this patch-set).
First I wanted to use it because speed: faster changes stress system more
efficiently, but validation might slows it down anyway.
Validation: I give up because server app using threads (each binded to it's own
IP) was too slow and with client waiting for server to be up looked to me that
validation complicates the test a lot. But maybe instead of threading running
just several single thread instances would be faster.

Kind regards,
Petr
