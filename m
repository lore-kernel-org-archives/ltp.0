From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 12:00:19 +0200
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <YO6vZDRj4C15sg7K@yuki>
References: <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
 <CAEemH2fcubrbMpeoeSJJoZtD+xaiRrs_upG_+KQXB_8C9m3eQg@mail.gmail.com>
 <60E50AB4.7050404@fujitsu.com> <YObbKCNKUoC7lSxd@pevik>
 <YObpRzTjx8T2GAZn@yuki> <60EBA9C3.4050103@fujitsu.com>
 <c81eee80-6cea-de14-aeff-8919495c4396@bell-sw.com>
 <YOwASqNKNXBl4lqe@pevik>
 <0b622e21-453c-5dc2-214e-c9c0a5d48f44@bell-sw.com>
 <YO6vZDRj4C15sg7K@yuki>
Message-ID: <YO61swgamAEnoAFj@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> We will need to have some kind of flag that would tell the testrunner
> that the test is using/modifying SysV IPC anyways as without namespaces
> these tests cannot run in parallel at all.

> So I would say that we should:

> * Write these tests in a way that they expect that they are the only
>   process that modifies these resources during the testrun

> * Mark all these tests with .sysv_ipc flag in the tst_test structure

> * Then we can easily add support for running them in a separate
>   namespace in the test library

> Does that sound reasonable?
+1

Kind regards,
Petr
