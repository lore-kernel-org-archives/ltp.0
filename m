From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Oct 2018 16:51:26 +0200
Subject: [LTP] [PATCH v2 ltp] runltp: fix shellcheck error for sending
 email
In-Reply-To: <20181015141857.2q7yhvhs6q3c7hdm@xps.therub.org>
References: <20180726083426.19026-1-yixin.zhang@intel.com>
 <20181015095214.GA32587@dell5510>
 <20181015141857.2q7yhvhs6q3c7hdm@xps.therub.org>
Message-ID: <20181015145126.GB28106@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It might be easier to get people using it if it were in tree. Would it
> be possible to have runltp and runltp-ng both in tree? Until then, it's
> hard to not support the only available runner.

That is a fair point.

> Looking at the README at
> https://github.com/metan-ucw/ltp/tree/master/tools/runltp-ng, it's hard
> to tell if it has feature parity with runltp, or if there are still
> gaps. Some example usecases would be nice too. For example, I see the
> list of back ends, but what if I want to run it locally (today's
> behavior)?

And the lack of documentation and the fact that the code is not yet
considered stable enough is the reason why it's not in-tree.

I guess that the test-runner can be put into a separate git repo, it
does not depend on the rest of the LTP in any way, which should make it
easier to get the source code, without pulling in the outdated LTP
repostitory.

Also the local test execution is called shell backend, in that case the
testrunner forks a shell instead of doing a ssh connection and executes
the testcases locally.

-- 
Cyril Hrubis
chrubis@suse.cz
