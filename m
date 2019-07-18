From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Jul 2019 10:26:55 +0200
Subject: [LTP] [PATCH 1/1] syscalls/ustat: Use __kernel_daddr_t instead
 of daddr_t
In-Reply-To: <20190717173456.GA5272@dell5510>
References: <20190617213138.15896-1-petr.vorel@gmail.com>
 <20190717173456.GA5272@dell5510>
Message-ID: <20190718082655.GA24449@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This fixes build for musl, which does not have <sys/ustat.h> nor
> > typedef daddr_t. Musl does not define these as ustat is deprecated
> > in favor of statfs() and daddr_t is ancient [1].
> 
> > Other libc also does not have <sys/ustat.h> (ustat support was removed
> > from glibc in 2.28), but they have daddr_t.
> 
> > This brings <linux/types.h> dependency for ustat testing.
> 
> > Typedef is needed as sparc and mips have __kernel_daddr_t long,
> > otherwise it's int.
> 
> > [1] https://www.openwall.com/lists/musl/2019/06/10/1

I'm always worried when we use types starting with double underscores
but let's apply this one, we can always revert it in a case that it
breaks build somewhere.

-- 
Cyril Hrubis
chrubis@suse.cz
