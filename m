From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Oct 2020 13:35:10 +0200
Subject: [LTP] [PATCH 1/2] fanotify: Move safe_fanotify_init() + safe
 macro into fanotify.h
In-Reply-To: <CAEemH2eg7RZCWu66Z81x9RLmHGX=XC06ttK4x3_zmbw2jZnG9A@mail.gmail.com>
References: <20200428113501.24711-1-pvorel@suse.cz>
 <20201014134648.GA13224@yuki.lan> <20201014180221.GC19540@dell5510>
 <CAEemH2eg7RZCWu66Z81x9RLmHGX=XC06ttK4x3_zmbw2jZnG9A@mail.gmail.com>
Message-ID: <20201016113510.GA6305@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > The original motivation was to do further modifications for libc wrapper
> > vs.
> > syscall() for fanotify_init() and fanotify_mark(). But I guess even without
> > second commit it makes sense to have all fanotify helpers together.
> > We can always revert it if really need them as safe macros.

> +1

> Reviewed-by: Li Wang <liwang@redhat.com>
Thanks Li! Merged.

I've also sent another fanotify cleanup patch:
https://patchwork.ozlabs.org/project/ltp/patch/20201016112441.4838-1-pvorel@suse.cz/

Kind regards,
Petr
