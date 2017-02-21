From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Feb 2017 09:05:20 +0100
Subject: [LTP] test_net.sh: Require to redefine less variables
In-Reply-To: <7cbae912-5295-00d6-14e4-f1a9f1c4d197@oracle.com>
References: <20170216230608.yjdkk2ix3ftleud6@dell5510>
 <7cbae912-5295-00d6-14e4-f1a9f1c4d197@oracle.com>
Message-ID: <20170221080520.gachulbuwoeqva7a@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,


> That would be a nice feature to have of cause, regarding this variables:

> IPV{4,6}_NETWORK
> {L,R}HOST_IPV{4,6}_HOST

> and afaik they only used in test_net.sh to make up host addresses, so we can easily get rid of them and use only two variables with non-default subnets (optional).
{L,R}HOST_IPV4_HOST, IPV{4,6}_NETWORK and IPV{4,6}_NET_REV and are needed at least in testcases/network/stress/dns/dns-stress and testcases/network/stress/interface/if4-addr-change. So we'd need to calculate them from address.

Obviously IPV{4,6}_NET_REV are used only in dns-stress test only. A lot of scripts in
network stress tests pass other variables from test_net.sh to set_ipv4addr, add_ipv6addr,
check_icmpv{4,6}_connectivity, ns-icmpv6_sender and probably some other tests mentioned in
testcases/network/stress/ns-tools/00_Descriptions.txt.

So I'd keep all of these variables, just to calculate these with shell script or C binary:
IPV{4,6}_NETWORK
{L,R}HOST_IPV{4,6}_HOST
IPV{4,6}_NET_REV


Kind regards,
Petr
