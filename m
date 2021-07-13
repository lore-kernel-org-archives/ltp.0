From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jul 2021 10:57:12 +0200
Subject: [LTP] tst_strstatus.c fails on Alpine
In-Reply-To: <CAASaF6zS0kPHk6vSvANA1KzuOCtJHskLmOE_DE1n4b5AhMUPkg@mail.gmail.com>
References: <YOx1pir0UuBNM+4w@pevik>
 <CAASaF6zS0kPHk6vSvANA1KzuOCtJHskLmOE_DE1n4b5AhMUPkg@mail.gmail.com>
Message-ID: <YO1VaOB8nnMh6FT1@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> On Mon, Jul 12, 2021 at 7:02 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > I see failures of lib/newlib_tests/tst_strstatus on Alpine:

> > tst_strstatus.c:31: TPASS: exited with 1
> > tst_strstatus.c:31: TPASS: killed by SIGHUP
> > tst_strstatus.c:31: TPASS: is stopped
> > tst_strstatus.c:31: TPASS: is resumed
> > tst_strstatus.c:29: TFAIL: killed by ??? != invalid status 0xff

> > Any idea what could be wrong?


> I'd start with definition of WIFSIGNALED on that system.

> printf("%d\n", WIFSIGNALED(0xff));
> should give you 0, but it does appear to return 1 in output above.

Thanks for a hint. Indeed WIFSIGNALED(0xff) returns 1, thus tst_strstatus()
returns signaled(status).

musl defines WIFSIGNALED() as:

#define WIFSIGNALED(s) (((s)&0xffff)-1U < 0xffu)

which returns 1.

Glibc defines __WIFSIGNALED() as:

#define __WIFSIGNALED(status) \
  (((signed char) (((status) & 0x7f) + 1) >> 1) > 0)

which returns 0.

I wonder if it's a musl bug which we should report or {0x100, "invalid status
0xff"} test case is glibc specific and we should guard it with #ifdef __GLIBC__.

Kind regards,
Petr
