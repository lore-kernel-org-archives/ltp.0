From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 11:02:27 +0200
Subject: [LTP] Re-running ltp after killing it
In-Reply-To: <201703241556.v2OFuKjp032250@sellcey-lt.caveonetworks.com>
References: <201703241556.v2OFuKjp032250@sellcey-lt.caveonetworks.com>
Message-ID: <20170329090227.GB7089@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have a basic question about running LTP.  I started an LTP run, and for
> various reasons killed it before it finished.  Later I started a
> new LTP run.  I assumed that LTP would do a complete new run but it 
> appears that LTP restarted from where I had killed it before.  Is that
> expected?

Looking into runltp script it prepares a file with a list of testcases
to run, then starts ltp-pan which uses the file to execute the tests,
writes the logfiles, etc.

The only explanation I can think of is that the first run wasn't killed
properly and the ltp-pan stayed running in the background and both
instances were writing to the same result files, but that is just wild
guess.

> It left me confused because when I looked at the second log file it
> said that there were 5 failures but when I looked for some specific
> tests I could not find them.  I did find their results in the first
> log file (where they failed) but those failures were not listed or
> counted in the second log file.  Is LTP supposed to work this way?

No.

-- 
Cyril Hrubis
chrubis@suse.cz
