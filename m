From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 8 Jan 2019 18:52:18 +0800
Subject: [LTP] [PATCH] device-drivers/cpufreq_boost.c: skip test if
 turbo is disabled by BIOS or unavailable on processor
In-Reply-To: <cd870461-e84f-d16a-0621-f3466fd59f32@arm.com>
References: <1546852515-19045-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190108093344.GA2687@x230> <5C347181.8080303@cn.fujitsu.com>
 <cd870461-e84f-d16a-0621-f3466fd59f32@arm.com>
Message-ID: <5C3480E2.2020702@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/01/08 18:10, Cristian Marussi wrote:
> Hi
>
> On 08/01/2019 09:46, Xiao Yang wrote:
>> On 2019/01/08 17:33, Petr Vorel wrote:
>>> Hi Xiao,
>>>
>>>> If intel_pstate driver has been initialized but turbo is disabled by BIOS
>>>> or unavailable on processor(i.e. intel_pstate/no_turbo file exists but its
>>>> default value is 1), we cannot write data into intel_pstate/no_turbo and
>>>> return EPERM, as below:
>>>> ------------------------------------------------------------------------
>>>> cpufreq_boost    1  TBROK  :  safe_file_ops.c:301: Failed to close FILE '/sys/devices/system/cpu/intel_pstate/no_turbo' at cpufreq_boost.c:151: errno=EPERM(1): Operation not permitted
>>>> cpufreq_boost    2  TBROK  :  safe_file_ops.c:301: Remaining cases broken
>>>> ------------------------------------------------------------------------
>>>> We try to skip test in this case.
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> Acked-by: Petr Vorel<pvorel@suse.cz>
>>>
>>> Not merging it as it's a git freeze (although it's a fix).
>>>
>>>> +	/* We try to skip test when getting EPERM. */
>>>> +	if (write(fd, off, 1) == -1&&   errno == EPERM) {
>>>> +		SAFE_CLOSE(NULL, fd);
>>>> +		tst_brkm(TCONF, NULL, "Turbo is disabled by "
>>>> +			 "BIOS or unavailable on processor");
>>> Minor tip: I wouldn't split the string (better for grep, also checkpatch.pl
>>> warns about it).
>> Hi Petr,
>>
>> Thanks for your review.
>>
>> 1) I will get the "line over 80 characters" warning if i don't split the string.
>> 2) I will get the "quoted string split across lines" warning if i split the string.
>>
>> Which one should i choose?  I am not sure.
> I could be wrong but i think that if you keep the string unsplitted and move it
> on its own line checkpatch.pl should be fine, like in:
>
> tst_brkm(TCONF, NULL,
>           "Turbo is disabled by BIOS or unavailable on processor");
Hi Cristian, Petr

Right, it's my fault.  According to checkpatch.pl code, one line with a single string
doesn't trigger the "line over 80 characters" warning even if its length over 80 chars.

Best Regards,
Xiao Yang

> Regards
>
> Cristian
>
>> Best Regards,
>> Xiao Yang
>>
>>> Kind regards,
>>> Petr
>>>
>>>
>>> .
>>>
>>
>>
>>
>



