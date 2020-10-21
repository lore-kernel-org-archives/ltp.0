From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 21 Oct 2020 12:18:56 +0300
Subject: [LTP] [PATCH 1/5] lib/tst_net: add generic tst_netload_compare()
In-Reply-To: <20201020135210.GA23197@dell5510>
References: <20201015122056.20715-1-alexey.kodanev@oracle.com>
 <20201020135210.GA23197@dell5510>
Message-ID: <eeae2689-153e-3a0b-8bf9-be606683c6d7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20.10.2020 16:52, Petr Vorel wrote:
> Hi Alexey,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>> * Remove duplicate code for comparing time-based results in
>>   network tests (bbr, busy_poll, sctp, tcp fastopen, virt tests)
> 
>> * Expand thresholds for sctp, bbr test-cases, in order to avoid
>>   false-positive failures.
> I'm ok to keep more changes in single commit, but this change is affecting the
> result, thus maybe put into separate commit?
> (easier if somebody wants to bisect).
> 
Hi Petr,

Sure, will move it to the new one.


>> * In virt_lib.sh, keep sign for VIRT_PERF_THRESHOLD.
> 
>> * TWARN when the base result is too bad (threshold_hi arg is set)
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>>  testcases/lib/tst_net.sh                      | 31 +++++++++++++++++++
>>  testcases/network/busy_poll/busy_poll01.sh    | 10 ++----
>>  testcases/network/busy_poll/busy_poll02.sh    |  8 +----
>>  testcases/network/busy_poll/busy_poll03.sh    |  8 +----
>>  testcases/network/dccp/dccp01.sh              | 15 ++-------
>>  testcases/network/sctp/sctp01.sh              |  8 +----
>>  testcases/network/tcp_cc/bbr01.sh             |  2 +-
>>  testcases/network/tcp_cc/bbr02.sh             |  2 +-
>>  testcases/network/tcp_cc/dctcp01.sh           |  2 +-
>>  testcases/network/tcp_cc/tcp_cc_lib.sh        |  8 +----
>>  .../network/tcp_fastopen/tcp_fastopen_run.sh  | 15 ++-------
>>  testcases/network/virt/virt_lib.sh            | 21 ++-----------
>>  12 files changed, 46 insertions(+), 84 deletions(-)
> 
>> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
>> index d939a5780..b29e076c3 100644
>> --- a/testcases/lib/tst_net.sh
>> +++ b/testcases/lib/tst_net.sh
>> @@ -741,6 +741,37 @@ tst_netload()
>>  	return $ret
>>  }
> 
>> +# Compares results for netload runs.
>> +# tst_netload_compare TIME_BASE TIME THRESHOLD_LOW [THRESHOLD_HI]
>> +# TIME_BASE: time taken to run netstress load test - 100%
>> +# TIME: time that is compared to the base one
>> +# THRESHOD_LOW: lower limit for TFAIL
>> +# THRESHOD_HIGH: upper limit for TWARN
>> +tst_netload_compare()
>> +{
>> +	local base_time=$1
>> +	local new_time=$2
>> +	local threshold_low=$3
>> +	local threshold_hi=$4
>> +
>> +	if [ -z "$base_time" -o -z "$new_time" -o -z "$threshold_low" ]; then
>> +		tst_brk_ TBROK "tst_netload_compare: invalid argument(s)"
>> +	fi
>> +
>> +	local res=$(((base_time - new_time) * 100 / base_time))
>> +	local msg="performance result is ${res}%"
>> +
>> +	if [ "$res" -lt "$threshold_low" ]; then
>> +		tst_res_ TFAIL "$msg < threshold ${threshold_low}%"
>> +		return
>> +	fi
>> +
>> +	[ "$threshold_hi" ] && [ "$res" -gt "$threshold_hi" ] && \
>> +		tst_res_ TWARN "$msg > threshold ${threshold_hi}%"
>> +
>> +	tst_res_ TPASS "$msg, in range [${threshold_low}:${threshold_hi:-}]%"
> 
> Do you mean ${threshold_hi:--} (to print "-" when $threshold_hi not set?)
> As ${threshold_hi:-} prints empty string when unset (equivalent of ${threshold_hi}).
> 
> 

Yes, it's not really needed anymore. At some point I tried
to use different placeholders, a white-space etc... but it
fine as it is now, so will change to a simpler form.


>> +}
> 
> ...
> 
> Kind regards,
> Petr
> 

