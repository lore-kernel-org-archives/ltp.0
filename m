From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 21 Aug 2019 09:57:57 +0200
Subject: [LTP] [PATCH] tst_res: Print errno number in addition to error
 name
In-Reply-To: <20190820102711.GA22483@rei.lan>
References: <20190819133618.7538-1-rpalethorpe@suse.com>
 <20190820095521.GA22253@rei.lan>
 <CAEemH2cX1CO=zLzf1ZHQM+MUNS=FLKpGD1ypx=2uGst5qXn4YQ@mail.gmail.com>
 <20190820102711.GA22483@rei.lan>
Message-ID: <87y2znuf0a.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > > It appears we are atleast missing ENOTSUPP (524) which is probably returned by
>> > > create_timer for some alarm clocks on none x86 arches. This isn't entirely
>> > > clear, but what is clear is that it would help to know what the error number
>> > > is without using strace.
>> >
>> > Can we please also patch the lib/errnos.h so that the ENOTSUPP is
>> > included there as well?
>>
>> Not sure if we should do that since it(from google) says ENOTSUPP is
>> not intended to used in userland.

I suppose we could print a warning/fail if any error value over 512
(ERESTARTSYS) is seen by tst_res(). We can define these error numbers in
user land for debugging purposes.

>
> Looks like there are two of these ENOTSUP and ENOTSUPP so the syscall
> returning ENOTSUPP is a bug itself since it should return ENOTSUP. Also
> btw ENOTSUP == EOPNOTSUPP and we do have EOPNOTSUPP in errnos.h.

I think there is quite a lot of stuff missing. Maybe it is time to
create a script for generating this list?

--
Thank you,
Richard.
