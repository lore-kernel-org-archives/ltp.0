From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 1 Mar 2019 12:49:53 +0100
Subject: [LTP] Question regarding background jobs in LTP
In-Reply-To: <AD78C4C6-E57B-4E67-91CC-EFD43E8CE99E@linux.vnet.ibm.com>
References: <AD78C4C6-E57B-4E67-91CC-EFD43E8CE99E@linux.vnet.ibm.com>
Message-ID: <20190301114953.GA32413@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We've found an issue when executing our testcase mon_fsstatd under LTP. 
> The test logic assumes that we start some processes as shell jobs and then kill them, like in these commands
> 
>     mon_fsstatd_run 0 "mon_procd -a &"
>     sleep 2
>     mon_fsstatd_run 0 "killall mon_procd"
> 
> But so far we observe that the testcase being run as 
> ./runltp -f s390x_tests
> simply hangs at the point of starting background job, it simply runs in foreground, and then test finishes with error after timeout.
> 
> Is it possible to execute background jobs in LTP ?

It should be possible unless the command you are trying to run needs
access to stdin since that could be done only by the process group
leader which is always the ltp-pan binary.

From the snippet of code it's not 100% clear what the code does, can you
share at least the code for mon_fsstad_run function? Also have you tried
to change the shebang to #!/bin/sh -x to see where exactly it hangs?

-- 
Cyril Hrubis
chrubis@suse.cz
