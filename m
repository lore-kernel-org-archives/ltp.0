From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 May 2021 13:30:54 +0200
Subject: [LTP] [PATCH 4/6] API/cgroups: Add cpu controller
In-Reply-To: <20210513152125.25766-5-rpalethorpe@suse.com>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
 <20210513152125.25766-5-rpalethorpe@suse.com>
Message-ID: <YKT27nlItfECLuYw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/tst_cgroup.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 54636fd7e..da177a1ad 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -82,7 +82,8 @@ struct cgroup_root {
>  /* Controller sub-systems */
>  enum cgroup_ctrl_indx {
>  	CTRL_MEMORY = 1,
> -	CTRL_CPUSET = 2,
> +	CTRL_CPU,
> +	CTRL_CPUSET,
>  };
>  #define CTRLS_MAX CTRL_CPUSET
>  
> @@ -162,6 +163,18 @@ static const files_t memory_ctrl_files = {
>  	{ }
>  };
>  
> +static const files_t cpu_ctrl_files = {
> +	/* The V1 quota and period files were combined in the V2 max
> +	 * file. The quota is in the first column and if we just print
> +	 * a single value to the file, it will be treated as the
> +	 * quota. To get or set the period we need to branch on the
> +	 * API version.
> +	 */

I wonder if this is worth a helper function, something as:

#define SAFE_CGROUP_CPU_SET_MAX(cg, quota_us, period_us) \
	tst_cgroup_cpu_set_max(__FILE__, __LINENO__, cg, quota_us, period_us)

void tst_cgroup_cpu_set_max(const char *const file, const int lineno,
                            const struct tst_cgroup_group *const cg,
                            unsigned int quota_us, unsigned int period_us);

#define SAFE_CGROUP_CPU_GET_MAX(cg, quota_us, period_us) \
	tst_cgroup_cpu_get_max(__FILE__, __LINENO__, cg, quota_us, period_us)

void tst_cgroup_cpu_get_max(const char *const file, const int lineno,
                            const struct tst_cgroup_group *const cg,
                            unsigned int *quota_us, unsigned int *period_us);

I guess that if we are going to add more tests we would end up with such
functions somewhere anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
