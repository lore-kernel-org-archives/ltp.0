From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Nov 2018 14:14:48 +0100
Subject: [LTP] [PATCH 4/5] syscalls/fanotify03: add test for
 FAN_MARK_FILESYSTEM permission events
In-Reply-To: <20181116065119.6912-5-amir73il@gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
 <20181116065119.6912-5-amir73il@gmail.com>
Message-ID: <20181121131448.GE2954@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -static void setup_mark(unsigned int n)
> +static int setup_mark(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
>  	struct fanotify_mark_type *mark = &tc->mark;
> @@ -144,7 +149,12 @@ static void setup_mark(unsigned int n)
>  	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
>  			  FAN_ACCESS_PERM | FAN_OPEN_PERM,
>  			  AT_FDCWD, fname) < 0) {
> -		if (errno == EINVAL) {
> +		if (errno == EINVAL && support_perm_events &&
> +		    mark->flag == FAN_MARK_FILESYSTEM) {
> +			tst_res(TCONF,
> +				"FAN_MARK_FILESYSTEM not supported in kernel?");
> +			return -1;
> +		} else if (errno == EINVAL) {
>  			tst_brk(TCONF | TERRNO,
>  				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
>  				"configured in kernel?");
> @@ -155,9 +165,16 @@ static void setup_mark(unsigned int n)
>  				"AT_FDCWD, %s) failed.",
>  				fd_notify, mark->name, fname);
>  		}
> +	} else {
> +		/*
> +		 * To distigouish between perm event not supported and
> +		 * filesystem mark not supported.
> +		 */
> +		support_perm_events = 1;

I'm a bit puzzled here, so we attempted to cache if perm_events are
supported here?

I guess that we depend on the order of the tcases[] array here, which is
not very nice.

Also it does not have to be in else branch, if we get EINVAL the first
time we call fanotify_mark() tst_brk() is called, which exits the test,
so if we ever get to this point in the program, we did at least one
successful mark.

>  	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> +	return 0;
>  }
>  
>  static void test_fanotify(unsigned int n)
> @@ -165,7 +182,9 @@ static void test_fanotify(unsigned int n)
>  	int tst_count;
>  	int ret, len = 0, i = 0, test_num = 0;
>  
> -	setup_mark(n);
> +	if (setup_mark(n) != 0)
> +		return;
> +
>  	run_child();
>  
>  	tst_count = 0;
> -- 
> 2.17.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
