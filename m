From: zhaogongyi <zhaogongyi@huawei.com>
Date: Mon, 15 Mar 2021 12:06:45 +0000
Subject: [LTP] [PATCH] lib/tst_device.c: Add exception handling of
 function tst_find_free_loopdev
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB403891DF0@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I mean that /dev/loopX maybe removed by mistake after we get a free loop dev /dev/loopX. And in this case, we could try to create it or report error info immediately?

Actually?it seems there has no Sufficient reason to do it.

Thanks so much!

Best Regards,
Gongyi

> 
> Hi!
> > > In addition, when "loopdevno = ioctl(fd, LOOP_CTL_GET_FREE)" get
> > > free loop device i, and the loop device file /dev/loop%i has been
> removed??
> > > set_dev_path will return 1 and set " /dev/block/loop%i "
> > > in path. It might happened in many Embedded Systems because the
> test
> > > process's id is root always. So we could also Add exception handling?
> >
> > Or maybe we can try to create it when node doesn't exist?
> > 	mknod("/dev/loop%i", S_IFBLK|0644, makedev(7, i))
> 
> I do not really get what happens on your system. It looks like dev fs is not
> properly populated, which would be bug in your system rather than in the
> test library.
> 
> What is the state of /dev/loop* and /dev/block/loop* before you attempt
> to run the test?
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
