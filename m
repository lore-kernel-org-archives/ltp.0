From: Xiong Zhou <xzhou@redhat.com>
Date: Wed, 23 Aug 2017 12:15:58 +0800
Subject: [LTP] [PATCH v3] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <20170822142356.GB23381@rei.lan>
References: <20170821160047.GB6479@rei.lan>
 <1503390908-13620-1-git-send-email-xzhou@redhat.com>
 <20170822142356.GB23381@rei.lan>
Message-ID: <20170823041558.33vhtfsdswenhcfa@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 22, 2017 at 04:23:57PM +0200, Cyril Hrubis wrote:
> Hi!
> >  runtest/syscalls                          |   2 +
> >  testcases/kernel/syscalls/fcntl/Makefile  |   3 +
> >  testcases/kernel/syscalls/fcntl/fcntl36.c | 386 ++++++++++++++++++++++++++++++
> 
> Don't forget about .gitignore entry as well.

Ha, now i found the right one, :)

> 
> ...
> 
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
...
> > +		SAFE_READ(1, fd, buf, pa->length);
> > +
> > +		/* Verifying data read */
> > +		for (i = 0; i < pa->length; i++) {
> > +
> > +			if (buf[i] < 1 || buf[i] > 254) {
> > +
> > +				tst_res(TFAIL, "Unexpected data "
> > +					"offset %ld value %d",
> > +					pa->offset + i, buf[i]);
> > +				break;
> > +			}
> > +
> > +			long tmp = pa->length / 2;
> 
> We can simplify this with:
> 			int j = i / (pa->length/2);
> 
> 			if (buf[i] != buf[j]) {
> 				...
> 			}

After checking, this is not what I meant to check here about
this data verifying.

We could read 4k data that first half 2k of it have the same
value and the another half 2k have a different value.

> 
> > +			if ((i < tmp && buf[i] != buf[0]) ||
> > +			    (i >= tmp && buf[i] != buf[tmp])) {
> > +
> > +				tst_res(TFAIL, "Unexpected data "
> > +					"offset %ld value %d",
> > +					pa->offset + i, buf[i]);
> > +				break;
> > +			}
> > +		}
> > +
...
> > +	if (tst_fill_file(fname, 1, write_size, thread_cnt)) {
> > +		tst_brk(TBROK, "Failed to create tst file");
> > +	}
> 
> No need for the curly braces around single line statement here.

I thought it's safer for a macro. Now it's one line function in
the macro, not hurting to remove the braces.

Thanks for reviewing!
Xiong
