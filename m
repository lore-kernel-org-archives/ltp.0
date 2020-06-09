From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 9 Jun 2020 07:01:57 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Get the logic_block_size
 dynamically
In-Reply-To: <96ba542d-4ec7-bc5d-41d9-f533952f94cd@cn.fujitsu.com>
References: <1591691583-12442-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <218497387.15286923.1591694653027.JavaMail.zimbra@redhat.com>
 <b1a7a025-3875-86db-222d-5a1e40737b24@cn.fujitsu.com>
 <1837993622.15296660.1591697802060.JavaMail.zimbra@redhat.com>
 <96ba542d-4ec7-bc5d-41d9-f533952f94cd@cn.fujitsu.com>
Message-ID: <828833321.15301509.1591700517554.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> >>> Would BLKSSZGET work? It returns bdev_logical_block_size().
> >>
> >> But it needs a blockdev, in user space, we can specify bdev, but how can
> >> we
> >> figure out this inode->i_sb->s_bdev block dev.
> > 
> > Isn't that the block device "test.img" is on?
> Do you mean the test.img belong to some block dev, such as /dev/sda1 or
> our mounted block_dev? If so, I think it is.

The former. Say if test.img is in /tmp, then I'd assume "s_bdev" is
/dev/mapper/rhel-root (/dev/dm-0)

$ df -T /tmp/test.img
Filesystem            Type 1K-blocks     Used Available Use% Mounted on
/dev/mapper/rhel-root xfs   66789516 33211340  33578176  50% /

