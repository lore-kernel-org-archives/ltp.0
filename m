From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 31 May 2018 09:35:42 -0400 (EDT)
Subject: [LTP] [PATCH] pty/pty02: new test for hang involving
 EXTPROC|ICANON	terminal mode
In-Reply-To: <20180513000101.13027-1-ebiggers3@gmail.com>
References: <20180513000101.13027-1-ebiggers3@gmail.com>
Message-ID: <793542157.23379871.1527773742485.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> + * Regression test for commit 966031f340185 ("n_tty: fix EXTPROC vs ICANON
> + * interaction with TIOCINQ (aka FIONREAD)").  The test reproduces a hang
> + * (infinite loop in the kernel) after a pseudoterminal is put in both
> canonical
> + * (ICANON) and external processing (EXTPROC) mode, some data is written to
> the
> + * master and read from the slave, and the FIONREAD ioctl is called on the
> + * slave.  This is simplified from a syzkaller-generated reproducer.
> + */
> +
> +#include <stdlib.h>
> +#include <termio.h>
> +
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	struct termios io = { .c_lflag = EXTPROC | ICANON };

Hi,

I'm running into compilation errors on older distros (RHEL5/6)
with this test:

pty02.c: In function ‘do_test’:
pty02.c:34: error: ‘EXTPROC’ undeclared (first use in this function)
pty02.c:34: error: (Each undeclared identifier is reported only once
pty02.c:34: error: for each function it appears in.)
make: *** [pty02] Error 1

We should probably ifdef the test, because adding define to LAPI
still makes it fail:

tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
pty02.c:44: BROK: tcsetattr() failed: EINVAL

Regards,
Jan
