Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDFXi-0007jE-PW
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 15:46:38 +0000
Date: Tue, 11 Feb 2014 16:46:00 +0100
From: chrubis@suse.cz
Message-ID: <20140211154600.GC15043@rei.Home>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1388048842-28373-4-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1388048842-28373-4-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 3/5] rpc-tirpc-full-test-suite: fixed the cmdline
 in runtest
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
> To make debugging easier we don't use run_rpc_test.sh but
> use its own test case name for each test case.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  runtest/rpc                                        |    8 +++++++-
>  runtest/stress.part3                               |    8 +++++++-
>  .../rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh    |   12 +++++++-----
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/runtest/rpc b/runtest/rpc
> index c9e5f0d..7c18eda 100644
> --- a/runtest/rpc
> +++ b/runtest/rpc
> @@ -2,7 +2,13 @@
>  #
>  # PLEASE READ THE README FILE IN /rpc BEFORE RUNNING THESE.
>  #
> -run_rpc_tests.sh run_rpc_tests.sh
> +rpc_addrmanagmt_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_addrmanagmt_basic_lib.sh
> +rpc_auth_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_auth_basic_lib.sh
> +rpc_broadc_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_broadc_basic_lib.sh
> +rpc_createdestroy_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_createdestroy_basic_lib.sh
> +rpc_err_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_err_basic_lib.sh
> +rpc_regunreg_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_regunreg_basic_lib.sh
> +rpc_stdcall_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_stdcall_basic_lib.sh

I don't like the long path here, but we cannot do anything about it
unless we install the binaries into the standard localtion.

>  rpc01 rpc01
>  rpcinfo rpcinfo01
>  rup rup01
> diff --git a/runtest/stress.part3 b/runtest/stress.part3
> index bb4807c..57a5106 100644
> --- a/runtest/stress.part3
> +++ b/runtest/stress.part3
> @@ -886,6 +886,12 @@ hangup01 hangup01
>  mc_cmds mc_cmds
>  mc_opts export TCsrc=$LTPROOT/testcases/network/multicast/mc_opts; mc_opts
>  rpc01 export TCbin=$LTPROOT/testcases/network/rpc/basic_tests/rpc01; rpc01
> -run_rpc_tests.sh export TCbin=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; run_rpc_tests.sh
> +rpc_addrmanagmt_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_addrmanagmt_basic_lib.sh
> +rpc_auth_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_auth_basic_lib.sh
> +rpc_broadc_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_broadc_basic_lib.sh
> +rpc_createdestroy_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_createdestroy_basic_lib.sh
> +rpc_err_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_err_basic_lib.sh
> +rpc_regunreg_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_regunreg_basic_lib.sh
> +rpc_stdcall_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_stdcall_basic_lib.sh
>  perf_lan perf_lan
>  
> diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
> index e3fca59..66be9b8 100755
> --- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
> +++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
> @@ -24,15 +24,17 @@
>  # *** INITIALISATION ***
>  # **********************
>  
> +LTPROOT=${LTPROOT:=$(readlink -f ../../../..)}

Why are you redefining the LTPROOT? It should be exported by the ltp-pan
correcty.

>  # Indicates in which directory tests binaries are installed
> -SERVERTSTPACKDIR=/home/lerouzic/benchs/ltp-full-20080930/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack
> -CLIENTTSTPACKDIR=/home/lerouzic/benchs/ltp-full-20080930/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack
> +SERVERTSTPACKDIR=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack
> +CLIENTTSTPACKDIR=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack
>  # LOCALIP variable is computer IP/name used to run tests scripts
>  # if LOCALIP = SERVERIP = CLIENTIP, that means all tests are in local mode
>  # (run on the same machine)
> -LOCALIP=localhost
> -SERVERIP=localhost
> -CLIENTIP=localhost
> +LOCALIP=`hostname`
> +SERVERIP=`hostname`
> +CLIENTIP=`hostname`
>  SERVERUSER=root
>  CLIENTUSER=root
>  # number of threads for thread tests

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
