From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Sep 2021 08:32:06 +0200
Subject: [LTP] [PATCH v2 0/7] Cleanup sched/process.c
In-Reply-To: <CAEemH2evPtStSndYb0viwt-+x+g4dB3FER366_KEjcRUn7pWYg@mail.gmail.com>
References: <20210910130820.21141-1-pvorel@suse.cz>
 <CAEemH2evPtStSndYb0viwt-+x+g4dB3FER366_KEjcRUn7pWYg@mail.gmail.com>
Message-ID: <YT7wZrmi8Jc0YHfL@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Hi Petr,

> The patchset clean-up looks good.
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks!

> But I just wondering, is there a run test file to perform this test case?
> I greped the runtest/* but find no file currently includes this:(.

IMHO it's in sched:
$ git grep -w process runtest/
runtest/sched:hackbench01 hackbench 50 process 1000

Kind regards,
Petr
