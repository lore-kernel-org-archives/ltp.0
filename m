Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maxim.uvarov@linaro.org>) id 1VTr56-0005hN-TE
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 10:33:28 +0000
Received: from mail-lb0-f169.google.com ([209.85.217.169])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VTr55-0001O2-42
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 10:33:28 +0000
Received: by mail-lb0-f169.google.com with SMTP id z5so586106lbh.14
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 Oct 2013 03:33:20 -0700 (PDT)
Message-ID: <525530ED.2030509@linaro.org>
Date: Wed, 09 Oct 2013 14:33:17 +0400
From: Maxim Uvarov <maxim.uvarov@linaro.org>
MIME-Version: 1.0
References: <1380881832-7418-1-git-send-email-maxim.uvarov@linaro.com>
	<31658697.3684822.1381305595230.JavaMail.root@redhat.com>
In-Reply-To: <31658697.3684822.1381305595230.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] LTP max_map_count: filer out not accounted vector
 stub for arm
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Maxim Uvarov <maxim.uvarov@linaro.com>, linaro-networking@linaro.org

On 10/09/2013 11:59 AM, Jan Stancek wrote:
>
> ----- Original Message -----
>> From: "Maxim Uvarov" <maxim.uvarov@linaro.org>
>> To: ltp-list@lists.sourceforge.net
>> Cc: linaro-networking@linaro.org, "Maxim Uvarov" <maxim.uvarov@linaro.com>
>> Sent: Friday, 4 October, 2013 12:17:11 PM
>> Subject: [LTP] [PATCH] LTP max_map_count: filer out not accounted vector	stub for arm
>>
>> Arm has following vector stab:
>> ffff0000-ffff1000 r-xp 00000000 00:00 0 [vectors]
>> which is not accounted in map_count.
>>
>> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.com>
>> ---
>>   testcases/kernel/mem/tunable/max_map_count.c |   19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/kernel/mem/tunable/max_map_count.c
>> b/testcases/kernel/mem/tunable/max_map_count.c
>> index 01fbe5e..ca28fba 100644
>> --- a/testcases/kernel/mem/tunable/max_map_count.c
>> +++ b/testcases/kernel/mem/tunable/max_map_count.c
>> @@ -121,12 +121,24 @@ void cleanup(void)
>>    * for in the vm_area_struct's map_count.
>>    */
>>   #if defined(__x86_64__) || defined(__x86__)
>> -static int filter_map(char *buf)
>> +static int filter_map(char *line)
>>   {
>> +	char buf[BUFSIZ];
>> +	int ret;
>> +
>> +	ret = sscanf(line, "%*p-%*p %*4s %*p %*2d:%*2d %*d %s", buf);
>> +	if (ret != 1)
>> +		return 0;
>> +
>>   	return strcmp(buf, "[vsyscall]") == 0;
>>   }
>> +#elif defined(__arm__)
>> +static int filter_map(char *line)
>> +{
>> +	return strncmp(line, "ffff0000-ffff1000", 17) == 0;
> Hi,
>
> just curious, why comparing the range instead of name ([vectors])?
>
> Regards,
> Jan
for arm there are 8 regions for vectors. Only that region is not accounted.

Maxim.

>> +}
>>   #else
>> -static int filter_map(char *buf)
>> +static int filter_map(char *line)
>>   {
>>   	return 0;
>>   }
>> @@ -146,8 +158,7 @@ static long count_maps(pid_t pid)
>>   		tst_brkm(TBROK | TERRNO, cleanup, "fopen %s", buf);
>>   	while (getline(&line, &len, fp) != -1) {
>>   		/* exclude vdso and vsyscall */
>> -		if (sscanf(line, "%*p-%*p %*4s %*p %*2d:%*2d %*d %s", buf) ==
>> -				1 && filter_map(buf))
>> +		if (filter_map(line))
>>   			continue;
>>   		map_count++;
>>   	}
>> --
>> 1.7.9.5
>>
>>
>> ------------------------------------------------------------------------------
>> October Webinars: Code for Performance
>> Free Intel webinars can help you accelerate application performance.
>> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from
>> the latest Intel processors and coprocessors. See abstracts and register >
>> http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
