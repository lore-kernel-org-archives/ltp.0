From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Oct 2019 14:19:03 +0200
Subject: [LTP] [PATCH] lsmod01.sh: retry test couple times to lower
 false positives
In-Reply-To: <c8843f2f4a325e820d030d9c7c36d7624f1baa82.1571393044.git.jstancek@redhat.com>
References: <c8843f2f4a325e820d030d9c7c36d7624f1baa82.1571393044.git.jstancek@redhat.com>
Message-ID: <20191023121901.GA25868@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

...
> -lsmod_test()
> +lsmod_matches_proc_modules()
>  {
>  	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
>  	if [ -z "$lsmod_output" ]; then
> -		tst_res TFAIL "Failed to parse the output from lsmod"
> -		return
> +		tst_brk TBROK "Failed to parse the output from lsmod"
>  	fi

> -	modules_output=$(awk '{print $1, $2, $3}' /proc/modules | sort)
> +	modules_output=$(awk '{print $1, $2, $3} 1' /proc/modules | sort)
>  	if [ -z "$modules_output" ]; then
> -		tst_res TFAIL "Failed to parse /proc/modules"
> -		return
> +		tst_brk TBROK "Failed to parse /proc/modules"
>  	fi

>  	if [ "$lsmod_output" != "$modules_output" ]; then
> -		tst_res TFAIL "lsmod output different from /proc/modules."
> +		tst_res TINFO "lsmod output different from /proc/modules."

>  		echo "$lsmod_output" > temp1
>  		echo "$modules_output" > temp2
>  		diff temp1 temp2

> -		return
> +		return 1
>  	fi
> +	return 0
> +}

> -	tst_res TPASS "'lsmod' passed."
> +lsmod_test()
> +{
> +	for i in $(seq 1 5); do
> +		if lsmod_matches_proc_modules; then
> +			tst_res TPASS "'lsmod' passed."
> +			return
> +		fi
> +		tst_res TINFO "Trying again"
> +		sleep 1
> +	done
This is similar pattern to TST_RETRY_FUNC()/TST_RETRY_FN_EXP_BACKOFF()
(for both shell and C). I wonder if we also have use for TPASS/TFAIL
instead of just TBROK and specifying number of tries instead of time to be
setup.
C and shell usage is a bit different, so maybe
TST_RETRY_FUNC()/TST_RETRY_FN_EXP_BACKOFF() doesn't make much sense for shell
(actually nothing uses them in shell) and I don't see much usage for my proposal
in C.

> +	tst_res TFAIL "'lsmod' doesn't match /proc/modules output"

+ we forget to use local (for lsmod_outputa and i), but that's not that
important.

Kind regards,
Petr
