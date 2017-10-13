From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Oct 2017 11:20:55 +0200
Subject: [LTP] [PATCH 2/2] POSIX: Allow pthread_cond_destroy to block
In-Reply-To: <87h8v376xi.fsf@our.domain.is.not.set>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
 <20171009101824.17251-3-rpalethorpe@suse.com>
 <20171012140111.GC21253@rei> <87h8v376xi.fsf@our.domain.is.not.set>
Message-ID: <20171013092055.GA32278@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Do I understand this correctly that this is a preemptive fix? Since this
> > test seems to work fine for me, while the barrier one blocks.
> >
> > Can we have this kind of information included in the commit message as
> > well?
> >
> 
> It deadlocks on my system. The two functions share a lot of code in
> glibc as well, so the same code is responsible for the blocking.

Strange, for me this one worked fine. I guess that it depends on actual
glibc version.

-- 
Cyril Hrubis
chrubis@suse.cz
