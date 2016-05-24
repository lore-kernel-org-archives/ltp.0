From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 May 2016 14:26:55 +0200
Subject: [LTP] [PATCH V2] memcg/functional: check several times if the
 process is killed
In-Reply-To: <1464079938-32392-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <57434132.4040100@oracle.com>
 <1464079938-32392-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160524122655.GD10029@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	tpk_pid_exists=1
> +	for tpk_iter in $(seq 5); do
> +		tpk_state=$(ps -o state= -p $pid)
> +		if [ -z "$tpk_state" ] || echo "$tpk_state" | grep -q Z; then
> +			tpk_pid_exists=0
> +			break
> +		fi


We may also poke directly the /proc/$PID/ and /proc/$PID/status
something as (beware untested):

	if [ ! -d /proc/$PID/ ] || grep -q "Z (zombie)" /proc/$PID/status; then
		...
	fi

> +		sleep 1

And I would change this sleep to at least 1/4s so that we do not waste
too much time here.

> +	done
> +
> +	if [ $tpk_pid_exists -eq 0 ]; then
>  		wait $pid
>  		if [ $? -eq 1 ]; then
>  			result $FAIL "process $pid is killed by error"
> -- 
> 1.7.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
