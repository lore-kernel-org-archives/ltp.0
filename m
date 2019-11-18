From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Nov 2019 21:33:42 +0100
Subject: [LTP] [PATCH 1/1] fanotify: Fix for musl
In-Reply-To: <20191117100401.GB22986@x230>
References: <20191116002003.13013-1-petr.vorel@gmail.com>
 <977310824.12699736.1573924977430.JavaMail.zimbra@redhat.com>
 <20191117100401.GB22986@x230>
Message-ID: <20191118203342.GD2531@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > If it's needed for __kernel_fsid_t we'll need to come up with better names.
> +1. But hope this is not needed.

> > This basically reverts part of previous patch, which looks ok to me.
> Yep. I'll add this to commit message, to be obvious.

> > Acked-by: Jan Stancek <jstancek@redhat.com>

> Thanks for your review.
> I'll wait with merge till Monday (if Cyril has some comments).

Merged.

Kind regards,
Petr
