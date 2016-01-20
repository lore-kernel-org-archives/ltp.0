From: Tejun Heo <tj@kernel.org>
Date: Wed, 20 Jan 2016 10:10:44 -0500
Subject: [LTP] [BUG] oom hangs the system,
 NMI backtrace shows most CPUs in shrink_slab
In-Reply-To: <201601202217.BEF43262.QOLFHOOJFVFtMS@I-love.SAKURA.ne.jp>
References: <569D06F8.4040209@redhat.com>
 <569E1010.2070806@I-love.SAKURA.ne.jp>
 <569E5287.4080503@redhat.com>
 <201601201923.DCC48978.FSHLOQtOVJFFOM@I-love.SAKURA.ne.jp>
 <201601202217.BEF43262.QOLFHOOJFVFtMS@I-love.SAKURA.ne.jp>
Message-ID: <20160120151044.GA5157@mtj.duckdns.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 20, 2016 at 10:17:23PM +0900, Tetsuo Handa wrote:
> What happens if memory allocation requests from items using this workqueue
> got stuck due to OOM livelock? Are pending items in this workqueue cannot
> be processed because this workqueue was created without WQ_MEM_RECLAIM?

If something gets stuck due to OOM livelock, anything which tries to
allocate memory can hang.  That's why it's called a livelock.
WQ_MEM_RECLAIM or not wouldn't make any difference.

> I don't know whether accessing swap memory depends on this workqueue.
> But if disk driver depends on this workqueue for accessing swap partition
> on the disk, some event is looping inside memory allocator will result in
> unable to process disk I/O request for accessing swap partition on the disk?

What you're saying is too vauge for me to decipher exactly what you
have on mind.  Can you please elaborate?

-- 
tejun
