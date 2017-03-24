From: Steve Ellcey <sellcey@cavium.com>
Date: Fri, 24 Mar 2017 08:56:20 -0700
Subject: [LTP] Re-running ltp after killing it
Message-ID: <201703241556.v2OFuKjp032250@sellcey-lt.caveonetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I have a basic question about running LTP.  I started an LTP run, and for
various reasons killed it before it finished.  Later I started a
new LTP run.  I assumed that LTP would do a complete new run but it 
appears that LTP restarted from where I had killed it before.  Is that
expected?  It left me confused because when I looked at the second log
file it said that there were 5 failures but when I looked for some specific
tests I could not find them.  I did find their results in the first
log file (where they failed) but those failures were not listed or counted
in the second log file.  Is LTP supposed to work this way?

Steve Ellcey
