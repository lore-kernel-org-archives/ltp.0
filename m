From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 14:39:22 +0200
Subject: [LTP] [RFC PATCH 0/2] Shell API: TST_TESTFUNC_DATA
Message-ID: <20180516123924.11047-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this patch is maybe controversial as 1) it adds yet another way how to
run tests in new shell API 2) it does not support new C API.  It simply
workaround missing POSIX support for arrays (in C we do similar things
with array struct).

Some network functions which use old API run several times with for
loop. Here, in dccp_ipsec.sh, $IPSEC_SIZE_ARRAY gets changed with
getopts in ipsec_lib.sh.

runtest/net_stress.ipsec_dccp
dccp4_ipsec01 dccp_ipsec.sh -s "100 500 1000"
...

testcases/network/stress/dccp/dccp_ipsec.sh (simplified)
TCID=dccp_ipsec
TST_TOTAL=3
. ipsec_lib.sh
do_test()
{
	for p in $IPSEC_SIZE_ARRAY; do
		tst_netload -H $(tst_ipaddr rhost) -T dccp -n $p -N $p \
			-r $IPSEC_REQUESTS
	done
}
do_test
tst_exit
---
Running it:
/opt/ltp/testscripts/network.sh -D
...
<<<test_start>>>
tag=dccp4_ipsec01 stime=1526471999
cmdline="dccp_ipsec.sh -s 100:500:1000"
contacts=""
analysis=exit
<<<test_output>>>
dccp_ipsec 1 TINFO: run server 'netstress -T dccp -R 500000 -B /tmp/netpan-24771/LTP_dccp_ipsec.uHpwIo4sw4'
dccp_ipsec 1 TINFO: run client 'netstress -l -T dccp -H 10.0.0.1 -n 100 -N 100 -a 2 -r 500 -d tst_netload.res -g 43799'
dccp_ipsec 1 TPASS: netstress passed, time spent '116' ms
dccp_ipsec 2 TINFO: run server 'netstress -T dccp -R 500000 -B /tmp/netpan-24771/LTP_dccp_ipsec.uHpwIo4sw4'
dccp_ipsec 2 TINFO: run client 'netstress -l -T dccp -H 10.0.0.1 -n 500 -N 500 -a 2 -r 500 -d tst_netload.res -g 39537'
dccp_ipsec 2 TPASS: netstress passed, time spent '11' ms
dccp_ipsec 3 TINFO: run server 'netstress -T dccp -R 500000 -B /tmp/netpan-24771/LTP_dccp_ipsec.uHpwIo4sw4'
dccp_ipsec 3 TINFO: run client 'netstress -l -T dccp -H 10.0.0.1 -n 1000 -N 1000 -a 2 -r 500 -d tst_netload.res -g 34207'
dccp_ipsec 3 TPASS: netstress passed, time spent '9' ms
...

When rewritten into new API (simplified):
TST_TESTFUNC=do_test
. ipsec_lib.sh
do_test()
{
	for p in $IPSEC_SIZE_ARRAY; do
		tst_netload -H $(tst_ipaddr rhost) -T dccp -n $p -N $p \
			-r $IPSEC_REQUESTS
	done
}
tst_run
---
The problem is we lost counters:
...
<<<test_output>>>
dccp_ipsec 1 TINFO: run server 'netstress -T dccp -R 500000 -B /tmp/netpan-20326/LTP_dccp_ipsec.6mH0vypvZC'
dccp_ipsec 1 TINFO: run client 'netstress -l -T dccp -H 10.0.0.1 -n 100 -N 100 -a 2 -r 500 -d tst_netload.res -g 44791'
dccp_ipsec 1 TPASS: netstress passed, time spent '18' ms
dccp_ipsec 1 TINFO: run server 'netstress -T dccp -R 500000 -B /tmp/netpan-20326/LTP_dccp_ipsec.6mH0vypvZC'
dccp_ipsec 1 TINFO: run client 'netstress -l -T dccp -H 10.0.0.1 -n 500 -N 500 -a 2 -r 500 -d tst_netload.res -g 39661'
dccp_ipsec 1 TPASS: netstress passed, time spent '16' ms
dccp_ipsec 1 TINFO: run server 'netstress -T dccp -R 500000 -B /tmp/netpan-20326/LTP_dccp_ipsec.6mH0vypvZC'
dccp_ipsec 1 TINFO: run client 'netstress -l -T dccp -H 10.0.0.1 -n 1000 -N 1000 -a 2 -r 500 -d tst_netload.res -g 41279'
dccp_ipsec 1 TPASS: netstress passed, time spent '12' ms

UDP IPsec tests (udp_ipsec.sh, udp_ipsec_vti.sh) have TST_TOTAL=6, so it
gets a bit unclear with just '1'.

With TST_TESTFUNC_DATA and TST_TESTFUNC_DATA_IFS we can 1) simplify 7
tests now without creating special helper 2) keep ids.

Second patch isn't applicable, it's just for demonstrating how it works
as it expects further changes, I'll post with bigger patch for rewriting
net/{stress,virt} tests. What is missing here is rewritten
dccp/dccp_ipsec.sh and ipsec_lib.sh into new shell API and changes to
runtest/net_stress.ipsec_dccp:
-dccp4_ipsec01 dccp_ipsec.sh -s "100 500 1000"
+dccp4_ipsec01 dccp_ipsec.sh -s 100:500:1000

Kind regards,
Petr

Petr Vorel (2):
  lib/tst_test.sh: TST_TESTFUNC_DATA and TST_TESTFUNC_DATA_IFS
  net/{stress,virt}: Use TST_TESTFUNC_DATA and TST_TESTFUNC_DATA_IFS

 doc/test-writing-guidelines.txt             | 23 +++++++++++++++++++++++
 testcases/lib/tst_test.sh                   | 20 ++++++++++++++++++--
 testcases/network/stress/dccp/dccp_ipsec.sh |  6 ++----
 testcases/network/stress/ipsec/ipsec_lib.sh |  3 ++-
 4 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.16.3

