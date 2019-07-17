From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Jul 2019 17:27:17 +0800
Subject: [LTP] [PATCH] snd_timer: check if file /dev/snd/timer exist
 before opening
In-Reply-To: <20190717090326.GA25480@rei.lan>
References: <20190717072109.7077-1-liwang@redhat.com>
 <20190717090326.GA25480@rei.lan>
Message-ID: <CAEemH2fUztKu5uY7MJTJV7EGGLasWmCHMuvhWXVZM7pa7ZpgSA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 17, 2019 at 5:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > 1. check if /dev/snd/timer exist
> >
> > 2. add tst_fzsync_pair_reset(&fzsync_pair, NULL) to reset variables
> > needed by fzsync. Especially for pair->exec_time_start, we use it to
> > control the test time in case that the execution loops timed out on
> > slow machine.
>
> This is obviously OK, acked.
>

Pushed, thanks.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190717/f7ff84db/attachment.htm>
