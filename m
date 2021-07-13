From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jul 2021 11:26:43 +0200
Subject: [LTP] tst_strstatus.c fails on Alpine
In-Reply-To: <d2d298df-b432-4afb-6654-cafb7de36bbb@bell-sw.com>
References: <YOx1pir0UuBNM+4w@pevik>
 <CAASaF6zS0kPHk6vSvANA1KzuOCtJHskLmOE_DE1n4b5AhMUPkg@mail.gmail.com>
 <d2d298df-b432-4afb-6654-cafb7de36bbb@bell-sw.com>
Message-ID: <YO1cU11EEzoZIFNT@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 13.07.2021 09:08, Jan Stancek wrote:


> > On Mon, Jul 12, 2021 at 7:02 PM Petr Vorel <pvorel@suse.cz <mailto:pvorel@suse.cz>> wrote:

> >     Hi all,

> >     I see failures of lib/newlib_tests/tst_strstatus on Alpine:

> >     tst_strstatus.c:31: TPASS: exited with 1
> >     tst_strstatus.c:31: TPASS: killed by SIGHUP
> >     tst_strstatus.c:31: TPASS: is stopped
> >     tst_strstatus.c:31: TPASS: is resumed
> >     tst_strstatus.c:29: TFAIL: killed by ??? != invalid status 0xff

> >     Any idea what could be wrong?


> > I'd start with definition of WIFSIGNALED on that system.

> > printf("%d\n", WIFSIGNALED(0xff));
> > should give you 0, but it does appear to return 1 in output above.


> musl defines it as:
> #define WIFSIGNALED(s) (((s)&0xffff)-1U < 0xffu)
> so passing 0xff trigger this.

> This difference from the glibc have appeared since the commit:
> 41c632824c08 ("fix definitions of WIFSTOPPED and WIFSIGNALED to support up to signal 127")

> May be changed 0xff to 0x1ff for invalid status...

Thanks, 0x1ff is the right value for both glibc and musl.
I'll send it as part of v4 	of my patchset "Run tests in CI".

Kind regards,
Petr
