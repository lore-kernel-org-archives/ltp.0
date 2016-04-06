From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Apr 2016 13:51:09 +0200
Subject: [LTP] LTP new test library && release prepratations
Message-ID: <20160406115108.GC19271@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good new everyone,
the new test library API was finally merged. The new API was designed so
that it can coexist with the old API, as converting all LTP testcases is
a long term task, however all newly written testcases should use the new
API from now on.

The most important changes are:

o The cleanup callback is not passed directly to various library
  functions but is set once globally in the structure that describes a test.

o Most of the boilerplate code is moved to library.

o Various resources are initialized and freed automatically when requested.

o The result reporting functions now use shared memory to propagate
  test results from child processes automatically.

o The test no longer implements main() function but instead fills a
  structure describing the testcase.

The overall result is that writing a testcase is much easier now. You
can have a look at a few converted testcases to get a feel for the new
API, for example:

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/add_key/add_key01.c

or

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/preadv/preadv01.c

And read the updated test writing guidelines to get more detailed
overview of the library interface.


Lastly but not least it's about the time we should start preparing for a
next LTP release. You probaly know the drill by now. We will start with
getting all pending important fixes merged, then proceed with freeze and
testing. The testing period will be a bit longer than usuall this time
due to extensive changes to the test library. Also the sooner we test it
the better, so if you have at least a little bit of time go ahead and
try latest git.

-- 
Cyril Hrubis
chrubis@suse.cz
