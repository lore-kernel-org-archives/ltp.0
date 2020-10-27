From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 27 Oct 2020 20:18:23 +0100
Subject: [LTP] [RFC PATCH 1/1] lapi: Add sysinfo.h to fix build with
 MUSL libc
In-Reply-To: <20201015190620.GA9408@dell5510>
References: <20201001231256.6930-1-petr.vorel@gmail.com>
 <20201014143317.GC13224@yuki.lan> <20201015190620.GA9408@dell5510>
Message-ID: <20201027191823.GB25803@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> I've added this patch already to buildroot, but if kernel patch get accepted,
> it'd be kept only temporarily (I think they don't have patches for musl based
> toolchains, otherwise they'd take Alpine's patch by now. But they instead drop
> support for these toolchains in packages which don't upstream the solution.

> > Apart from that it looks like the kernel patch has been ignored. I guess
> > that you should try to push it a bit more before we give up and apply
> > workarounds...
> Tried next version, let's see.
> https://lore.kernel.org/linux-api/20201015190013.8901-1-petr.vorel@gmail.com/

Patch has been included into next tree [1]. If not reverted, it would fix the
problem for newer kernel headers. Distros using MUSL (Buildroot and OpenEmbedded)
will have to keep this patch for older headers and update it as we might add
more <sys/sysinfo.h> in the future, but that's not that difficult.

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20201027&id=92a5a1734a34380444dd9cace835525c5f51a9ed
