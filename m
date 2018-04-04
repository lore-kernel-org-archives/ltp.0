From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 4 Apr 2018 19:16:32 +0800
Subject: [LTP] [PATCH] sctp/sctp_big_chunk.c: Fix compiler error
In-Reply-To: <fe226cc4-3c0a-0b4b-e618-e31e28647d07@oracle.com>
References: <1522831939-31257-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180404094556.2eahiw2z4sz3y3r5@dell5510> <5AC4A11B.5010205@cn.fujitsu.com>
 <fe226cc4-3c0a-0b4b-e618-e31e28647d07@oracle.com>
Message-ID: <5AC4B410.3010106@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 2018/04/04 18:46, Alexey Kodanev wrote:
> On 04.04.2018 12:55, Xiao Yang wrote:
>> On 2018/04/04 17:45, Petr Vorel wrote:
>>> Hi Xiao,
>>>
>>>> On old distros(e.g. RHEL5), Compilation failed because of redefinitions
>>>> from linux/sctp.h(including linux/in.h) and netinet/in.h, as below:
>>>> ----------------------------------------------------------------------
>>>> In file included from /usr/include/linux/sctp.h:54,
>>>>                    from ../../../include/lapi/sctp.h:22,
>>>>                    from sctp_big_chunk.c:35:
>>>> /usr/include/linux/in.h:26: error: redeclaration of enumerator ‘IPPROTO_IP’
>>>> /usr/include/netinet/in.h:33: error: previous definition of ‘IPPROTO_IP’ was here
>>>> ...
>>>> ----------------------------------------------------------------------
>>>> 1) There was a existed netinet/sctp.h based on lksctp-tools-devel package
>>>>      in LTP, so we used netinet/sctp.h to fix it as the sctp tests did.
>>>> 2) We removed lapi/sctp.h and duplicated SOL_SCTP in lapi/socket.h.
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>> ---
>>> Thank you for the fix. I'd prefer to remove our utils/sctp/include/netinet/sctp.h (I don't
>>> think it's a good idea to copy headers into source code) and fix include/lapi/sctp.h
>>> header trying first include<netinet/sctp.h>   (with autotools check) and then
>>> <linux/sctp.h>   if the previous is not available, as Alexey suggested [1].
>> Hi Petr,
>>
>> If only<linux/sctp.h>   is provided on RHEL5, it seems that the redefinition problem still exists.
>
> I think it would be better to just remove the include of linux/sctp.h
> for now, to fix this issue. lapi/ has the needed definitions to compile
> the test without it.
Hi Alexey and Petr,

Thanks for your reply.

I will remove linux/sctp.h and check netinet/sctp.h as you suggested in 
v2 patch.

Thanks,
Xiao Yang
> Optionally,
> we could include netinet/sctp.h, if it was installed, in lapi/sctp.h,
> or substitute it with the one from utils and support it from there,
> including utils/sctp which is lksctp-tools.
>
> Thanks,
> Alexey
>
>
>



