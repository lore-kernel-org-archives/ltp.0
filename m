From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Jan 2017 17:12:12 +0100
Subject: [LTP] mce-test suite in LTP
In-Reply-To: <5873A0E4.1050608@oracle.com>
References: <5873A0E4.1050608@oracle.com>
Message-ID: <20170111161212.GB10729@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Does anyone have any experience about mce-test suite.

Yes.

> What is the benefit to keep this suite as submodule of ltp git,I went 
> through the howto.txt file and feel  it is a separate test suite.

It was historically part of LTP, then it was moved to a separate place
and git submodule was created. The usefulness of this approach is a bit
questionable for sure. We may as well remove the submodule from LTP.

> Is it possible to drive such testsuite by ltp-pan.

No. What the test does it to inject machine check exception events into
the kernel, which means some kind of hardware failure and some of the
tests triggers kernel panic. Then the test expects the crash dump kernel
to take over, save the core and reboots back into the test environment.
This is something that ltp-pan cannot handle at all.

-- 
Cyril Hrubis
chrubis@suse.cz
