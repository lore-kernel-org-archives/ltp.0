From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 1 Sep 2021 16:23:15 +0200
Subject: [LTP] [PATCH v3 1/2] controllers/cpuacct: skip cpuacct_100_100
 on small memory systems
In-Reply-To: <YS99h3rPMLeSEFv5@yuki>
References: <20210827092007.20889-1-krzysztof.kozlowski@canonical.com>
 <YS99h3rPMLeSEFv5@yuki>
Message-ID: <440b0bcf-63b5-bb78-6a0b-565a5266d9da@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/09/2021 15:17, Cyril Hrubis wrote:
> Hi!
>> +check_free_memory()
>> +{
>> +	local memneeded
>> +	local memfree=`awk '/MemAvailable/ {print $2}' /proc/meminfo`
>> +
>> +	if [ $? -ne 0 ]; then
>> +		local memcached
>> +
>> +		memfree=`awk '/MemFree/ {print $2}' /proc/meminfo`
>> +		test $? -eq 0 || return 0
>> +
>> +		memcached=`awk '/MemCached/ {print $2}' /proc/meminfo`
>> +		test $? -eq 0 || return 0
>> +
>> +		memfree=$((memfree + memcached))
>> +	fi
>> +
>> +	# On x86_64, each 100 of processes were using ~16 MB of memory,
>> +	# so try to estimate the needed free memory based on this.
>> +	memneeded=$((max * nbprocess * 16384 / 100))
>> +
>> +	if [ $memfree -lt $memneeded ]; then
>> +		tst_brk TCONF "not enough of free memory on this system (approximate need $memneeded kB, free $memfree kB)"
>> +	fi
>> +	tst_res TINFO "memory requirements fulfilled (approximate need $memneeded kB, free $memfree kB)"
>> +
>> +	return 0
>> +}
>> +
>> +check_limits()
>> +{
>> +	local real_uid="$SUDO_UID"
>> +	local tasksneeded=$((max * nbprocess + 100))
>> +
>> +	if [ "$real_uid" = "" ]; then
>> +		real_uid=`id -u`
>> +		test $? -eq 0 || return 0
>> +	fi
>> +
>> +	local tasksmax=`systemctl show user-${real_uid}.slice | awk -F '=' '/TasksMax/ {print $2}'`
>> +	test $? -eq 0 || return 0
>> +
>> +	# Check for number for cases like TasksMax=infinity
>> +	[ -n "$tasksmax" ] && [ "$tasksmax" -eq "$tasksmax" ] 2>/dev/null
>> +	test $? -eq 0 || return 0
> 
> Well we do have a C implementation of this now, it would be better to
> have the logic in one place and just call the C function to collect the
> number of pids.
> 
> If we add tst_get_free_pids.c to the testcases/lib/ directory with:
> 
> #define TST_NO_DEFAULT_MAIN
> #include <stdio.h>
> #include <tst_test.h>
> 
> extern struct tst_test *tst_test;
> 
> static struct tst_test test = {
> };
> 
> int main(void)
> {
> 	/* force messages to be printed from new library */
>         tst_test = &test;
> 
>         printf("%i\n", tst_get_free_pids());
> 
>         return 0;
> }
> 
> We can do FREE_PIDS=$(tst_get_free_pids) here and then just compare the numbers.
> 

I'll move this piece, as you suggested. The free memory limits is okay
to stay here?


Best regards,
Krzysztof
