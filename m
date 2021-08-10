From: Jan Kara <jack@suse.cz>
Date: Tue, 10 Aug 2021 11:01:57 +0200
Subject: [LTP] [PATCH v4] ucounts: add missing data type changes
In-Reply-To: <8735rijqlv.fsf_-_@disp2133>
References: <20210730062854.3601635-1-svens@linux.ibm.com>
 <YQn+GomdRCoYc/E8@Ryzen-9-3900X.localdomain>
 <875ywlat5e.fsf@disp2133>
 <94478003-8259-4b57-6d93-5a07e0750946@kernel.org>
 <87v94jalck.fsf@disp2133>
 <56b7c0fe-f2e1-7c4f-eb1b-1d9793dea5a8@kernel.org>
 <CA+G9fYv+Azmu+_YUv6+C6RRM990k0FhUc0hgSJKssubmsWfvhA@mail.gmail.com>
 <8735rijqlv.fsf_-_@disp2133>
Message-ID: <20210810090157.GA18722@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon 09-08-21 15:43:56, Eric W. Biederman wrote:
> 
> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
> changed the data type of ucounts/ucounts_max to long, but missed to
> adjust a few other places. This is noticeable on big endian platforms
> from user space because the /proc/sys/user/max_*_names files all
> contain 0.
> 
> v4 - Made the min and max constants long so the sysctl values
>      are actually settable on little endian machines.
>      -- EWB
> 
> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Alexey Gladkov <legion@kernel.org>
> v1: https://lkml.kernel.org/r/20210721115800.910778-1-svens@linux.ibm.com
> v2: https://lkml.kernel.org/r/20210721125233.1041429-1-svens@linux.ibm.com
> v3: https://lkml.kernel.org/r/20210730062854.3601635-1-svens@linux.ibm.com
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Thanks everyone for testing and helping find the cause of this bug.  I
> will push this out to linux-next shortly.
> 
>  fs/notify/fanotify/fanotify_user.c | 17 +++++++++++------
>  fs/notify/inotify/inotify_user.c   | 17 +++++++++++------
>  kernel/ucount.c                    | 19 +++++++++++--------
>  3 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 64864fb40b40..28b67cb9458d 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -54,22 +54,27 @@ static int fanotify_max_queued_events __read_mostly;
>  
>  #include <linux/sysctl.h>
>  
> +static long ft_zero = 0;
> +static long ft_int_max = INT_MAX;
> +
>  struct ctl_table fanotify_table[] = {
>  	{
>  		.procname	= "max_user_groups",
>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(long),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> +		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &ft_zero,
> +		.extra2		= &ft_int_max,
>  	},
>  	{
>  		.procname	= "max_user_marks",
>  		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(long),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> +		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &ft_zero,
> +		.extra2		= &ft_int_max,
>  	},
>  	{
>  		.procname	= "max_queued_events",
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 98f61b31745a..62051247f6d2 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -55,22 +55,27 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
>  
>  #include <linux/sysctl.h>
>  
> +static long it_zero = 0;
> +static long it_int_max = INT_MAX;
> +
>  struct ctl_table inotify_table[] = {
>  	{
>  		.procname	= "max_user_instances",
>  		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(long),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> +		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &it_zero,
> +		.extra2		= &it_int_max,
>  	},
>  	{
>  		.procname	= "max_user_watches",
>  		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(long),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> +		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &it_zero,
> +		.extra2		= &it_int_max,
>  	},
>  	{
>  		.procname	= "max_queued_events",
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 77be3bbe3cc4..bb51849e6375 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -58,14 +58,17 @@ static struct ctl_table_root set_root = {
>  	.permissions = set_permissions,
>  };
>  
> -#define UCOUNT_ENTRY(name)				\
> -	{						\
> -		.procname	= name,			\
> -		.maxlen		= sizeof(int),		\
> -		.mode		= 0644,			\
> -		.proc_handler	= proc_dointvec_minmax,	\
> -		.extra1		= SYSCTL_ZERO,		\
> -		.extra2		= SYSCTL_INT_MAX,	\
> +static long ue_zero = 0;
> +static long ue_int_max = INT_MAX;
> +
> +#define UCOUNT_ENTRY(name)					\
> +	{							\
> +		.procname	= name,				\
> +		.maxlen		= sizeof(long),			\
> +		.mode		= 0644,				\
> +		.proc_handler	= proc_doulongvec_minmax,	\
> +		.extra1		= &ue_zero,			\
> +		.extra2		= &ue_int_max,			\
>  	}
>  static struct ctl_table user_table[] = {
>  	UCOUNT_ENTRY("max_user_namespaces"),
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
