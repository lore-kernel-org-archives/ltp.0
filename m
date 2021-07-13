From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jul 2021 13:49:07 +0200
Subject: [LTP] tst_strstatus.c fails on Alpine
In-Reply-To: <YO1p3LfWwdY0cmGj@pevik>
References: <YOx1pir0UuBNM+4w@pevik>
 <CAASaF6zS0kPHk6vSvANA1KzuOCtJHskLmOE_DE1n4b5AhMUPkg@mail.gmail.com>
 <YO1VaOB8nnMh6FT1@pevik> <YO1cIhIKgEPrApUC@yuki>
 <YO1p3LfWwdY0cmGj@pevik>
Message-ID: <YO19s5999M7m24dI@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> FYI musl commit 41c63282 ("fix definitions of WIFSTOPPED and WIFSIGNALED
> to support up to signal 127") [1] mentions mips bug discussion on linux-mips ML
> from 2013 (musl fix is also from that time) [2]:
> 
> > I think it's feasible to ask {g,uc}libc to change their defines
> > (on MIPS as a minimum), and live with 127 signals.
> 
> => I haven't checked if it was posted at the time. I wonder if anybody cares
> enough about mips nowadays to fix this. I also like these guarders, thus I
> wonder if musl should have it only for mips (currently it's for all archs).

Hmm, as long as you allow signal 127 you really have to look at the
zeroed unused bits to distinguish between stopped and killed by a
signal. And after that the invalid cobinations end up only to be
non-zero in the upper byte and anything else than 0x7f in the lower
byte without the special value 0xffff.

So in addition to the 0x01ff things like 0x0101 etc. are invalid as
well.

-- 
Cyril Hrubis
chrubis@suse.cz
