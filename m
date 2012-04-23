Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SMI4k-0000WC-Jv
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 12:09:02 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SMI4g-0003Vr-91
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 12:09:02 +0000
Date: Mon, 23 Apr 2012 08:08:51 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1d285433-80be-43a0-bcc7-27254e53a0cd@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4F953947.5060204@casparzhang.com>
MIME-Version: 1.0
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net, "Jeffrey Burke" <jburke@redhat.com>
> Sent: Monday, 23 April, 2012 1:13:11 PM
> Subject: Re: [LTP] [PATCH 3/3] syscalls/cma: add errno tests
> 
> On 04/23/2012 06:32 PM, Jan Stancek wrote:
> > Based on proposed man page:
> > http://ozlabs.org/~cyeoh/cma/process_vm_readv.txt
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/cma/cma01.c              |  434
> >  ++++++++++++++++++++
> >  .../kernel/syscalls/cma/process_vm_readv/Makefile  |    7 +
> >  .../kernel/syscalls/cma/process_vm_writev/Makefile |    7 +
> 
> [snip]
> 
> > +static void cma_test_params_read(struct process_vm_params *params)
> > +{
> > +#if (HAVE_PROCESS_VM_READV==1)
> > +	TEST(process_vm_readv(params->pid,
> > +	    params->lvec, params->liovcnt,
> > +	    params->rvec, params->riovcnt,
> > +	    params->flags));
> > +#elif defined(__NR_process_vm_readv)
> > +	TEST(syscall(__NR_process_vm_readv, params->pid,
> > +	    params->lvec, params->liovcnt,
> > +	    params->rvec, params->riovcnt,
> > +	    params->flags));
> > +#else
> > +	tst_brkm(TCONF, cleanup, "process_vm_readv does not exist on"
> > +	    " your system");
> > +#endif
> 
> omit other parts since looking good to me.
> 
> Still the question left for open-discussion: isn't syscall-only
> testing
> enough, do we need to test glibc wrapper in higher priority?

When looking at other tests, my impression was that LTP uses
glibc wrappers if available. That interface is what users will most
likely use in the end.

Since this is new syscall, glibc wrapper may not be available,
in which case it tries syscall(2).

Regards,
Jan

> 
> Thanks,
> Caspar
> 
> > +}
> > +
> > +static void cma_test_params_write(struct process_vm_params
> > *params)
> > +{
> > +#if (HAVE_PROCESS_VM_WRITEV==1)
> > +	TEST(process_vm_writev(params->pid,
> > +	    params->lvec, params->liovcnt,
> > +	    params->rvec, params->riovcnt,
> > +	    params->flags));
> > +#elif defined(__NR_process_vm_writev)
> > +	TEST(syscall(__NR_process_vm_writev, params->pid,
> > +	    params->lvec, params->liovcnt,
> > +	    params->rvec, params->riovcnt,
> > +	    params->flags));
> > +#else
> > +	tst_brkm(TCONF, cleanup, "process_vm_writev does not exist on"
> > +	    " your system");
> > +#endif
> > +}
> 
> [snip]
> 
> 

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
