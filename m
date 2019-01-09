From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Jan 2019 13:01:30 +0100
Subject: [LTP] [PATCH v2] fzsync: revoke thread_B when parent hit
 accidental break
In-Reply-To: <874laim6ot.fsf@rpws.prws.suse.cz>
References: <20190108132618.25965-1-liwang@redhat.com>
 <20190108134815.GC30528@rei.lan>
 <CAEemH2csXcj4jwUNmJAR9jXRZaE+sYNmSJxeU9YqjdgoFcckcA@mail.gmail.com>
 <874laim6ot.fsf@rpws.prws.suse.cz>
Message-ID: <20190109120129.GA19502@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Actually I think the correct way to kill a thread is with
> pthread_cancel.
> 
> AFAICT we could call:
> 
> pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS)
> pthread_setcancelstate(PTHREAD_CANCEL_ENABLE)
> 
> at the start of thread B, then call:
> 
> pthread_cancel(<thread_b_pid>)
> 
> in thread A if we can't rely on setting the exit flag to work
> 
> There are other ways to use pthread_cancel, but this looks like the
> simplest for our use case.

That may work, at least this avoids the need to have a signal handler in
the first place.

But I would still like to push the simpler solution before the release,
i.e. checking for recvmmsg support in the test setup.

-- 
Cyril Hrubis
chrubis@suse.cz
