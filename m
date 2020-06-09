From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 9 Jun 2020 05:24:13 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Get the logic_block_size
 dynamically
In-Reply-To: <1591691583-12442-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1591691583-12442-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <218497387.15286923.1591694653027.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> In loop driver code, the sb_bsize was calculated as below
> sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev),
> 
> it is the super block's block size that the backing file's inode belongs to,
> not by using the st_blksize member of stat struct(it uses inode->i_blkbits).

I'm not sure I follow the above, are you saying the difference is bdev blksize
vs. filesystem blksize? Is the test failing in some scenarios or is this
fix based on code inspection?

> 
> IMO, we don't have the direct ioctl to get this size, just try it from 512 to
> page_size.

Would BLKSSZGET work? It returns bdev_logical_block_size().

