From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2016 16:10:37 +0100
Subject: [LTP] [PATCH v2 2/5] syscalls/ipc: add newipc library for new
	API
In-Reply-To: <20161212145811.GE21828@rei.lan>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1481087800-20639-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20161212145811.GE21828@rei.lan>
Message-ID: <20161212151037.GG21828@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +void rm_queue(int queue_id)
> > +{
> > +	if (queue_id == -1)
> > +		return;
> > +
> > +	if (msgctl(queue_id, IPC_RMID, NULL) == -1) {
> > +		tst_res(TINFO, "WARNING: message queue deletion failed.");
>                          ^
> 			 This really should be TWARN, even the message
> 			 includes 'WARNING' in the string. And we should
> 			 include errno with TERRNO as well.
> 
> 			 Or even better we should exit the test with
> 			 TBROK here.

I see that these functions are used in the cleanup, hence TWARN is the
one that should be used here.

But even so, why can't we just do:

if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL))
	tst_res(TWARN | TERRNO, "Failed to delete message queue %i", queue_id);

In the test cleanup?

Is this really worth of creating a library function?

-- 
Cyril Hrubis
chrubis@suse.cz
