From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Aug 2016 17:51:02 +0200
Subject: [LTP] [PATCH 5/8] waitpid11: update the description
In-Reply-To: <1470818466-28109-6-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-5-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-6-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160815155102.GI20680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/syscalls/waitpid/waitpid11.c
> +++ b/testcases/kernel/syscalls/waitpid/waitpid11.c
> @@ -25,7 +25,7 @@
>   *	Tests to see if pids returned from fork and waitpid are same
>   *
>   * ALGORITHM
> - * 	Check proper functioning of waitpid with pid = -1 and arg = 0
> + *	Check proper functioning of waitpid with pid = 0 and < -1 with arg 0
>   */

This one is obviously OK.

-- 
Cyril Hrubis
chrubis@suse.cz
