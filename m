From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Wed, 16 Jun 2021 17:11:34 +0300
Subject: [LTP] [PATCH v3] ssh-stress: Convert to new api
In-Reply-To: <20210616081856.3026223-1-lkml@jv-coder.de>
References: <20210616081856.3026223-1-lkml@jv-coder.de>
Message-ID: <fb4b9d45-2cbb-5e5c-fefe-3ca429373a54@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16.06.2021 11:18, Joerg Vehlow wrote:
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> 
> Apart from pure conversion:
>  - Use "StrictModes no" in ssh config, to get rid of
>    access permission problems; All part of the path of the
>    authorized_keys file must not be writeable by anyone but the owner.
>    This allows writing the file to the default temp directory
>  - Moved all rhost scripts into ssh-stress.sh
> 
> Changes in v3:
> - use pkill instead of ps | awk | xargs
> - Changed test descriptions slightly
>   * include actual ip version
>   * dropped "for a long time", the tests do not run
>     for a long time with the default config
> - Use netstress -B and ssh -f for background processes
>   This implies using pgrep to get the pids of these processes.
> 
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
...
>  
> -TCID=ssh-stress
> -TST_TOTAL=3
>  TST_CLEANUP="cleanup"
> +TST_SETUP="setup"
> +TST_TESTFUNC="test"
> +TST_CNT=3
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_TMPDIR=1
> +TST_NEEDS_CMDS="sshd ssh od pkill pgrep"
>  
> -TST_USE_LEGACY_API=1
>  . tst_net.sh
>  
> -# Temporary directory to store sshd setting or ssh key
> -# Note: ssh doesn't work when those directory is under /tmp.
> -TMPDIR="/root"
> +# SSH config file on the remote host
> +RHOST_SSH_CONF=
> +# SSH command to connect from the remote host to the test host
> +RHOST_SSH=
> +# Processes started on the remote host, killed at cleanup
> +RHOST_PIDS=
> +# Netstress process started on the test host, killed at cleanup
> +NETSTRESS_PID=
>  
>  cleanup()
>  {
> +	local pids
> +
>  	# Stop the ssh daemon
> -	test -s sshd.pid && kill $(cat sshd.pid)
> -	pkill 'netstress$'
> -	tst_rmdir
> -	[ "$rtmpdir" ] && tst_rhost_run -c "rm -rf $rtmpdir"
> -	TMPDIR=
> +	[ -s sshd.pid ] && kill $(cat sshd.pid)
> +	[ -n "$NETSTRESS_PID" ] && kill -2 $NETSTRESS_PID >/dev/null 2>&1
> +
> +	tst_rhost_run -c "kill $RHOST_PIDS"  >/dev/null 2>&1
> +
> +	# Kill all remaining ssh processes
> +	tst_rhost_run -c "pkill -f '^ssh $RHOST_SSH_CONF'"

Perhaps we should check that $RHOST_SSH_CONF is set before running
pkill.


For the rest:
Reviewed-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
