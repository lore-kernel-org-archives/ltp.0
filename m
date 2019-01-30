From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 30 Jan 2019 17:35:01 +0800
Subject: [LTP] [PATCH] controllers/cpuset: cpuset.cpus file doesn't
 exist which triggers TFAIL
In-Reply-To: <ca762b1e-499e-2082-c1dc-a8bba4707898@linux.alibaba.com>
References: <1548756794-121129-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <5C5033D5.10705@cn.fujitsu.com>
 <ca762b1e-499e-2082-c1dc-a8bba4707898@linux.alibaba.com>
Message-ID: <5C516FC5.4070206@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 2019/01/30 15:54, Jason Xing wrote:
>
> On 2019/1/29 下午7:07, Xiao Yang wrote:
>> On 2019/01/29 18:13, Jason Xing wrote:
>>> When doing cpuset_hotplug test, it will mount cpuset filesystem on
>>> /dev/cpuset and try to 'cat' cpuset.cpus file. But the cpuset.cpus
>>> doesn't exist because the cgroup system generates cpus without 'cpuset'
>>> prefix instead. The result is undoubtly TFAIL.
>>>
>>> The old ltp test uses "mount -t cpuset cpuset "$CPUSET"" which will
>>> mount with 'noprefix' options in the kernel(see 
>>> kernel/cgroup/cpuset.c).
>>> The reason is that it wants the backwards compatibility for the old
>>> cpuset file system. Therefore, using "mount -t cgroup -o" method
>>> surely fixes this issue once for all.
>> Hi Jason,
>>
>> It looks good to me. :-)
>>
>> Best Regards,
>> Xiao Yang
>
> Hi Yang,
>
> Thanks for your review.
>
> But it seems that the maintainers miss this patch, it's not a 
> complicated one, just one line changed. So I decided to reply to you all.
Hi Jason,

Pushed, thanks for your work.

Best Regards,
Xiao Yang

>
>>> Signed-off-by: Jason Xing<kerneljasonxing@linux.alibaba.com>
>>> ---
>>>   testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> index cc31729..935a41e 100755
>>> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> @@ -128,7 +128,7 @@ setup()
>>>
>>>       mkdir -p "$CPUSET_TMP"
>>>       mkdir "$CPUSET"
>>> -    mount -t cpuset cpuset "$CPUSET" 2>  /dev/null
>>> +    mount -t cgroup -o cpuset cpuset "$CPUSET" 2>  /dev/null
>>>       if [ $? -ne 0 ]; then
>>>           cleanup
>>>           tst_brkm TFAIL "Could not mount cgroup filesystem with"\
>>
>>
>
>
> .
>



