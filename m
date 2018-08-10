From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 10 Aug 2018 16:10:04 +0200
Subject: [LTP] [PATCH] fs: exclude 'wakeup_count' from read_all_sys test.
In-Reply-To: <20180803152018.13701-1-sspatil@google.com>
References: <20180803152018.13701-1-sspatil@google.com>
Message-ID: <87sh3m48jn.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Sandeep Patil <sspatil@google.com> writes:

> /sys/power/wakeup_count semantics state that the read() for the file
> will block as long as there is a wakeup_event in progress. On most
> systems, this will be non deterministic and will result in extremely
> flaky test. Exclude the file from read_all_sys test for the same.
>
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
>  runtest/fs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/runtest/fs b/runtest/fs
> index a66948a43..aca7e355f 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -71,7 +71,7 @@ proc01 proc01 -m 128
>  
>  read_all_dev read_all -d /dev -p -q -r 10
>  read_all_proc read_all -d /proc -q -r 10
> -read_all_sys read_all -d /sys -q -r 10
> +read_all_sys read_all -d /sys -q -r 10 -e /sys/power/wakeup_count
>  

This probably won't be the only file with semantics like these. So I am
wondering if we can limit the time it spends blocking with timer_create
and SIGEV_THREAD_ID or something similar?

-- 
Thank you,
Richard.
