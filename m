From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Fri, 23 Aug 2019 11:10:30 +0800
Subject: [LTP] [PATCH] lapi/fs.h: Replace MAX_LFS_FILESIZE constant with
 own implementation
In-Reply-To: <5D5CFD75.3050506@cn.fujitsu.com>
References: <20190815083630.26975-1-pvorel@suse.cz>
 <20190816085309.fqvip4exe4mvtv2o@XZHOUW.usersys.redhat.com>
 <CAEemH2d7TYn4sZ7kkjRsPc-yBnTrN9LC+w84MAO6pDxYpfiFcw@mail.gmail.com>
 <5D5BB8DC.6070900@cn.fujitsu.com>
 <CAEemH2d_CKOwE3mHEXZKi1BkMBw5dn95aMJtkrSRciH2PU6NJA@mail.gmail.com>
 <5D5CFD75.3050506@cn.fujitsu.com>
Message-ID: <20190823031030.eqv6swzsspprh5dw@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 21, 2019 at 04:14:45PM +0800, Yang Xu wrote:
> on 2019/08/21 15:27, Li Wang wrote:
> 
> > On Tue, Aug 20, 2019 at 5:10 PM Yang Xu<xuyang2018.jy@cn.fujitsu.com>  wrote:
> > ...
> > > > But I don't understand why to define MAX_OFF as (MAX_LEN - MIN_OFF),
> > > > the failure indicates that not to write at a position past the maximum
> > > > allowed offset. Shouldn't we give a dst_off large than
> > > > MAX_LFS_FILESIZE?
> > > Yes, we should use a dst_off large than MAX_LFS_FILESIZE because it used pos to compare
> > > in kernel code as below:
> > > 
> > > mm/filemap.c
> > >    static int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
> > > ...
> > > if (unlikely(pos>= max_size))
> > >     return -EFBIG;
> > > ...
> > > 
> > > I strace xfstest generic/564 code( I follow this test code to ltp), as below:
> > > #max_off=$((8 * 2**60 - 65536 - 1))
> > > #min_off=65537
> > > #xfs_io -f -c "pwrite -S 0x61 0 128k" file
> > > #touch copy
> > > #strace xfs_io -c "copy_range -l $min_off -s 0 -d $max_off file" copy
> > > ....
> > >    openat(AT_FDCWD, "file", O_RDONLY)      = 4
> > >    copy_file_range(4, [0], 3, [9223372036854710271], 65537, 0) = 65536
> > >    copy_file_range(4, [65536], 3, [9223372036854775807], 1, 0) = -1 EFBIG (File too large)
> > > ....
> > > 
> > > xfsprogs used a loop to call copy_file_range, and get EFBIG when pos greater than LLONG_MAX.
> > > 
> > > I think we should  use tst_max_lfs_filesize instead of (tst_max_lfs_filesize -MIN_OFF)
> > > and this case will pass whether xfs,btrfs and ext4.
> > Good job, Xu. I think you can format a new patch to fix this problem.
> > Because Petr's patch is used for solving the cross-compiling issue and
> > looks good.
> Hi Li
> 
> OK. I will send a new patch to fix this problem. But copy_file_range02.c still has a problem as Murphy found,
> we set all_filesystem but use the same tmpdir instead of mntpoint.  I think we can remove all_filesystem and mountpoint.
> 
> @Murphy Zhou  Hi Murphy, would you like to send a new patch to remove useless all_filesystem or I do it in my
> new patch by adding your signed-off-by tag? What do you think about it?

You can go ahead and do it. Thank you!

M
> 
> > @Petr Vorel Hi Petr, what do you think? any more comments?
> > 
> 
> 
> 
