From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Jul 2019 14:51:08 +0200
Subject: [LTP] [PATCH v4 1/3] lib: alter find_free_loopdev()
In-Reply-To: <5D26B44D.4010208@cn.fujitsu.com>
References: <5D25B05A.8000600@cn.fujitsu.com>
 <1562755997-5626-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190710135710.GC5628@rei.lan> <5D26B44D.4010208@cn.fujitsu.com>
Message-ID: <20190711125108.GB8709@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This needs more changes than this.
> >
> > The problem here is that the function modifies dev_path which is
> > returned by tst_acquire_device() so if you call this function after
> > tst_acquire_device() it will rewrite the dev_path which means that the
> > test would end up with wrong device path in tst_device->dev.
> >
> > I guess that the easiest solution would be changing the function to get
> > buffer parameter which, when non-NULL, is filled with the path.
> >
> > I.e. the function prototype would became:
> >
> > int tst_find_free_loopdev(char *path, size_t path_len);
> >
> > And we would pass the dev_path inside of the tst_device.c and NULL from
> > the copy_file_range() tests.
> Hi Cyril
> 
> This is a good comment. But I doubt why we don't use a set_devpath_flag todistinguish it.
> Or you have a future plan(in different directory ,/dev,/dev/loop/,/dev/block)?

Well you can add a flag to the function but that would be a bad design
as far as I can tell. It would still allowed for a user to modify the
library internal state by calling the tst_find_free_loopdev() with the
flag set.

-- 
Cyril Hrubis
chrubis@suse.cz
