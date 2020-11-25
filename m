From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Nov 2020 16:16:47 +0530
Subject: [LTP] kernel BUG at mm/highmem.c:417! invalid opcode: 0000 EIP:
 zero_user_segments
In-Reply-To: <20201125004632.GG4327@casper.infradead.org>
References: <CA+G9fYuKZGaHVvAv=ZwOL_p6UM3YhOHy0DcJRRM_DOLGYXg1Dw@mail.gmail.com>
 <20201124171628.dk6tle5lh3sx2jxg@linutronix.de>
 <20201125004632.GG4327@casper.infradead.org>
Message-ID: <CA+G9fYt+P1=efG+Ciq6Pak-NvPARx_GoqOw8FLnw4eb-LjRKrw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 25 Nov 2020 at 06:16, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 24, 2020 at 06:16:28PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2020-11-24 18:52:44 [+0530], Naresh Kamboju wrote:
> > > While running LTP test case access01 the following kernel BUG
> > > noticed on linux next 20201124 tag kernel on i386.
> > >
> > > git short log:
> > > ----------------
> > > git log --oneline next-20201120..next-20201124 -- mm/highmem.c
> > > d9927d46febf Merge branch 'akpm-current/current'
> > > 72d22a0d0e86 mm: support THPs in zero_user_segments
> > > 2a656cad337e mm/highmem: Take kmap_high_get() properly into account
> > >
> > > Please find these easy steps to reproduce the kernel build and boot.
> >
> > This BUG_ON() is in zero_user_segments() which ash been added in commit
> >    72d22a0d0e86 mm: support THPs in zero_user_segments
> >
> > > [   50.852189] kernel BUG at mm/highmem.c:417!
> >
> > I managed to capture one invocation with:
> > zero_user_segments(0xd4367a90,
> >                  0x1000, 0x1000,
> >                  0x0, 0x50)
> > page_compound() -> 1
> > page_size() -> 4096
>
> Thanks for debugging this!  I didn't realise start1 was allowed to be
> less than start2.  Try this ... (systemd is sabotaging my efforts to
> test an i386 kernel)

This patch tested on i386, x86_64 and arm and the reported problem got fixed.
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

- Naresh
