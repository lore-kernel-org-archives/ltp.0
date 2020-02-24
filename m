From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Feb 2020 07:27:24 +0100
Subject: [LTP] [PATCH V2 04/10] syscalls/fsopen: New tests
In-Reply-To: <f203c3d7-cfc3-3be8-f6d1-01010e9391e3@cn.fujitsu.com>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
 <20200220170425.GB15699@gacrux.arch.suse.de>
 <20200224031847.4nbao5too3vuyfqx@vireshk-i7>
 <f203c3d7-cfc3-3be8-f6d1-01010e9391e3@cn.fujitsu.com>
Message-ID: <20200224062724.GA2436981@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > On 20-02-20, 18:04, Petr Vorel wrote:
> > > However I have problem on fsopen01 and fsmount02.
> > > mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not making
> > > filesystem (use -I to override)
> > > tst_mkfs.c:100: BROK: tst_test.c:830: mkfs.vfat failed with 1

> > > .dev_fs_flags = TST_FS_SKIP_FUSE helps with exfat and ntfs, but this also fails
> > > on vfat.

> > > This is tested on system with CONFIG_VFAT_FS=m and CONFIG_FAT_FS=m, vfat and fat
> > > are loaded by mkfs.vfat. IMHO we need something like TST_FS_SKIP_EXFAT | TST_FS_SKIP_FAT | TST_FS_SKIP_NTFS | TST_FS_SKIP_FUSE
> > > i.e. explicitly say what FS is not wanted no matter whether it's fuse or not.

> > > Or maybe just TST_FS_SKIP_FAT | TST_FS_SKIP_FUSE would be enough.

> > > NOTE: flags TST_FS_SKIP_EXFAT, TST_FS_SKIP_FAT, TST_FS_SKIP_NTFS do not exists yet.

> > I am not sure what should be done here.
> I guess petr may want to let you add TST_FS_SKIP_FAT flag like  adding
> TST_FS_SKIP_FUSE flag in commit dbe56e52bc50("ib: Add flags to
> tst_get_supported_fs_types()").
Yes, that's what I meant.
This was meant as a question whether there is simpler solution than this
(it's easy to implement it, but I might have overlook something - it might be
fixed even without it).

> Best Regards
> Yang Xu

> > @Cyril ?



