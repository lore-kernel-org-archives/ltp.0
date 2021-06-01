From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Jun 2021 13:08:18 +0200
Subject: [LTP] [PATCH 2/2] tst_wallclock_restore: fix access time of
 /etc/localtime
In-Reply-To: <20210601093614.245873-2-egorenar@linux.ibm.com>
References: <20210601093614.245873-1-egorenar@linux.ibm.com>
 <20210601093614.245873-2-egorenar@linux.ibm.com>
Message-ID: <YLYVIvTBYsdE6Gzh@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  lib/tst_wallclock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
> index 838dde8b3..37d3005ef 100644
> --- a/lib/tst_wallclock.c
> +++ b/lib/tst_wallclock.c
> @@ -60,6 +60,8 @@ void tst_wallclock_restore(void)
>  
>  	if (tst_clock_settime(CLOCK_REALTIME, &adjust))
>  		tst_brk(TBROK | TERRNO, "tst_clock_settime() realtime failed");
> +
> +	SAFE_TOUCH("/etc/localtime", 0, NULL);

I would prefer not to break the test here if the file is not present on
a system, there may be embedded systems where this file does not exists
and SAFE_TOUCH() will exit the test with TBROK in that case.

Also the problem is access time here, so opening and closing the file
should be enough to fix it right?

What about something as:

	int fd = open("/etc/localtime", O_RDWR);
	if (fd > 0)
		SAFE_CLOSE(fd);

That should fix the access time without breaking the test on systems
that does not have the /etc/localtime file installed.

>  }
>  
>  void tst_rtc_clock_save(const char *rtc_dev)
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
