From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 28 Mar 2017 14:46:26 +0800
Subject: [LTP] [PATCH] commands/keyctl01: Add new regression test
In-Reply-To: <20170327134232.GA21272@rei.lan>
References: <1489576439-15122-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170327134232.GA21272@rei.lan>
Message-ID: <58DA06C2.6050703@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Thanks for your review.

On 03/27/2017 09:42 PM, Cyril Hrubis wrote:
> Hi!
>> +	ORIG_KEYSZ=`grep -w "0:" $PATH_KEYSTAT | awk '{print $5}' | \
>> +		cut -d '/' -f1`
> 
> This looks too complicated for what it does, we can probably simplify
> this by something as:
> 
> awk -F' +|/' '/0:/ {print $9}' /proc/key-users
>       ^        ^     ^
>       |        |     This prints last number in the line
>       |        This matches lines that contain 0:
>       This sets field separator to any sequence of spaces or single /
> 

This is way much better than mine, thanks very much!


awk -F' +|/' '/ 0:/ {print $8}' /proc/key-users
               ^            ^
               |            Sorry, but here should be $8 I suppose
               And here needs a space, to distinguish something like:

    0:     6 5/5 3/200 115/20000
  100:     3 3/3 3/200 84/20000

> 
>> +	ORIG_MAXKEYSZ=`cat $PATH_KEYQUOTA`
>> +}
>> +
>> +cleanup()
>> +{
>> +	if [ -n "$ORIG_MAXKEYSZ" ]; then
>> +		echo $ORIG_MAXKEYSZ >$PATH_KEYQUOTA
>> +	fi
>> +}
>> +
>> +do_test()
>> +{
>> +	local maxkeysz=$((ORIG_KEYSZ + 100))
>> +
>> +	while true
>> +	do
>> +		echo $maxkeysz >$PATH_KEYQUOTA
>> +
>> +		keyctl request2 user debug:fred negate @t >temp 2>&1
>> +		grep -q -E "quota exceeded" temp
>> +		if [ $? -eq 0 ]; then
>> +			break
>> +		fi
>> +
>> +		local key=`keyctl show | grep -w "debug:fred" | \
>> +			awk '{print $1}'`
> 
> Here as well, simple awk '/debug:fred/ {print $1}' should do.
> 

OK, thanks.

>> +		if [ -n "$key" ]; then
>> +			keyctl unlink $key @s >/dev/null
>> +			tst_sleep 100ms
> 
> Is this sleep here necessary? For how much time the test takes?

Yes, it is necessary, without the sleep, this test fails to
reproduce the bug on RHEL7.2GA(buggy kernel), since I found
that it actually takes some time to free the key.


With 100ms sleep, the whole test takes about 2s.


Best Regards,
Guangwen Feng

> 
>> +		fi
>> +
>> +		((maxkeysz -= 4))
>> +	done
>> +
>> +	tst_res TPASS "Bug not reproduced"
>> +}
>> +
>> +tst_run
>> -- 
>> 1.8.4.2
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


