From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 22 Feb 2019 08:39:53 +0100
Subject: [LTP] [PATCH] syscalls/ustat: Move the syscall to lapi
In-Reply-To: <20190221143021.GC17813@rei.lan>
References: <20190221112201.18324-1-chrubis@suse.cz>
 <87r2c12udf.fsf@rpws.prws.suse.cz> <20190221143021.GC17813@rei.lan>
Message-ID: <87pnrk2rw6.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > diff --git a/include/lapi/ustat.h b/include/lapi/ustat.h
>> > index 12c073582..6365b2e92 100644
>> > --- a/include/lapi/ustat.h
>> > +++ b/include/lapi/ustat.h
>> > @@ -10,12 +10,19 @@
>> >  #ifdef HAVE_SYS_USTAT_H
>> >  # include <sys/ustat.h>
>>
>> Just a thought, but this is potentially a problem if lib C implementes
>> ustat in user land, but the system call still exists. Which I think is
>> more likely with an obsolete system call.
>
> Good point. So it all depends on what we want to focus on, if we are
> after kernel, we should call the syscall directly, if we look at system
> functionality we should go after the libc one by default.
>
> I guess that ideally we should test both, not sure how to achiveve that
> reasonably easily...

Possibly we could create a config option which forcibly sets (almost)
all the HAVE_* macros to zero. This will probably result in a lot of
tests being skipped as well, but it might be good enough.

--
Thank you,
Richard.
