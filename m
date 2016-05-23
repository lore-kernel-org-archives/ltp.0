From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 May 2016 18:39:29 +0200
Subject: [LTP] [PATCH] memcg/functional: check several times if the
 process is killed
In-Reply-To: <57432F07.3040207@oracle.com>
References: <1463669724-7193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160523160257.GF25488@rei.lan> <57432F07.3040207@oracle.com>
Message-ID: <20160523163929.GG25488@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This does no seem right to me. The original code send a SIGUSR1 signal
> > to the memcg_process which caused it to allocate memory which supposedly
> > provokes OOM to kill it. Hence the sleep 1 after the kill -s USR $pid.
> >
> > Now this code hammers the memcg_process with SIGKILL instead.
> >
> > As far as I can tell the right thing to do here is to wait with
> > reasonable timeout for the memcg_process to become zombie and only kill
> > it if that hasn't happened. Or did I miss something?
> 
> No, you didn't miss anything. I was planning to use 'kill' to check 
> whether the pid is alive or not. But I should have used 'kill -s 0' 
> instead of plain 'kill'.

Would that even work? Technically till you wait the process the pid
still exists albeit in a zombie state.

And looking into POSIX there were some systems that returned ESRCH in
this case but it looks this behavior is strongly discouraged.

-- 
Cyril Hrubis
chrubis@suse.cz
