From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Mar 2018 15:38:08 +0100
Subject: [LTP] LTP API documentation
In-Reply-To: <CA+bK7J6t-gsK+P5ZrP6j4BqO2CtxFGaVukNhCifexKisX8ipyw@mail.gmail.com>
References: <CA+bK7J7jetfNOpXmxstQtC-_-gbzb0ko8OV8rjRnYp7BbR7JAw@mail.gmail.com>
 <20180307105215.GC9871@rei>
 <CA+bK7J6t-gsK+P5ZrP6j4BqO2CtxFGaVukNhCifexKisX8ipyw@mail.gmail.com>
Message-ID: <20180307143808.GB2607@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> OK.  I actually had found both of these, but didn't realize that
> these were intended as API documentation.  I was expecting
> to see something more formal describing each routine
> (maybe in an alphabetical list).  For the SAFE_ macros,
> it says to look at the source for a complete list, so for these
> and possibly other APIs these docs don't appear to be
> comprehensive.

Well we kept it this way for several reasons the main was that we barely
had manpower to maintain the documentation along with all the changes in
the codebase since the library API haven't been stable in the past. We
had major rewrite of the library API in the middle of 2016 by the way,
but it has been stable since with occasional additions.

We also have quite a lot of documentation in form of a header comments
so maybe it would be best just to transform it into a parseable format
and generate the formal API documentation from that. That would probably
mean changing all the comments into doxygen format and making sure every
piece of public API is documented, what do you think about that?

> Would you be OK with me writing up some more formal
> documentation for the APIs, and contributing them to the
> project?  I probably won't get to it for a few weeks, as
> I'm busy getting ready for a conference.  But it might
> be nice to document these more formally and comprehensively.

Better documetation is always welcomed, the hard part is keeping it in
sync with the code :-).

-- 
Cyril Hrubis
chrubis@suse.cz
