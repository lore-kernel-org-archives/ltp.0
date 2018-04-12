From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 12 Apr 2018 14:39:10 +0800
Subject: [LTP] [PATCH] sctp/sctp_big_chunk.c: Add a hint on failure with
	EINVAL
In-Reply-To: <b53044f2-18fc-393e-48fd-dd5700ddfc8b@oracle.com>
References: <1522924077-15028-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <b53044f2-18fc-393e-48fd-dd5700ddfc8b@oracle.com>
Message-ID: <5ACEFF0E.2030505@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/04/11 22:30, Alexey Kodanev wrote:
> On 05.04.2018 13:27, Xiao Yang wrote:
>> If two ipv6 addresses have same family, a buggy kernel(e.g. RHEL6) lacked
>> the port check for them, and made this test get a failure with EINVAL:
>> -------------------------------------------------------------------------
>> safe_net.c:160: BROK: sctp_big_chunk.c:77: setsockopt(4, 132, 100, 0x7ffdbaac83a0, 91644) failed: EINVAL
>> -------------------------------------------------------------------------
>>
>> If you want to know detailed info for the bug, please see the following commit:
>> '40b4f0f (sctp: lack the check for ports in sctp_v6_cmp_addr)'
>>
>> We just want to hint users about the likely cause of the failure.
> I guess, the test will fail with EINVAL with this patch,
>
> https://patchwork.ozlabs.org/patch/897172/
>
> it tries to avoid the check with ports so it won't be possible
> to pass the same addresses like the test does, it is currently
> in ML.
Hi Alexey,

Thanks for your explanation.

Before commit 40b4f0f, it also failed with EINVAL because of the same ipv6 addresses.
Do you want to apply the first version of the test?

Thanks,
Xiao Yang

> The first version of the test would work but it can be slower
> for some VMs, because it creates unique addresses.
>
> http://lists.linux.it/pipermail/ltp/2018-March/007269.html
>
> Thanks,
> Alexey
>
>
>



