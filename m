From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 23 Apr 2020 22:04:15 +0300
Subject: [LTP] [PATCH 1/1] net/sendfile01.sh: Check with timeout
In-Reply-To: <20200421180002.11351-1-pvorel@suse.cz>
References: <20200421180002.11351-1-pvorel@suse.cz>
Message-ID: <dab04fc5-5d20-3dbc-c21f-535112ab222f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 21.04.2020 21:00, Petr Vorel wrote:
> Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Alexey,
> 
> I guess nothing controversial here as failure of starting server is
> guarded by -s.
> I was thinking about using TST_RETRY_FUNC, but passing command to it
> leads to: tst_rhost_run: unknown option: l
> 

Hi Petr,

eval might help in this case, take a look at tst_retry() in test.sh
old api, not sure why exactly it was removed in the new one...

index 1d8a71d9f..e34edb26a 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -207,7 +207,7 @@ TST_RETRY_FN_EXP_BACKOFF()
        fi
 
        while true; do
-               $tst_fun
+               eval "$tst_fun"
                if [ "$?" = "$tst_exp" ]; then
                        break
                fi

> What bothers me more, that TST_NEEDS_CMDS does not check command on
> rhost. Do we want to have something like TST_NEEDS_CMDS_RHOST or we just
> don't care?

In general, yes, we need to check if a command exists on the remote host.
Yet another variable, what about checking what in TST_NEEDS_CMDS on the
remote host? Though TST_NEEDS_CMDS_RHOST looks quite well.

> 
> Kind regards,
> Petr
> 
>  testcases/network/tcp_cmds/sendfile/sendfile01.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01.sh b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
> index af9cadf57..94fff2c9a 100755
> --- a/testcases/network/tcp_cmds/sendfile/sendfile01.sh
> +++ b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
> @@ -11,7 +11,7 @@ TST_SETUP=do_setup
>  TST_CLEANUP=do_cleanup
>  TST_TESTFUNC=do_test
>  TST_NEEDS_TMPDIR=1
> -TST_NEEDS_CMDS="diff stat"
> +TST_NEEDS_CMDS="diff ss stat"
>  . tst_net.sh
>  
>  do_setup()
> @@ -28,7 +28,10 @@ do_setup()
>  	tst_rhost_run -s -b -c "$server $(tst_ipaddr rhost) $port"
>  	server_started=1
>  	tst_res TINFO "wait for the server to start"
> -	sleep 1
> +	while true; do
> +		tst_rhost_run -c "ss -ltp" | grep -q "$port.*testsf" && break
> +		tst_sleep 10ms
> +	done
>  }
>  
>  do_test()
> 

