From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 16:31:16 +0100
Subject: [LTP] [PATCH v3] syscalls/ptrace11: Add test for tracing init
 process
In-Reply-To: <5FB259B2.4040106@cn.fujitsu.com>
References: <20201112120505.GA15765@yuki.lan>
 <1605233273-3784-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20201113151239.GB16315@yuki.lan> <5FB259B2.4040106@cn.fujitsu.com>
Message-ID: <20201119153116.GA18048@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +	/*
> >> +	 * Running attach/detach more times will trigger a ESRCH error because
> >> +	 * ptrace_check_attach function in kernel will report it if its process
> >> +	 * stats is not __TASK_TRACED.
> >> +	 */
> >> +	TST_RETRY_FUNC(ptrace(PTRACE_DETACH, 1, NULL, NULL), TST_RETVAL_EQ0);
> >
> > Why do we have to retry the detach here?
> 
> I add a retry here because running attach/detach serval times may make 
> init process isn't traced status . Even we have do attach action, detach 
> will get ESRCH error .

Looking at the manual page it says:

PTRACE_ATTACH

...
The tracee is sent a SIGSTOP, but will not necessarily have stopped by
the completion of this call; use waitpid(2) to wait for the tracee to
stop.
...

So my guess is that if we call PTRACE_ATTACH followed by the
PTRACE_DETACH we may end up in a state where the SIGSTOP for the traced
process haven't arrived yet and in this case we should get ESCRCH.

So the correct solution is waitpid() for the traced process before we
detach it.

-- 
Cyril Hrubis
chrubis@suse.cz
