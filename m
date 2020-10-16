From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Oct 2020 11:20:55 +0800
Subject: [LTP] [PATCH 1/2] fanotify: Move safe_fanotify_init() + safe
 macro into fanotify.h
In-Reply-To: <20201014180221.GC19540@dell5510>
References: <20200428113501.24711-1-pvorel@suse.cz>
 <20201014134648.GA13224@yuki.lan> <20201014180221.GC19540@dell5510>
Message-ID: <CAEemH2eg7RZCWu66Z81x9RLmHGX=XC06ttK4x3_zmbw2jZnG9A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 15, 2020 at 2:02 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > > Fanotify code is used only in testcases/kernel/syscalls/fanotify/,
> which
> > > justify breaking rule of having safe function and macro outside of
> > > library. This will be further cleaned in next commit.
>
> > I guess that this is OK, I doubt that we will need a fanotify_init()
> > anywhere else but the fanotify testcases.
> Amir acked whole patch some time ago, thus I guess he's not against this
> first one.
>
> The original motivation was to do further modifications for libc wrapper
> vs.
> syscall() for fanotify_init() and fanotify_mark(). But I guess even without
> second commit it makes sense to have all fanotify helpers together.
> We can always revert it if really need them as safe macros.
>
+1

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201016/9eb28f53/attachment-0001.htm>
