From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jan 2020 18:46:01 +0800
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <20200107101119.GA22967@rei.lan>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
Message-ID: <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 7, 2020 at 6:11 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> >  This function reads test block device stat file
> (/sys/block/<device>/stat) and
> > -returns the bytes written since the last invocation of this function.
> > +returns the bytes written since the last invocation of this function.
> To avoid
> > +FS deferred IO metadata/cache interferes the result, we suggest doing
> "syncfs"
>                                  |   interfecence    |
>

Thanks.

>
> > +before the tst_dev_bytes_written first invocation. And an inline
> function named
> > +tst_dev_sync is created for that intention.
>
> Other than this it looks good to me, thanks for doing this, acked.
>

Pushed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200108/8350ae6e/attachment.htm>
