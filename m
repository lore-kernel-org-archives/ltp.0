Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SMIBy-0002VH-IR
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 12:16:30 +0000
Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SMIBt-0000IM-1k
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 12:16:30 +0000
Received: by bkcjk7 with SMTP id jk7so3697129bkc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 23 Apr 2012 05:16:18 -0700 (PDT)
Message-ID: <4F953947.5060204@casparzhang.com>
Date: Mon, 23 Apr 2012 19:13:11 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F952FBC.7040000@redhat.com>
In-Reply-To: <4F952FBC.7040000@redhat.com>
Subject: Re: [LTP] [PATCH 3/3] syscalls/cma: add errno tests
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 04/23/2012 06:32 PM, Jan Stancek wrote:
> Based on proposed man page:
> http://ozlabs.org/~cyeoh/cma/process_vm_readv.txt
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/cma/cma01.c              |  434 ++++++++++++++++++++
>  .../kernel/syscalls/cma/process_vm_readv/Makefile  |    7 +
>  .../kernel/syscalls/cma/process_vm_writev/Makefile |    7 +

[snip]

> +static void cma_test_params_read(struct process_vm_params *params)
> +{
> +#if (HAVE_PROCESS_VM_READV==1)
> +	TEST(process_vm_readv(params->pid,
> +	    params->lvec, params->liovcnt,
> +	    params->rvec, params->riovcnt,
> +	    params->flags));
> +#elif defined(__NR_process_vm_readv)
> +	TEST(syscall(__NR_process_vm_readv, params->pid,
> +	    params->lvec, params->liovcnt,
> +	    params->rvec, params->riovcnt,
> +	    params->flags));
> +#else
> +	tst_brkm(TCONF, cleanup, "process_vm_readv does not exist on"
> +	    " your system");
> +#endif

omit other parts since looking good to me.

Still the question left for open-discussion: isn't syscall-only testing
enough, do we need to test glibc wrapper in higher priority?

Thanks,
Caspar

> +}
> +
> +static void cma_test_params_write(struct process_vm_params *params)
> +{
> +#if (HAVE_PROCESS_VM_WRITEV==1)
> +	TEST(process_vm_writev(params->pid,
> +	    params->lvec, params->liovcnt,
> +	    params->rvec, params->riovcnt,
> +	    params->flags));
> +#elif defined(__NR_process_vm_writev)
> +	TEST(syscall(__NR_process_vm_writev, params->pid,
> +	    params->lvec, params->liovcnt,
> +	    params->rvec, params->riovcnt,
> +	    params->flags));
> +#else
> +	tst_brkm(TCONF, cleanup, "process_vm_writev does not exist on"
> +	    " your system");
> +#endif
> +}

[snip]


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
