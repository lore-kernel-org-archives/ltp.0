From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Jun 2018 10:09:11 +0800
Subject: [LTP] [PATCH] pty/pty02: new test for hang involving
 EXTPROC|ICANON terminal mode
In-Reply-To: <793542157.23379871.1527773742485.JavaMail.zimbra@redhat.com>
References: <20180513000101.13027-1-ebiggers3@gmail.com>
 <793542157.23379871.1527773742485.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2ctB_N6KX1wxykN3FZ2HXXtCgvbmY0y5KWwCXxqApB5tg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Jan,

On Thu, May 31, 2018 at 9:35 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > + * Regression test for commit 966031f340185 ("n_tty: fix EXTPROC vs
> ICANON
> > + * interaction with TIOCINQ (aka FIONREAD)").  The test reproduces a
> hang
> > + * (infinite loop in the kernel) after a pseudoterminal is put in both
> > canonical
> > + * (ICANON) and external processing (EXTPROC) mode, some data is
> written to
> > the
> > + * master and read from the slave, and the FIONREAD ioctl is called on
> the
> > + * slave.  This is simplified from a syzkaller-generated reproducer.
> > + */
> > +
> > +#include <stdlib.h>
> > +#include <termio.h>
> > +
> > +#include "tst_test.h"
> > +
> > +static void do_test(void)
> > +{
> > +     struct termios io = { .c_lflag = EXTPROC | ICANON };
>
> Hi,
>
> I'm running into compilation errors on older distros (RHEL5/6)
> with this test:
>
> pty02.c: In function ‘do_test’:
> pty02.c:34: error: ‘EXTPROC’ undeclared (first use in this function)
> pty02.c:34: error: (Each undeclared identifier is reported only once
> pty02.c:34: error: for each function it appears in.)
> make: *** [pty02] Error 1
>
> We should probably ifdef the test, because adding define to LAPI
> still makes it fail:
>


​Xiao and I have also noticed this, ​beside the undefine issue, there are
still
other problems in pty02 test.

The discuss is here:
http://lists.linux.it/pipermail/ltp/2018-May/008253.html



>
> tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
> pty02.c:44: BROK: tcsetattr() failed: EINVAL
>
> Regards,
> Jan
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180601/bb2bbfb8/attachment-0001.html>
