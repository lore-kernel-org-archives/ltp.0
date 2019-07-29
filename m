From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 14:35:57 +0200
Subject: [LTP] [PATCH v2] syscalls/clock_gettime: Ported
 clock_gettime03.c to new API
In-Reply-To: <20190729121719.GA25075@rei.lan>
References: <20190729120222.4717-1-pvorel@suse.cz>
 <20190729121719.GA25075@rei.lan>
Message-ID: <20190729123557.GA9131@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > NOTE: test is still a mess, even after porting it.
> > Cleaning it up would probably be its own patch as the best
> > solution would be to rewrite it from scratch.

> The patch looks good, acked.

> There are couple of things that could be done to make the code cleaner.
> For instance we should make use of the .restore_wallclock flag in the
> test structure. But let's do that in a subsequent patches.
+1

> Also I'm not 100% sure that this test belongs under the clock_gettime/
> directory, we do call clock_gettime() in the main test function but the
> whole test is about inserting leap second. Maybe we should keep the test
> under the clock_gettime directory and rename it to leapsec01.c or
> something like this, but I'm not 100% sure about this.
+1 Before 0051eab23 it was called leapsec_timer.c. I also consider leapsec01.c
as more descriptive. Anyone else against renaming it?

Kind regards,
Petr
