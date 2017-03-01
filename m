From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 1 Mar 2017 16:10:57 +0100
Subject: [LTP] [PATCH 0/1] uname26 exploit regression test
In-Reply-To: <20170220101116.GA8829@rei.lan>
References: <20170217113653.595ce1b4@linux-v3j5>
 <20170220101116.GA8829@rei.lan>
Message-ID: <20170301161057.65753d4f@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 20 Feb 2017 11:11:16 +0100
"Cyril Hrubis" <chrubis@suse.cz> wrote:

> Sounds reasonable. I guess that for some exploits there is no single
> syscall to blame so putting these into syscalls/ does not make much
> sense.
> 
> Maybe we can just put all these tests into an security/exploits or
> security/CVE directory or something.

Perhaps use security/CVE directory then list the exploits by CVE number is
best. Then if someone needs to find an exploit for a particular syscall they
will need to grep its name or they could look it up in a CVE database.

Maybe you could add a field in the test struct for keywords and then at some
later date we could add an option to the test runner to search for tests with
some particular keywords or other meta data? (I am thinking about the -q
option you added for runltp-ng (good work btw :-))).

> 
> > 2) What is the appropriate runtest file for security tests? I think they
> >    should be separated from functional tests.  
> 
> If there is none we should start one. Something as runtest/security. I'm
> also wondering if we should add these into the runtest/syscalls as well,
> at least these that are directly related to a syscall of some kind.

This does mean we will end up unintentionally running some tests twice,
although maybe runltp stops that. In fact if all the tests are named cve-*
then it is easy to stop that.

In any case some exploits are likely to run a long time or crash the system if
successful so I would either want to keep them seperate or have some way of
labeling them as dangerous or long running. For example I started running the
OOM killer tests separately in OpenQA from the other memory tests because they
are very good at causing freezes and stop the other tests from running.

Thank you,
Richard.
