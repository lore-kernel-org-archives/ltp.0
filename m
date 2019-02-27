From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 27 Feb 2019 17:36:00 +0800
Subject: [LTP] [PATCH 3/3] syscalls/preadv202: Add new testcase
In-Reply-To: <1132129902.3082239.1551258476831.JavaMail.zimbra@redhat.com>
References: <1538125851-26738-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1538125851-26738-3-git-send-email-yangx.jy@cn.fujitsu.com>
 <20181004121916.GB7724@rei.lan> <5C76476D.3070005@cn.fujitsu.com>
 <1132129902.3082239.1551258476831.JavaMail.zimbra@redhat.com>
Message-ID: <5C765A00.1090307@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/02/27 17:07, Jan Stancek wrote:
>
> ----- Original Message -----
>> Hi Jan,
>>
>> preadv202 has used tst_get_bad_addr() instead of the hardcoded -1 to
>> test  EFAULT, so is it
>> necessary to test EFAULT on s390 by truncating file as commit 856383c
>> does?
> If s390 doesn't immediately check iovec for validity, I don't see
> difference between -1 and other invalid address.
>
> I missing some context for this email, what made you look into this again?
> Anyway, I tried dropping truncate and ran test on 5.0.0-rc8 s390x:
>
> # ./preadv202
> tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
> preadv202.c:82: PASS: preadv2() failed as expected: EINVAL
> preadv202.c:82: PASS: preadv2() failed as expected: EINVAL
> preadv202.c:82: PASS: preadv2() failed as expected: EOPNOTSUPP
> preadv202.c:77: FAIL: preadv2() succeeded unexpectedly
> preadv202.c:82: PASS: preadv2() failed as expected: EBADF
> preadv202.c:82: PASS: preadv2() failed as expected: EBADF
> preadv202.c:82: PASS: preadv2() failed as expected: EISDIR
> preadv202.c:82: PASS: preadv2() failed as expected: ESPIPE
Hi Jan,

Thanks a lot for your reply and test. :-)

Recently, i am looking into pwritev202.c written by Jinhui Huang, and i 
just want to
know if it is necessary for both preadv2 and pwritev2 to test EFAULT by 
truncating.

Best Regards,
Xiao Yang
> Regards,
> Jan
>
>>   Perhaps, we
>> can remove the truncation if it is unnecessary.   Sorry, i don't have
>> s390 to confirm it.
>>
>> Best Regards,
>> Xiao Yang
>> On 2018/10/04 20:19, Cyril Hrubis wrote:
>>> Hi!
>>>> Note:
>>>>   From preadv2(2) manpage, preadv2() with invalid flag should return
>>>> EINVAL, but it actually returned EOPNOTSUPP in current upstream
>>>> kernel, as below:
>>>> ---------------------------------------------------------------
>>>> include/uapi/linux/fs.h:
>>>> define RWF_SUPPORTED   (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>>>>                            RWF_APPEND)
>>>> ...
>>>>
>>>> include/linux/fs.h:
>>>> static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>>>> {
>>>>           if (unlikely(flags&   ~RWF_SUPPORTED)) {
>>>>                   return -EOPNOTSUPP;
>>>>           }
>>>> ...
>>>> ---------------------------------------------------------------
>>>>
>>>> We use EOPNOTSUPP as expected errno for the time being.
>>> This is probably worth a patch for the man-pages project, will you take
>>> care of that?
>>>
>>> Pushed with a minor change, I've changed the EFAULT test to get address
>>> from tst_get_bad_addr() instead of the hardcoded -1.
>>>
>>> Thanks!
>>>
>>
>>
>>
>
> .
>



