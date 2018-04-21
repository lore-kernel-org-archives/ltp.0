From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sat, 21 Apr 2018 14:06:23 +0800
Subject: [LTP] [PATCH] sctp/sctp_big_chunk.c: Add a hint on failure with
	EINVAL
In-Reply-To: <36020c3f-4809-3334-df49-b0d35ecf6386@oracle.com>
References: <1522924077-15028-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <b53044f2-18fc-393e-48fd-dd5700ddfc8b@oracle.com>
 <5ACEFF0E.2030505@cn.fujitsu.com>
 <36020c3f-4809-3334-df49-b0d35ecf6386@oracle.com>
Message-ID: <5ADAD4DF.1040906@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/04/12 19:15, Alexey Kodanev wrote:
> On 12.04.2018 09:39, Xiao Yang wrote:
>> On 2018/04/11 22:30, Alexey Kodanev wrote:
>>> On 05.04.2018 13:27, Xiao Yang wrote:
>>>> If two ipv6 addresses have same family, a buggy kernel(e.g. RHEL6) lacked
>>>> the port check for them, and made this test get a failure with EINVAL:
>>>> -------------------------------------------------------------------------
>>>> safe_net.c:160: BROK: sctp_big_chunk.c:77: setsockopt(4, 132, 100, 0x7ffdbaac83a0, 91644) failed: EINVAL
>>>> -------------------------------------------------------------------------
>>>>
>>>> If you want to know detailed info for the bug, please see the following commit:
>>>> '40b4f0f (sctp: lack the check for ports in sctp_v6_cmp_addr)'
>>>>
>>>> We just want to hint users about the likely cause of the failure.
>>> I guess, the test will fail with EINVAL with this patch,
>>>
>>> https://patchwork.ozlabs.org/patch/897172/
>>>
>>> it tries to avoid the check with ports so it won't be possible
>>> to pass the same addresses like the test does, it is currently
>>> in ML.
>> Hi Alexey,
>>
>> Thanks for your explanation.
>>
>> Before commit 40b4f0f, it also failed with EINVAL because of the same ipv6 addresses.
>> Do you want to apply the first version of the test?
>>
> Hi Xiao,
>
> Not sure, may be we could just use a raw socket on the client
> instead. And the easiest solution would be to return TCONF in
> this case. Any other ideas?
Hi Alexey,

I tried to use a raw socket on the client, but failed to bind the same 
ipv6 addresses.
I am not familiar with SOCK_RAW,  so could you tell me detailed steps to 
use it.

Beside, can we add different ipv6 addresses by modifying this existed test?

Thanks,
Xiao Yang
> Thanks,
> Alexey
>
>
>



