From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Sep 2021 09:31:29 +0200
Subject: [LTP] [PATCH v2 0/7] Cleanup sched/process.c
In-Reply-To: <CAEemH2cO31kSwK3=tk6krB8ZZYPPaP+c-+5D7FGRK2ofYSmbtg@mail.gmail.com>
References: <20210910130820.21141-1-pvorel@suse.cz>
 <CAEemH2evPtStSndYb0viwt-+x+g4dB3FER366_KEjcRUn7pWYg@mail.gmail.com>
 <YT7wZrmi8Jc0YHfL@pevik>
 <CAEemH2cO31kSwK3=tk6krB8ZZYPPaP+c-+5D7FGRK2ofYSmbtg@mail.gmail.com>
Message-ID: <YT7+UU1d3llds9br@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > > But I just wondering, is there a run test file to perform this test case?
> > > I greped the runtest/* but find no file currently includes this:(.

> > IMHO it's in sched:
> > $ git grep -w process runtest/
> > runtest/sched:hackbench01 hackbench 50 process 1000


> Hmm, here "process" is only a parameter to hackbench01, it
> has no direct relevance to the process_stress/process.c.

> After checking the history a while, I think that process_stress/process.c
> is an independent test and obsoleted for a quite long time, maybe
> we can add online back to runtest/sched file or just let is there until
> someone converting to the new API.

> commit 576f1ee560b2370818b49366bad581952af3dd70
> Author: robbiew <robbiew>
> Date:   Fri Feb 1 16:39:39 2002 +0000

>     Removed a test that was not correctly running.

Ah, good catch! I didn't check it's not a binary which would be required.
I'll recheck it once again and send a patch to remove it then.

Kind regards,
Petr

