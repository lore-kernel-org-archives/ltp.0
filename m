From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 24 Feb 2020 08:48:47 +0530
Subject: [LTP] [PATCH V2 04/10] syscalls/fsopen: New tests
In-Reply-To: <20200220170425.GB15699@gacrux.arch.suse.de>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <aab7ae7e324c40e8e995ff381384a402d2aba8f5.1582104018.git.viresh.kumar@linaro.org>
 <20200220170425.GB15699@gacrux.arch.suse.de>
Message-ID: <20200224031847.4nbao5too3vuyfqx@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-02-20, 18:04, Petr Vorel wrote:
> However I have problem on fsopen01 and fsmount02.
> mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not making
> filesystem (use -I to override)
> tst_mkfs.c:100: BROK: tst_test.c:830: mkfs.vfat failed with 1
> 
> .dev_fs_flags = TST_FS_SKIP_FUSE helps with exfat and ntfs, but this also fails
> on vfat.
> 
> This is tested on system with CONFIG_VFAT_FS=m and CONFIG_FAT_FS=m, vfat and fat
> are loaded by mkfs.vfat. IMHO we need something like TST_FS_SKIP_EXFAT | TST_FS_SKIP_FAT | TST_FS_SKIP_NTFS | TST_FS_SKIP_FUSE
> i.e. explicitly say what FS is not wanted no matter whether it's fuse or not.
> 
> Or maybe just TST_FS_SKIP_FAT | TST_FS_SKIP_FUSE would be enough.
> 
> NOTE: flags TST_FS_SKIP_EXFAT, TST_FS_SKIP_FAT, TST_FS_SKIP_NTFS do not exists yet.

I am not sure what should be done here.

@Cyril ?

-- 
viresh
