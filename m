From: Sandeep Patil <sspatil@android.com>
Date: Sun, 9 Jun 2019 17:27:43 -0700
Subject: [LTP] [PATCH 3/5] syscalls/asyncio02: convert to new library.
In-Reply-To: <20190603143137.GA18922@dell5510>
References: <20190519003808.47425-1-sspatil@android.com>
 <20190519003808.47425-4-sspatil@android.com>
 <20190529112529.GC26685@rei.lan> <20190603143137.GA18922@dell5510>
Message-ID: <20190610002743.GD212690@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 03, 2019 at 04:31:37PM +0200, Petr Vorel wrote:
> Hi,
> 
> > The cleanup looks good, but we should also decide what to do with the
> > test as it is in a wrong place. There is no asyncio syscall in Linux and
> > the test actually looks very similar to the stat01.c test, so maybe it
> > would be best to rename the test to stat02.c after the cleanup. What do
> > you think?
> I'd also move it into stat/stat02.c.

I did this now as part of v2. However, the test is still super trivial and
isn't at all unique. All it is now is "verify stat size" and I think stat01
covers it too.

Anyway, its there in the new series if you still see value in having a
stat02.

- ssp
