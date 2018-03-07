From: Tim Bird <tbird20d@gmail.com>
Date: Wed, 7 Mar 2018 06:01:01 -0800
Subject: [LTP] LTP API documentation
In-Reply-To: <20180307105215.GC9871@rei>
References: <CA+bK7J7jetfNOpXmxstQtC-_-gbzb0ko8OV8rjRnYp7BbR7JAw@mail.gmail.com>
 <20180307105215.GC9871@rei>
Message-ID: <CA+bK7J6t-gsK+P5ZrP6j4BqO2CtxFGaVukNhCifexKisX8ipyw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 7, 2018 at 2:52 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> Where is the API documentation, for stuff like tst_* and SAFE_*
>> and 'struct tst_test'
>>
>> I looked in ltp/docs and on the wiki, but couldn't seem to find it.
>
> It's named test-writing-guidelines, which arguably is a bit confusing
> but its there:
>
> ltp/doc/test-writing-guidelines.txt or
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
>
> And we also have nice C testcase tutorial:
>
> doc/c-test-tutorial-simple.txt or
> https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

OK.  I actually had found both of these, but didn't realize that
these were intended as API documentation.  I was expecting
to see something more formal describing each routine
(maybe in an alphabetical list).  For the SAFE_ macros,
it says to look at the source for a complete list, so for these
and possibly other APIs these docs don't appear to be
comprehensive.

Would you be OK with me writing up some more formal
documentation for the APIs, and contributing them to the
project?  I probably won't get to it for a few weeks, as
I'm busy getting ready for a conference.  But it might
be nice to document these more formally and comprehensively.

 -- Tim Bird
Senior Staff Software Engineer, Sony Corporation
Architecture Group Chair, Core Embedded Linux Project, Linux Foundation
