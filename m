From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Wed, 26 May 2021 10:02:35 +0000
Subject: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before
 test
In-Reply-To: <CAEemH2eSmf+7kGcq3rZS4_RPZ7W58hSyLqdx=zrzJUsEMQf8og@mail.gmail.com>
References: <20190911124714.GA21670@rei.lan>
 <1571975625-6322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2dxhzBk+fbR8YnxAKqQSYhsb=HW2B2rov18yOjk9a+5Uw@mail.gmail.com>
 <YK0GqLg9AUrOxPdx@yuki> <60ADC7EC.5080706@fujitsu.com>
 <CAEemH2eSmf+7kGcq3rZS4_RPZ7W58hSyLqdx=zrzJUsEMQf8og@mail.gmail.com>
Message-ID: <60AE1CE7.3030002@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> Hi all,
>
>  > >> This patch makes sense to me, I'm not sure if any blocker issue for
>  > >> holding the apply process. If _no_ I would help to merge it:).
>  > >
>  > > See:
>  > >
>  > > https://github.com/linux-test-project/ltp/issues/557
>  > >
>  > > Basically this change hides a kernel bug.
>  > I don't think it is a kernel bug and it is only an non-supported feature
>  > before linux 5.1 when not using ext4 driver for ext2.
>
> Cyril hopes to have a reproducer to cover the bug [1](though
> you think it a non-support problem), but that is responsible
> advicefor FileSystem:).
Yes, xfstest is more situable to do this.
> Actually, the worth to say, there already a separate test
> (xfstest/generic/424) for reproducing this problem[2].
Yes, this fix is found by xfstest/generic/424.
> See: https://github.com/kdave/xfstests/blob/master/tests/generic/424
Usually I see xfstests case on offical repo repository
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> I believe FS QE/Dev will run it for all filesystems regularly.
I think Theodore Ts'o may do it on xfstests-bld[1] and other 
project(like lkp) may also do it by using really ext2 driver. So having 
generic/424 is enough to find this kernel bug.

[1]https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git/tree/kernel-configs/x86_64-config-5.10#n114
>
> So maybe we can safely apply this patch in LTP without
> adding a duplicated test?
+1. With this patch, we can also run this case on xfs filesystem.
>
> [1] https://bugs.linaro.org/show_bug.cgi?id=4012
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93bc420ed41df63
>
> --
> Regards,
> Li Wang
