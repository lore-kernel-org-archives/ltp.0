From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 May 2021 14:57:51 +0200
Subject: [LTP] [PATCH 2/2] tst_test: using SIGTERM to terminate process
In-Reply-To: <20f87781-e66d-e8c6-1ac5-de208667a7f2@jv-coder.de>
References: <20210518122610.17171-1-liwang@redhat.com>
 <20210518122610.17171-2-liwang@redhat.com> <YLTbXU1ZF4ZiXKdt@yuki>
 <20f87781-e66d-e8c6-1ac5-de208667a7f2@jv-coder.de>
Message-ID: <YLTdT3v4AscW1PIE@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>   # default trap function
> >> -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> >> +trap "tst_brk TBROK 'test interrupted'" INT
> >> +trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
> > I've been looking at this for a while and I think that we should unset
> > the _tst_setup_timer_pid at the end of the _tst_timeout_process()
> > instead, right?
> That won't work or am I missing something? ;) We are in a subshell in 
> _tst_timeout_process, it cannot manipulate the environment of the parent 
> or is my mental modal of how shell works wrong again?.

Nah, you are right this time, I missed that it runs on a background.

> > Otherwise we will leave the timeout process sleeping if someone sends
> > SIGTERM to the test process from the outside, or do I miss something?
> Yes, that is one of the reasons why I initially suggested a different 
> signal for timeout. That would cleanly separate the logic.
> But on the other hand when will SIGTERM be sent from the outside? This 
> is probably only happening on shutdown? In that case it is not really a 
> problem.
> If someone wants to terminate gracefully using SIGTERM, he could send it 
> to the process group. That would kill the timeout process as well.

Okay. Let's go with this version, it's simple enough and anything that
would behave better would only overcomplicate the code again.

For the patch:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
