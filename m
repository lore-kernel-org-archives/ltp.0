From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jan 2018 12:07:51 +0100
Subject: [LTP] log per test?
In-Reply-To: <20180125172716.o5aioq4htmloksa5@xps>
References: <20180125172716.o5aioq4htmloksa5@xps>
Message-ID: <20180126110750.GA2391@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm looking at how we run LTP at Linaro and currently we redirect all
> output to a file. When a test fails, someone has to read through the log
> to find the test failure. Not difficult, but in terms of automation,
> we'd like to be able to post just the log of the test that failed
> directly. We're starting to work on parsing it, but that too can be a
> little tricky.
> 
> I noticed runltp -K to capture dmesg output per test - very useful!
> 
> Is there anything similar for capturing stdout and stderr per test? I
> saw some facilities in ltp-pan but I didn't see anything in runltp
> (though I may have missed it). I'm not sure if what I'm asking for
> already exists, or if I'd have to write a new i.e. reporttype.

As far as I know there is none. And the code that runs the testcases is
quite dated and was in maintenance mode for quite some time.

Which is the reason why I started to work on a replacement recently with
more modular approach in mind so that it can run open posix testcases as
well and also export results in various formats so that it can be
plugged into automation frameworks with minimal effort. It's not
finished yet, but it kind of works at this point, you can have a look at
it at:

https://github.com/metan-ucw/ltp/tree/master/tools/runltp-ng

And as usual comments and patches are welcomed :-).

-- 
Cyril Hrubis
chrubis@suse.cz
