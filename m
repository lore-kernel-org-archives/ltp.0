From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 15:29:12 +0100
Subject: [LTP] runltp-ng hackweek experiment
Message-ID: <20170228142912.GA13189@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've tried to experiment with a proof of concept for new LTP test
execution framework during Hackweek[1]. And I've ended up with something
that is more or less usable and has features missing in runltp + ltp-pan
script we have now.

It's in the proof of concept state at this point and polishing it would
require more work, but it looks promising at this point.

The key desing points are:

* We use the ltp-wrapper[2] instead of ltp-pan, which runs oldlib and
  openposix testcases from a test() function from a newlib test.

  This provides us test timeouts and killing whole test process tree,
  etc. basically for free.

* The ltp-runner[3] then does the runtest files parsing, openposix test
  discovery, test execution, writing test results, etc.

  - The one intrusive change is that I've added code to both oldlib and
    newlib to support '-q' flag, so that we can query test for details
    i.e. if it's oldlib/newlib test, if it requires root, etc. This is
    would be also needed for parallel test execution, where the test
    would report if it can be executed in parallel and/or report what
    kind of system resources it monopolizes. The bottom line is that
    all testcases should understand the -q option and at least exit
    without writing any output, which is not the case at the moment.

  - The code is split into several modules, the parsers prepare list of
    tests to be executed, then there is code to execute the tests and
    store logs, then the output writers can produce logs in several
    different formats. I've experimented a bit with a better html
    output[4][5] (table sorting is not implemented yet, but planned).

  - The code is prepared for parallel test execution which is not
    implemented at the moment but basically boils down to marking
    down testcases that cannot be executed concurently. As I wrote
    I would like to keep this information inside the test code and
    export it via the -q options.

  - We miss random test execution and execute tests for defined amount
    of time at this point, but other than that the basic features are
    there.

And as usuall any comments are welcomed ;-).

[1] https://hackweek.suse.com/
[2] https://github.com/metan-ucw/ltp/blob/master/tools/runltp-ng/bin/ltp-wrapper.c
[3] https://github.com/metan-ucw/ltp/blob/master/tools/runltp-ng/bin/ltp-runner.c
[4] http://metan.ucw.cz/outgoing/ltp-openposix.html
[5] http://metan.ucw.cz/outgoing/ltp-syscalls.html

-- 
Cyril Hrubis
chrubis@suse.cz
