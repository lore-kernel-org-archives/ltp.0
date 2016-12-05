From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Dec 2016 17:13:51 +0100
Subject: [LTP] [PATCH v5 1/1] syscalls/mq_unlink: convert to use new
 test library API
In-Reply-To: <20161205144943.GI22344@rei.lan>
References: <20161205143258.8102-1-pvorel@suse.cz>
 <20161205144943.GI22344@rei.lan>
Message-ID: <20161205161351.GL22344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > We may also run the test for nobody in a child process so
> > > that we don't have to take care restoring the euid at the end of the
> > > function.
> > It's require to restore euid for other tests (to be running as root again). Or
> > have I overlooked something?
> 
> If you fork() then call setuid() in the child, do the test and exit then
> parent will still run under the same uid it has been started. No need to
> resetore anything.

Looks like I've been to fast to respond here, I should have read the
question twice before answering...

The test will fail to unlink the queue at the end of the do_test() in
this case. That is the reason the euid is reset to root back again as
the first thing after we jump to EXIT: label.

-- 
Cyril Hrubis
chrubis@suse.cz
