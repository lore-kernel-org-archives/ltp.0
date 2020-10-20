From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Oct 2020 14:23:51 +0200
Subject: [LTP] [PATCH] syscalls/timer_settime01: adjust for rounding
 from nsec to usec
In-Reply-To: <20201013140315.GD29925@yuki.lan>
References: <20201006085309.32227-1-cascardo@canonical.com>
 <20201013140315.GD29925@yuki.lan>
Message-ID: <20201020122351.GA15920@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What about this change instead?
> 
> diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
> index 67143e8f8..599ef2891 100644
> --- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
> +++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
> @@ -132,11 +132,13 @@ static void run(unsigned int n)
>  					get_clock_str(clock));
>  				continue;
>  			}
> -			val += tst_ts_to_us(timenow);
> +			tst_ts_add_us(timenow, val);
> +			tst_its_set_value_from_ts(&new_set, timenow);
> +		} else {
> +			tst_its_set_value_from_us(&new_set, val);
>  		}
>  
>  		tst_its_set_interval_from_us(&new_set, tc->it_interval_tv_usec);
> -		tst_its_set_value_from_us(&new_set, val);
>  
>  		TEST(tv->timer_settime(timer, tc->flag, tst_its_get(&new_set), tst_its_get(tc->old_ptr)));
>  
> 
> 
> By adding the us to the timenow first and then setting the its.value
> from it we can avoid the rounding completely.

Does this fix work for you?

-- 
Cyril Hrubis
chrubis@suse.cz
