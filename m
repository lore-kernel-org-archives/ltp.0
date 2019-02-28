From: Elif Aslan <elas@linux.vnet.ibm.com>
Date: Thu, 28 Feb 2019 15:42:44 +0100
Subject: [LTP] Question regarding background jobs in LTP
Message-ID: <AD78C4C6-E57B-4E67-91CC-EFD43E8CE99E@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We've found an issue when executing our testcase mon_fsstatd under LTP. 
The test logic assumes that we start some processes as shell jobs and then kill them, like in these commands

    mon_fsstatd_run 0 "mon_procd -a &"
    sleep 2
    mon_fsstatd_run 0 "killall mon_procd"

But so far we observe that the testcase being run as 
./runltp -f s390x_tests
simply hangs at the point of starting background job, it simply runs in foreground, and then test finishes with error after timeout.

Is it possible to execute background jobs in LTP ?
