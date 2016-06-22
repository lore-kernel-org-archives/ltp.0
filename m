From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jun 2016 15:34:44 +0200
Subject: [LTP] [PATCH 1/4] memcg/functional: rewrite
In-Reply-To: <1465917893-32074-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1465917893-32074-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160622133444.GD13962@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  # Record the test result of a test case
>  # $1 - The result of the test case, $PASS or $FAIL
> @@ -55,7 +82,6 @@ result()
>  		tst_resm TPASS "$info"
>  	else
>  		tst_resm TFAIL "$info"
> -		: $(( failed += 1 ))
>  	fi

Can we get rid of the result() function?

Since the failures are now counted in the test.sh library it does not
make a sense to define special result reporting function.

> @@ -83,7 +109,7 @@ warmup()
>  {
>  	pid=$1
>  
> -	echo "Warming up for test: $cur_id, pid: $pid"
> +	tst_resm TINFO "Warming up pid: $pid"
>  	kill -s USR1 $pid 2> /dev/null
>  	sleep 1
>  	kill -s USR1 $pid 2> /dev/null
> @@ -91,10 +117,10 @@ warmup()
>  
>  	kill -0 $pid
>  	if [ $? -ne 0 ]; then
> -		result $FAIL "cur_id=$cur_id"
> +		result $FAIL ""
                              ^
Shouldn't we print here something as:

"process died after warmup"

Or even better wait the pid and print the exit value as well.


Otherwise this looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
