From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Feb 2016 09:39:21 -0500 (EST)
Subject: [LTP] Test library API changes
In-Reply-To: <20160216211958.GC2515@rei.lan>
References: <20160105111136.GA32659@rei.lan> <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
 <20160210114134.GA10106@rei.lan> <20160211160313.GA22877@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
 <20160212175308.GA30723@rei.suse.cz> <20160216211958.GC2515@rei.lan>
Message-ID: <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 16 February, 2016 10:19:58 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> The up to date code is at the same place as usual.
> (https://github.com/metan-ucw/ltp)
> 
> Apart from added support of acquiring a device, checkpoints and
> resource files the IPC was rewritten to shared memory.
> 
> Now the library, before the test is started, mmaps a page backed by a
> file on /dev/shm/. The first few bytes are used for shared struct
> results, the rest is used by checkpoints if checkpoints are needed. The
> struct result values are incremented by gcc atomic operations (which is
> thread safe as well), the open question is if we need a fallback to
> inline assembler if these are not supported. Then there is a special
> function to open checkpoint shm file from a process started by a exec (a
> few of the testcases does so) since it must open the shm rather than a
> file in a temporary directory.
> 
> There are still some rough edges and the code should be reviewed, but at
> least 90% of the functionality is there and working.
> 
> As usuall comments are welcome :)

Hi,

My first impression of this version is that it looks simpler,
I find it easier to follow, but that could also be explained
by fact that I'm reading it for 3rd time :-).

Here are some comments/questions/ideas:

1. acnt appears to be unused now

2. Can we keep ltp_syscall() and call correct brk func with some magic?

3. new/old files names do not follow obvious pattern
For example: tst_dev.h vs tst_device.h
I'm thinking if we can give all old same kind of prefix, like tst1_*
to distinguish them from new api files.

4. ipc_fd = open(name, O_CREAT | O_EXCL | O_RDWR, 0600);
Should we allow other users to read/write too? For example,
what if I change euid and then fork? Or do we expect to always
fork and then change euid?

5. setup_ipc ideas/comments (some of these are connected)

5a) Why not always setup results and checkpoints?
    If we always map file, it doesn't cost us anything
    to initialize checkpoints. needs_checkpoints could be
    removed.
    Also processes spawned via exec could report results
    easily to main process if we always initialized both.

5b) split setup_ipc into setup_ipc and open_ipc,
    That should eliminate some code from tst_checkpoint_open()

5c) What if we stored ipc path to env variable?

setup_ipc
  generates tmp name based on test name: ltp_ipc_path
  for convenience will initialize also envp array:
    ltp_only_ipc_env[] = { "LTP_IPC_PATH="$ltp_ipc_path, NULL }
  creates ipc file

open_ipc(ipc_path)
  if results and checkpoints already initialized
    return
  if ipc_path == NULL
    ipc_path = getenv("LTP_IPC_PATH")
  if ipc_path == NULL
    brk()
  open ipc file and initialize both results and checkpoints

TST_CHECKPOINT_INIT calls open_ipc(NULL)
  process spawned via exec could call either of them,
  effect would be the same

5d) Always unlink ipc file in setup if we have /proc
    Main pid keeps file open and unlinks it.
    ltp_ipc_path would be set to "/proc/$main_pid/fd/$fd"

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
