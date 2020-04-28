From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 28 Apr 2020 12:51:51 +0300
Subject: [LTP] [PATCH 4/4] syscalls/fanotify: New test for FAN_MODIFY_DIR
In-Reply-To: <20200428092256.GC18634@dell5510>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-5-amir73il@gmail.com>
 <20200428092256.GC18634@dell5510>
Message-ID: <CAOQ4uxgQFj6QXVPbLZAf59Piiw=JmzoFHeAfAkzQqhqj9o5E4w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 28, 2020 at 12:22 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> ...
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
> ...
> > +     fd_notify = fanotify_init(FAN_REPORT_FID, 0);
> > +     if (fd_notify == -1) {
> > +             if (errno == EINVAL) {
> > +                     tst_brk(TCONF,
> > +                             "FAN_REPORT_FID not supported by kernel");
> > +                     return;
> tst_brk() exits the test, so return is not needed.
> > +             }
> > +             tst_brk(TBROK | TERRNO,
> > +                     "fanotify_init(FAN_REPORT_FID, 0) failed");
> > +     }
> > +
> > +     /*
> > +      * Watch dir modify events with name in filesystem/dir
> > +      */
> > +     if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
> > +                       AT_FDCWD, MOUNT_PATH) < 0) {
> > +             if (errno == EINVAL) {
> > +                     tst_brk(TCONF,
> > +                             "FAN_DIR_MODIFY not supported by kernel");
> > +                     return;
> Also here.
> > +             }
> > +             tst_brk(TBROK | TERRNO,
> > +                 "fanotify_mark (%d, FAN_MARK_ADD | %s, "
> > +                 "FAN_DIR_MODIFY, AT_FDCWD, '"MOUNT_PATH"') "
> > +                 "failed", fd_notify, mark->name);
> > +     }
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Suggesting these changes:

Hi Petr,

Those changes are fine by me.

Thanks,
Amir.
