From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Jul 2021 11:33:24 +0200
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <0b622e21-453c-5dc2-214e-c9c0a5d48f44@bell-sw.com>
References: <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
 <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
 <CAEemH2fcubrbMpeoeSJJoZtD+xaiRrs_upG_+KQXB_8C9m3eQg@mail.gmail.com>
 <60E50AB4.7050404@fujitsu.com> <YObbKCNKUoC7lSxd@pevik>
 <YObpRzTjx8T2GAZn@yuki> <60EBA9C3.4050103@fujitsu.com>
 <c81eee80-6cea-de14-aeff-8919495c4396@bell-sw.com>
 <YOwASqNKNXBl4lqe@pevik>
 <0b622e21-453c-5dc2-214e-c9c0a5d48f44@bell-sw.com>
Message-ID: <YO6vZDRj4C15sg7K@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> Perhaps it can be done at the higher level, e.g. in the ltp tests
> >> runner if some tests request it with a newipc flag...
> > Well, we have at least two runners (runltp which uses ltp-pan, runltp-ng) and we
> > also support running tests without runner, it'd be nice to solve this in LTP
> > API.
> 
> I didn't mean these runners, I was thinking about fork_testrun() in tst_test.c.

We will need to have some kind of flag that would tell the testrunner
that the test is using/modifying SysV IPC anyways as without namespaces
these tests cannot run in parallel at all.

So I would say that we should:

* Write these tests in a way that they expect that they are the only
  process that modifies these resources during the testrun

* Mark all these tests with .sysv_ipc flag in the tst_test structure

* Then we can easily add support for running them in a separate
  namespace in the test library

Does that sound reasonable?

-- 
Cyril Hrubis
chrubis@suse.cz
