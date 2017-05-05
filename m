From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 5 May 2017 11:09:05 +0200
Subject: [LTP] [RFC] [PATCH] syscalls/madvise09: Fix for disabled swap
 accounting
In-Reply-To: <20170503081832.GA28634@rei.lan>
References: <20170502133329.9913-1-chrubis@suse.cz>
 <696452069.6330211.1493799270469.JavaMail.zimbra@redhat.com>
 <20170503081832.GA28634@rei.lan>
Message-ID: <20170505090905.GA8277@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > The test had to be fixed for systems with swap accounting disabled.
> > > 
> > > First there are no "memsw" prefixed tuning knobs in memcg directories if
> > > swap accounting is disabled.
> > > 
> > > Then we had to limit the hungry child since otherwise it will be killed
> > > only after all system swap was filled. Hence we exit the memory hungry
> > > child once the process fills 100MB of swap. That seems to be enough to
> > > put the cgroup into memory pressure while it limits the test runtime to
> > > a few seconds.
> > 
> > Looks reasonable to me, only 2 alternatives I can think of is turning
> > off swap for duration of test, or exit with TCONF if swap accounting
> > is disabled.

Pushed with your ack.

-- 
Cyril Hrubis
chrubis@suse.cz
