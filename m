From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Feb 2019 02:37:50 -0500 (EST)
Subject: [LTP] [PATCH v2] syscalls/mprotect: align exec_func to 64 bytes
In-Reply-To: <CAEemH2f6=VqWp7f=2VrFQPN_7BfTv7H4J-r5CdFcPE5xTXOLQg@mail.gmail.com>
References: <e1b5efb3d806fa26da13d46247b46ea5d78271c4.1549922861.git.jstancek@redhat.com>
 <CAEemH2f6=VqWp7f=2VrFQPN_7BfTv7H4J-r5CdFcPE5xTXOLQg@mail.gmail.com>
Message-ID: <1508347197.2635651.1551080270164.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> On Tue, Feb 12, 2019 at 6:15 AM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > exec_func() is dummy/empty function. Try to align it so we don't
> > need to worry about copying 2 pages. But also check that compiler
> > aligned it and there's sufficient space between start of func_exec
> > and end of page.
> >
> > This patch also removes copy_sz, which is now replaced with page_sz.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

Pushed.

Regards,
Jan

> 
> 
> > +mprotect04: CFLAGS += -falign-functions=64
> >
> 
> One of my concern was this option maybe not supported by kind of compiler
> and probably broken in the compiling phase. So I just submitted these
> two(another is Daniel's) patches to Travis CI, the result looks good and no
> compiler error found there.
> https://travis-ci.com/wangli5665/ltp/builds/101429714
> 
> Beside that, I also manually tried that with old gcc(gcc version 4.1.2) and
> verify that works fine.
> 
> --
> Regards,
> Li Wang
> 
