From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Jul 2020 01:46:27 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/ioctl09: Add test for BLKRRPART ioctl
In-Reply-To: <1690c3ad-a7d4-fa18-db19-343e3e345f8c@cn.fujitsu.com>
References: <1594016612-7975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <150668383.1091545.1594129246387.JavaMail.zimbra@redhat.com>
 <1690c3ad-a7d4-fa18-db19-343e3e345f8c@cn.fujitsu.com>
Message-ID: <172872545.1186681.1594187187385.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > 20MB feels a bit small, even though tests I ran passed on old and new
> > kernels.
> > LTP default is 256, to cover various filesystems, but here we don't even
> > write anything..
> In actually, ioctl_loop01 test case also uses 10M size and we only cover
> ext4 fileystem in here. I don't have objection about changing this size
> to 256M. Just reconfirm. If so, we should also modify ioctl_loop01 code.

OK, thanks for pointing that out. I wanted to go to 32 or 64, but if 10
worked in ioctl_loop01 until now, then 20 should be fine here.

