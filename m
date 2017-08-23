From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Aug 2017 11:53:12 +0200
Subject: [LTP] [PATCH v3] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <20170823041558.33vhtfsdswenhcfa@XZHOUW.usersys.redhat.com>
References: <20170821160047.GB6479@rei.lan>
 <1503390908-13620-1-git-send-email-xzhou@redhat.com>
 <20170822142356.GB23381@rei.lan>
 <20170823041558.33vhtfsdswenhcfa@XZHOUW.usersys.redhat.com>
Message-ID: <20170823095312.GB17676@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +#include <sys/types.h>
> > > +#include <sys/stat.h>
> ...
> > > +		SAFE_READ(1, fd, buf, pa->length);
> > > +
> > > +		/* Verifying data read */
> > > +		for (i = 0; i < pa->length; i++) {
> > > +
> > > +			if (buf[i] < 1 || buf[i] > 254) {
> > > +
> > > +				tst_res(TFAIL, "Unexpected data "
> > > +					"offset %ld value %d",
> > > +					pa->offset + i, buf[i]);
> > > +				break;
> > > +			}
> > > +
> > > +			long tmp = pa->length / 2;
> > 
> > We can simplify this with:
> > 			int j = i / (pa->length/2);
> > 
> > 			if (buf[i] != buf[j]) {
> > 				...
> > 			}
> 
> After checking, this is not what I meant to check here about
> this data verifying.
> 
> We could read 4k data that first half 2k of it have the same
> value and the another half 2k have a different value.

Ah right, made a silly mistake the correct formula is:

	int j = (i / (pa->length/2)) * pa->length/2;

The previous one was yielding incorrect result for i >= pa->length/2.

-- 
Cyril Hrubis
chrubis@suse.cz
