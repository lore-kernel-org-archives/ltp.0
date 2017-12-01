From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri, 01 Dec 2017 16:00:22 +0000
Subject: [LTP] [PATCH v2 12/13] hotplug/cpu_hotplug: Repopulate
	cgroup:cpusets after testing hotplug
In-Reply-To: <20171130135815.GD2924@rei> (Cyril Hrubis's message of "Thu, 30
 Nov 2017 14:58:15 +0100")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-13-punit.agrawal@arm.com>
 <20171130135815.GD2924@rei>
Message-ID: <87wp26xwtl.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> LTP tests that online CPUs must test for the legacy cgroup hierarchy and
>> update the cpusets for all users/sessions. Add this code the
>> cpu_online() helper.
>
> I'm not sure if we want to work around kernel/systemd bugs like this,
> but even if we do we probably want to inform user about the bug.  Maybe
> we should just check if the cpus are disabled after the test, if so,
> restore them and fail the test.

It turns out that the problem behaviour is specific to the filesystem
(Ubuntu 14.04).

On a recent debian filesystem I tested with, systemd doesn't even seem
to use cpusets by default. I imagine other distros make similarly
different choices. :)

If anybody faces the same (or similar) problem with reduced performance
after runnnig ltp, they can find their way to this commit now that it's
on the list (and you're aware of the problem).

I am going to drop this patch from the next version.

Thanks,
Punit

>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
>>  .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 36 ++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>> 
>> diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
>> index 9f856e554..35ec7c86b 100644
>> --- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
>> +++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
>> @@ -58,6 +58,39 @@ set_affinity()
>>      return $?
>>  }
>>  
>> +# repopulate_cpusets()
>> +#
>> +# If the legacy cgroup hierarchy is in use, and cpuset is mounted, copy
>> +# the permitted cpus from the root group, which always has all available
>> +# cpus and memory, into the other hierarchy nodes. This prevents hotplug
>> +# tests from losing CPUs, and affecting the results of later tests.
>> +#
>> +CPUSET="/sys/fs/cgroup/cpuset"
>> +repopulate_cpusets()
>> +{
>> +	# Only if we have cpusets
>> +	if [ ! -d ${CPUSET} ] ; then
>> +		return;
>> +	fi
>> +
>> +	# And then only legacy cpusets
>> +	if grep --quiet "/sys/fs/cgroup/cpuset[ ]*cgroup2" /proc/mounts ; then
>> +		return;
>> +	fi
>> +
>> +	# Copy root cpus into system and user slices
>> +	cat ${CPUSET}/cpuset.cpus > ${CPUSET}/system.slice/cpuset.cpus
>> +	cat ${CPUSET}/cpuset.cpus > ${CPUSET}/user.slice/cpuset.cpus
>
> This will fail on distros that do not use systemd, we should check first
> if system.slice and user.slice directories are present.
>
>> +	# Fix each session of each user
>> +	for TUSER in ${CPUSET}/user.slice/user-*.slice ; do
>> +		cat ${CPUSET}/cpuset.cpus > ${TUSER}/cpuset.cpus
>> +		for SESSION in ${TUSER}/session-*.scope; do
>> +			cat ${CPUSET}/cpuset.cpus > ${SESSION}/cpuset.cpus
>> +		done
>> +	done
>> +
>> +}
>> +
>>  # online_cpu(CPU)
>>  #
>>  #  Onlines the given CPU.  Returns a true value if it was able
>> @@ -77,6 +110,9 @@ online_cpu()
>>  
>>      $TIME echo 1 > /sys/devices/system/cpu/cpu${CPU}/online
>>      RC=$?
>> +
>> +    repopulate_cpusets
>> +
>>      report_timing "Online cpu ${CPU}"
>>      return $RC
>>  }
>> -- 
>> 2.14.2
>> 
