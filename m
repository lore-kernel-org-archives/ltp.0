Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIepR-0000Xp-Up
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 13:47:17 +0000
Date: Wed, 26 Feb 2014 14:47:03 +0100
From: chrubis@suse.cz
Message-ID: <20140226134703.GA27609@rei>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140211151034.GA15043@rei.Home> <530C7004.3060102@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <530C7004.3060102@oracle.com>
Subject: Re: [LTP] rpc-tirpc-full-test-suite
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> I found that run_rpc_test.sh fails during ltpstress.sh execution. And it fails
> >> because the rpc-tirpc-full-test-suite is not compiled.
> >>
> >> So I:
> >> * integrated a part of the rpc-tirpc-full-test-suite into the LTP
> >>    building process (added Makefiles and etc). This part is the one
> >>    which was executed by run_rpc_tests.sh.
> >>
> >> * changed the description of the testcases in runtest/.
> >>    To ease debugging.
> >>
> >> I couldn't find a solution to make 'make' add the '.bin' suffix to the produced
> >> binaries. Therefore I had to fix some of the test scripts for that fact.
> >
> > I think that we are better without the bin suffix as it's not standard
> > suffix for binaries on Linux.
> >
> >> Does anybody know how to do that?
> >
> > As far as I know you need to write a custom rule for that because the
> > one make has by default matches %: %.c and not %.bin: %.c
> >
> 
> Thank you for review.
> 
> Addressing your comments I propose the following:
> 
> 1. Introduce configure option to enable building of 
> rpc-tirpc-full-test-suite (--with-rpc-tirpc-full-test-suite).
> If this option is set, ./configure will check for libtirpc (necessary 
> requirement for building TI-RPC test binaries).

I would rather see it compiled automatically if libtirpc is found.
Anything that is not compiled by default gets less testing and tend to
break.

You can skip the whole subdirectory in rpc/Makefile if tirpc is not
found with:

ifeq ($(RPC_LIBS),)
FILTER_OUT_DIRS+=rpc-tirpc-full-test-suite
endif

Assuming that the RPC_LIBS behaves the same way as NUMA_LIBS for
example.

And please shorten the directory names when you are at it,
rpc-tirpc-full-test-suite is far to long and tirpc or similar would do
the same job.

> 2. Rename the test suite binaries using this scheme:
> rpc_stdcall_callrpc/1-basic.c -> rpc_stdcall_callrpc/rpc_callrpc.c
> rpc_stdcall_callrpc/2-stress.c -> rpc_stdcall_callrpc/rpc_callrpc_stress.c
>
> tirpc_toplevel_clnt_call/1-basic.c -> tirpc_clnt_call.c
> tirpc_toplevel_clnt_call/2-stress.c -> tirpc_clnt_call_stress.c

Sounds reasonable to me.

> Make corresponding changes in current execution/building infrastructure 
> under rpc-tirpc-full-test-suite. Maybe someone will need it. And I don't 
> feel that I have a right to remove all these shell scripts and etc.

I would personaly remove the current execution/building infrastructure
and focus on the LTP integration. Managing two parallel systems is much
more work and unless somebody will use the current system it will get
broken sooner or later.

> 3. Add corresponding Makefiles under 
> testcases/network/rpc/rpc-tirpc-full-test-suite.
> All binaries will be installed into LTPROOT/testcases/bin.
> No names ending with '.bin'!
> 
> 4. Remove 'run_rpc_test.sh' from runtest/rpc and from 
> runtest/stress.part3, because rpc-tirpc-full-test-suite is an optional 
> component.
> 
> 5. Remove files runtest/rpctirpc, runtest/tirpc. They are useless.
> 
> 6. Introduce new wrappers for execution of RPC and TI-RPC test cases 
> from rpc-tirpc-full-test-suite inside LTP framework.
> 
> Make it as simple as possible. The algorithm will be:
>    * Set TCID
>    * Start a test rpc server (if necessary) on $RHOST
>    * Execute a test client and pass it the value of $RHOST.
>      Get return code from the client.
>    * Stop the test server and do some cleanup
>    * Basing on the client return code print either TPASS or TFAIL
> 
> So we use only 2 compluters - local and $RHOST. Connects to $RHOST are 
> with rsh.

Can we default to running the server on localhost if REMOTE host wasn't
configured?

> 7. Create files runtest/rpc_tests, runtest/tirpc_tests.
> 
> rpc_tests will contain the testcases which now should be executed by 
> run_rpc_tests.sh. Like this:
> rpc_get_myaddress run_ltp_rpc_test.sh rpc_get_myaddress
> rpc_pmap_getmaps run_ltp_rpc_test.sh rpc_pmap_getmaps
> rpc_pmap_getport run_ltp_rpc_test.sh rpc_pmap_getport
> 
> tirpc_tests will containt the testcases which now should be executed by 
> run_tirpc_tests.sh. Like this:
> tirpc_rpc_call run_ltp_tirpc_test.sh tirpc_rpc_call
> tirpc_rpcb_getaddr run_ltp_tirpc_test.sh tirpc_rpcb_getaddr
> 
> A TCID for each test binary.

Looks good.

> This looks like a big amount of work, so I want to discuss this before 
> submitting any patches for review. :)
> 
> What do you think?

Apart from minor things this sounds like a good plan.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
