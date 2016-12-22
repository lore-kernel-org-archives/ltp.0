From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Dec 2016 20:55:50 +0300
Subject: [LTP] [PATCH 1/3] test_net.sh: fix netns when defined
 LHOST_IFACES or RHOST_IFACES
In-Reply-To: <20161222151725.vd76lhusgxm4iero@dell5510>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <f18cb5f0-e5d9-68e8-45c7-262c987aca28@oracle.com>
 <20161222130148.gn2j3vblabp4n446@dell5510>
 <a388a121-3402-e274-7b34-05257c56a98d@oracle.com>
 <20161222151725.vd76lhusgxm4iero@dell5510>
Message-ID: <e06a35be-a03a-a984-759c-740e1d30c8a5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/22/2016 06:17 PM, Petr Vorel wrote:
> Hi Alexey,
>
>>>> Any good reason to do that?
>>> Yes. Currently if you define LHOST_IFACES and/or RHOST_IFACES netns is defined for
>>> ltp_ns_veth2 and ltp_ns_veth1, but then there are used new variables => it's not working.
>>> Or have I overlooked something?
>> I understand, but why do you need to re-define these interface names?
> I don't need that, but if anyone does, it will have to find what's broken. This can happen
> if you migrate from existing config (ssh/rsh) into netns.
> IMHO the logic should be clever enough not to break things just due bad config (or let the
> user to know about it).

Basically, if we set '*_IFACES' variables before the test, we have to 
make sure they contains the names of already existed interfaces. if 
someone moved from rsh config and left eth0 interface names... LTP must 
setup veth pair with this name? More likely the names will be the same 
and veth pair won't be created.

With current configuration, we could create ltp_ns namespace and setup 
our own interface(s) before the test (e.g. veth/br0 -> bond -> vxlan -> 
vlan ... etc), then run the tests with new names set (skipping default 
setup).

Thanks,
Alexey

