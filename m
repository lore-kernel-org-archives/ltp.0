From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Dec 2017 11:52:34 +0100
Subject: [LTP] [RFC] Showing skipped tests in results?
In-Reply-To: <20171205221105.yobl5c4brhpu5tdo@xps>
References: <20171205221105.yobl5c4brhpu5tdo@xps>
Message-ID: <20171206105233.GD13979@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When we skip tests in LTP using "./runltp -S SKIPFILE", they get removed
> from the test list completely, leaving no trace in the results.
> Meanwhile, tests that are not able to run due to configuration show up
> as a "CONF" in the results file.
> 
> From our perspective, this is not ideal because we want to see tests
> that are explicitly skipped as skipped in the results. Ideally, tests
> that are skipped will still show up in the results as a SKIP.
> 
> It looks like there's some precedent in runltp for prepending a string
> to a test name that can then later be picked up and interpreted by
> individual tests.
> 
> Specifically, I noticed that if you use -I ITERATIONS to run tests
> multiple times, it will prepend an iteration count and number in
> alltests:
> 
> $ cat alltests
> 1_ITERATION_gzip01 gzip_tests.sh
> 2_ITERATION_gzip01 gzip_tests.sh
> 3_ITERATION_gzip01 gzip_tests.sh
> 
> Which made me wonder if we could use a similar convention for SKIP,
> rather than just removing the test from alltests (what currently
> happens).
> 
> So for example, if you skip gzip01, the alltests file would end up with
> something like: SKIP_gzip01 gzip_tests.sh
> 
> When I try that, it actually runs gzip01 still. I thought it would
> fail. Which means that something is stripping the "SKIP_" (and
> throwing it away).

I think that you misunderstand how things works, the first string on
each line in the alltests file that is parsed by ltp-pan is just test
name that appears in the test result file, it does not affect anything
but that.

I guess that the easiest solution would be replacing the actuall command
that is supposed to be executed with something that just reports
skipped status.

Quick hack would be replacing these with something that just returns the
right exit value:

gzip01 gzip_tests.hs -> gzip01 exit 32

Something like this should mark the gzip01 as TCONF in test results,
would that suffice for your purpose?

This should be as easy as changing the sed command from delete to
replace in the runltp script.

-- 
Cyril Hrubis
chrubis@suse.cz
