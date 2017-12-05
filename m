From: Dan Rue <dan.rue@linaro.org>
Date: Tue, 5 Dec 2017 16:11:05 -0600
Subject: [LTP] [RFC] Showing skipped tests in results?
Message-ID: <20171205221105.yobl5c4brhpu5tdo@xps>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello!

Before I submit any patches, I wanted to run this idea by the community
for advice.

When we skip tests in LTP using "./runltp -S SKIPFILE", they get removed
from the test list completely, leaving no trace in the results.
Meanwhile, tests that are not able to run due to configuration show up
as a "CONF" in the results file.

From our perspective, this is not ideal because we want to see tests
that are explicitly skipped as skipped in the results. Ideally, tests
that are skipped will still show up in the results as a SKIP.

It looks like there's some precedent in runltp for prepending a string
to a test name that can then later be picked up and interpreted by
individual tests.

Specifically, I noticed that if you use -I ITERATIONS to run tests
multiple times, it will prepend an iteration count and number in
alltests:

$ cat alltests
1_ITERATION_gzip01 gzip_tests.sh
2_ITERATION_gzip01 gzip_tests.sh
3_ITERATION_gzip01 gzip_tests.sh

Which made me wonder if we could use a similar convention for SKIP,
rather than just removing the test from alltests (what currently
happens).

So for example, if you skip gzip01, the alltests file would end up with
something like: SKIP_gzip01 gzip_tests.sh

When I try that, it actually runs gzip01 still. I thought it would
fail. Which means that something is stripping the "SKIP_" (and
throwing it away).

I looked a bit and I'm guessing we'd need to patch lib/parse_opts.c
and then probably stuff in testcases/lib (but maybe not).

Any feedback on the concept or the implementation is really appreciated.
Thank you!

Dan
