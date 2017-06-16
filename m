From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 16 Jun 2017 10:03:29 -0400 (EDT)
Subject: [LTP] [PATCH] Fix mmap01 testcase on hppa architecture
In-Reply-To: <0a7d9ad3-c1fc-1936-15e2-cef6e0b8e56e@gmx.de>
References: <20170609145328.GA7129@ls3530>
 <2130257221.33914320.1497352715953.JavaMail.zimbra@redhat.com>
 <0a7d9ad3-c1fc-1936-15e2-cef6e0b8e56e@gmx.de>
Message-ID: <1366594617.36983858.1497621809398.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On 13.06.2017 13:18, Jan Stancek wrote:
> >> The mmap() syscall to map a file at any given page-aligned address (via
> >> the
> >> MAP_FIXED flag) can fail on the hppa architecture due to cache colouring
> >> requirements of the architecture.
> >>
> >> This patch drops the MAP_FIXED flag and thus maps the file instead at
> >> some convenient address based on the hint as given by the addr
> >> parameter.
> > 
> > It looks like we don't need addr at all. Test is remapping part
> > of heap with MAP_FIXED, which looks risky. I'd drop that page
> > initialisation inside heap too. Now, without MAP_FIXED, it's
> > just completely unrelated page. What do you think?
> 
> Yes, that's probably the best choice.
> The original code tries to initialize the area where the file is going
> to be mapped with non-zero values to be able to check if after the mapping
> the memory area beyond the EOF was zero-initialized by the kernel.
> This part of the check was already changed by my initial patch, with
> your suggestion we would now drop the initialization completely.
> I think your suggestion is fair.
> 
> New patch is attached.

Pushed.

Thanks,
Jan

