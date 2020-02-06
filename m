From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 06 Feb 2020 12:02:07 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <20200205191006.GA18877@rei>
References: <20200203113956.13176-1-mdoucha@suse.cz>
 <20200203113956.13176-2-mdoucha@suse.cz> <20200205143107.GC30186@rei>
 <fda46288-1850-8ac9-1c56-7641aaeb8759@suse.cz> <20200205155012.GA4920@rei>
 <2c7e9545-93e3-3460-6006-5e57b982ecc7@suse.cz> <20200205191006.GA18877@rei>
Message-ID: <87lfpgges0.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > That's only true if we are building and external interface for a
>> > library, here we are just avoiding copy&paste by the simpliest means
>> > available.
>>
>> I am building external interface for a library. The library is called
>> bpf_common. But if you still disagree with splitting the executable code
>> into a separate file to make the header more readable for developers of
>> future BPF tests, I'll gladly unassign myself from this task and go work
>> on something else.
>
> Can we please discuss things calmly and rationally? If you want to give
> up on your patch that's fine, however if you want to continue to discuss
> technical details, let's do it without emotions, okay?

Honestly this is a style issue, so we can exchange one or two opinions,
but then just decide Cyril is right (because he has survived as
maintainer for X years with similar ideas about style) and move on to
things where the universe proves you right or wrong in the time it takes
to compile and run your code.

>
> Getting back to the technical point of the discussion, I still do not
> consider that these three functions are complex enough to be split into
> header and C source, but I do not have such strong opinion about that.
>
> So if you really think that it should be separated like that at least
> put the change that moves the code into a separate patch, since that is
> unrelated change to introduction of the new function.
>
> --
> Cyril Hrubis
> chrubis@suse.cz


--
Thank you,
Richard.
