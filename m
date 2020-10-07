From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 7 Oct 2020 07:14:35 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] cacheflush01: Rewrite into new API
In-Reply-To: <20201002202416.28972-1-petr.vorel@gmail.com>
References: <20201002202416.28972-1-petr.vorel@gmail.com>
Message-ID: <1478290725.17134142.1602069275205.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This syscall is currently (v5.9) supported on these architectures:
> arc, csky, mips, m68k, nds32, sh
> 
> constants are missing for m68k, not sure if the testcase is valid for it.
> Untested.
> 
> Test for __LTP__NR_INVALID_SYSCALL saves adding autotools check for
> <asm/cachectl.h>.
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Hi,
> 
> FYI: I was going to ask for removal of this test, but all these archs are
> still supported. This test compiles on all archs now, but I haven't run
> it (I don't have access to none of these archs, not sure if LTP is even
> tested on these archs).

I haven't tested it too, but rewrite looks good.

Acked-by: Jan Stancek <jstancek@redhat.com>

