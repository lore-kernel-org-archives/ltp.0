From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 17 Jul 2019 19:34:57 +0200
Subject: [LTP] [PATCH 1/1] syscalls/ustat: Use __kernel_daddr_t instead
 of daddr_t
In-Reply-To: <20190617213138.15896-1-petr.vorel@gmail.com>
References: <20190617213138.15896-1-petr.vorel@gmail.com>
Message-ID: <20190717173456.GA5272@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> This fixes build for musl, which does not have <sys/ustat.h> nor
> typedef daddr_t. Musl does not define these as ustat is deprecated
> in favor of statfs() and daddr_t is ancient [1].

> Other libc also does not have <sys/ustat.h> (ustat support was removed
> from glibc in 2.28), but they have daddr_t.

> This brings <linux/types.h> dependency for ustat testing.

> Typedef is needed as sparc and mips have __kernel_daddr_t long,
> otherwise it's int.

> [1] https://www.openwall.com/lists/musl/2019/06/10/1

Ping, please.

Kind regards,
Petr
