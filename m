From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jan 2020 19:39:03 +0800
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <20200108113535.GA17272@rei.lan>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
 <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
 <20200108112537.GA22954@dell5510> <20200108113535.GA17272@rei.lan>
Message-ID: <CAEemH2dZ0pVqpaecjO06stw8RiK-hmSUWwo=kndm3EsvoXCW2w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 8, 2020 at 7:35 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > This broke build with -Werror=implicit-function-declaration [1]:
> >
> > ../include/tst_device.h:78:2: error: implicit declaration of function
> 'syncfs'; did you mean 'sync'? [-Werror=implicit-function-declaration]
> > 2770  syncfs(fd);
> > 2771  ^~~~~~
> > 2772  sync
>

Thanks for highlight this.

> >
> > The problem is that syncfs() is guarded with __USE_GNU (in glibc, in musl
> > directly _GNU_SOURCE), so this requires to use _GNU_SOURCE (before
> including
> > first header).
> > Because it's in tst_device.h, we effectively need to build with
> -D_GNU_SOURCE.
> > Is that what we want? Or should we always use tst_syscall(__NR_syncfs,
> fd)
> > (without conditional check #ifndef HAVE_SYNCFS) ?
>
> I guess calling raw syscall in the tst_device.h would be easiest fix.
>

Yes, we can have a try.

Btw I just pushed a simple fix to include unistd.h, it seems not works.


> --
> Cyril Hrubis
> chrubis@suse.cz
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200108/1a77dcb4/attachment.htm>
