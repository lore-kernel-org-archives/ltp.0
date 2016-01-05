From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2016 12:11:36 +0100
Subject: [LTP] Test library API changes
Message-ID: <20160105111136.GA32659@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I'm back after my vacation and I had a some time to experiment with the
LTP test API. My intention is to make the changes in the next
development cycle. I.e. we will concentrate on the release in upcoming
weeks and once that is taken care of I would like to discuss these
changes.

I've pushed one cleanup that removes tst_res() and tst_brk() from the
codebase today since there was only one test using this interface and
that was a typo anyway.

Two patches that actually implement sketch of the new API are in forked
LTP repository at:

https://github.com/metan-ucw/ltp

The interesting files are:

https://github.com/metan-ucw/ltp/blob/master/include/tst_test.h
and
https://github.com/metan-ucw/ltp/blob/master/lib/tst_test.c
and one testcase that has been converted to the new library:
https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/preadv/preadv01.c

The general intention is to move as much code to the library as possible
in order to avoid common mistakes and also to let the programmer
concentrate on the test itself rather than spending time figuring out
the test library API.

One of the important changes is that the library functionality is
exported as bitflags in the test structure rather than function calls,
this makes the library much easier to use since this eliminates all
problems with ordering of the resource inits/cleanups.

Another big change is that the process no longer runs the test function
itself but rather than that export pointer to the function that runs the
test. This would allow us to finally fix problems with test timeouts
etc. since we can easily fork in the test library before we start
execution the test code and watch for segfaults/timeouts etc.

The code I've wrote just a proof of concept and by no means complete.
It's intended to start a conversation (I can send it as a patch here as
well if desired, but I do not think that it makes sense for so early
prototype).

-- 
Cyril Hrubis
chrubis@suse.cz
