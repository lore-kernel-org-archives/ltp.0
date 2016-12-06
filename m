From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Dec 2016 11:34:36 +0100
Subject: [LTP] [PATCH 5/5] syscalls/setpriority01: Use new user id to
 avoid messing system environment
In-Reply-To: <5846928B.2010805@cn.fujitsu.com>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1480507955-12652-5-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161205144526.GH22344@rei.lan> <5846928B.2010805@cn.fujitsu.com>
Message-ID: <20161206103436.GC17241@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm, why do we run the actuall testcase in the child here? That
> > complicates the whole test far more than it should have.
> > 
> > We can instead just run pause() in the child and run the setpriority()
> > call in the parent with right pid/group/uid. Or did I miss something?
> > 
> 
> Sorry, if we do the actual test in the parent, we have to do the process
> synchronization, because parent needs child to be ready (prctl, setuid...)
> and after every test, child's pause() needs to be waken up by parent, so
> I feel it's more complicated by comparison...

Since we have the checkpoint synchronization in the test library this is
just a matter of calling TST_CHECKPOINT_WAIT() in the parent and
TST_CHECKPOINT_WAKE_AND_WAIT() in the child then finally
TST_CHECKPOINT_WAKE() in the parent.

-- 
Cyril Hrubis
chrubis@suse.cz
