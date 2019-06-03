From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Jun 2019 16:31:37 +0200
Subject: [LTP] [PATCH 3/5] syscalls/asyncio02: convert to new library.
In-Reply-To: <20190529112529.GC26685@rei.lan>
References: <20190519003808.47425-1-sspatil@android.com>
 <20190519003808.47425-4-sspatil@android.com>
 <20190529112529.GC26685@rei.lan>
Message-ID: <20190603143137.GA18922@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> The cleanup looks good, but we should also decide what to do with the
> test as it is in a wrong place. There is no asyncio syscall in Linux and
> the test actually looks very similar to the stat01.c test, so maybe it
> would be best to rename the test to stat02.c after the cleanup. What do
> you think?
I'd also move it into stat/stat02.c.

> Cyril Hrubis

Kind regards,
Petr
