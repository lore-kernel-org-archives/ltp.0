From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Aug 2021 14:44:12 +0200
Subject: [LTP] [PATCH 1/2] shell: Add checkpoints api for new lib
In-Reply-To: <20210809121238.1585673-1-lkml@jv-coder.de>
References: <20210809121238.1585673-1-lkml@jv-coder.de>
Message-ID: <YRPGHBuKHnvARkn+@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index c6aa2c487..d4a1ab736 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -253,6 +253,27 @@ TST_RTNL_CHK()
>  	tst_brk TBROK "$@ failed: $output"
>  }
>  
> +TST_CHECKPOINT_WAIT()
> +{
> +	ROD tst_checkpoint wait 10000 "$1"
> +}
> +
> +TST_CHECKPOINT_WAKE()
> +{
> +	ROD tst_checkpoint wake 10000 "$1" 1
> +}
> +
> +TST_CHECKPOINT_WAKE2()
> +{
> +	ROD tst_checkpoint wake 10000 "$1" "$2"
> +}
> +
> +TST_CHECKPOINT_WAKE_AND_WAIT()
> +{
> +	TST_CHECKPOINT_WAKE "$1"
> +	TST_CHECKPOINT_WAIT "$1"
> +}
> +
>  tst_mount()
>  {
>  	local mnt_opt mnt_err
> @@ -558,6 +579,20 @@ tst_set_timeout()
>  	_tst_setup_timer
>  }
>  
> +_tst_init_checkpoints()
> +{
> +	local pagesize
> +
> +	LTP_IPC_PATH="/dev/shm/ltp_${TCID}_$$"
> +	pagesize=$(tst_getconf PAGESIZE)
> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "tst_getconf PAGESIZE failed"
> +	fi
> +	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
> +	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
> +	export LTP_IPC_PATH
> +}

Shouldn't we also delete the /dev/shm/ltp_${TCID}_$$ in the
_tst_do_exit() if LTP_IPC_PATH was set?

Other than that it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
