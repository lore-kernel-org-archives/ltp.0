From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 27 Jun 2019 16:03:34 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02.c: Compatible with new
 and old kernels
In-Reply-To: <CAOQ4uxjE6RC_60SR0KZk7dJvU12pxPXEq56-tz840rDCQth1Xg@mail.gmail.com>
References: <1559292243-2882-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <5CF0FEB5.4030700@cn.fujitsu.com>
 <CAEemH2erJkdcKU_qg8RsjWUf7A37wj1QgMv=UZ21xUy=vXq9rg@mail.gmail.com>
 <CAOQ4uxjE6RC_60SR0KZk7dJvU12pxPXEq56-tz840rDCQth1Xg@mail.gmail.com>
Message-ID: <5D147856.5040709@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/05/31 21:02, Amir Goldstein wrote:

> On Fri, May 31, 2019 at 3:03 PM Li Wang<liwang@redhat.com>  wrote:
>>
>>
>> On Fri, May 31, 2019 at 6:15 PM Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>>> On 2019/05/31 16:44, Jinhui huang wrote:
>>>> On new kernels, copy_file_range() returned EISDIR when copyed contents
>>>> to directory, but on old kernels, it returned EBADF, we should accept
>>>> EBADF to be compatible with new and old kernels.
>>>>
>>>> The patch as follows:
>>>> commit 11cbfb10775a ("vfs: deny copy_file_range() for non regular files")
>>> Hi,
>>>
>>>  From description of commit, I wonder if we can add more tests for some
>>> non regular files(e.g. block, pipe)?
>>
>> I have no objection on this. But, is there really make sense to test some more non regular files which not being mentioned by Linux Manual Page?
>>
> FYI, more changes to copy_file_range checks are in the works:
> https://lore.kernel.org/linux-fsdevel/20190526061100.21761-1-amir73il@gmail.com/T/#me34d4363449118bd3b2ec8421d282a77e9a7d2d1

Hi Amir

     Meet again.  We can increase ltp copy_file_range02 coverage include( swapfile ->ETXTBUSY,  immutable file->EPERM) as same as xfstests generic/553[4].
Also the two other checks(overlaping and offset wrap).  I am glad to do it.

PS: Why we don't have test for overlaping and offset wrap check on xfstests? Or, I miss it?

Thanks
Yang Xu

>> The copy_file_range02 test errors are all extract from manual page, I commented that in Christian's first patch version. And I don't think it's necessary to test undefined behavior in syscall using, because how do we know what error return is the expected?
>>
>>> I just want to increase coverage and fix all similar issues as you did. :-)
>>>
>>> Best Regards,
>>> Xiao Yang
>>>> Signed-off-by: Jinhui huang<huangjh.jy@cn.fujitsu.com>
>>>> ---
>>>>   .../syscalls/copy_file_range/copy_file_range02.c   | 33 +++++++++++++++-------
>>>>   1 file changed, 23 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
>>>> index 07c0207..9e6356c 100644
>>>> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
>>>> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
>>>> @@ -54,19 +54,32 @@ static void verify_copy_file_range(unsigned int n)
>>>>        TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
>>>>                                0, CONTSIZE, tc->flags));
>>>>
>>>> -     if (TST_RET == -1) {
>>>> -             if (tc->exp_err == TST_ERR) {
>>>> +     if (TST_RET != -1) {
>>>> +             tst_res(TFAIL,
>>>> +                     "copy_file_range returned wrong value: %ld", TST_RET);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     if (tc->exp_err == TST_ERR) {
>>>> +             tst_res(TPASS | TTERRNO,
>>>> +                     "copy_file_range failed as expected");
>>>> +     } else {
>>>> +             /* copy_file_range() returned EISDIR when copyed contents to
>>>> +              * directory on new kernels, but on old kernels, it returned
>>>> +              * EBADF.
>>>> +              *
>>>> +              * the patch as follws:
>>>> +              * commit 11cbfb10775a ("vfs: deny copy_file_range() for non regular files")
>>>> +              */
>>>> +             if (tc->exp_err == EISDIR&&  TST_ERR == EBADF) {
>>>>                        tst_res(TPASS | TTERRNO,
>>>> -                                     "copy_file_range failed as expected");
>>>> -             } else {
>>>> -                     tst_res(TFAIL | TTERRNO,
>>>> -                             "copy_file_range failed unexpectedly; expected %s, but got",
>>>> -                             tst_strerrno(tc->exp_err));
>>>> +                             "copy_file_range failed as expected");
>>>>                        return;
>>>>                }
>>>> -     } else {
>>>> -             tst_res(TFAIL,
>>>> -                     "copy_file_range returned wrong value: %ld", TST_RET);
>>>> +
>>>> +             tst_res(TFAIL | TTERRNO,
>>>> +                     "copy_file_range failed unexpectedly; expected %s, but got",
>>>> +                     tst_strerrno(tc->exp_err));
>>>>        }
>>>>   }
>>>>
>>>
>>>
>>
>> --
>> Regards,
>> Li Wang
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp



