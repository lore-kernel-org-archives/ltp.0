Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Sz65S-0008U1-50
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 13:14:10 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sz65R-0007k1-0N
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 13:14:10 +0000
Date: Wed, 8 Aug 2012 09:14:02 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <438207751.1923339.1344431642365.JavaMail.root@redhat.com>
In-Reply-To: <1186725319.1825876.1344423162046.JavaMail.root@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/4] syscall/process_vm_readv02: new testcase
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
Cc: LTP List <ltp-list@lists.sourceforge.net>


----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Caspar Zhang" <caspar@casparzhang.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Wednesday, 8 August, 2012 12:52:42 PM
> Subject: Re: [LTP] [PATCH 1/4] syscall/process_vm_readv02: new testcase
> 
> Hi Caspar,
> 
> +	if (TEST_RETURN != len)
> +		tst_brkm(TBROK|TERRNO, tst_exit, "process_vm_readv");
> Shouldn't this be TFAIL? Can it also print TEST_RETURN?
> 
> +	lp = SAFE_MALLOC(tst_exit, len + 1);
> +	local.iov_base  = lp;
> +	local.iov_len   = len;
> +	remote.iov_base = rp;
> +	remote.iov_len  = len;
> +
> +	tst_resm(TINFO, "child 1: reading string from same memory
> location.");
> +	TEST(test_process_vm_readv(pids[0], &local, 1, &remote, 1, 0));
> +	if (TEST_RETURN != len)
> +		tst_brkm(TBROK|TERRNO, tst_exit, "process_vm_readv");
> +	if (strcmp(lp, tst_string) != 0)
> +		tst_brkm(TFAIL, tst_exit, "child 1: expected string: %s, "
> +			    "received string: %s", tst_string, lp);
> I think SAFE_MALLOC is not initialising memory. So if "lp[len] != 0"
> strcmp will fail.
> 
> +#if !defined(__NR_process_vm_readv)
> +	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
> +		    "on your system");
> Message says "process_vm_writev", testcase is for "process_vm_readv".

+			tst_brkm(TBROK|TERRNO, cleanup, "fork #0");
Both messages about broken fork are "fork #0".

SIGSTOP/SIGCONT approach seems prone to races: if other child
is able to finish before first one raises SIGSTOP, then SIGCONT
arrives first. For example, let's put small sleep before SIGSTOP
in child_alloc() and child will never finish:

    sleep(2);
    if (raise(SIGSTOP) < 0)
            tst_brkm(TBROK|TERRNO, tst_exit, "raise");

The testcase still gives PASS, but one of children is now hanging
in background:
 5399 pts/0    T      0:00 ./process_vm_readv02

Regards,
Jan

> 
> Regards,
> Jan
> 
> ----- Original Message -----
> > From: "Caspar Zhang" <caspar@casparzhang.com>
> > To: "LTP List" <ltp-list@lists.sourceforge.net>
> > Sent: Wednesday, 8 August, 2012 11:26:54 AM
> > Subject: [LTP] [PATCH 1/4] syscall/process_vm_readv02: new testcase
> > 
> > 
> > This testcase is one of the simple CMA syscalls (process_vm_readv,
> > process_vm_writev) tests originally written by Chris Yeoh
> > <yeohc@au1.ibm.com>. I made some modifications to make it match the
> > code
> > style in LTP.
> > 
> > Test Assertion and Strategy:
> > 
> >     Fork two children, one child allocates memory and initializes
> >     it;
> >     then the other one calls process_vm_readv and reads from the
> >     same
> >     memory location, it then verifies if process_vm_readv returns
> >     correct data.
> > 
> > Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> > ---
> >  testcases/kernel/syscalls/cma/process_vm_readv02.c |  162
> >  ++++++++++++++++++++
> >  1 files changed, 162 insertions(+), 0 deletions(-)
> >  create mode 100644
> >  testcases/kernel/syscalls/cma/process_vm_readv02.c
> > 
> > 
> > ------------------------------------------------------------------------------
> > Live Security Virtual Conference
> > Exclusive live event will cover all the ways today's security and
> > threat landscape has changed and how IT managers can respond.
> > Discussions
> > will include endpoint security, mobile security and the latest in
> > malware
> > threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
