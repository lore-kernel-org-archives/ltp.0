From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 May 2021 13:17:29 +0200
Subject: [LTP] [PATCH] mtest06/mmap1: Further limit distant mmap size
In-Reply-To: <CAASaF6y2XaLjHwfErwez4zo2NYFLoScROGocK0ibH1pVZcia1w@mail.gmail.com>
References: <20210519131916.314184-1-cascardo@canonical.com>
 <CAASaF6y2XaLjHwfErwez4zo2NYFLoScROGocK0ibH1pVZcia1w@mail.gmail.com>
Message-ID: <YKZFSfvZK+79K9Pv@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Though on recent kernels (starting with 5.2, commit
> > 8c7829b04c523cdc732cb77f59f03320e09f3386 ("mm: fix false-positive
> > OVERCOMMIT_GUESS failures"), overcommit accounting allows for allocating up
> > to MemTotal memory, older kernels have a much more complicated overcommit
> > guess accounting.
> >
> > That leads to mmap failing on small enough systems:
> >
> > mmap1.c:205: TBROK: mmap((nil),2088370176,3,34,-1,0) failed: ENOMEM (12)
> >
> > Allocating only half of the total memory would generally work on test
> > systems.
> >
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> 
> Thanks for patch.
> 
> Acked-by: Jan Stancek <jstancek@redhat.com>

Looks safe enough for the release, as far as I can tell the test
shouldn't care at all where we map the block of memory.

Jan looks like you originaly wrote the test, do you agree that this
should go in now?

-- 
Cyril Hrubis
chrubis@suse.cz
