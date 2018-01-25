From: Dan Rue <dan.rue@linaro.org>
Date: Thu, 25 Jan 2018 11:27:16 -0600
Subject: [LTP] log per test?
Message-ID: <20180125172716.o5aioq4htmloksa5@xps>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hey all,

I'm looking at how we run LTP at Linaro and currently we redirect all
output to a file. When a test fails, someone has to read through the log
to find the test failure. Not difficult, but in terms of automation,
we'd like to be able to post just the log of the test that failed
directly. We're starting to work on parsing it, but that too can be a
little tricky.

I noticed runltp -K to capture dmesg output per test - very useful!

Is there anything similar for capturing stdout and stderr per test? I
saw some facilities in ltp-pan but I didn't see anything in runltp
(though I may have missed it). I'm not sure if what I'm asking for
already exists, or if I'd have to write a new i.e. reporttype.

Thanks!
Dan
