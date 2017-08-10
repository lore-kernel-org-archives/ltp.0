From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 10 Aug 2017 09:24:23 +0200
Subject: [LTP] [PATCH v4 1/3] lib: Add personality fallback and SAFE
	macro
In-Reply-To: <20170809132907.GG32573@rei.lan>
References: <20170808144717.27590-1-rpalethorpe@suse.com>
 <20170809132907.GG32573@rei.lan>
Message-ID: <87a8376g2g.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello Metan,

Cyril Hrubis writes:

> Hi!
>> +#ifndef PERSONALITY_H
>> +#define PERSONALITY_H
>> +
>> +#include <sys/personality.h>
>> +
>> +#if !(HAVE_DECL_UNAME26 == 1 || defined(UNAME26))
>              ^
> 	 Where is this macro from, I cannot see it anywhere.
>
> Have you forgotten git add on configure.ac or something?

Sorry, I am not sure what has happened there.

>
> And I doubt that we need anything else than:
>
> #ifndef UNAME26
> # define UNAME26 0x0020000
> #endif
>
> here...

It is defined as an enum in glibc, but as a macro in musl. I guess it
doesn't matter if macro covers the enum though, except maybe that some
debugging symbol is lost.

-- 
Thank you,
Richard.
