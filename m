From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Aug 2019 14:12:03 +0200
Subject: [LTP] [PATCH v2 1/2] clock_getres01: drop case which is passing
 NULL res parameter
In-Reply-To: <ee463189a82212a10c1ac06229dc0a418e18305b.1565361031.git.jstancek@redhat.com>
References: <ee463189a82212a10c1ac06229dc0a418e18305b.1565361031.git.jstancek@redhat.com>
Message-ID: <20190813121202.GB16005@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Since commit a9446a906f52 ("lib/vdso/32: Remove inconsistent NULL pointer checks")
> VDSO treats NULL parameter differently than in syscall.
> 
> Drop NULL parameter, subsequent patch will add test variants that test NULL
> res parameter using syscall.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/clock_getres/clock_getres01.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> index 15f32310839a..df3e84271ad9 100644
> --- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> +++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> @@ -28,7 +28,6 @@ static struct test_case {
>  	{"MONOTONIC", CLOCK_MONOTONIC, &res, 0, 0},
>  	{"PROCESS_CPUTIME_ID", CLOCK_PROCESS_CPUTIME_ID, &res, 0, 0},
>  	{"THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID, &res, 0, 0},
> -	{"REALTIME", CLOCK_REALTIME, NULL, 0, 0},

Shouldn't we keep the REALTIME clock here and pass the &res here
instead?

>  	{"CLOCK_MONOTONIC_RAW", CLOCK_MONOTONIC_RAW, &res, 0, 0,},
>  	{"CLOCK_REALTIME_COARSE", CLOCK_REALTIME_COARSE, &res, 0, 0,},
>  	{"CLOCK_MONOTONIC_COARSE", CLOCK_MONOTONIC_COARSE, &res, 0, 0,},
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
