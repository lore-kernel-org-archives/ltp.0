From: Gao Xiang <xiang@kernel.org>
Date: Fri, 30 Apr 2021 09:48:23 +0800
Subject: [LTP] [f2fs] 02eb84b96b: ltp.swapon03.fail
In-Reply-To: <cf28837a-9558-b00c-bca3-601a70b752ea@oppo.com>
References: <20210308072510.GA902@xsang-OptiPlex-9020> <87h7llhnfe.fsf@suse.de>
 <c75229cc-e325-1c8b-0afa-fd236db8319c@oppo.com>
 <20210309040144.GH3479805@casper.infradead.org>
 <c84bf5c9-501e-6c25-1728-a7c6281093fd@oppo.com>
 <YEkw0J9VEg66AgIt@google.com>
 <e2009f2d-253d-264c-53ca-fa644897a952@huawei.com>
 <cf28837a-9558-b00c-bca3-601a70b752ea@oppo.com>
Message-ID: <20210430014823.GA3132@hsiangkao-HP-ZHAN-66-Pro-G1>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Apr 29, 2021 at 09:08:42PM +0800, Weichao Guo wrote:
> 
> On 2021/3/23 17:04, Chao Yu wrote:
> > On 2021/3/11 4:49, Jaegeuk Kim wrote:
> > > On 03/10, Huang Jianan wrote:
> > > > Hi Richard,
> > > > 
> > > > On 2021/3/9 12:01, Matthew Wilcox wrote:
> > > > > On Tue, Mar 09, 2021 at 10:23:35AM +0800, Weichao Guo wrote:
> > > > > > Hi Richard,
> > > > > > 
> > > > > > On 2021/3/8 19:53, Richard Palethorpe wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > > kern  :err   : [  187.461914] F2FS-fs (sda1):
> > > > > > > > Swapfile does not align to section
> > > > > > > > commit 02eb84b96bc1b382dd138bf60724edbefe77b025
> > > > > > > > Author: huangjianan@oppo.com <huangjianan@oppo.com>
> > > > > > > > Date:   Mon Mar 1 12:58:44 2021 +0800
> > > > > > > >        f2fs: check if swapfile is section-alligned
> > > > > > > >        If the swapfile isn't created by pin and
> > > > > > > > fallocate, it can't be
> > > > > > > >        guaranteed section-aligned, so it may be
> > > > > > > > selected by f2fs gc. When
> > > > > > > >        gc_pin_file_threshold is reached, the
> > > > > > > > address of swapfile may change,
> > > > > > > >        but won't be synchronized to swap_extent,
> > > > > > > > so swap will write to wrong
> > > > > > > >        address, which will cause data corruption.
> > > > > > > >        Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > > > > > > >        Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > > > > > > >        Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > > > > > >        Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > > > The test uses fallocate to preallocate the swap file
> > > > > > > and writes zeros to
> > > > > > > it. I'm not sure what pin refers to?
> > > > > > 'pin' refers to pinned file feature in F2FS, the
> > > > > > LBA(Logical Block Address)
> > > > > > of a file is fixed after pinned. Without this operation
> > > > > > before fallocate,
> > > > > > the LBA may not align with section(F2FS GC unit), some
> > > > > > LBA of the file may
> > > > > > be changed by F2FS GC in some extreme cases.
> > > > > > 
> > > > > > For this test case, how about pin the swap file before
> > > > > > fallocate for F2FS as
> > > > > > following:
> > > > > > 
> > > > > > ioctl(fd, F2FS_IOC_SET_PIN_FILE, true);
> > > > > No special ioctl should be needed.  f2fs_swap_activate()
> > > > > should pin the
> > > > > file, just like it converts inline inodes and disables compression.
> > > > 
> > > > Now f2fs_swap_activate() will pin the file. The problem is that when
> > > > f2fs_swap_activate()
> > > > 
> > > > is executed, the file has been created and may not be section-aligned.
> > > > 
> > > > So I think it would be better to consider aligning the swapfile during
> > > > f2fs_swap_activate()?
> > > 
> > > Does it make sense to reallocate blocks like
> > > in f2fs_swap_activate(),
> > >     set_inode_flag(inode, FI_PIN_FILE);
> > >     truncate_pagecache(inode, 0);
> > >     f2fs_truncate_blocks(inode, 0, true);
> > 
> > It will corrupt swap header info while relocating whole swapfile...
> How about back up the header page, and recover it after expand_inode_data()
> ?

That sounds somewhat hacky, since I don't think fs should take care of swap
detailed format.

My premature suggesttion, how about
 a) for non-pinned files, f2fs_swap_activate() pins the file and move
    (reallocate) pre-fallocated data blocks if needed;
 b) for already pinned files and not section-aligned when
    f2fs_swap_activate(), just reject it.

I think it would pass the test since pinned operation is f2fs-specific only.
Or am I still missing something?

Thanks,
Gao Xiang

> > 
> > >     expand_inode_data();
> > > .
> > > 
