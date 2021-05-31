From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 May 2021 14:54:39 +0200
Subject: [LTP] [PATCH 2/2] tst_test: using SIGTERM to terminate process
In-Reply-To: <af8480e6-2020-d21d-bfe7-d9a4d28e0733@jv-coder.de>
References: <20210518122610.17171-1-liwang@redhat.com>
 <20210518122610.17171-2-liwang@redhat.com>
 <d70f9e5f-0008-02aa-e099-2a8243c4b3fa@jv-coder.de>
 <YLTYDC4hxQPVxkZq@yuki>
 <af8480e6-2020-d21d-bfe7-d9a4d28e0733@jv-coder.de>
Message-ID: <YLTcjz4SoLJXPMTg@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> But one more strange thing here.
> >> I wonder why this even works. $pid is used in _tst_kill_test and defined
> >> in _tst_setup_timer as a local variable.
> >> It looks like it is inherited through the call chain and since it is
> >> copied to the background process, it cannot be manipulated by the tests.
> >> Still I would vote for changing this at some point, because it is highly
> >> confusing.
> > That's actually a correct and well defined behavior, if you call a
> > function g from function f the function g has access to the variables
> > local to f.
> >
> > And yes it's confusing, but the alternative is having another global
> > variable which I do not think is much better than this.
> Hm shell code has more strange behavior than I would have ever expected...

Strongly agree here, to be honest if there was as better scripting
language that would be widely avaiable I would have switched long time
ago...

> But at least Li and myself did not know that and even while you know 
> about this "feature", you think it is strange.
> I would rather like to be explicit and use a global variable (what harm 
> is it really?) instead of confusing the next one looking at this piece 
> of code....

If you really think global variable would be better, then go ahead and
send a patch, I do not have a strong feelings about this particular
detail.

-- 
Cyril Hrubis
chrubis@suse.cz
