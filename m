From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Mar 2019 12:58:45 +0100
Subject: [LTP] [PATCH] controllers/cpuset: add cpuset files check for
 different OS
In-Reply-To: <1545987769-32388-1-git-send-email-lijinyue@huawei.com>
References: <1545987769-32388-1-git-send-email-lijinyue@huawei.com>
Message-ID: <20190313115844.GB2606@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> While mounting cpuset cgroup, the subsystem directory entries
> differ in different OS release.
> eg, cpuset.cpus file on Ubuntu and cpus on some other release.
Which ones, please? I'm not aware of anyone.

> So we add cpuset files checker to make sure the test work well
> on all OS release.

...
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
...
> +cpus_file=
> +cpu_exclusive_file=
> +mems_file=
> +memory_pressure_file=
> +memory_pressure_enabled_file=
> +mem_exclusive_file=
> +mem_hardwall_file=
> +memory_migrate_file=
> +memory_spread_page_file=
> +memory_spread_slab_file=
> +sched_load_balance_file=
> +sched_relax_domain_level_file=
Maybe move the ones in $CPUSET/cpuset.cpus clause here as the default ones
and move those from else clause into setup.

...
> +# check cpuset cgroup files for different OS
> +cpuset_files_check()
> +{
> +	setup
I guess this should be vice versa, i.e. cpuset_files_check() be part of setup()
And then not needed to be added into all functions using cpuset_funcs.sh
> +
> +	if [ -f "$CPUSET/cpuset.cpus" ]; then
> +		cpus_file="cpuset.cpus"
> +		cpu_exclusive_file="cpuset.cpu_exclusive"
> +		mems_file="cpuset.mems"
> +		memory_pressure_file="cpuset.memory_pressure"
> +		memory_pressure_enabled_file="cpuset.memory_pressure_enabled"
> +		mem_exclusive_file="cpuset.mem_exclusive"
> +		mem_hardwall_file="cpuset.mem_hardwall"
> +		memory_migrate_file="cpuset.memory_migrate"
> +		memory_spread_page_file="cpuset.memory_spread_page"
> +		memory_spread_slab_file="cpuset.memory_spread_slab"
> +		sched_load_balance_file="cpuset.sched_load_balance"
> +		sched_relax_domain_level_file="cpuset.sched_relax_domain_level"
> +	else
> +		cpus_file="cpus"
> +		cpu_exclusive_file="cpu_exclusive"
> +		mems_file="mems"
> +		memory_pressure_file="memory_pressure"
> +		memory_pressure_enabled_file="memory_pressure_enabled"
> +		mem_exclusive_file="mem_exclusive"
> +		mem_hardwall_file="mem_hardwall"
> +		memory_migrate_file="memory_migrate"
> +		memory_spread_page_file="memory_spread_page"
> +		memory_spread_slab_file="memory_spread_slab"
> +		sched_load_balance_file="sched_load_balance"
> +		sched_relax_domain_level_file="sched_relax_domain_level"
> +
> +	fi
> +
> +	cleanup
> +}


Kind regards,
Petr
