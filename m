From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun, 17 Nov 2019 11:04:01 +0100
Subject: [LTP] [PATCH 1/1] fanotify: Fix for musl
In-Reply-To: <977310824.12699736.1573924977430.JavaMail.zimbra@redhat.com>
References: <20191116002003.13013-1-petr.vorel@gmail.com>
 <977310824.12699736.1573924977430.JavaMail.zimbra@redhat.com>
Message-ID: <20191117100401.GB22986@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ----- Original Message -----
> > FSID_VAL_MEMBER() wrapper was meant to be only for struct
> > fanotify_event_info_fid, it was used also for struct event_t
> > (which has also __kernel_fsid_t fsid, but shouldn't be redefined).

> > This caused error on recent musl v1.1.23 (with f67b3c17),
> > which has struct fanotify_event_info_fid.

> > Fixes: 0498fc0a8 ("fanotify: Detect val vs. __val
> > fanotify_event_info_fid.fsid member")

> > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

> If it's needed for __kernel_fsid_t we'll need to come up with better names.
+1. But hope this is not needed.

> This basically reverts part of previous patch, which looks ok to me.
Yep. I'll add this to commit message, to be obvious.

> Acked-by: Jan Stancek <jstancek@redhat.com>

Thanks for your review.
I'll wait with merge till Monday (if Cyril has some comments).

Kind regards,
Petr
