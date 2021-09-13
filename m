From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Sep 2021 15:26:22 +0800
Subject: [LTP] [PATCH v2 0/7] Cleanup sched/process.c
In-Reply-To: <YT7wZrmi8Jc0YHfL@pevik>
References: <20210910130820.21141-1-pvorel@suse.cz>
 <CAEemH2evPtStSndYb0viwt-+x+g4dB3FER366_KEjcRUn7pWYg@mail.gmail.com>
 <YT7wZrmi8Jc0YHfL@pevik>
Message-ID: <CAEemH2cO31kSwK3=tk6krB8ZZYPPaP+c-+5D7FGRK2ofYSmbtg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > But I just wondering, is there a run test file to perform this test case?
> > I greped the runtest/* but find no file currently includes this:(.
>
> IMHO it's in sched:
> $ git grep -w process runtest/
> runtest/sched:hackbench01 hackbench 50 process 1000
>

Hmm, here "process" is only a parameter to hackbench01, it
has no direct relevance to the process_stress/process.c.

After checking the history a while, I think that process_stress/process.c
is an independent test and obsoleted for a quite long time, maybe
we can add online back to runtest/sched file or just let is there until
someone converting to the new API.

commit 576f1ee560b2370818b49366bad581952af3dd70
Author: robbiew <robbiew>
Date:   Fri Feb 1 16:39:39 2002 +0000

    Removed a test that was not correctly running.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210913/29480597/attachment.htm>
