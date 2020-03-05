From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Mar 2020 12:54:13 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
In-Reply-To: <20200305101122.GA31652@rei>
References: <20200304151201.19117-1-pvorel@suse.cz>
 <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
 <dc371963-7dd4-1414-f1c9-19696ffc0124@suse.cz>
 <20200304164521.GA5603@dell5510> <20200305101122.GA31652@rei>
Message-ID: <20200305115413.GA5882@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > > I forgot to add one more thing: making the return value checks more
> > > pedantic would also be nice.
> > I guess you mean if (rval == -1). Sure, I'll do that.

> Actually for the sake of SAFE_MACROS() it makes sense to fail unless we
> got a valid result. So for > 0 for timerfd_create() 
I guess you mean fd < 0 here (no " > 0), as it's a file descriptor.
> and != 0 for
> timerfd_settime() and timerfd_gettime().

Kind regards,
Petr
