From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 15:03:17 +0200
Subject: [LTP] [PATCH 8/8] waitpid08: test stopped children
In-Reply-To: <1470818466-28109-9-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-5-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-6-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-7-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-8-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-9-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160816130316.GA25540@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The whole purpose of WUNTRACED is to help with handling of stopped
> children. Therefore, let's expand the scope of testing by making
> the children stop before we call waitpid() (similarly to waitpid13).
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/waitpid/waitpid08.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/waitpid/waitpid08.c b/testcases/kernel/syscalls/waitpid/waitpid08.c
> index e17663f..c743c26 100644
> --- a/testcases/kernel/syscalls/waitpid/waitpid08.c
> +++ b/testcases/kernel/syscalls/waitpid/waitpid08.c
> @@ -43,7 +43,7 @@ static void do_child_1(void)
>  
>  		pid = SAFE_FORK();
>  		if (pid == 0)
> -			do_exit(0);
> +			do_exit(1);
>  
>  		fork_kid_pid[i] = pid;

Hmm, shouldn't we send SIGCONT and reap the children at the end of the
do_child_1() after this change?

Since if we pass the -i 100 parameter to the test the waitpid_test()
would continue to fork() children that will stay sigstopped in the
background even after the test exits since the fork_kid_pid[] is changed
in each iteration, half of the children has different process group and
the waitpid_cleanup() is called once at the end of the test. Or do I
miss something?

-- 
Cyril Hrubis
chrubis@suse.cz
