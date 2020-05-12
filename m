From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 12 May 2020 09:41:47 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Ensure do zero offset in
 kernel always
In-Reply-To: <5EB904E5.8020109@cn.fujitsu.com>
References: <1588918535-4682-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5EB51F9D.6080404@cn.fujitsu.com>
 <207ce727-a0a4-2c2a-19f7-87aef956ffb5@cn.fujitsu.com>
 <5EB904E5.8020109@cn.fujitsu.com>
Message-ID: <74d96248-f1fd-1040-8ac9-a5fbe7600247@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao


> On 2020/5/8 17:23, Yang Xu wrote:
>> Hi Xiao
>>
>>
>>> On 2020/5/8 14:15, Yang Xu wrote:
>>>> Currently, we use return instead of zero_offset. I debug this code
>>>> (early return, ext4 filesystem)as below:
>>>> ---------------------------------------
>>>> TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
>>>> if (TST_RET == 0) {
>>>> ??? tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded unexpectedly");
>>>> ???????? SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
>>>> }
>>>> return;
>>>> ---------------------------------------
>>>> this case will broke when using i parameter,
>>>> ioctl_loop05.c:62: BROK: ioctl(3,LOOP_SET_DIRECT_IO,...) failed:
>>>> EINVAL (22)
> Hi Xu,
> 
> Sorry for the late reply.
> 
> Without modifying code, we can also fall into this branch by running 
> ioctl_loop05 under btrfs, so could we simple the description of issue?
"make sure zero offset in kernel at the begginning of the test to avoid 
unknown error when using -i parameter". How about this?
> 
>>>>
>>>> It seems the last test affected this test, so I think we should use
>>>> goto instead of return. Also including a typo, updata->update.
>>>>
>>>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>>>> ---
>>>> ? testcases/kernel/syscalls/ioctl/ioctl_loop05.c | 5 +++--
>>>> ? 1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
>>>> b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
>>>> index 6cf701f47..a103aaa94 100644
>>>> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
>>>> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
>>>> @@ -5,7 +5,7 @@
>>>> ?? *
>>>> ?? * This is a basic ioctl test about loopdevice.
>>>> ?? *
>>>> - * It is designed to test LOOP_SET_DIRECT_IO can updata a live
>>>> + * It is designed to test LOOP_SET_DIRECT_IO can update a live
>>> Hi Xu,
>>>
>>> What does the line changes?
>> just a typo, updata->update
> 
> Sorry for missing the typo.
> 
>>>
>>>> ?? * loop device dio mode. It needs the backing file also supports
>>>> ?? * dio mode and the lo_offset is aligned with the logical block size.
>>>> ?? *
>>>> @@ -85,13 +85,14 @@ static void verify_ioctl_loop(void)
>>>> ????? if (TST_RET == 0) {
>>>> ????????? tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
>>>> ????????? SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
>>>> -??????? return;
>>>> +??????? goto zero_offset;
>>>> ????? }
>>>> ????? if (TST_ERR == EINVAL)
>>>> ????????? tst_res(TPASS | TTERRNO, "LOOP_SET_DIRECT_IO failed as
>>>> expected");
>>>> ????? else
>>>> ????????? tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed
>>>> expected EINVAL got");
>>>>
>>>> +zero_offset:
>>>> ????? loopinfo.lo_offset = 0;
>>>> ????? TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS,&loopinfo),
>>>> TST_RETVAL_EQ0);
>>>
>>> You have cleared the struct loopinfo at the beginning of
>>> verify_ioctl_loop(), so could we just drop loopinfo.lo_offset = 0 and
>>> move 'TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS,&loopinfo),
>>> TST_RETVAL_EQ0);' to the beginning?
>> Yes. IMO, at the beginning or end, they all work well.
> 
> Agreed, but it seems simpler to clear resouce at the beginning of 
> verify_ioctl_loop(), like this:
> -----------------------------------
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c 
> b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> index 6cf701f47..6c9ea2802 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> ...
> @@ -57,6 +57,7 @@ static void verify_ioctl_loop(void)
>  ??????? struct loop_info loopinfo;
> 
>  ??????? memset(&loopinfo, 0, sizeof(loopinfo));
> +?????? TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), 
> TST_RETVAL_EQ0);
> 
>  ??????? tst_res(TINFO, "Without setting lo_offset or sizelimit");
>  ??????? SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 1);
> @@ -91,9 +92,6 @@ static void verify_ioctl_loop(void)
>  ??????????????? tst_res(TPASS | TTERRNO, "LOOP_SET_DIRECT_IO failed as 
> expected");
>  ??????? else
>  ??????????????? tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed 
> expected EINVAL got");
> -
> -?????? loopinfo.lo_offset = 0;
> -?????? TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), 
> TST_RETVAL_EQ0);
> -----------------------------------
Yes.
> 
> Best Regards,
> Xiao Yang
>>>
>>> Thanks,
>>> Xiao Yang
>>>> ? }
>>>
>> .
>>
> 


