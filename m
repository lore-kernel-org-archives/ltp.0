From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jan 2018 11:56:24 +0100
Subject: [LTP] [PATCH v2] Add regression test for CVE-2017-17052
In-Reply-To: <20180112105212.bkzxuhspnlgbg3x7@linux.suse>
References: <20180110155505.28433-1-mmoese@suse.de>
 <20180112104540.GA22350@rei>
 <20180112105212.bkzxuhspnlgbg3x7@linux.suse>
Message-ID: <20180112105624.GC22350@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Well, on an unpatched kernel, it does not survive the test. In my QEMU 
> testing, the kernel never survived this test until the end.
> Unfortunately, I was not able to test for this CVE without risking a 
> crash. 
> That is the reason why there is no "the kernel is vulnerable" message.

Okay, then this is fine but can you pretty please add a line or two to
the top level comment in the source the test will crash upatched kernel?

-- 
Cyril Hrubis
chrubis@suse.cz
