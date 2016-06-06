From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Jun 2016 10:40:43 +0200
Subject: [LTP] [RFC] shell wrappers for tst_checkpoint
In-Reply-To: <57504983.5010106@oracle.com>
References: <1464791693-10249-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160601150345.GA23934@rei.lan> <57504983.5010106@oracle.com>
Message-ID: <20160606084043.GA11753@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 70345e5..00eeeae 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -100,6 +100,10 @@ tst_exit()
>  		$TST_CLEANUP
>  	fi
>  
> +	if [ -n "$LTP_IPC_PATH" -a -f "$LTP_IPC_PATH" ]; then
> +		rm -f "$LTP_IPC_PATH"
> +	fi
> +
>  	# Mask out TINFO
>  	exit $((LTP_RET_VAL & ~16))
>  }
> @@ -374,6 +378,16 @@ tst_module_exists()
>  	tst_brkm TCONF "Failed to find module '$mod_name'"
>  }
>  
> +TST_CHECKPOINT_WAIT()
> +{
> +	ROD tst_checkpoint_wait "$1" 10000
> +}
> +
> +TST_CHECKPOINT_WAKE()
> +{
> +	ROD tst_checkpoint_wake "$1" 10000
> +}

Given that we have wrappers for the checkpoint programs anyway, we can
build just one binary called tst_checkpoint and pass the wait/wake as
first parameter. That way we can spare us the special rules in Makefile
and ifdefs in the checkpoint C source.

>  # Check that test name is set
>  if [ -z "$TCID" ]; then
>  	tst_brkm TBROK "TCID is not defined"
> @@ -393,3 +407,16 @@ if [ -z "$LTPROOT" ]; then
>  else
>  	export LTP_DATAROOT="$LTPROOT/testcases/data/$TCID"
>  fi
> +
> +if [ "$TST_NEEDS_CHECKPOINTS" = "1" ]; then
> +	LTP_IPC_PATH="/dev/shm/ltp_$$"

We may also include the $TCID in the filename, since that would make
identifying which tests possibly failed to cleanup easier...

> +	LTP_IPC_SIZE=$(getconf PAGESIZE)
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK "getconf PAGESIZE failed"
> +	fi
> +
> +	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$LTP_IPC_SIZE" count=1
> +	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
> +	export LTP_IPC_PATH
> +fi

Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
