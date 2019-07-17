From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 17 Jul 2019 09:10:44 +0300
Subject: [LTP] [PATCH v4 1/3] lib: alter find_free_loopdev()
In-Reply-To: <5D2819B8.8050401@cn.fujitsu.com>
References: <5D25B05A.8000600@cn.fujitsu.com>
 <1562755997-5626-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190710135710.GC5628@rei.lan> <5D26B44D.4010208@cn.fujitsu.com>
 <20190711125108.GB8709@rei> <5D2819B8.8050401@cn.fujitsu.com>
Message-ID: <CAOQ4uxjwrFRCYe8vT5yJEfDPHjOSB=MD85GeKX5xALyD4SWwnA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 12, 2019 at 8:26 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
>
> > Hi!
> >>> This needs more changes than this.
> >>>
> >>> The problem here is that the function modifies dev_path which is
> >>> returned by tst_acquire_device() so if you call this function after
> >>> tst_acquire_device() it will rewrite the dev_path which means that the
> >>> test would end up with wrong device path in tst_device->dev.
> >>>
> >>> I guess that the easiest solution would be changing the function to get
> >>> buffer parameter which, when non-NULL, is filled with the path.
> >>>
> >>> I.e. the function prototype would became:
> >>>
> >>> int tst_find_free_loopdev(char *path, size_t path_len);
> >>>
> >>> And we would pass the dev_path inside of the tst_device.c and NULL from
> >>> the copy_file_range() tests.
> >> Hi Cyril
> >>
> >> This is a good comment. But I doubt why we don't use a set_devpath_flag todistinguish it.
> >> Or you have a future plan(in different directory ,/dev,/dev/loop/,/dev/block)?
> > Well you can add a flag to the function but that would be a bad design
> > as far as I can tell. It would still allowed for a user to modify the
> > library internal state by calling the tst_find_free_loopdev() with the
> > flag set.
> >
> Hi  Cyril
>
> Even we use int tst_find_free_loopdev(char *path, size_t path_len), user aslo can modify the internal state.
> I don't know how to limit it. Can you give some example code? If we set LTP_DEV in *tst_acquire_device__,
> we can pass dev and len to tst_find_free_loopdev(), but if we not set LTP_DEV, what can pass to tst_free_loopdev()?
>
>

I don't understand your concern.
Attached untested patch which implements Cyril's suggestion.

You may call tst_find_free_loopdev(NULL, 0) to get a free minor number
without changing lib internal state.

Thanks,
Amir.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ltp-tst_find_free_loopdev.patch
Type: text/x-patch
Size: 2597 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190717/d3591519/attachment-0001.bin>
