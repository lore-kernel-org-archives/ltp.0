From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 10 Nov 2016 13:07:39 +0300
Subject: [LTP] [PATCH] lsmod01: keep the output in variables
In-Reply-To: <20161109164956.GB9168@rei.lan>
References: <20161011161557.GD17083@rei.suse.cz>
 <1478702093-15080-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20161109164956.GB9168@rei.lan>
Message-ID: <582446EB.2080206@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 11/09/2016 07:49 PM, Cyril Hrubis wrote:
>>  lsmod_test()
>>  {
>> -	lsmod >temp 2>&1
>> -	if [ $? -ne 0 ]; then
>> -		tst_resm TFAIL "'lsmod' failed."
>> -		cat temp
>> +	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
>> +	if [ -z "$lsmod_output" ]; then
>> +		tst_resm TFAIL "Failed to parse the output from lsmod"
>>  		return
>>  	fi
>>  
>> -	awk '!/Module/{print $1, $2, $3}' temp |sort >temp1
>> -
>> -	awk '{print $1, $2, $3}' /proc/modules |sort >temp2
>> +	modules_output=$(awk '{print $1, $2, $3}' /proc/modules | sort)
>> +	if [ -z "$modules_output" ]; then
>> +		tst_resm TFAIL "Failed to parse /proc/modules"
>> +		return
>> +	fi
>>  
>> -	diff temp1 temp2 >temp3
>> -	if [ $? -ne 0 ]; then
>> +	if [ "$lsmod_output" != "$modules_output" ]; then
>>  		tst_resm TFAIL "lsmod output different from /proc/modules."
>> -		cat temp3
>> +
>> +		echo "$lsmod_output" > temp1
>> +		echo "$modules_output" > temp2
>> +		diff temp1 temp2
> 
> Hmm since the foo=$() flattened the text into single line this diff
> would be pretty much useless.

Sorry, but are you sure about that?

[stas@kholmanskikh ~]$ lsmod_output=$(lsmod | awk '!/Module/{print $1,
$2, $3}' | sort)
[stas@kholmanskikh ~]$ echo "$lsmod_output" > /tmp/gg
[stas@kholmanskikh ~]$ tail -n 2 /tmp/gg
xt_state 1370 3
zlib_deflate 21991 1
[stas@kholmanskikh ~]$ modules_output=$(awk '{print $1, $2, $3}'
/proc/modules | sort)
[stas@kholmanskikh ~]$ echo "$modules_output" > /tmp/zz
[stas@kholmanskikh ~]$ tail -n 2 /tmp/zz
xt_state 1370 3
zlib_deflate 21991 1
[stas@kholmanskikh ~]$

i.e. the content of /tmp/gg and /tmp/zz are in the form ready to be diff-ed.

> 
> So we can either just print these two lines, or split them again
> so that exactly three words/numbers are on each line before we do the
> diff.
> 
>>  		return
>>  	fi
>>  
>> -- 
>> 1.7.1
>>
> 
