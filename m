From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 12 Feb 2020 08:32:07 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/kill11: add a check between hard limit
 and MIN_RLIMIT_CORE
In-Reply-To: <1581486286-13615-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1581486286-13615-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1892366945.7197852.1581514327491.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Currently, running this case will report EINVAL error if I run "ulimit -c
> 1023" command firstly. From setrlimit(2)manpage, it got EINVAL error because
> rlim->rlim_cur was greater than rlim->rlim_max. So add a check for it before
> setrlimit.
> 
> Reported-by: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/kill/kill11.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/kill/kill11.c
> b/testcases/kernel/syscalls/kill/kill11.c
> index 83fba5beb..5f70b0a07 100644
> --- a/testcases/kernel/syscalls/kill/kill11.c
> +++ b/testcases/kernel/syscalls/kill/kill11.c
> @@ -201,6 +201,9 @@ void setup(void)
>  
>  	SAFE_GETRLIMIT(NULL, RLIMIT_CORE, &rlim);
>  
> +	if (rlim.rlim_max < MIN_RLIMIT_CORE)
> +		tst_brkm(TCONF, NULL, "hard limit(%lu)less than MIN_RLIMT_CORE(%i)",
> +				rlim.rlim_max, MIN_RLIMIT_CORE);

This looks OK, but could we also raise the limit when possible?


+       if (rlim.rlim_max < MIN_RLIMIT_CORE) {
+               if (geteuid() != 0) {
+                       tst_brkm(TCONF, NULL, "hard limit(%lu)less than MIN_RLIMT_CORE(%i)",
+                               rlim.rlim_max, MIN_RLIMIT_CORE);
+               }
+               tst_resm(TINFO, "Raising rlim_max to %i", MIN_RLIMIT_CORE);
+               rlim.rlim_max = MIN_RLIMIT_CORE;
+       }

