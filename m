From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 15 May 2019 17:01:24 +0800
Subject: [LTP] [PATCH] ltp-cap.m4: add libcap version detection && fix
 compiler error
In-Reply-To: <20190514120119.GA26452@dell5510>
References: <1557732392-7049-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190513131451.GA22761@dell5510> <5CDA5124.3070708@cn.fujitsu.com>
 <20190514120119.GA26452@dell5510>
Message-ID: <5CDBD564.8010300@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/05/14 20:01, Petr Vorel wrote:
> Hi Yang,
>
>> Hi Peter
>>    I sent a mail to you last Friday mentioned this problem.
> Noticed, before I find a time you send a patch, so I replied to it (it's always
> better to send a question in public).
>
OK. I  got it.

>> At the beginning, I
>>    think it makes no sense because libcap-1 is too old.  But I notices that ltp-quota.m4
>>    has quota_v1 and quota_v2. I changes my mind.
>>    Since we have drop libnuma v1, I agree with you that we also drop libcap v1(too old).
>>    Also, I think we should drop quota_v1 because it is too old (since Linux 2.4.22, Q_GETINFO has
>>    been supported in kernel).
> Good point. But I'm not sure if it's the same, as QFMT_VFS_OLD is part of kernel
> source tree (part of kernel space code) so it makes sense to test it, whereas
> libcap v1 and libnuma v1 are just old versions of user space library.
> Or am I wrong?
Hi Petr

    I have seen kernel source about quota and try it. I think you are right.  But current quota_v1
and quota_v2 detection has problem. In kernel source, I disable CONFIG_QFMT_V2 and enable CONFIG_QFMT_V1
,then I found ltp still detects quotav2 instead of quotav1,  and run ./quotactl01, the following error occurs:

./quotactl01
tst_device.c:84: INFO: Found free device '/dev/loop0'
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.44.4 (18-Aug-2018)
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
quotactl01.c:195: FAIL: quotactl failed to turn on quota for user: ESRCH
quotactl01.c:195: FAIL: quotactl failed to set disk quota limit for user: ESRCH
quotactl01.c:195: FAIL: quotactl failed to get disk quota limit for user: ESRCH
quotactl01.c:195: FAIL: quotactl failed to set information about quotafile for user: ESRCH
quotactl01.c:195: FAIL: quotactl failed to get information about quotafile for user: ESRCH
quotactl01.c:195: FAIL: quotactl failed to get quota format for user: ESRCH
quotactl01.c:206: PASS: quotactl succeeded to update quota usages for user
quotactl01.c:206: PASS: quotactl succeeded to turn off quota for user
quotactl01.c:195: FAIL: quotactl failed to turn on quota for group: ESRCH
quotactl01.c:195: FAIL: quotactl failed to set disk quota limit for group: ESRCH
quotactl01.c:195: FAIL: quotactl failed to set disk quota limit for group: ESRCH
quotactl01.c:195: FAIL: quotactl failed to set information about quotafile for group: ESRCH
quotactl01.c:195: FAIL: quotactl failed to get information about quotafile for group: ESRCH
quotactl01.c:195: FAIL: quotactl failed to get quota format for group: ESRCH
quotactl01.c:206: PASS: quotactl succeeded to update quota usages for group
quotactl01.c:206: PASS: quotactl succeeded to turn off quota for group

Summary:
passed   4
failed   12
skipped  0
warnings 0

Kind Regards,
Yang Xu

>> Kind Regards,
>> Yang Xu
> Kind regards,
> Petr
>
>
>



