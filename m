From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Jun 2016 15:16:54 +0200
Subject: [LTP] [PATCH V2] controllers/memcg: Mark testcase_2 as pass
 when mlock failed
In-Reply-To: <20160602013657.GA8737@localhost.localdomain>
References: <CAAUgArC7-C7tc2W5gpwt9=U_=gcU98uiLJci3xnjHDXjk8mUxg@mail.gmail.com>
 <20160601090728.GA25827@localhost.localdomain>
 <20160601093652.GB19762@rei.lan>
 <20160602013657.GA8737@localhost.localdomain>
Message-ID: <20160606131653.GA21264@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -229,8 +229,11 @@ test_proc_kill()
>  	ps -p $pid > /dev/null 2> /dev/null
>  	if [ $? -ne 0 ]; then
>  		wait $pid
> -		if [ $? -eq 1 ]; then
> +		ret=$?
> +		if [ $ret -eq 1 ]; then
>  			result $FAIL "process $pid is killed by error"
> +		elif [[ $ret -eq 2 ]]; then
> +			result $PASS "Failed to lock memory"

The [[ is bashism (and will not work on Debian), use single brackets
instead.

>  		else
>  			result $PASS "process $pid is killed"
>  		fi
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
> index 3d34394..40c677b 100644
> --- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
> @@ -203,8 +203,12 @@ void mmap_lock2()
>  		if (p == MAP_FAILED)
>  			err(1, "mmap failed");
>  
> -		if (mlock(p, memsize) == -1)
> -			err(1, "mlock failed");
> +		if (mlock(p, memsize) == -1) {
> +			if (errno == EAGAIN)
> +				exit(2);
> +                        else
> +				err(1, "mlock failed");
> +                }

The code indented by spaces again. Plase use tabs only.

>  	} else {
>  		if (munmap(p, memsize) == -1)
>  			err(1, "munmap failed");
-- 
Cyril Hrubis
chrubis@suse.cz
