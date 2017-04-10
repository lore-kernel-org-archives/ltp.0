From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 10 Apr 2017 20:49:59 +0300
Subject: [LTP] [RFC PATCH v4 0/3] Simplify network setup
In-Reply-To: <20170410125326.e35n77a7wfraupfg@dell5510>
References: <20170405204418.3240-1-pvorel@suse.cz>
 <5d196274-519f-fb5c-f971-29ece892330d@oracle.com>
 <20170406155005.smxqad2aqkcwecmz@dell5510>
 <7ec9883c-7b9a-42ff-b49f-a5732d59a9fb@oracle.com>
 <20170410125326.e35n77a7wfraupfg@dell5510>
Message-ID: <fc3fc497-6803-751f-fe16-140cefd7dd27@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 04/10/2017 03:53 PM, Petr Vorel wrote:
> ...
> IMHO it's not about what is in tst_ipaddr(), but that we need IPV{4,6}_NETWORK and
> IPV{4,6}_NET_REV variables in some scripts:
>
> * testcases/network/stress/dns/dns-stress (which already sources test_net.sh) needs
> IPV{4,6}_NETWORK and IPV{4,6}_NET_REV variables. This is the only test which uses all
> of these variables.
> 	if [ "$TST_IPV6" ]; then
> 		record="AAAA"
> 		net="$IPV6_NETWORK"
> 		net_rev="$IPV6_NET_REV"
> 	else
> 		record="A"
> 		net="$IPV4_NETWORK"
> 		net_rev="$IPV4_NET_REV"
> 	fi
> ...
> 	zone "$net_rev.$ip_zone_opt.arpa" {
> 		type master;
> 		file "ltp-ns.rev";
> 	};


Looking at this test, there is no need to use IP4|6_NETWORK vars
and *_L|RHOST_. We could just use "unused network" variables there.
I'll prepare the patch... but still we need to get a reverse net,
though these variables more or less static.

If we want to automate it, may be create reverse IP program as
a separate tool in LTP so it can be invoked inside tests, like
dns-stress?

Thanks,
Alexey

