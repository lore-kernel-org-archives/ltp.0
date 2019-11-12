From: Christoph Hellwig <hch@lst.de>
Date: Tue, 12 Nov 2019 13:08:18 +0100
Subject: [LTP] [xfs] 73e5fff98b: kmsg.dev/zero:Can't_open_blockdev
In-Reply-To: <1108442397.11662343.1573560143066.JavaMail.zimbra@redhat.com>
References: <20191111010022.GH29418@shao2-debian>
 <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
 <1108442397.11662343.1573560143066.JavaMail.zimbra@redhat.com>
Message-ID: <20191112120818.GA8858@lst.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 12, 2019 at 07:02:23AM -0500, Jan Stancek wrote:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/fs_fill/fs_fill.c
> 
> Setup of that test is trying different file system types, and it looks
> at errno code of "mount -t $fs /dev/zero /mnt/$fs".
> 
> Test still PASSes. This report appears to be only about extra message in dmesg,
> which wasn't there before:
> 
> # mount -t xfs /dev/zero /mnt/xfs
> # dmesg -c
> [  897.177168] /dev/zero: Can't open blockdev

That message comes from fs/super.c:get_tree_bdev(), a common library
used by all block device based file systems using the new mount API.

It doesn't seem all that useful to me, but it is something we'll
need to discuss with David and Al, not the XFS maintainers.
