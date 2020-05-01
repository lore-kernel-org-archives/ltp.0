From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 1 May 2020 12:05:31 +0300
Subject: [LTP] [PATCH 1/4] syscalls/fanotify09: Check merging of events
 on directories
In-Reply-To: <20200501071740.GA2217@morpheus.bobrowski.net>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-2-amir73il@gmail.com>
 <20200501071740.GA2217@morpheus.bobrowski.net>
Message-ID: <CAOQ4uxi3mKYH68oWZmqJ7NMs2SgGirYx=pnBQ3UD-0LkHjRw3A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 1, 2020 at 10:17 AM Matthew Bobrowski
<mbobrowski@mbobrowski.org> wrote:
>
> On Tue, Apr 21, 2020 at 09:49:59AM +0300, Amir Goldstein wrote:
> > +static void event_res(int ttype, int group,
> > +                   struct fanotify_event_metadata *event)
> > +{
> > +     int len;
> > +     sprintf(symlnk, "/proc/self/fd/%d", event->fd);
> > +     len = readlink(symlnk, fdpath, sizeof(fdpath));
> > +     if (len < 0)
> > +             len = 0;
> > +     fdpath[len] = 0;
> > +     tst_res(ttype, "group %d got event: mask %llx pid=%u fd=%d path=%s",
> > +             group, (unsigned long long)event->mask,
> > +             (unsigned)event->pid, event->fd, fdpath);
> > +}
>
> Nice helper, although it would be nice not to see all these statements
> clunked together like this.
>
> > -      * generate FAN_CLOSE_NOWRITE event on a child subdir.
> > +      * generate FAN_CLOSE_NOWRITE event on a testdir (subdir or ".")
>            ^ s/g/G :P
>
> Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
>

Thanks for the review Matthew, but this patch has already been merged,
so those cleanups could be done at a later time.
I will address you comments to fanotify15 and fanotify16, which are
still not merged, when you are done with review.

Thanks,
Amir.
