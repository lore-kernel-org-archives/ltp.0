From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 16:46:22 +0200
Subject: [LTP] [PATCH V3 16/23] Fix test_proc_kill hanging
In-Reply-To: <20160722042656.22346-16-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-16-raj.khem@gmail.com>
Message-ID: <20160727144622.GE11986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index c90d0a2..331e75b 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -220,8 +220,8 @@ test_proc_kill()
>  
>  	$TEST_PATH/memcg_process $2 -s $3 &
>  	pid=$!
> -	sleep 1
>  	echo $pid > tasks
> +	sleep 1

Hmm are you sure that this fixes race condition where the test is not
attached to the group while the signal is send?

I would say that the kernel should guarantee that once the echo returns
back to userspace the processes is attached. Anything else would be
terribly racy.

There is different race condition as well, and this one is between the
memcg_process setting up the signal handler and the stress test testing
the signal that may be the cause for a random failures as well.

>  	kill -s USR1 $pid 2> /dev/null
>  	sleep 1
> -- 
> 2.9.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
