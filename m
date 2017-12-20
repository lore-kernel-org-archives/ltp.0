From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 Dec 2017 17:39:55 +0800
Subject: [LTP] [PATCH] netns/netns_helper.sh: Fix failure when testing
 ipv6 in netns
In-Reply-To: <9318bde0-cca5-7428-b046-b1f506bfdbba@oracle.com>
References: <1513343597-5720-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <f50e3f7f-2279-e692-607e-987d75bee69c@oracle.com>
 <5A372CF7.9050003@cn.fujitsu.com>
 <9318bde0-cca5-7428-b046-b1f506bfdbba@oracle.com>
Message-ID: <5A3A2FEB.7090809@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/12/19 16:24, Alexey Kodanev wrote:
> On 12/18/2017 05:50 AM, Xiao Yang wrote:
>> On 2017/12/15 22:06, Alexey Kodanev wrote:
>>> On 12/15/2017 04:13 PM, Xiao Yang wrote:
>>>> When testing ipv6 in network namespace, we got the following
>>>> error on some distros(e.g. RHEL7.5Alpha):
>>>> ----------------------------------------------------------------------------------
>>>> connect: Cannot assign requested address
>>>> netns_comm_ns_exec_ipv6_netlink 1 TFAIL: configuration and communication over veth0
>>>> connect: Cannot assign requested address
>>>> netns_comm_ns_exec_ipv6_netlink 2 TFAIL: configuration and communication over veth1
>>>> -----------------------------------------------------------------------------------
>>>>
>>>> We could fix this issue by waiting enough time(5s) for address
>>>> to pass duplicate address detection.
>>> netns tests disable DAD in setup so this shouldn't happen. It's quite
>>> likely that the kernel doesn't have the following upstream patch-fix:
>>>
>>> 094009531612 ("ipv6: set all.accept_dad to 0 by default")
>> Hi Alexey,
>>
>> Thanks for your explanation.  The patch mentioned in your reply can fix
>> the error.
>>
>> Should we fix the error by setting all.accept_dad to 0 manually in netns
>> or leave the
>> error to expose this issue?
> Ideally, we could check if the kernel is 4.14 and all.accept_dad
> not equals 0, then apply workaround and print some warning message...
Hi Alexey,

Checking kernel version seems unreliable because commit 35e015e1f577 and 
a2d3f3e33853
may be ported into some distros(e.g. RHEL7.5Alpha with kernel v3.10.0).

Thanks,
Xiao Yang
> Anyway, I see that the patch in the queue for stable:
> http://patchwork.ozlabs.org/bundle/davem/stable/?state=*
>
> Thanks,
> Alexey
>
>
>



