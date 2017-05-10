From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 May 2017 12:15:33 +0200
Subject: [LTP] TWARN and "ltp-pan reported PASS"
In-Reply-To: <20170510090428.GC29838@rei.suse.de>
References: <20170509120935.q2v6dqhwmecy265w@dell5510>
 <20170510090428.GC29838@rei.suse.de>
Message-ID: <20170510101533.zu7x642tzfn73u4v@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril!
> Are you sure that ltp-pan actually passes the test return value? As far
> as I can tell it actually increments the exit_stat variable on error
> then does exit(exit_stat).

> So I would say that the only guarantee that you have is that non-zero
> return value from ltp-pan means "everything went ok" and non-zero
> "something went wrong".

do_test() in shell testcases/network/multicast/mc_cmds/mc_cmds with TWARN:
		tst_resm TWARN "'ip maddr show $(tst_iface)' failed," \
			       " parsing 'ip maddr show'"

reports termination_id=4 => FAIL:

$ /opt/ltp/testscripts/network.sh -m
network_settings 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
network_settings 1 TINFO: set local addr 10.0.0.2/24
network_settings 1 TINFO: set local addr fd00:1:1:1::2/64
network_settings 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
network_settings 1 TINFO: set remote addr 10.0.0.1/24
network_settings 1 TINFO: set remote addr fd00:1:1:1::1/64
network_settings 1 TINFO: wait for IPv6 DAD completion 1/5 sec
<<<test_start>>>
tag=mc_cmds stime=1494410089
cmdline="mc_cmds"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
mc_cmds 1 TWARN: 'ip maddr show ltp_ns_veth2' failed,  parsing 'ip maddr show'
mc_cmds 1 TINFO: Ping all-host-groups over specified interface
ping: unknown iface 10.0.0.2
mc_cmds 1 TINFO: Trying to ping with ltp_ns_veth2 with the -I option instead of IP address
mc_cmds 1 TPASS: Test Successful
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=4 corefile=no
cutime=3 cstime=1
<<<test_end>>>
ltp-pan reported FAIL

Changing it into TINFO it returns termination_id=0 => PASS:
-----
diff --git testcases/network/multicast/mc_cmds/mc_cmds testcases/network/multicast/mc_cmds/mc_cmds
index 8077b1f15..e66890019 100755
--- testcases/network/multicast/mc_cmds/mc_cmds
+++ testcases/network/multicast/mc_cmds/mc_cmds
@@ -51,7 +51,7 @@ do_test()
 
        ip maddr show $(tst_iface) | grep -q '224.0.0.1'
        if [ $? -ne 0 ]; then
-               tst_resm TWARN "'ip maddr show $(tst_iface)' failed," \
+               tst_resm TINFO "'ip maddr show $(tst_iface)' failed," \
                               " parsing 'ip maddr show'"
                ip maddr show | sed -ne "/\s$(tst_iface)/,/^[0-9]/p" | \
                        grep -q 224.0.0.1 || \
-----

$ /opt/ltp/testscripts/network.sh -m
<snip>
mc_cmds 1 TINFO: Trying to ping with ltp_ns_veth2 with the -I option instead of IP address
mc_cmds 1 TPASS: Test Successful
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=2 cstime=1
<<<test_end>>>
ltp-pan reported PASS
-----
So I don't see any other reason than TWARN causing the exit value.

> Frankly at this point I would rather kept the old test execution scripts
> as they are and put more effort into the new execution framework.
> Hopefully I will have a bit time to invest into it once we are done with
> the release.
I understand and agree with that. I'll be also glad when the old scripts will go away. I
just wanted to consult what is the expected behaviour.


Kind regards,
Petr
