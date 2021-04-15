From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 15 Apr 2021 11:06:49 +0200
Subject: [LTP] [PATCH 2/2] pec: Fix multiple event test
In-Reply-To: <YGIf3JSsFHn/gwKJ@pevik>
References: <20210315092844.991073-1-lkml@jv-coder.de>
 <20210315092844.991073-2-lkml@jv-coder.de> <YGIf3JSsFHn/gwKJ@pevik>
Message-ID: <8f7b161a-486a-edc2-11de-32d5d6fac825@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I will send a v2, but want to comment on some of your remarks first:

On 3/29/2021 8:43 PM, Petr Vorel wrote:
>> +	while read -r exp; do
>> +		local found=0
>> +		act_nevents=$((act_nevents + 1))
>> +		while read -r <&${fd_act} act; do
> <& is a bashism. Isn't it using just stdin enough?
Actually no, and I don't even think this is a bashism. I guess it is a 
bug in the checkbashisms script.
[n]<&m means copy file descriptor m to n when executing the command. See 
[1].
My theory of a bug is even more supported by the fact, that 
checkbashisms suggests to replace
"<&$var" with ">word 2>&1". so "<&$var" obviously triggered the 
"&>word"-rule.

This is required here, because $fd_act is a file handle to the actual 
received events, that is supposed
to be iterated only once, while the expected events are iterated over in 
the outer loop.
This construct allows "actual" to contain more events, than expected. 
But all expected events must be
in the correct order in actual.

In v2 I reordered the code a bit (while read....; do ....; done <&$fd). 
This still triggers checkbashims, but
it this works@least in bash, ash, dash, and busybox sh.

> 		while read -r < $fd_act act; do
>> +			if [ "$exp" = "$act" ]; then
>> +				found=1
>> +				break
>> +			fi
>> +		done
>> +		if [ $found -ne 1 ]; then
>> +			failed=1
>> +			tst_res TFAIL "Event was not detected by the event listener: $exp"
>> +			break
>> +		fi
>> +	done <gen_$event.log
>> +
>> +	eval "exec ${fd_act}<&-"
>> +
>> +	if [ $failed -eq 0 ]; then
>> +		if [ $act_nevents -ne $num_events ]; then
>> +			tst_res TBROK "Expected $num_events, but $act_nevents generated"
>> +		else
>> +			tst_res TPASS "All events detected"
>> +		fi
>>   	else
>> -		tst_res TFAIL "$event not detected by listener"
>> +		cat lis_$event.log
> Why removing tst_res TFAIL?
> If "cat lis_$event.log" needed, why not having it in previous commit?
I moved this up into the loop, to be able to output the expected event, 
that was not detected.
The output of the actual events is for debugging. It is not strictly 
required,
but could simplify identifying why an event is missing. Feel free to 
remove this in v2 ;)

I hope I fixed everything else.

J?rg

[1] 
https://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html#tag_02_07_05
