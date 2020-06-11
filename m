From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 Jun 2020 07:09:20 -0400 (EDT)
Subject: [LTP] [PATCH v3] syscalls/ioctl_loop05: Use correct blockdev to
 get logical_block_size
In-Reply-To: <1591853524-17011-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <660069492.15476972.1591794243308.JavaMail.zimbra@redhat.com>
 <1591853524-17011-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1004907592.15616646.1591873760020.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Using inode block size is also wrong because it is for filesystem io(such as
> we format
> filesystem can specify block size for data or log or metadata), it is not
> suitable
> for logical block size.

If this copes correctly with btrfs too, I don't have objections.
I retested on failing s390 setup and v3 works there OK.

