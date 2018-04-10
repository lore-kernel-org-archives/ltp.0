From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Apr 2018 19:41:14 +0200
Subject: [LTP] [RFC PATCH v6 0/7] Rewriting network tests into new shell
	API
In-Reply-To: <20180406123118.21309-1-pvorel@suse.cz>
References: <20180406123118.21309-1-pvorel@suse.cz>
Message-ID: <20180410174114.kgtivukd7ph3zabp@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Changelog v5->v6:
> * Fix bashism in v5 when passing parameters to tst_net.sh.
>   https://lists.linux.it/pipermail/ltp/2018-April/007619.html
> * Fixed missing $ipver in multicast tests.
> * Fixed broken creating tmpdir on rhost in new API.

> Changelog v4->v5:
> * Fix handling getopts parameters in scripts which are using legacy API
>   with getopts (ipsec_lib.sh, tcp_fastopen_run.sh, rpc_test.sh) by
>   shifting args after getopts and moving sourcing tst_net.sh after that.
>   Also -6 param for IPv6 must be passed to tst_net.sh (ipsec_lib.sh,
>   tcp_fastopen_run.sh).
> * Fixed iver for legacy scripts (caused some bugs at least in interfaces
>   tests).

> Changes v3->v4:
> * Fixed bugs with setting TST_IPV6 and ipver variables. Now added into
>   setup function (for new API they must not be used in test scripts
>   outside setup/run/cleanup functions as they're not set).
> * New commit: 6/6 "network/interface: Split tests to test only one command per test"
>   A bit complicated than I thought (adding tst_test_cmds and using it
>   would be simpler), but I guess separation is better (as Cyril noted).
>   I needed to pass -c as getopts parameter.
> * Renamed functions in tst_net.sh (Alexey).
> * Fixed script name in Makefile, changed output of usage (Alexey).
> * Export TST_ID, LTPROOT and TST_DATAROOT also for TST_NO_DEFAULT_RUN
>   (Cyril).

> Petr Vorel (7):
>   tst_net.sh: Support both new and legacy APIs + rename
>   tst_test.sh: Introduce TST_NO_DEFAULT_RUN
>   network.sh: Migrate to new shell API
>   network/interface: Cleanup if4-addr-change
>   network/if-updown: Restore IP in cleanup function
>   tst_net_stress.sh: Migrate with dependencies to new API + rename
>   network/interface: Split tests to test only one command per test

I didn't want to flood ML again, so here is the diff v6->v7:
diff --git testscripts/network.sh testscripts/network.sh
index b18f202d5..c946e4d86 100755
--- testscripts/network.sh
+++ testscripts/network.sh
@@ -86,15 +86,12 @@ if [ "$OPTIND" -eq 1 ]; then
 fi
 shift $(($OPTIND - 1))
 
-TST_TOTAL=1
-TCID="network_settings"
-
 TST_NO_DEFAULT_RUN=1
 . tst_net.sh
 
 # Reset variables.
 # Don't break the tests which are using 'testcases/lib/cmdlib.sh'
-unset TCID TST_LIB_LOADED TST_USE_LEGACY_API
+unset TST_ID TST_LIB_LOADED TST_NO_DEFAULT_RUN
 
 rm -f $CMDFILE
---- 

Alternatively you can clone changes here:
https://github.com/pevik/ltp/tree/tst_net.sh.v7

Anything to change?

Kind regards,
Petr
