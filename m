From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Nov 2020 15:26:49 +0100
Subject: [LTP] [PATCH v4 3/6] fanotify: Check for FAN_REPORT_FID support
 on fs
In-Reply-To: <CAOQ4uxh8yb+GRc2cN=MNcgBu8KZO=NPzmO9tSMkgRAvbUCXjZg@mail.gmail.com>
References: <20201126214121.6836-1-pvorel@suse.cz>
 <20201126214121.6836-4-pvorel@suse.cz>
 <CAOQ4uxh8yb+GRc2cN=MNcgBu8KZO=NPzmO9tSMkgRAvbUCXjZg@mail.gmail.com>
Message-ID: <20201127142649.GA20397@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Just a minor nit below.
> you may add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Sure. Thanks for your review!

> As far as I am concerned, you do not need to re-post for the nits
> if Cyril is going to fix my nit on merge (or even if he doesn't)
Sure, I also hope that nothing controversial appear after 4 reviews.

...
> > There might be even more cleanup: not sure if nofid_fd in fanotify13.c
> > is required. According to the description is probably required:

> You're right, It is required.
Thanks for confirmation!

...
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
...
> > +static inline int fanotify_fan_report_fid_supported_on_fs(const char *fname)
> > +{
> > +       int fd;
> > +       int rval = 0;
> > +
> > +       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> > +
> > +       if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> > +                         FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> > +                         AT_FDCWD, fname) < 0) {

> All those flags are not really needed for the test.
> This minimal arg list would have been enough:

> fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname)
Ack, thanks!

> Thanks,
> Amir.

Kind regards,
Petr
