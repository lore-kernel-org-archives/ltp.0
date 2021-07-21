From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Jul 2021 16:37:27 +0200
Subject: [LTP] [PATCH v4,
 2/2] cgroup/cgroup_regression_test: Fix umount failure
In-Reply-To: <20210719092239.GA1475@atcfdc88>
References: <20210719092239.GA1475@atcfdc88>
Message-ID: <YPgxJwx795fhXgLa@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Leo,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  	rmdir cgroup/0 cgroup/1
> -	umount cgroup/
> +	tst_umount cgroup/	# Avoid possible EBUSY error
>  }

>  #---------------------------------------------------------------------------
> @@ -193,7 +193,7 @@ test3()
>  	wait $pid2 2>/dev/null

>  	rmdir $cpu_subsys_path/0 2> /dev/null
> -	umount cgroup/ 2> /dev/null
> +	tst_umount cgroup/ 2> /dev/null		# Avoid possible EBUSY error
I'd prefer: # keep "/" to avoid possible EBUSY error
But that can be changed before merge.

More I'm interested if other maintainers agree with me about this approach.
(keep / here instead of in tst_umount())

>  	check_kernel_bug
>  }

> @@ -222,7 +222,7 @@ test4()
>  	mount -t cgroup -o none,name=foo cgroup cgroup/
>  	mkdir cgroup/0
>  	rmdir cgroup/0
> -	umount cgroup/
> +	tst_umount cgroup/		# Avoid possible EBUSY error

>  	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
>  		tst_res TFAIL "lockdep BUG was found"
> @@ -254,7 +254,7 @@ test5()
>  	mount -t cgroup none cgroup 2> /dev/null
>  	mkdir cgroup/0
>  	rmdir cgroup/0
> -	umount cgroup/ 2> /dev/null
> +	tst_umount cgroup/ 2> /dev/null		# Avoid possible EBUSY error
I'd drop stderr redirection here. It was here originally, but I suppose it's not
needed when using tst_umount. But that can be done during merge.

...

Kind regards,
Petr
