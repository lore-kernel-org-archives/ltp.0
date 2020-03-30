From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 30 Mar 2020 16:59:01 +0800
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSCB2MyAwLzNdIEZpeCBidWcgY2F1?=
 =?gb2312?b?c2VkIGJ5IGRlZmF1bHQgdW1hc2s=?=
In-Reply-To: <C3CD0DF8AD11A84CB25A1426DE537C61E5928002@dggeml524-mbx.china.huawei.com>
References: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
 <5E81A0EF.4040508@cn.fujitsu.com>
 <C3CD0DF8AD11A84CB25A1426DE537C61E5928002@dggeml524-mbx.china.huawei.com>
Message-ID: <5E81B4D5.9070706@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/3/30 16:22, Zouwei (Samuel) wrote:
> Hi Yang,
> 
> I downloaded the development version of ltp two weeks ago, ran the cases in the runtest directory, and analyzed all the failed cases.
> I found that these 3 cases have the umask issue.
> 
> Due to the limited time invested by individuals, it is possible that other cases with the same issue will not be discovered.
> I will analyze the other failed cases that have not been concluded further in the next few weeks.
Hi Zou,

Thanks, I have pushed the patch set.
Perhaps, you can fix all same umask issues by a single patch in future.

Thanks,
Xiao Yang
> 
> Thanks for your suggestions and reviews.
> 
> Best Regards
> Zou Wei
> -----????-----
> ???: Xiao Yang [mailto:yangx.jy@cn.fujitsu.com]
> ????: 2020?3?30? 15:34
> ???: Zouwei (Samuel)<zou_wei@huawei.com>
> ??: ltp@lists.linux.it
> ??: Re: [LTP] [PATCH v3 0/3] Fix bug caused by default umask
> 
> On 2020/3/30 15:27, Zou Wei wrote:
>> v3:
>> The case is only successful when system default umask is 0022.
>> When default umask is 0077 or other values, should clear umask by umask(0) in setup().
> Hi Zou,
> 
> Thanks for your patch set.
> Did you find any other cases related with the same issue?
> 
> Thanks,
> Xiao Yang
>>
>> Zou Wei (3):
>>     security/dirtyc0w: Fix bug caused by default umask
>>     syscalls/fstat: Fix bug caused by default umask
>>     syscalls/statx01: Fix bug caused by default umask
>>
>>    testcases/kernel/security/dirtyc0w/dirtyc0w.c | 2 ++
>>    testcases/kernel/syscalls/fstat/fstat02.c     | 2 ++
>>    testcases/kernel/syscalls/statx/statx01.c     | 2 ++
>>    3 files changed, 6 insertions(+)
>>
>> --
>> 2.6.2
>>
>>
> 
> 
> 
> 
> 



