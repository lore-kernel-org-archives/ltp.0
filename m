From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 8 Oct 2020 21:33:54 +0800
Subject: [LTP] [PATCH] controllers/libcpuset.c: Add 'cpuset' prefix for
 cpuset files
In-Reply-To: <20200928061347.275858-1-yangx.jy@cn.fujitsu.com>
References: <20200928061347.275858-1-yangx.jy@cn.fujitsu.com>
Message-ID: <5F7F1542.4040900@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi?

Ping :-)
I think it is a simple fix.

Best Regards,
Xiao Yang
On 2020/9/28 14:13, Xiao Yang wrote:
> cpuset_cpusetofpid() in cpuset_cpu_hog.c cannot find cpuset files by
> wrong names(without 'cpuset' prefix) so cpuset_load_balance_test.sh
> reported the following error:
> ---------------------------------------
> cpuset_load_balance 1 TFAIL: load balance test failed.
> ---------------------------------------
>
> Use correct names(with 'cpuset' prefix) to find cpuset files.
>
> Fixes: #690
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  .../controllers/cpuset/cpuset_lib/libcpuset.c | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> index 172e23714..a687ad2ee 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> +++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
> @@ -2093,11 +2093,11 @@ int cpuset_query(struct cpuset *cp, const char *relpath)
>  
>  	fullpath(buf, sizeof(buf), relpath);
>  
> -	if (load_flag(buf, &cp->cpu_exclusive, "cpu_exclusive") < 0)
> +	if (load_flag(buf, &cp->cpu_exclusive, "cpuset.cpu_exclusive") < 0)
>  		goto err;
>  	cp->cpu_exclusive_valid = 1;
>  
> -	if (load_flag(buf, &cp->mem_exclusive, "mem_exclusive") < 0)
> +	if (load_flag(buf, &cp->mem_exclusive, "cpuset.mem_exclusive") < 0)
>  		goto err;
>  	cp->mem_exclusive_valid = 1;
>  
> @@ -2105,60 +2105,60 @@ int cpuset_query(struct cpuset *cp, const char *relpath)
>  		goto err;
>  	cp->notify_on_release_valid = 1;
>  
> -	if (exists_flag(buf, "memory_migrate")) {
> -		if (load_flag(buf, &cp->memory_migrate, "memory_migrate") < 0)
> +	if (exists_flag(buf, "cpuset.memory_migrate")) {
> +		if (load_flag(buf, &cp->memory_migrate, "cpuset.memory_migrate") < 0)
>  			goto err;
>  		cp->memory_migrate_valid = 1;
>  	}
>  
> -	if (exists_flag(buf, "mem_hardwall")) {
> -		if (load_flag(buf, &cp->mem_hardwall, "mem_hardwall") < 0)
> +	if (exists_flag(buf, "cpuset.mem_hardwall")) {
> +		if (load_flag(buf, &cp->mem_hardwall, "cpuset.mem_hardwall") < 0)
>  			goto err;
>  		cp->mem_hardwall_valid = 1;
>  	}
>  
> -	if (exists_flag(buf, "memory_pressure_enabled")) {
> +	if (exists_flag(buf, "cpuset.memory_pressure_enabled")) {
>  		if (load_flag
>  		    (buf, &cp->memory_pressure_enabled,
> -		     "memory_pressure_enabled") < 0)
> +		     "cpuset.memory_pressure_enabled") < 0)
>  			goto err;
>  		cp->memory_pressure_enabled_valid = 1;
>  	}
>  
> -	if (exists_flag(buf, "memory_spread_page")) {
> +	if (exists_flag(buf, "cpuset.memory_spread_page")) {
>  		if (load_flag
> -		    (buf, &cp->memory_spread_page, "memory_spread_page") < 0)
> +		    (buf, &cp->memory_spread_page, "cpuset.memory_spread_page") < 0)
>  			goto err;
>  		cp->memory_spread_page_valid = 1;
>  	}
>  
> -	if (exists_flag(buf, "memory_spread_slab")) {
> +	if (exists_flag(buf, "cpuset.memory_spread_slab")) {
>  		if (load_flag
> -		    (buf, &cp->memory_spread_slab, "memory_spread_slab") < 0)
> +		    (buf, &cp->memory_spread_slab, "cpuset.memory_spread_slab") < 0)
>  			goto err;
>  		cp->memory_spread_slab_valid = 1;
>  	}
>  
> -	if (exists_flag(buf, "sched_load_balance")) {
> +	if (exists_flag(buf, "cpuset.sched_load_balance")) {
>  		if (load_flag
> -		    (buf, &cp->sched_load_balance, "sched_load_balance") < 0)
> +		    (buf, &cp->sched_load_balance, "cpuset.sched_load_balance") < 0)
>  			goto err;
>  		cp->sched_load_balance_valid = 1;
>  	}
>  
> -	if (exists_flag(buf, "sched_relax_domain_level")) {
> +	if (exists_flag(buf, "cpuset.sched_relax_domain_level")) {
>  		if (load_number
>  		    (buf, &cp->sched_relax_domain_level,
> -		     "sched_relax_domain_level") < 0)
> +		     "cpuset.sched_relax_domain_level") < 0)
>  			goto err;
>  		cp->sched_relax_domain_level_valid = 1;
>  	}
>  
> -	if (load_mask(buf, &cp->cpus, cpuset_cpus_nbits(), "cpus") < 0)
> +	if (load_mask(buf, &cp->cpus, cpuset_cpus_nbits(), "cpuset.cpus") < 0)
>  		goto err;
>  	cp->cpus_valid = 1;
>  
> -	if (load_mask(buf, &cp->mems, cpuset_mems_nbits(), "mems") < 0)
> +	if (load_mask(buf, &cp->mems, cpuset_mems_nbits(), "cpuset.mems") < 0)
>  		goto err;
>  	cp->mems_valid = 1;
>  



