From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Apr 2021 09:42:28 +0200
Subject: [LTP] [PATCH] lib/tst_test.c: Bugfix for heartbeat
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B3761@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B3761@dggeml531-mbx.china.huawei.com>
Message-ID: <YHVLZOKAfNMbU/UP@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +		/*
> > > +		 * We need kill the task group immediately since the
> > > +		 * main process has exit.
> > > +		 */
> > > +		kill(0, SIGKILL);
> > 
> > Shouldn't we call exit here? There is no point in continuing once we
> > reached this point.
> >
> 
> Yes, There is no point in continuing once we reached this point. Considering the test might have created sub processes with system, posix_spawn and so on,
> 
> do we need to kill the task group?

Yes, I think this is the right course of action, we do the same if the
test timeouts as well.

-- 
Cyril Hrubis
chrubis@suse.cz
