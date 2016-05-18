From: Mason <slash.tmp@free.fr>
Date: Wed, 18 May 2016 18:43:49 +0200
Subject: [LTP] Some tests fail with over-commit disabled
In-Reply-To: <573C9453.5040503@free.fr>
References: <573C9453.5040503@free.fr>
Message-ID: <573C9BC5.3040209@free.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18/05/2016 18:12, Mason wrote:

> On a system with 1.5 GB of memory and no swap...
> Some tests PASS when over-commit is enabled, but FAIL when it is disabled.
> 
> $ sysctl -w vm.overcommit_memory=0 && msgctl09
> vm.overcommit_memory = 0
> msgctl09    1  TPASS  :  msgctl09 ran successfully!
> 
> $ sysctl -w vm.overcommit_memory=2 && msgctl09
> vm.overcommit_memory = 2
> Fork failure in the second child of child group 4
> Fork failure in the first child of child group 10
> msgctl09    1  TFAIL  :  msgctl09.c:203: Child exit status = 1
> Fork failure in the first child of child group 14
> Fork failure in the second child of child group 15
> Fork failure in the first child of child group 3
> Fork failure in the second child of child group 2
> Fork failure in the second child of child group 8
> Fork failure in the second child of child group 7
> /tmp$ Fork failure in the first child of child group 6
> Fork failure in the first child of child group 11
> Fork failure in the first child of child group 9
> Fork failure in the first child of child group 12
> Fork failure in the first child of child group 1
> Fork failure in the first child of child group 0
> 
> 
> Raising the overcommit amount doesn't seem to help (much).
> 
> $ sysctl -w vm.overcommit_ratio=95
> $ grep Commit /proc/meminfo 
> CommitLimit:     1477380 kB
> Committed_AS:      72764 kB
> $ sysctl -w vm.overcommit_memory=2 && msgctl09
> vm.overcommit_memory = 2
> Fork failure in the second child of child group 9
> msgctl09    1  TFAIL  :  msgctl09.c:203: Child exit status = 1
> Fork failure in the second child of child group 4
> /tmp$ Fork failure in the second child of child group 1
> Fork failure in the second child of child group 15
> Fork failure in the second child of child group 0
> Fork failure in the second child of child group 5
> Fork failure in the first child of child group 7
> 
> 
> I expected ulimit -s 500 to help, but it doesn't... Not sure why.
> 
> $ sysctl -w vm.overcommit_memory=2 && msgctl09
> vm.overcommit_memory = 2
> Fork failure in the second child of child group 10
> Fork failure in the second child of child group 3
> Fork failure in the first child of child group 14
> Fork failure in the first child of child group 7
> Fork failure in the second child of child group 0
> Fork failure in the first child of child group 5
> Fork failure in the first child of child group 1
> Fork failure in the second child of child group 12
> Fork failure in the second child of child group 6
> Fork failure in the first child of child group 11
> Fork failure in the second child of child group 2
> msgctl09    1  TFAIL  :  msgctl09.c:203: Child exit status = 1
> 
> 
> Does anyone have an idea why fork is failing?

Behavior appears to be non-deterministic...

/tmp$ msgctl09 1000 10 10
msgctl09    1  TPASS  :  msgctl09 ran successfully!
/tmp$ msgctl09 1000 10 10
Fork failure in the first child of child group 1
msgctl09    1  TFAIL  :  msgctl09.c:203: Child exit status = 1
/tmp$ msgctl09 1000 10 10
Fork failure in the first child of child group 2
msgctl09    1  TFAIL  :  msgctl09.c:203: Child exit status = 1
/tmp$ msgctl09 1000 10 10
msgctl09    1  TPASS  :  msgctl09 ran successfully!
/tmp$ msgctl09 1000 10 10
msgctl09    1  TPASS  :  msgctl09 ran successfully!
/tmp$ msgctl09 1000 10 10
msgctl09    1  TPASS  :  msgctl09 ran successfully!


Will take a closer look in a few days.

Regards.
