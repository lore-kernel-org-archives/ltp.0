From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Wed, 26 May 2021 04:00:09 +0000
Subject: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before
 test
In-Reply-To: <YK0GqLg9AUrOxPdx@yuki>
References: <20190911124714.GA21670@rei.lan>
 <1571975625-6322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2dxhzBk+fbR8YnxAKqQSYhsb=HW2B2rov18yOjk9a+5Uw@mail.gmail.com>
 <YK0GqLg9AUrOxPdx@yuki>
Message-ID: <60ADC7EC.5080706@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>>> stx_attributes_mask shows what's supported in stx_attributes.
>>> Set supp_{append,compr,immutable,nodump} attributes only on filesystems
>>> which actually support it.
>>>
>>> Also merge duplicate code.
>>>
>>> ---------------
>>> v2->v3:
>>> 1.add kernel version check for stx_attributes_mask
>>> 2. use test_flag(int) instead of test_flagged and test_unflagged
>>> ---------------
>>>
>>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>>> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>>
>> Reviewed-by: Li Wang<liwang@redhat.com>
>>
>> This patch makes sense to me, I'm not sure if any blocker issue for
>> holding the apply process. If _no_ I would help to merge it:).
>
> See:
>
> https://github.com/linux-test-project/ltp/issues/557
>
> Basically this change hides a kernel bug.
I don't think it is a kernel bug and it is only an non-supported feature 
before linux 5.1 when not using ext4 driver for ext2.

> I've proposed to create a
> separate test for kernel that makes sure that all flags that are
> supposed to be enabled are enabled for new enough kernels, then we can
> apply this patch.
But not all fs support all flags, like xfs it doesn't support 
STATX_ATTR_COMPRESSED flag even now.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/xfs/xfs_iops.c#n611
>

