From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2016 14:48:15 +0100
Subject: [LTP] mkfs01 testcases issue
In-Reply-To: <567D7ED0.2060706@oracle.com>
References: <567D7ED0.2060706@oracle.com>
Message-ID: <20160105134815.GB32659@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> While running LTP commands testcases,these three 
> tests(mkfs01_msdos,mkfs01_vfat,mkswap01) sometimes failed.
> It is because that mkfs.vfat/mkswap on the test block device which is 
> made as btrfs( in previous mkfs01_btrfs test) does not work.
> blkid still show "TYPE="btrfs" after mkfs.vfat/mkswap.
> Seems the issue is only reproduced with a very small size of block 
> device(less than 20M).
> Does anyone hit similar issue,is it a kernel or btrfs bug?

Hmm, looks like blkid does not work for vfat formatted partition if the
partition was formatted with btrfs beforehand. I can reproduce the problem with:

dd if=/dev/zero of=disk.img bs=1024 count=18000
losetup /dev/loop0 disk.img
mkfs.btrfs /dev/loop0
mkfs.vfat /dev/loop0
blkid /dev/loop0

The output from the blkid is indeed empty, i.e. the loop device is not
recognized as a fat partition.

Trying to mount the device results in:

mount: /dev/loop0: more filesystems detected. This should not happen,
       use -t <type> to explicitly specify the filesystem type or
       use wipefs(8) to clean up the device.

So it looks like mkfs.vfat/mkswap fails to erase btrfs magic string,
which I would call a bug in the mkfs/mkswap.

> Anyway,how about making the test block device $LTP_DEV to the original 
> filesystem in tst_release_device(),so it will avoid such effect between 
> different testcases.

We can consider calling wipefs before we format the device with a filesystem,
but I would rather see mkfs/mkswap fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
