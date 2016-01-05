From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2016 15:21:15 +0100
Subject: [LTP] mkfs01 testcases issue
In-Reply-To: <20160105134815.GB32659@rei.lan>
References: <567D7ED0.2060706@oracle.com>
 <20160105134815.GB32659@rei.lan>
Message-ID: <20160105142114.GA8939@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > While running LTP commands testcases,these three 
> > tests(mkfs01_msdos,mkfs01_vfat,mkswap01) sometimes failed.
> > It is because that mkfs.vfat/mkswap on the test block device which is 
> > made as btrfs( in previous mkfs01_btrfs test) does not work.
> > blkid still show "TYPE="btrfs" after mkfs.vfat/mkswap.
> > Seems the issue is only reproduced with a very small size of block 
> > device(less than 20M).
> > Does anyone hit similar issue,is it a kernel or btrfs bug?

And looks like mkswap has been fixed allready in:

commit c1f1b301718ec0f5ffeae5b631c3ff38455b9ccd
Author: Milan Broz <mbroz@redhat.com>
Date:   Mon Sep 10 12:58:39 2012 +0200

    mkswap: wipe old signature if there is no part table by default

    Historically mkswap avoids wiping any signature on "whole disk",
    until force option is given.

    While the idea is that it should not wipe possible boot loader,
    in reality it leads to many situations where e.g. LUKS device
    is overwritten but still can be detected as LUKS (but unusable).

    Patch chnges behaviour that only if partition table is detected,
    signatures are not wiped.

    Also it removes check for block device - loop device can now
    map partitions in-kernel, so using mkswap on disk image in file
    should behave the same as on disk.

    Also it adds warning that know signature was wiped.

-- 
Cyril Hrubis
chrubis@suse.cz
