From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 May 2018 14:42:47 +0200
Subject: [LTP] LTP TODO list
Message-ID: <20180511124247.GD17721@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
As you may remeber I've asked previously here where to start tracking
LTP TODO list, we decided on GitHub and hence I started to put the
information there.

So far I've started with a rough estimate of missing syscall coverage, I
do expect this list easily to grow at least twice once I have a time to
dig deeper into it, but it's a start at least.

I've added a tag "missing coverage" where you can see what we are not
testing at the moment:

https://github.com/linux-test-project/ltp/labels/missing%20coverage

These issues vary a lot in complexity, some of them could be done under
an hour, some are three months jobs, this is inevitable as sometimes one
syscall is a gateway for a very complex functionality.

I'll also dump a list of CVE reproducers and regression tests that are
candidates to be turned into LTP tests that I currently have. Which will
go under reproducer tag:

https://github.com/linux-test-project/ltp/labels/reproducer

I would also like to encourage everyone of you to add issues there and
also feel free to pick any of these, just comment it with someting as
"working on it".

-- 
Cyril Hrubis
chrubis@suse.cz
