From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Jul 2021 14:02:15 +0200
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <YObbKCNKUoC7lSxd@pevik>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
 <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
 <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
 <CAEemH2fcubrbMpeoeSJJoZtD+xaiRrs_upG_+KQXB_8C9m3eQg@mail.gmail.com>
 <60E50AB4.7050404@fujitsu.com> <YObbKCNKUoC7lSxd@pevik>
Message-ID: <YObpRzTjx8T2GAZn@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > Yes, good point, that would be more precise for ENOSPC testing.
> > AFAIK, ltp doesn't support parallel test now. I think parallel test 
> > maybe a future plan that is why we use docparase to collect each case's 
> > used resources(so we can convert many groups, like pid, memory, disk 
> > space..., then we can run pid group and memory groups test case parallelly).
> Yes, parallel support is not supported atm. Richie and Cyril has done some work
> on runltp-ng to support it. Yes, first it's needed to add support in resources
> (docparse), see Cyril's old block post [1].

Besides most of the SHM tests will crash and burn if executed in
parallel. The SysV IPC shares a global namespace and because of that we
can't really write tests without assuming that we are the only one
manipulating them when the test is executed.

-- 
Cyril Hrubis
chrubis@suse.cz
