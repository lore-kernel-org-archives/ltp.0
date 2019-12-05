From: Xiao Yang <ice_yangxiao@163.com>
Date: Thu, 5 Dec 2019 15:27:39 +0800
Subject: [LTP] [PATCH] syscalls/quotactl07: add regresstion test for
 Q_XQTUOTARM
In-Reply-To: <de1c1667-9535-b122-e76c-66d42d88dc1f@cn.fujitsu.com>
References: <1575457056-10022-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <8c735de2-8022-1df2-6ce5-ee4dabe77767@163.com>
 <de1c1667-9535-b122-e76c-66d42d88dc1f@cn.fujitsu.com>
Message-ID: <8688f941-2aba-df89-def6-e4d22aa041fd@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 12/5/19 11:18 AM, Yang Xu wrote:
>
> Hi Xiao
>
> on 2019/12/04 22:57, Xiao Yang wrote:
>> Hi Yang,
>>
>> On 12/4/19 6:57 PM, Yang Xu wrote:
>>> This is a regresstion test to check Q_XQUOTARM? whether has
>>> quota flags check.
>>>
>>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>> ---
>>> ? include/lapi/quotactl.h?????????????????????? |? 4 +
>>> ? runtest/syscalls????????????????????????????? |? 1 +
>>> ? testcases/kernel/syscalls/quotactl/.gitignore |? 1 +
>>> ? .../kernel/syscalls/quotactl/quotactl07.c???? | 89 
>>> +++++++++++++++++++
>>> ? 4 files changed, 95 insertions(+)
>>> ? create mode 100644 testcases/kernel/syscalls/quotactl/quotactl07.c
>>>
>>> diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
>>> index d3223b863..c1ec9d6e1 100644
>>> --- a/include/lapi/quotactl.h
>>> +++ b/include/lapi/quotactl.h
>>> @@ -59,6 +59,10 @@ struct fs_quota_statv {
>>> ? # define PRJQUOTA 2
>>> ? #endif
>>> +#ifndef Q_XQUOTARM
>>> +# define Q_XQUOTARM XQM_CMD(6)
>>> +#endif
>>> +
>>> ? #ifndef Q_XGETQSTATV
>>> ? # define Q_XGETQSTATV XQM_CMD(8)
>>> ? #endif
>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>> index 15dbd9971..0f75cf3f6 100644
>>> --- a/runtest/syscalls
>>> +++ b/runtest/syscalls
>>> @@ -958,6 +958,7 @@ quotactl03 quotactl03
>>> ? quotactl04 quotactl04
>>> ? quotactl05 quotactl05
>>> ? quotactl06 quotactl06
>>> +quotactl07 quotactl07
>>> ? read01 read01
>>> ? read02 read02
>>> diff --git a/testcases/kernel/syscalls/quotactl/.gitignore 
>>> b/testcases/kernel/syscalls/quotactl/.gitignore
>>> index 12896d6ad..8d2ef94d9 100644
>>> --- a/testcases/kernel/syscalls/quotactl/.gitignore
>>> +++ b/testcases/kernel/syscalls/quotactl/.gitignore
>>> @@ -4,3 +4,4 @@
>>> ? /quotactl04
>>> ? /quotactl05
>>> ? /quotactl06
>>> +/quotactl07
>>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c 
>>> b/testcases/kernel/syscalls/quotactl/quotactl07.c
>>> new file mode 100644
>>> index 000000000..076db0bfe
>>> --- /dev/null
>>> +++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
>>> @@ -0,0 +1,89 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>>> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>> + *
>>> + * This is a regresstion test for kernel commit 3dd4d40b4208
>>> + * ("xfs: Sanity check flags of Q_XQUOTARM call").
>>> + */
>>> +
>>> +#include "config.h"
>>> +#include <errno.h>
>>> +#include <unistd.h>
>>> +#include <stdio.h>
>>> +#include <sys/quota.h>
>>> +#include "lapi/quotactl.h"
>>> +#include "tst_test.h"
>>> +
>>> +#ifdef HAVE_XFS_XQM_H
>>> +# include <xfs/xqm.h>
>>> +
>>> +#define MNTPOINT??? "mntpoint"
>>> +
>>> +static uint32_t qflag_acct = XFS_QUOTA_UDQ_ACCT;
>>> +static int test_id;
>>> +static int xquotarm_nsup;
>>> +static unsigned int valid_type = 1;
>>> +static unsigned int invalid_type = 9;
>>> +
>>> +static void verify_quota(void)
>>> +{
>>> +??? if (xquotarm_nsup) {
>>> +??????? tst_res(TCONF,
>>> +??????????? "current system doesn't support Q_XQUOTARM, skip it");
>>> +??????? return;
>>> +??? }
>>> +
>>> +??? SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 
>>> "quota");
>>> +
>>> +??? TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 
>>> test_id, (void *)&qflag_acct));
>>> +??? if (TST_RET == -1)
>>> +??????? tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
>> Is it possible to git rid of Q_XQUOTAOFF and call Q_XQUOTARM with 
>> invalid_type directly?
> From man-pages, before we use Q_XQUOTARM , quotas must have already 
> been turned off. If we don't use turnoff, it will report EINVAL but 
> not we wanted "EINVAL".? as below:
> -------------------------------------------------------
> diff --git a/fs/xfs/xfs_quotaops.c b/fs/xfs/xfs_quotaops.c
> index c7de17deeae6..006c6985a528 100644
> --- a/fs/xfs/xfs_quotaops.c
> +++ b/fs/xfs/xfs_quotaops.c
> @@ -164,8 +164,10 @@ xfs_quota_enable(
>
> ??????? if (sb_rdonly(sb))
> ??????????????? return -EROFS;
> -?????? if (!XFS_IS_QUOTA_RUNNING(mp))
> +?????? if (!XFS_IS_QUOTA_RUNNING(mp)) {
> +?????????????? printk("xuyang quota is no running\n");
> ??????????????? return -ENOSYS;
> +?????? }
>
> ??????? return xfs_qm_scall_quotaon(mp, xfs_quota_flags(uflags));
> ?}
> @@ -198,12 +200,15 @@ xfs_fs_rm_xquota(
> ??????? if (sb_rdonly(sb))
> ??????????????? return -EROFS;
>
> -?????? if (XFS_IS_QUOTA_ON(mp))
> +?????? if (XFS_IS_QUOTA_ON(mp)) {
> +?????????????? printk("xuyang rm quota\n");
> ??????????????? return -EINVAL;
> +?????? }
>
> -?????? if (uflags & ~(FS_USER_QUOTA | FS_GROUP_QUOTA | FS_PROJ_QUOTA))
> +?????? if (uflags & ~(FS_USER_QUOTA | FS_GROUP_QUOTA | FS_PROJ_QUOTA)) {
> +?????????????? printk("xuyang flag check\n");
> ??????????????? return -EINVAL;
> -
> +?????? }
> ??????? if (uflags & FS_USER_QUOTA)
> ??????????????? flags |= XFS_DQ_USER;
> ??????? if (uflags & FS_GROUP_QUOTA)
>
> -------------------------------------------------------
> it will report "xuyang rm quota" because quota acct is on.
>
> So I think it is impossible except we mount without quota option. But 
> it is meaningless(without quota feature to use Q_XQUOTARM). I prefer 
> to use my old way. What do you think about it?

Hi Xu,


Sorry for the late reply.? It seems that you understood what I mean.

e.g. Make setup stage do mount and Q_XQUOTAOFF and then only call

Q_XQUOTARM in verify_quota() as you v2 patch does.


Thanks,

Xiao Yang

>
>
>>> +
>>> +??? TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 
>>> test_id, (void *)&invalid_type));
>>> +??? if (TST_ERR == EINVAL)
>>> +??????? tst_res(TPASS, "Q_XQUOTARM has quota type check");
>>> +??? else
>>> +??????? tst_res(TFAIL, "Q_XQUOTARM doesn't have quota type check");
>>> +
>>> +??? SAFE_UMOUNT(MNTPOINT);
>>> +}
>>> +
>>> +static void setup(void)
>>> +{
>>> +??? test_id = geteuid();
>>
>> Is test_id necessary?? It seems to be ignored by both Q_XQUOTAOFF and 
>> Q_XQUOTARM.
> It is unnecessary.? From man-pages or kernel source code, this id 
> argument is ingored. I will use 0 instead of it.
>>
>>> +
>>> +??? SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 
>>> "quota");
>>> +
>>> +??? TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 
>>> test_id, (void *)&qflag_acct));
>>> +??? if (TST_RET == -1)
>>> +??????? tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
>>> +
>>> +??? TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 
>>> test_id, (void *)&valid_type));
>>> +??? if (TST_ERR == EINVAL)
>>> +??????? xquotarm_nsup = 1;
>> Is xquotarm_nsup variable duplicated? it seems simpler to report 
>> TCONF here.
> Yes. I will report TCONF here. Also, I will add SAFE_UMOUNT when we 
> use Q_XQUOTAOFF failed.
>>> +
>>> +??? SAFE_UMOUNT(MNTPOINT);
>>
>> Why do you need to mount and then umount?
>>
>> Could we call Q_XQUOTAON if you have to turn on usrquota again?
>>
> At the beginning , I also want to use Q_XQUOTAON to turn on usrquota 
> again. But from kernel code, when we call Q_XQUOTAON, it will use 
> XFS_IS_QUOTA_RUNNING macro to check whether there have quota acct. If 
> not, it will report ENOSYS. So, I give up using Q_XQUOTAON and use 
> mount/umount.
>
> Thanks
> Yang Xu
>>
>> Best Regards,
>>
>> Xiao Yang
>>
>>> +}
>>> +
>>> +static const char *kconfigs[] = {
>>> +??? "CONFIG_XFS_QUOTA",
>>> +??? NULL
>>> +};
>>> +
>>> +static struct tst_test test = {
>>> +??? .setup = setup,
>>> +??? .needs_root = 1,
>>> +??? .needs_kconfigs = kconfigs,
>>> +??? .test_all = verify_quota,
>>> +??? .format_device = 1,
>>> +??? .dev_fs_type = "xfs",
>>> +??? .mntpoint = MNTPOINT,
>>> +??? .tags = (const struct tst_tag[]) {
>>> +??????? {"linux-git", "3dd4d40b4208"},
>>> +??????? {}
>>> +??? }
>>> +};
>>> +#else
>>> +??? TST_TEST_TCONF("System doesn't have <xfs/xqm.h>");
>>> +#endif
>>
>>
>>
>

