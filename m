Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rb1co-0004Z3-Ts
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 03:04:50 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rb1cn-0000ym-NH
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 03:04:50 +0000
Received: by yenm12 with SMTP id m12so1289263yen.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Dec 2011 19:04:44 -0800 (PST)
Message-ID: <4EE963A0.8000902@casparzhang.com>
Date: Thu, 15 Dec 2011 11:04:00 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4EE8830E.6050804@redhat.com>
In-Reply-To: <4EE8830E.6050804@redhat.com>
Subject: Re: [LTP] [PATCH] pipeio: prevent race between SIGCHLD and open()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

On 12/14/2011 07:05 PM, Jan Stancek wrote:
> 
> This test occasionally hangs on some machines. The hang has been
> observed on some single CPU ones.
> 
> pipeio code is using signal(2), setting by default SA_RESTART
> flag, which is also the case for SIGCHLD.
> 
> If last child manages to exit while parent is still at open(),
> parent gets SIGCHLD and open() is restarted. At this point test
> hangs.
> 
> Here's strace output from parent point of view:
> 
> === snip ===
> brk(0)                                  = 0x11bb000
> brk(0x11dd000)                          = 0x11dd000
> getpid()                                = 18826
> stat("tpipe.18826", 0x7fff89e1d410)     = -1 ENOENT (No such file or
> directory)
> mknod("tpipe.18826", S_IFIFO|0777)      = 0
> rt_sigaction(SIGCHLD, {0x400a54, [CHLD], SA_RESTORER|SA_RESTART,
>    0x354aa32a20}, {SIG_DFL, [], 0}, 8) = 0
> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|
>    CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f53b9ddd9d0) = 18827
> fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 3), ...}) = 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
>    = 0x7f53b9de5000
> open("tpipe.18826", O_RDONLY
> )           = ? ERESTARTSYS (To be restarted)
> --- SIGCHLD (Child exited) @ 0 (0) ---
> wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 18827
> rt_sigreturn(0xffffffffffffffff)        = 2
> open("tpipe.18826", O_RDONLY
> === /snip ===
> 
> This patch is introducing semaphore, which prevents children from
> exiting until parent completes open(). It also adds timed wait,
> so parent waits for children to exit before it deletes pipe and
> semaphore.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

looks good.

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

> ---
>   testcases/kernel/ipc/pipeio/pipeio.c |   37 
> ++++++++++++++++++++++++++++++++-
>   1 files changed, 35 insertions(+), 2 deletions(-)
> 

------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
