From: Will Deacon <will@kernel.org>
Date: Tue, 15 Oct 2019 17:14:54 +0100
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E0-rc2-d6c2c23=2Ecki_=28stable-next=29?=
In-Reply-To: <20191015152651.GG13874@arrakis.emea.arm.com>
References: <cki.B4A567748F.PFM8G4WKXI@redhat.com>
 <805988176.6044584.1571038139105.JavaMail.zimbra@redhat.com>
 <CAAeHK+zxFWvCOgTYrMuD-oHJAFMn5DVYmQ6-RvU8NrapSz01mQ@mail.gmail.com>
 <20191014162651.GF19200@arrakis.emea.arm.com>
 <20191014213332.mmq7narumxtkqumt@willie-the-truck>
 <20191015152651.GG13874@arrakis.emea.arm.com>
Message-ID: <20191015161453.lllrp2gfwa5evd46@willie-the-truck>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 15, 2019 at 04:26:51PM +0100, Catalin Marinas wrote:
> On Mon, Oct 14, 2019 at 10:33:32PM +0100, Will Deacon wrote:
> > On Mon, Oct 14, 2019 at 05:26:51PM +0100, Catalin Marinas wrote:
> > > On Mon, Oct 14, 2019 at 02:54:17PM +0200, Andrey Konovalov wrote:
> > > > What do you think we should do here?
> > > 
> > > It is an ABI break as the man page clearly states that the above case
> > > should return -ENOMEM.
> > 
> > Although I agree with your analysis, I also thought that these sorts of
> > ABI breaks (changes in error codes) were unfortunately common so we
> > shouldn't throw the baby out with the bath water here.
> > 
> > > The options I see:
> > > 
> > > 1. Revert commit 057d3389108e and try again to document that the memory
> > >    syscalls do not support tagged pointers
> > > 
> > > 2. Change untagged_addr() to only 0-extend from bit 55 or leave the
> > >    tag unchanged if bit 55 is 1. We could mask out the tag (0 rather
> > >    than sign-extend) but if we had an mlock test passing ULONG_MASK,
> > >    then we get -ENOMEM instead of -EINVAL
> > > 
> > > 3. Make untagged_addr() depend on the TIF_TAGGED_ADDR bit and we only
> > >    break the ABI for applications opting in to this new ABI. We did look
> > >    at this but the ptrace(PEEK/POKE_DATA) needs a bit more thinking on
> > >    whether we check the ptrace'd process or the debugger flags
> > > 
> > > 4. Leave things as they are, consider the address space 56-bit and
> > >    change the test to not use LONG_MAX on arm64. This needs to be passed
> > >    by the sparc guys since they probably have a similar issue
> > 
> > I'm in favour of (2) or (4) as long as there's also an update to the docs.
> 
> With (4) we'd start differing from other architectures supported by
> Linux. This works if we consider the test to be broken. However, reading
> the mlock man page:
> 
>        EINVAL The result of the addition addr+len was less than addr
>        (e.g., the addition may have resulted in an overflow).
> 
>        ENOMEM Some of the specified address range does not correspond to
>        mapped pages in the address space of the process.
> 
> There is no mention of EINVAL outside the TASK_SIZE, seems to fall more
> within the ENOMEM description above.

Sorry, I was being too vague in my wording. What I was trying to say is I'm
ok with (2) or (4), but either way we need to update our ABI documentation
under Documentation/arm64/. I personally don't think userspace will care
about EINVAL vs ENOMEM because the kernel is already horribly unreliable
when it comes to keeping error codes stable, which is why I think we could
get away with (4). For example, Jan (who reported this issue) wrote this
change to LTP last year for one of the mmap tests:

https://github.com/linux-test-project/ltp/commit/e7bab61882847609be3132a2f0d94f7469ff5d3e

The fact that we have tagging at all already means that we differ from
many other architectures.

> > > It's slightly annoying to find this now. We did run (part of) LTP but I
> > > guess we never run the POSIX conformance tests.
> > 
> > Yes, and this stuff was in linux-next for a while so it's worrying that
> > kernelci didn't spot it either. Hmm.
> 
> For some reason the mlock test was skipped around the time we pushed the
> TBI patches into -next:
> 
> https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-open-posix-tests/mlock_8-1?&page=2

Coincidence?

> Internally I don't think we've configured LTP with
> --with-open-posix-testsuite, so this explains why we missed it.

Ok, hopefully you can fix that now.

> > > My preference is 2 with a quick attempt below. This basically means
> > > clear the tag if it resembles a valid (tagged) user pointer, otherwise
> > > don't touch it (bit 55 set always means an invalid user pointer). Not
> > > sure how the generated code will look like but we could probably do
> > > something better in assembly directly.
> [...]
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index b61b50bf68b1..c23c47360664 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -215,12 +215,18 @@ static inline unsigned long kaslr_offset(void)
> >   * up with a tagged userland pointer. Clear the tag to get a sane pointer to
> >   * pass on to access_ok(), for instance.
> >   */
> > -#define untagged_addr(addr)	\
> > +#define __untagged_addr(addr)	\
> >  	((__force __typeof__(addr))sign_extend64((__force u64)(addr), 55))
> >  
> > +#define untagged_addr(addr)	({					\
> > +	u64 __addr = (__force u64)addr;					\
> > +	__addr &= __untagged_addr(__addr);				\
> > +	(__force __typeof__(addr))__addr;				\
> > +})
> > +
> >  #ifdef CONFIG_KASAN_SW_TAGS
> >  #define __tag_shifted(tag)	((u64)(tag) << 56)
> > -#define __tag_reset(addr)	untagged_addr(addr)
> > +#define __tag_reset(addr)	__untagged_addr(addr)
> >  #define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
> >  #else
> >  #define __tag_shifted(tag)	0UL
> 
> This works for me. Szabolcs also suggested just zeroing the top byte but
> we wouldn't catch the overflow EINVAL case above, so I'd rather only
> mask the tag out if it was a user address (i.e. bit 55 is 0).

I'll spin it as a proper patch while we decide whether we want to do
anything.

Will
