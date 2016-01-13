From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Jan 2016 13:34:39 +0100
Subject: [LTP] [PATCH V3] Add testcases to test the kernel input stack
In-Reply-To: <1450441421-6511-1-git-send-email-chnyda@suse.com>
References: <1450441421-6511-1-git-send-email-chnyda@suse.com>
Message-ID: <20160113123439.GA12985@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a couple of fixes, thanks.

The main problem with the code were subtle race conditions that made the
testcases fail rarely. This was because the reader must open the device
before writer starts writing in it otherwise events could be lost (it's
not defined which of parent or child will resume execution first). So
now the testcases open the device for reading before the test loop even
happens.

The second big problem was the /dev/input/mice that produces merged
mouse events in PS/2 protocol. I had to switch the test from relative
pointer movements to right button clicks since the kernel merges the
movement events in unpredictable ways (and because of that the test
would fail even if nobody has moved the mouse while the test was
running). The mouse clicks are much easier to identify and hopefully
right button clicks are safe enough. The same goes for the tests that
expects that no events are generated for relative movements by zero. The
PS/2 protocol actually sends packes with zero movements on mouse clicks.
So I changed that test to work with the input device.

Then there was couple of mostly cosmetic things, a few typos, a few
return value checks missing, etc.

The full diff is attached.

-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: input.patch
Type: text/x-diff
Size: 22922 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160113/9c83d675/attachment.patch>
