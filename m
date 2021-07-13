From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jul 2021 12:24:28 +0200
Subject: [LTP] tst_strstatus.c fails on Alpine
In-Reply-To: <YO1cIhIKgEPrApUC@yuki>
References: <YOx1pir0UuBNM+4w@pevik>
 <CAASaF6zS0kPHk6vSvANA1KzuOCtJHskLmOE_DE1n4b5AhMUPkg@mail.gmail.com>
 <YO1VaOB8nnMh6FT1@pevik> <YO1cIhIKgEPrApUC@yuki>
Message-ID: <YO1p3LfWwdY0cmGj@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Hi!
> > Thanks for a hint. Indeed WIFSIGNALED(0xff) returns 1, thus tst_strstatus()
> > returns signaled(status).

> > musl defines WIFSIGNALED() as:

> > #define WIFSIGNALED(s) (((s)&0xffff)-1U < 0xffu)

> > which returns 1.

> > Glibc defines __WIFSIGNALED() as:

> > #define __WIFSIGNALED(status) \
> >   (((signed char) (((status) & 0x7f) + 1) >> 1) > 0)

> > which returns 0.

> > I wonder if it's a musl bug which we should report or {0x100, "invalid status
> > 0xff"} test case is glibc specific and we should guard it with #ifdef __GLIBC__.

> The process exit values are defined in the kernel ABI so I would say
> that there shouldn't be any differencies between how these are handled
> inside different libc implementation. That being said the musl version
> is incorrect only for invalid values that will probably not happen in
> practice. Glibc is simply more defensive in parsing and rejects invalid
> conditions.
Agree.


> WIFSIGNALED() is supposed to return 1 only if process was killed by a
> signal, which means that the upper byte of the status is ignored and the
> lower byte has to look like:

> 7 6 5 4 3 2 1 0
> x . . . . . . .
>   ^
> ^ Termination signal

> Core dumped flag

> Also this value can't be set tio 0x7f since that means "stopped by
> signal".

> This is exaclty what glibc does since it masks the termination signal
> number with 0x7f then adds 1, which would overlfow to 0x80 if the value
> was 0x7f initially and end up being negative. The bitshift is there to
> erase the +1 in a case we started with 0.

> The musl libc returns 1 if the lower byte is non-zero and the upper byte
> is zero, which depends on the fact that the upper byte is unused and
> filled in zeroes when the process was killed by a signal and non-zero in
> all other cases where the lower byte is non-zero. As long as we get only
> valid status from wait() this is going to work fine.

Thanks for a detailed explanation.

> To be honest I like the defensive parsing from libc more than the musl
> variant but I'm not 100% sure if this is something that should be added
> to musl as well.

FYI musl commit 41c63282 ("fix definitions of WIFSTOPPED and WIFSIGNALED
to support up to signal 127") [1] mentions mips bug discussion on linux-mips ML
from 2013 (musl fix is also from that time) [2]:

> I think it's feasible to ask {g,uc}libc to change their defines
> (on MIPS as a minimum), and live with 127 signals.

=> I haven't checked if it was posted at the time. I wonder if anybody cares
enough about mips nowadays to fix this. I also like these guarders, thus I
wonder if musl should have it only for mips (currently it's for all archs).


Kind regards,
Petr

[1] https://git.musl-libc.org/cgit/musl/commit/?id=41c632824c08ac2c9eea43b30d1b3515dd910df6
[2] https://www.linux-mips.org/archives/linux-mips/2013-06/msg00552.html

