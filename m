From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 14 Feb 2017 12:50:54 +0300
Subject: [LTP] [PATCH v2 4/4] network: migrate rpc_test.sh to use
	test_net.sh
In-Reply-To: <20170208144500.27340-4-pvorel@suse.cz>
References: <20170208144500.27340-1-pvorel@suse.cz>
 <20170208144500.27340-4-pvorel@suse.cz>
Message-ID: <0995acb3-33c4-7b3c-2b4a-5c24b024e0bd@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08.02.2017 17:45, Petr Vorel wrote:
> This fixes missing LTPROOT environment variable.
>
> Many tests are failing when using netns.

I tried to run this tests in netns, it seems that rpcbind (listening
port)not available in netns as a results tests are failing. If we
make the clientrun in network namespace, tests pass. Actually, I had
only twofailures:

rpc_test.sh -c rpc_xprt_register
[...]
rpc_xprt_register 1 TBROK : 'rpc_xprt_register 10.0.0.2 536875000 '
failed on '': 'rpc_xprt_register: svc_fd_create: could not retrieve
local addr
rpc_xprt_register: svc.c:96: xprt_register: Assertion `xprt != ((void
*)0)' failed.
sh: line 1: 20123 Aborted                 (core dumped)
rpc_xprt_register 10.0.0.2 536875000'

and the similar one:
rpc_test.sh -c rpc_xprt_unregister


What I did (above your patch):

--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -31,8 +31,8 @@ SERVER_STARTUP_SLEEP=1
 cleanup()
 {
        if [ ! -z "$SERVER" ]; then
-               tst_rhost_run -c "killall -9 $SERVER"
-               tst_rhost_run -c "$CLEANER $PROGNUMNOSVC"
+               killall -9 $SERVER
+               $CLEANER $PROGNUMNOSVC
        fi
 }

@@ -86,12 +86,11 @@ TST_CLEANUP=cleanup
 . test_net.sh

 if [ ! -z "$SERVER" ]; then
-       tst_rhost_run -b -c "$SERVER $PROGNUMNOSVC"
+       $SERVER $PROGNUMNOSVC &
        sleep "$SERVER_STARTUP_SLEEP"
 fi

-"$CLIENT" "$(tst_ipaddr rhost)" "$PROGNUMNOSVC" $CLIENT_EXTRA_OPTS
-ret=$?
+tst_rhost_run -sc "$CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS"

Note, last command would exit the test with TBROK if something bad
happened, so we just need TPASS after that.

Best regards,
Alexey

