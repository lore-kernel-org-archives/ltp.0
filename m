From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 May 2017 15:41:31 +0200
Subject: [LTP] TWARN and "ltp-pan reported PASS"
In-Reply-To: <20170510101533.zu7x642tzfn73u4v@dell5510>
References: <20170509120935.q2v6dqhwmecy265w@dell5510>
 <20170510090428.GC29838@rei.suse.de>
 <20170510101533.zu7x642tzfn73u4v@dell5510>
Message-ID: <20170517134131.GA21784@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Changing it into TINFO it returns termination_id=0 => PASS:
> -----
> diff --git testcases/network/multicast/mc_cmds/mc_cmds testcases/network/multicast/mc_cmds/mc_cmds
> index 8077b1f15..e66890019 100755
> --- testcases/network/multicast/mc_cmds/mc_cmds
> +++ testcases/network/multicast/mc_cmds/mc_cmds
> @@ -51,7 +51,7 @@ do_test()
>  
>         ip maddr show $(tst_iface) | grep -q '224.0.0.1'
>         if [ $? -ne 0 ]; then
> -               tst_resm TWARN "'ip maddr show $(tst_iface)' failed," \
> +               tst_resm TINFO "'ip maddr show $(tst_iface)' failed," \
>                                " parsing 'ip maddr show'"
>                 ip maddr show | sed -ne "/\s$(tst_iface)/,/^[0-9]/p" | \
>                         grep -q 224.0.0.1 || \
> -----
> 
> $ /opt/ltp/testscripts/network.sh -m
> <snip>
> mc_cmds 1 TINFO: Trying to ping with ltp_ns_veth2 with the -I option instead of IP address
> mc_cmds 1 TPASS: Test Successful
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=0 corefile=no
> cutime=2 cstime=1
> <<<test_end>>>
> ltp-pan reported PASS
> -----
> So I don't see any other reason than TWARN causing the exit value.

Looks like I've haven't been clear enough. The ltp-pan mapped any
non-zero test exit value to a failure. Partly becasuse there were (and
possibly still may be some) testcases that do not use LTP exit bitflags
and partly because ltp-pan predates LTP, at least that's what I remeber
from some CVS archeology.

Then we added special support for the TCONF exit status, since otherwise
skipped testcases were listed as failed as well.

So yes the TWARN still maps to a failure in ltp-pan and we use TWARN
mostly for non-fatal (to the test execution) failures, mostly in test
cleanups. Is that clear enough?

-- 
Cyril Hrubis
chrubis@suse.cz
