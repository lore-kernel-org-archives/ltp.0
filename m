From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 16 Jun 2021 09:28:59 +0200
Subject: [LTP] [PATCH v2 1/2] controllers/cpuacct: skip cpuacct_100_100
 on small memory systems
In-Reply-To: <ae81aa2b-da04-4ec5-aee9-4db1e511fdbf@canonical.com>
References: <20210614161413.82389-1-krzysztof.kozlowski@canonical.com>
 <YMjYBoqTw9RSqYqH@yuki> <ae81aa2b-da04-4ec5-aee9-4db1e511fdbf@canonical.com>
Message-ID: <893b4dd3-7dae-e4c3-3d5a-a6c467a179c8@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16/06/2021 09:27, Krzysztof Kozlowski wrote:
> On 15/06/2021 18:40, Cyril Hrubis wrote:
>> Hi!
>>> +check_free_memory()
>>> +{
>>> +	local memneeded
>>> +	local memfree=`awk '/MemAvailable/ {print $2}' /proc/meminfo`
>>> +
>>> +	if [ $? -ne 0 ]; then
>>> +		local memcached
>>> +
>>> +		memfree=`awk '/MemFree/ {print $2}' /proc/meminfo`
>>> +		test $? || return 0
>>> +
>>> +		memcached=`awk '/MemCached/ {print $2}' /proc/meminfo`
>>> +		test $? || return 0
>>
>> I do not think that something as basic as awk on /proc/meminfo here will
>> fail...
> 
> It's still nice pattern to check for return values but if you insist, I
> can drop it.
> 
>>
>>> +		memfree=$((memfree + memcached))
>>> +	fi
>>> +
>>> +	# On x86_64, each 100 of processes were using ~16 MB of memory,
>>> +	# so try to estimate the needed free memory based on this.
>>> +	memneeded=$((max * nbprocess * 16384 / 100))
>>> +
>>> +	if [ $memfree -lt $memneeded ]; then
>>
>> I would still add some memory margin to the memneeded here. At least
>> add a hundred of megabytes before we do the check.
> 
> Sure.
> 
>>
>>> +		tst_brk TCONF "not enough of free memory on this system (approximate need $memneeded kB, free $memfree kB)"
>>> +	fi
>>> +	tst_res TINFO "memory requirements fulfilled (approximate need $memneeded kB, free $memfree kB)"
>>> +
>>> +	return 0
>>> +}
>>> +
>>> +check_limits()
>>> +{
>>> +	local realuid="$SUDO_UID"
>>> +	local tasksneeded=$((max * nbprocess + 100))
>>> +
>>> +	if [ "$realuid" = "" ]; then
>>> +		realuid=`id -u`
>>> +		test $? || return 0
>>> +	fi
>>> +
>>> +	local tasksmax=`systemctl show user-${real_uid}.slice | awk -F '=' '/TasksMax/ {print $2}'`
>>> +	test $? || return 0
>>> +
>>> +	if [ $tasksmax -le $tasksneeded ]; then
>>> +		tst_brk TCONF "limit of tasks is too low (approximate need $tasksneeded, limit $tasksmax)"
>>> +	fi
>>> +	tst_res TINFO "task limit fulfilled (approximate need $tasksneeded, limit $tasksmax)"
>>
>> Huh, is this really needed? The test is supposed to run under root. The
>> user is supposed to login as a root or at least do 'su -' before
>> executing LTP anyways.
> 
> Yeah, because even root sessions (user-0.slice) have the PID limit set
> by systemd.
> 
> $ ssh root@....
> $ grep . /sys/fs/cgroup/pids/user.slice/*/*
> /sys/fs/cgroup/pids/user.slice/user-0.slice/cgroup.clone_children:0
> /sys/fs/cgroup/pids/user.slice/user-0.slice/notify_on_release:0
> /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.current:5
> /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.events:max 0
> /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max:5207

I forgot to mention: that's a default Ubuntu 20.04 LTS system on 2 GB
RAM machine, with systemd 245.4-4ubuntu3.6.


Best regards,
Krzysztof
