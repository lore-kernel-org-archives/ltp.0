From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Feb 2016 16:54:06 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan> <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
 <20160210114134.GA10106@rei.lan> <20160211160313.GA22877@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
 <20160212175308.GA30723@rei.suse.cz>
 <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
Message-ID: <20160217155406.GA12574@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> My first impression of this version is that it looks simpler,
> I find it easier to follow, but that could also be explained
> by fact that I'm reading it for 3rd time :-).

Well the SHM code is a bit easier than the pipes but not that much
easier, so I would say it's a combination of both.

> Here are some comments/questions/ideas:
>
> 1. acnt appears to be unused now

I haven't removed it yet... I'm still thinking how we can generate
things like TAP output that expects us to print exact number of tests on
the first line followed by exact number of result lines and make as
little rules for result reporting as possible.

Maybe we can just say that testcases that define test_all do one just
one test and produce one result per such test and do more detailed
reporting only for testcases that define tcnt.

Or we can turn on the detailed reporting only if acnt has been set.

> 2. Can we keep ltp_syscall() and call correct brk func with some magic?

Well we can split the header as we did with the rest of them, do you
think that it's worth of it?

> 3. new/old files names do not follow obvious pattern
> For example: tst_dev.h vs tst_device.h
> I'm thinking if we can give all old same kind of prefix, like tst1_*
> to distinguish them from new api files.

I would go for tst_old_ prefix in this case.

We can easily change all but safe_macros.h that is explicitly included
in ~200 testcases.

> 4. ipc_fd = open(name, O_CREAT | O_EXCL | O_RDWR, 0600);
> Should we allow other users to read/write too? For example,
> what if I change euid and then fork? Or do we expect to always
> fork and then change euid?

We have four tests that uses checkpoint from child processes, none of
them does change euid, so I've just put 0600 there. We can always change
that if needed. Or do you think that we should just enable it now since
it does not matter much?

> 5. setup_ipc ideas/comments (some of these are connected)
> 
> 5a) Why not always setup results and checkpoints?
>     If we always map file, it doesn't cost us anything
>     to initialize checkpoints. needs_checkpoints could be
>     removed.

That depends. If we want to be able to change the library internals in
the future we have to force the test to explicitly list what it's using,
otherwise we would have to anotate all tests that use checkpoints in the
futere in case that they wouldn't be initialized as a byproduct of
result propagation.

In short if we decide that shared memory is what we will use from now on
till the end of the world we can remove it. :)

>     Also processes spawned via exec could report results
>     easily to main process if we always initialized both.

Well we can but I see much value in this since execed() test processes
are quite rare (~10) and all of them seems to report PASS/FAIL using the
return value.

> 5b) split setup_ipc into setup_ipc and open_ipc,
>     That should eliminate some code from tst_checkpoint_open()

Sure, there are still some leftovers since I've commited first working
version late in the evening :).

> 5c) What if we stored ipc path to env variable?
> 
> setup_ipc
>   generates tmp name based on test name: ltp_ipc_path
>   for convenience will initialize also envp array:
>     ltp_only_ipc_env[] = { "LTP_IPC_PATH="$ltp_ipc_path, NULL }
>   creates ipc file

Hmm, that way the test would have to explicitly pass it to the execve().

I would rather make it reasonably unique but decideable without
explicitly passing variables around.

The current approach would not work when the the process is execed by an
child of the test process, which is not ideal either.

> open_ipc(ipc_path)
>   if results and checkpoints already initialized
>     return
>   if ipc_path == NULL
>     ipc_path = getenv("LTP_IPC_PATH")
>   if ipc_path == NULL
>     brk()
>   open ipc file and initialize both results and checkpoints
> 
> TST_CHECKPOINT_INIT calls open_ipc(NULL)
>   process spawned via exec could call either of them,
>   effect would be the same
>
> 5d) Always unlink ipc file in setup if we have /proc
>     Main pid keeps file open and unlinks it.
>     ltp_ipc_path would be set to "/proc/$main_pid/fd/$fd"

This is a good idea, that way the memory would be freed even when the
main test process fails to do cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz
