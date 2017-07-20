From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 20 Jul 2017 10:21:53 +0800
Subject: [LTP] [PATCH] lib/tst_timer_test.c: fix unsigned int overflow
 on RHEL5.11GA
In-Reply-To: <20170719121557.GG1015@rei.lan>
References: <1500274437-26154-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170719121557.GG1015@rei.lan>
Message-ID: <597013C1.8030405@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/07/19 20:15, Cyril Hrubis wrote:
> Hi!
>> On RHEL5.11GA, pselect01 gets signal SIGSEGV due to unsigned int
>> overflow when all members of the samples array are less than usec
>> in do_timer_test().  all tests which apply timer measurement library
>> could trigger this issue on RHEL5.11GA regularly.
> Ah righ, I've forgotten to add check for the array boundary there as
> well.
>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   lib/tst_timer_test.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
>> index f30ad73..178e232 100644
>> --- a/lib/tst_timer_test.c
>> +++ b/lib/tst_timer_test.c
>> @@ -295,9 +295,9 @@ void do_timer_test(long long usec, unsigned int nsamples)
>>   			i, samples[0], samples[i-1]);
>>   	}
>>
>> -	for (i = nsamples - 1; samples[i]<  usec; i--);
>> +	for (i = nsamples - 1; i<  nsamples&&  samples[i]<  usec; i--);
> But this does not seem right, we are decrementing i, hence we should
> check that i>  0, otherwise we overflow anyway. With i<  nsamples we
> will break the cycle after the overflow, which is wrong and works only
> by accident (since i is unsigned we overflow to UINT_MAX if we decrement
> 0).
>
>
> This should be the correct patch to fix the problem:
>
> diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
> index f30ad73dc..0b675f78d 100644
> --- a/lib/tst_timer_test.c
> +++ b/lib/tst_timer_test.c
> @@ -295,7 +295,7 @@ void do_timer_test(long long usec, unsigned int nsamples)
>                          i, samples[0], samples[i-1]);
>          }
>
> -       for (i = nsamples - 1; samples[i]<  usec; i--);
> +       for (i = nsamples - 1; samples[i]<  usec&&  i>  0; i--);
Hi Cyril,

It sounds better, but this change leads that samples[0] could not be 
checked if the whole samples array
is less than usec.

Could we fix this issue as below:
------------------------------------------------------------------------------------------------------------------------
-    for (i = nsamples - 1; samples[i] < usec; i--);
+    for (i = nsamples - 1; samples[i] < usec && i > 0; i--);

      if (i < nsamples - 1) {
-        tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
-            scall, nsamples - 1 - i,
-            samples[i+1], samples[nsamples-1]);
+        if (i == 0 && samples[i] < usec) {
+            tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
+                scall, nsamples - i, samples[i],
+                samples[nsamples-1]);
+        } else {
+            tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
+                scall, nsamples - 1 - i, samples[i+1],
+                samples[nsamples-1]);
+        }
------------------------------------------------------------------------------------------------------------------------
Thanks,
Xiao Yang
>
>          if (i<  nsamples - 1) {
>                  tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
>



