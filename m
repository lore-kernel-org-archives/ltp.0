From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jan 2021 16:17:11 +0100
Subject: [LTP] [PATCH] cpuset_inherit: Use the original mem value
 instead of N_NODES
In-Reply-To: <5FFD7D76.6070301@cn.fujitsu.com>
References: <1606701966-1596-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <X/hdjNT81M9CxbaD@yuki.lan> <5FFC14A6.3030408@cn.fujitsu.com>
 <5FFD7D76.6070301@cn.fujitsu.com>
Message-ID: <X/29dySZb8kL5Nms@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When I look these cpuset cases(cpuset_base_ops_test, 
> cpuset_hierarchy_test, cpuset_inherit_test...), these cases seems all 
> not consider the situation(cpus/memory are not numbered continously). If 
> we want to modify them to be situable for not numbered continously, it 
> will be complexd(especially cpuset_base_ops_test).

Thats why I said that these tests would need to be rewritten ideally
from a scratch. I guess that it would be easier to work with bitfields
in C as well.

> AFAIK, I rarely see not numbered continously for memory node. IMO, we
> just check whether memory/cpu numbered continously, if not, we just
> report TCONF and remind user to change their system to meet
> environment, so their system can be fully tested.

That would be better than unexpected failure at least.

> For cpu, maybe we can use the following script to detect
> 
> cpu_string="`cat /sys/devices/system/cpu/online`"
> offline_string="`cat /sys/devices/system/cpu/online`"
> NR_CPUS=`tst_ncpus`
> ALL_CPUS=`tst_ncpus_conf`
> if [ $NR_CPUS -eq $ALL_CPUS ]; then
>         tst_resm TINFO "All($ALL_CPUS) logical cpus on your environment"
> else
>        tst_brkm TCONF "Not all logical cpus on, online($cpu_string),offline($offline_string)"
> fi
> 
> I wonder if it's worth changing the stable cpuset/memory cases for these 
> rared situation(memory/cpu are not numbered continously).

It would allow us to offline CPUs in the middle of the test and checking
that offlined CPUs can no longer be added into the mask, which is
something we cannot test at the moment.

> What do you think about it?

To be honest I'm not sure if ncpus == ncpus_conf means that the cpu
numbering is continous.

I guess that the safest bet would be actually parsing the
/sys/devices/system/cpu/online instead. I.e. check that the file is in a
format 0-$(UINT), since that is what the testcases do expect, right?

> +#select the first one or two online cpu
> +select_online_cpus()
> +{
> +	ncpus_check ${1:-2}
> +	local cpus_array="$(seq -s' ' 0 $((ALL_CPUS-1)))"
> +	local cpuid=
> +	local iter=0
> +	for cpuid in $cpus_array
> +	do
> +		local file="/sys/devices/system/cpu/cpu$cpuid/online"
> +		local online="$(cat $file)"
> +		if [ $online -eq 1 ]; then
> +			iter=`expr $iter + 1`
> +			if [ $iter -eq 1 ]; then
> +				F_ONELINE_CPU=$cpu_id
> +			elif [ $iter -eq 2 ]; then
> +				S_ONLINE_CPU=$cpu_id
> +			else
> +				break
> +			fi
> +		fi
> +        done
> +}

Bitfields are akward in shell. So if I was writing these tests I would
write a function to parse the sysfs file into a cpuset bitfield and
second function to write the bitfield into a sysfs file. And after that
we would do all the operations on cpuset bitfields instead.

That way we can, for instance, get any subset of online CPUs easily,
since that is just one loop over the cpuset bitfield.

e.g. to get a subset with half of the online CPUs we would do:

	int flag = 0, i;

	for (i = 0; i < setsize; i++) {
		if (CPU_ISSET_S(i, setsize, inset)) {
			if (flag)
				GPU_SET_S(i, setsize, outset);

			flag = !flag;
		}
	}

We can probably reuse the code kernel uses to parse and print these, the
code to print a bitmap seems to be in bitmap_list_string() in
lib/vsprintf.c, the parsing seems to be implemented in
bitmap_parselist_user() in the lib/bitmap.c.

-- 
Cyril Hrubis
chrubis@suse.cz
