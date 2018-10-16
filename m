From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Oct 2018 17:40:20 +0200
Subject: [LTP] [PATCH v2] setregid03: convert to newlib
In-Reply-To: <20180910142327.20753-1-cfamullaconrad@suse.de>
References: <20180910142327.20753-1-cfamullaconrad@suse.de>
Message-ID: <20181016154020.GA19342@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Do not fork, cause I don't see the need for it. Maybe a left over
> from previous changes.

And I figured out why it was there. If we do not fork the possitive
testcases fail on the second and subsequent iterations, try to run the
test with -i 2.

Also it may be a bit cleaner to just split the test into two one with
possitive and one with negative tests, which will simplify the code and
we can then fork only for the test that tests for the positive cases.

-- 
Cyril Hrubis
chrubis@suse.cz
