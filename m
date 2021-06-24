From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Jun 2021 22:00:33 +0800
Subject: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
In-Reply-To: <018a369f-473b-524d-f81b-eb8be4df49bb@suse.cz>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <018a369f-473b-524d-f81b-eb8be4df49bb@suse.cz>
Message-ID: <CAEemH2eSNnhwnOOOMoUf5Xv0uup_ZTJMDncLsgkChcULY37RfQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 24, 2021 at 9:33 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 24. 06. 21 15:22, Krzysztof Kozlowski wrote:
> > On big memory systems, e.g. 196 GB RAM machine, the ioctl_sg01 test was
> > failing because of OoM killer during memory pollution:
> >
> > ...
> >
> > It seems leaving hard-coded 128 MB free memory works for small or medium
> > systems, but for such bigger machine it creates significant memory
> > pressure triggering the out of memory reaper.
> >
> > The memory pressure usually is defined by ratio between free and total
> > memory, so adjust the safety/spare memory similarly to keep always 0.5%
> > of memory free.
>
> Hi,
> I've sent a similar patch for the same issue a while ago. It covers a
> few more edge cases. See [1] for the discussion about it.


> [1]
>
> https://patchwork.ozlabs.org/project/ltp/patch/20210127115606.28985-1-mdoucha@suse.cz/


FYI, Another related analysis:
https://lists.linux.it/pipermail/ltp/2021-April/021903.html

The mmap() behavior changed in GUESS mode from commit 8c7829b04c523cd,
we can NOT receive MAP_FAILED on ENOMEM in userspace anymore, unless
the process one-time allocating memory larger than "total_ram+ total_swap"
explicitly.

Which also means the MAP_FAILED check lose effect permanently in line#51:
https://github.com/linux-test-project/ltp/blob/master/lib/tst_memutils.c#L51

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210624/a8c02dde/attachment-0001.htm>
