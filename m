From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Jun 2019 16:18:53 +0200
Subject: [LTP] [PATCH] fanotify06: add a test case for overlayfs
In-Reply-To: <CAOQ4uxgSrpfo=uz29PQOO0LjZFdX+dY4PNQdb7rCWbP3T8MgAA@mail.gmail.com>
References: <20190424085317.409-1-amir73il@gmail.com>
 <CAOQ4uxgSrpfo=uz29PQOO0LjZFdX+dY4PNQdb7rCWbP3T8MgAA@mail.gmail.com>
Message-ID: <20190603141853.GA17414@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

...
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
> > index 6a2e2494f..62defb23c 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify06.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
> > @@ -54,8 +54,23 @@ static int fd_notify[FANOTIFY_PRIORITIES][GROUPS_PER_PRIO];

> >  static char event_buf[EVENT_BUF_LEN];

> > -#define MOUNT_NAME "mntpoint"
> > +#define MNTPOINT "mntpoint"
> > +#define OVL_LOWER "ovl-lower"
> > +#define OVL_UPPER "ovl-upper"
> > +#define OVL_WORK "ovl-work"
> > +#define OVL_MNT "ovl-mnt"
I guess you're going to send v2 with {SAFE,TST}_MOUNT_OVERLAY() or .needs_overlay usage from library.
...

Kind regards,
Petr
