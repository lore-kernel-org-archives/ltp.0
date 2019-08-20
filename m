From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Aug 2019 12:27:11 +0200
Subject: [LTP] [PATCH] tst_res: Print errno number in addition to error
 name
In-Reply-To: <CAEemH2cX1CO=zLzf1ZHQM+MUNS=FLKpGD1ypx=2uGst5qXn4YQ@mail.gmail.com>
References: <20190819133618.7538-1-rpalethorpe@suse.com>
 <20190820095521.GA22253@rei.lan>
 <CAEemH2cX1CO=zLzf1ZHQM+MUNS=FLKpGD1ypx=2uGst5qXn4YQ@mail.gmail.com>
Message-ID: <20190820102711.GA22483@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > It appears we are atleast missing ENOTSUPP (524) which is probably returned by
> > > create_timer for some alarm clocks on none x86 arches. This isn't entirely
> > > clear, but what is clear is that it would help to know what the error number
> > > is without using strace.
> >
> > Can we please also patch the lib/errnos.h so that the ENOTSUPP is
> > included there as well?
> 
> Not sure if we should do that since it(from google) says ENOTSUPP is
> not intended to used in userland.

Looks like there are two of these ENOTSUP and ENOTSUPP so the syscall
returning ENOTSUPP is a bug itself since it should return ENOTSUP. Also
btw ENOTSUP == EOPNOTSUPP and we do have EOPNOTSUPP in errnos.h.

-- 
Cyril Hrubis
chrubis@suse.cz
