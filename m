From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 18 Dec 2017 10:50:31 +0800
Subject: [LTP] [PATCH] netns/netns_helper.sh: Fix failure when testing
 ipv6 in netns
In-Reply-To: <f50e3f7f-2279-e692-607e-987d75bee69c@oracle.com>
References: <1513343597-5720-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <f50e3f7f-2279-e692-607e-987d75bee69c@oracle.com>
Message-ID: <5A372CF7.9050003@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/12/15 22:06, Alexey Kodanev wrote:
> On 12/15/2017 04:13 PM, Xiao Yang wrote:
>> When testing ipv6 in network namespace, we got the following
>> error on some distros(e.g. RHEL7.5Alpha):
>> ----------------------------------------------------------------------------------
>> connect: Cannot assign requested address
>> netns_comm_ns_exec_ipv6_netlink 1 TFAIL: configuration and communication over veth0
>> connect: Cannot assign requested address
>> netns_comm_ns_exec_ipv6_netlink 2 TFAIL: configuration and communication over veth1
>> -----------------------------------------------------------------------------------
>>
>> We could fix this issue by waiting enough time(5s) for address
>> to pass duplicate address detection.
> netns tests disable DAD in setup so this shouldn't happen. It's quite
> likely that the kernel doesn't have the following upstream patch-fix:
>
> 094009531612 ("ipv6: set all.accept_dad to 0 by default")
Hi Alexey,

Thanks for your explanation.  The patch mentioned in your reply can fix 
the error.

Should we fix the error by setting all.accept_dad to 0 manually in netns 
or leave the
error to expose this issue?

Thanks,
Xiao Yang
> Thanks,
> Alexey
>
>
>



