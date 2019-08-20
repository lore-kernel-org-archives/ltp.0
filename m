From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Aug 2019 18:20:56 +0800
Subject: [LTP] [PATCH] tst_res: Print errno number in addition to error
 name
In-Reply-To: <20190820095521.GA22253@rei.lan>
References: <20190819133618.7538-1-rpalethorpe@suse.com>
 <20190820095521.GA22253@rei.lan>
Message-ID: <CAEemH2cX1CO=zLzf1ZHQM+MUNS=FLKpGD1ypx=2uGst5qXn4YQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 20, 2019 at 5:55 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > It appears we are atleast missing ENOTSUPP (524) which is probably returned by
> > create_timer for some alarm clocks on none x86 arches. This isn't entirely
> > clear, but what is clear is that it would help to know what the error number
> > is without using strace.
>
> Can we please also patch the lib/errnos.h so that the ENOTSUPP is
> included there as well?

Not sure if we should do that since it(from google) says ENOTSUPP is
not intended to used in userland.

But if we just for catching more errors to report in LTP, I also think
it does not hurt anything.

-- 
Regards,
Li Wang
