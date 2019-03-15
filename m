From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Mar 2019 09:25:28 +0100
Subject: [LTP] [PATCH v2] syscall: Add userfaultfd testcase
In-Reply-To: <824216999.8470703.1552563760595.JavaMail.zimbra@redhat.com>
References: <20190314085717.10207-1-camann@suse.com>
 <824216999.8470703.1552563760595.JavaMail.zimbra@redhat.com>
Message-ID: <20190315082528.GA25064@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

some explanation below.

> Hi,

> my main concern is that direct include of linux header.

> Other than that it looks ok, but you could use more SAFE_ macros
> which do the common checks and print error messages for you.

> <snip>

> > +#include "tst_test.h"
> > +#include "lapi/syscalls.h"
> > +#include <linux/userfaultfd.h>

> This doesn't look like it will compile on older kernels.
Please add linux/userfaultfd.h to AC_CHECK_HEADERS in configure.ac
and use #ifdef HAVE_LINUX_USERFAULTFD_H guard and TST_TEST_TCONF with error
message.

...
> > +static void set_pages(void)
> > +{
> > +	page_size = sysconf(_SC_PAGE_SIZE);
> > +	page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> > +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +	copy_page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> > +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

> Please use SAFE_MMAP
There are many of SAFE_*() macro helpers, which are supposed to be used
(see include/tst_safe_*.h and doc [1])


Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c
