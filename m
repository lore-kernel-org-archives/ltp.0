From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jun 2021 15:13:38 +0200
Subject: [LTP] [PATCH 2/3] syscalls/getrusage: Cleanup and bugfix for
 getrusage03
In-Reply-To: <8f8852e0-eed3-f7ae-744e-db48724e9b02@huawei.com>
References: <20210616093606.214856-1-xieziyao@huawei.com>
 <20210616093606.214856-3-xieziyao@huawei.com>
 <YMnk5QUhwnOHrWLi@yuki>
 <8f8852e0-eed3-f7ae-744e-db48724e9b02@huawei.com>
Message-ID: <YMn5AvbsDDV8ojWu@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Same with lib: tst_process_state: Add tst_process_release_wait().
> 
> If we call the signal(SIGCHLD,SIG_IGN), the SIGCHLD signal is ignored by 
> the system. Thus, no zombie is created before the child is terminated. 
> The logs are as follows:
> 
> getrusage03.h:27: TINFO: allocate 400MB
> getrusage03.c:39: TPASS: check that initial.children ~= pre_wait.children
> getrusage03.c:39: TPASS: check that post_wait.children ~= 400MB
> getrusage03.h:27: TINFO: allocate 500MB
> getrusage03.c:123: TBROK: Failed to open FILE '/proc/84598/stat' for 
> reading: ENOENT (2)
> 
> So I write TST_PROCESS_RELEASE_WAIT() here to check /proc/$PID.

Ah right, reading the documentation if parent ignores sigchild the child
is discarded and there is no trace of it on the system once it returns
from main().

So I guess that we should add a function that checks that a given pid is
present on a system but there is simpler interface for this, if you do
kill(2) with signal == 0 it returns with with errno set to ESRCH if the
pid is no longer present on a system.

Also I'm not sure if release is right word here, maybe it would better
describe the action if the function name was tst_process_exit_wait().

> I noticed that some safe_ micro checks tst_test->forks_child or other 
> tst_test->xx, while tst_test is not defined in some functions with 
> #define TST_NO_DEFAULT_MAIN.

Ah right, I guess that in a case of fork() and clone() calls it would be
easier not to use SAFE_MACROS() for processes that have been started by
exec().

-- 
Cyril Hrubis
chrubis@suse.cz
