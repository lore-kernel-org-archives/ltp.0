From: Ian Kent <raven@themaw.net>
Date: Wed, 13 Nov 2019 14:04:27 +0800
Subject: [LTP] [xfs] 73e5fff98b: kmsg.dev/zero:Can't_open_blockdev
In-Reply-To: <5f758be455bb8f761d028ea078b3e2a618dfd4b1.camel@themaw.net>
References: <20191111010022.GH29418@shao2-debian>
 <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
 <1108442397.11662343.1573560143066.JavaMail.zimbra@redhat.com>
 <20191112120818.GA8858@lst.de>
 <5f758be455bb8f761d028ea078b3e2a618dfd4b1.camel@themaw.net>
Message-ID: <e38bc7a8505571bbb750fc0198ec85c892ac7b3a.camel@themaw.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2019-11-13 at 09:13 +0800, Ian Kent wrote:
> Adding Al and David to the CC, hopefully that will draw their
> attention to this a bit sooner.
> 
> On Tue, 2019-11-12 at 13:08 +0100, Christoph Hellwig wrote:
> > On Tue, Nov 12, 2019 at 07:02:23AM -0500, Jan Stancek wrote:
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/fs_fill/fs_fill.c
> > > 
> > > Setup of that test is trying different file system types, and it
> > > looks
> > > at errno code of "mount -t $fs /dev/zero /mnt/$fs".
> > > 
> > > Test still PASSes. This report appears to be only about extra
> > > message in dmesg,
> > > which wasn't there before:
> > > 
> > > # mount -t xfs /dev/zero /mnt/xfs
> 
> Assuming that is what is being done ...

Arrrh, of course, a difference between get_tree_bdev() and
mount_bdev() is that get_tree_bdev() prints this message when
blkdev_get_by_path() fails whereas mount_bdev() doesn't.

Both however do return an error in this case so the behaviour
is the same.

So I'm calling this not a problem with the subject patch.

What needs to be done to resolve this in ltp I don't know?

Ian

