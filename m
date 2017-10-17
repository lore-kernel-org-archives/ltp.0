From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Oct 2017 11:19:56 +0200
Subject: [LTP] [PATCH v2 3/4] syscalls/keyctl07: new test for oops when
 reading negative key
In-Reply-To: <20171016194748.GE121701@gmail.com>
References: <20171012204227.116510-1-ebiggers3@gmail.com>
 <20171012204227.116510-4-ebiggers3@gmail.com>
 <20171016102259.GB29957@rei> <20171016194748.GE121701@gmail.com>
Message-ID: <20171017091956.GA21124@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi Cyril, I'll send out a new version that does that.  But please check that I'm
> handling the exit status from the child process correctly because I wasn't 100%
> sure how to do it.  (And I'm surprised more tests haven't run into this problem.
> Maybe there should be something in the library for this, like being able to set
> '.fail_on_sigkill = 1' in the 'struct tst_test'?  Or at least a different
> version of tst_reap_children().)

Agree that the current state of the API for waiting child is indeed
suboptimal. The problem is that some tests should succeed on SIGKILL,
some fail, etc. So the interface would have to be quite flexible. Rather
than that I've decided to add new tst_strstatus() function so that we
can easily print what happened to the child. With that you can pick the
specific cases that should be mapped to TPASS and TFAIL first, then
handle the rest with TBROK.

Generally it's supposed to be used as:

	SAFE_WAIT(&status);

	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
		tst_res(TPASS, ...);
		return;
	}

	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
		tst_res(TFAIL, ...);
		return;
	}

	tst_brk(TBROK, "Child ", tst_strstatus(status);


I guess that additional macros that would simplify the if conditions
would be helpful as well, something as TST_EXITEDWITH(status, 0) and
TST_SIGNALEDBY(status, SIGKILL).


We may as well try some kind of data driven approach with an array of
structures describing the exit-status to result mapping, howerever I
think that it would be an overkill in this case.

-- 
Cyril Hrubis
chrubis@suse.cz
