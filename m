From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 23 Jun 2021 17:33:33 +0200
Subject: [LTP] [PATCH] device-drivers/cpufreq_boost: skip test on
 virtual machines
In-Reply-To: <YNMdNqGiGXOgby6v@yuki>
References: <20210623080157.26424-1-krzysztof.kozlowski@canonical.com>
 <2a08d5c4-c002-7284-03d1-ff4441f8c9c5@canonical.com> <YNMdNqGiGXOgby6v@yuki>
Message-ID: <aaf8acb9-f28f-b550-ccbc-8feb5aad17b0@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23/06/2021 13:38, Cyril Hrubis wrote:
> Hi!
>>> diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
>>> index b9739db37cb7..67917b3fea25 100644
>>> --- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
>>> +++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
>>> @@ -90,6 +90,9 @@ static void setup(void)
>>>  	unsigned int i;
>>>  	tst_require_root();
>>>  
>>> +	if (tst_is_virt(VIRT_ANY))
>>> +		tst_brkm(TCONF, NULL, "running in a virtual machine, overclock not reliably measureable");
>>> +
>>>  	for (i = 0; i < ARRAY_SIZE(cdrv); ++i) {
>>>  		fd = open(cdrv[i].file, O_RDWR);
>>>  		if (fd == -1)
>>>
>>
>> Optionally, under virtual machine the test failure could be converted to
>> accepted pass. This would still allow to test CPUfreq boosting
>> interface. Any preferences?
> 
> I wonder what is the likehood of actually dicovering a bug by writing to
> the cpufreq boost file from within a VM, I guess that it's non-zero at
> least.

It's a test of kernel interface and whether the driver accepts input via
sysfs... so not much of a real cpufreq test. Indeed maybe better to skip
the test explicitly instead of giving some false hopes that cpufreq is
being tested.


Best regards,
Krzysztof
