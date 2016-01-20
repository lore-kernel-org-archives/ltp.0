From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 21 Jan 2016 00:54:56 +0900
Subject: [LTP] [BUG] oom hangs the system,
	NMI backtrace shows most CPUs in shrink_slab
In-Reply-To: <20160120151044.GA5157@mtj.duckdns.org>
References: <569E1010.2070806@I-love.SAKURA.ne.jp>
 <569E5287.4080503@redhat.com>
 <201601201923.DCC48978.FSHLOQtOVJFFOM@I-love.SAKURA.ne.jp>
 <201601202217.BEF43262.QOLFHOOJFVFtMS@I-love.SAKURA.ne.jp>
 <20160120151044.GA5157@mtj.duckdns.org>
Message-ID: <201601210054.CEG04187.VFMQOFHOOLJFtS@I-love.SAKURA.ne.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tejun Heo wrote:
> On Wed, Jan 20, 2016 at 10:17:23PM +0900, Tetsuo Handa wrote:
> > What happens if memory allocation requests from items using this workqueue
> > got stuck due to OOM livelock? Are pending items in this workqueue cannot
> > be processed because this workqueue was created without WQ_MEM_RECLAIM?
> 
> If something gets stuck due to OOM livelock, anything which tries to
> allocate memory can hang.  That's why it's called a livelock.
> WQ_MEM_RECLAIM or not wouldn't make any difference.
> 
> > I don't know whether accessing swap memory depends on this workqueue.
> > But if disk driver depends on this workqueue for accessing swap partition
> > on the disk, some event is looping inside memory allocator will result in
> > unable to process disk I/O request for accessing swap partition on the disk?
> 
> What you're saying is too vauge for me to decipher exactly what you
> have on mind.  Can you please elaborate?
> 

In this thread ( http://lkml.kernel.org/r/569D06F8.4040209@redhat.com )
Jan hit an OOM stall where free memory does not increase even after OOM
victim and dying tasks terminated. I'm wondering why such thing can happen.

Since "Swap cache stats:" stopped increasing immediately after the OOM
stall began, I'm suspecting possibility that disk I/O event which is
needed for accessing swap memory is deferred due to cdrom I/O event
stalling at memory allocation when that disk I/O event is needed for
increasing free memory.

  [ 6915.253288] MemAlloc: kworker/1:1(20708) seq=48 gfp=0x2400000 order=0 delay=20248 
  [ 6915.301353] MemAlloc: oom01(22011) seq=5135 gfp=0x24280ca order=0 delay=20641 
  [ 6915.317280] MemAlloc: oom01(22013) seq=5101 gfp=0x24280ca order=0 delay=20641 

Maybe retesting with show_workqueue_state() added answers my question.
