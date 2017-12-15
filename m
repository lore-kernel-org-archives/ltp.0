From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 15 Dec 2017 17:06:31 +0300
Subject: [LTP] [PATCH] netns/netns_helper.sh: Fix failure when testing
 ipv6 in netns
In-Reply-To: <1513343597-5720-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1513343597-5720-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <f50e3f7f-2279-e692-607e-987d75bee69c@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/15/2017 04:13 PM, Xiao Yang wrote:
> When testing ipv6 in network namespace, we got the following
> error on some distros(e.g. RHEL7.5Alpha):
> ----------------------------------------------------------------------------------
> connect: Cannot assign requested address
> netns_comm_ns_exec_ipv6_netlink 1 TFAIL: configuration and communication over veth0
> connect: Cannot assign requested address
> netns_comm_ns_exec_ipv6_netlink 2 TFAIL: configuration and communication over veth1
> -----------------------------------------------------------------------------------
> 
> We could fix this issue by waiting enough time(5s) for address
> to pass duplicate address detection.

netns tests disable DAD in setup so this shouldn't happen. It's quite
likely that the kernel doesn't have the following upstream patch-fix:

094009531612 ("ipv6: set all.accept_dad to 0 by default")

Thanks,
Alexey
