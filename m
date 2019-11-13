From: Ian Kent <raven@themaw.net>
Date: Wed, 13 Nov 2019 09:13:22 +0800
Subject: [LTP] [xfs] 73e5fff98b: kmsg.dev/zero:Can't_open_blockdev
In-Reply-To: <20191112120818.GA8858@lst.de>
References: <20191111010022.GH29418@shao2-debian>
 <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
 <1108442397.11662343.1573560143066.JavaMail.zimbra@redhat.com>
 <20191112120818.GA8858@lst.de>
Message-ID: <5f758be455bb8f761d028ea078b3e2a618dfd4b1.camel@themaw.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adding Al and David to the CC, hopefully that will draw their
attention to this a bit sooner.

On Tue, 2019-11-12 at 13:08 +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2019 at 07:02:23AM -0500, Jan Stancek wrote:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/fs_fill/fs_fill.c
> > 
> > Setup of that test is trying different file system types, and it
> > looks
> > at errno code of "mount -t $fs /dev/zero /mnt/$fs".
> > 
> > Test still PASSes. This report appears to be only about extra
> > message in dmesg,
> > which wasn't there before:
> > 
> > # mount -t xfs /dev/zero /mnt/xfs

Assuming that is what is being done ...

> > # dmesg -c
> > [  897.177168] /dev/zero: Can't open blockdev
> 
> That message comes from fs/super.c:get_tree_bdev(), a common library
> used by all block device based file systems using the new mount API.

I'll have a look at get_tree_bdev() but when I compared mount_bdev()
to get_tree_bdev() before using it they looked like they did pretty
much the same thing.

I don't know how /dev/zero is meant to be handled, I'll need to try
and work that out if Al or David don't see this soon enough.

> 
> It doesn't seem all that useful to me, but it is something we'll
> need to discuss with David and Al, not the XFS maintainers.

Ian

