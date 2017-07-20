From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 20 Jul 2017 17:25:30 +0800
Subject: [LTP] [PATCH] lib/tst_timer_test.c: fix unsigned int overflow
 on RHEL5.11GA
In-Reply-To: <20170720091359.GA27245@rei>
References: <1500274437-26154-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170719121557.GG1015@rei.lan> <597013C1.8030405@cn.fujitsu.com>
 <20170720091359.GA27245@rei>
Message-ID: <5970770A.4000703@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/07/20 17:13, Cyril Hrubis wrote:
> Hi!
>> It sounds better, but this change leads that samples[0] could not be
>> checked if the whole samples array
>> is less than usec.
>>
>> Could we fix this issue as below:
>> ------------------------------------------------------------------------------------------------------------------------
>> -    for (i = nsamples - 1; samples[i]<  usec; i--);
>> +    for (i = nsamples - 1; samples[i]<  usec&&  i>  0; i--);
>>
>>        if (i<  nsamples - 1) {
>> -        tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
>> -            scall, nsamples - 1 - i,
>> -            samples[i+1], samples[nsamples-1]);
>> +        if (i == 0&&  samples[i]<  usec) {
>> +            tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
>> +                scall, nsamples - i, samples[i],
>> +                samples[nsamples-1]);
>> +        } else {
>> +            tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
>> +                scall, nsamples - 1 - i, samples[i+1],
>> +                samples[nsamples-1]);
>> +        }
>> ------------------------------------------------------------------------------------------------------------------------
> That is still unnecessarily complex. I do not care that much about this
> corner case, but if we want to fix it correctly we can simply change the
> i to be signed integer and check for i>  -1 in the loop and everything
> would work fine.
Hi Cyril,

Thanks for your explanation.  I will send v2 patch as you said.

Thanks,
Xiao Yang



