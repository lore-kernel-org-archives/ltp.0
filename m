From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Jul 2019 15:01:35 +0800
Subject: [LTP] [PATCH 1/1] syscalls/ustat: Use __kernel_daddr_t instead
 of daddr_t
In-Reply-To: <20190617213138.15896-1-petr.vorel@gmail.com>
References: <20190617213138.15896-1-petr.vorel@gmail.com>
Message-ID: <CAEemH2fGBfsxyJTotcvDrGOzFqRs53QmaXygEj8Jz5HgUxr5+A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Tue, Jun 18, 2019 at 5:32 AM Petr Vorel <petr.vorel@gmail.com> wrote:

> This fixes build for musl, which does not have <sys/ustat.h> nor
> typedef daddr_t. Musl does not define these as ustat is deprecated
> in favor of statfs() and daddr_t is ancient [1].
>
> Other libc also does not have <sys/ustat.h> (ustat support was removed
> from glibc in 2.28), but they have daddr_t.
>
> This brings <linux/types.h> dependency for ustat testing.
>
> Typedef is needed as sparc and mips have __kernel_daddr_t long,
> otherwise it's int.
>
> [1] https://www.openwall.com/lists/musl/2019/06/10/1
>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>

I don't have a try to build this with musl, but from my code review, the
patch makes sense.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190718/284ee6d4/attachment.htm>
