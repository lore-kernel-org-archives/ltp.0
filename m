From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 15 May 2017 18:20:51 +0800
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
Message-ID: <59198103.4070308@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/05/15 18:03, Jan Stancek wrote:
>
> ----- Original Message -----
>> +
>> +/*
>> + * The threshold per one syscall is computed as a sum of:
>> + *
>> + *  250 us                 - accomodates for context switches, etc.
>> + *  2*monotonic_resolution - accomodates for granurality of the
>> CLOCK_MONOTONIC
>> + *  slack_per_scall        - 0.1% of the sleep capped on 100ms
>> + *                           which is slack allowed in kernel
>> + *
>> + * We also allow for outliners, i.e. add some number to the threshold in
>> case
>> + * that the number of iteration is small. For large enoung number of
>> iterations
>> + * outliners are averaged out.
>> + */
>> +static int compute_threshold(long long requested_us, unsigned int
>> iterations)
>> +{
>> +	unsigned int slack_per_scall = MIN(100000, requested_us / 1000);
> Hi,
>
> while looking at fs/select.c I noticed that it also takes
> current->timer_slack_ns into account and uses that if
> slack is smaller. Would it make sense to add ...?
>    slack_per_scall = MAX(slack_per_scall, prctl(PR_GET_TIMERSLACK) / 1000);
> The default is 50us, so maybe the 250us in formula covers this already?
>
> v2 looks good to me, and my KVM guest ran test successfully for hours.
>
> Regards,
> Jan
Hi Jan and Cyril,

Did you get the following error message when running pselect01 on 
RHEL5.11GA (physical machine):
=====================================================================================
[root@RHEL5U11ga_Intel64 pselect]# ./pselect01
tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
pselect01.c:62: INFO: pselect() sleeping for 1 secs 0 nsec 1 iterations
pselect01.c:95: PASS: pselect() slept for 1000443us, requested 
1000000us, treshold 10200
pselect01.c:62: INFO: pselect() sleeping for 0 secs 1000000 nsec 100 
iterations
pselect01.c:95: PASS: pselect() slept for 101455us, requested 100000us, 
treshold 21000
pselect01.c:62: INFO: pselect() sleeping for 0 secs 2000000 nsec 100 
iterations
pselect01.c:95: PASS: pselect() slept for 203069us, requested 200000us, 
treshold 22000
pselect01.c:62: INFO: pselect() sleeping for 0 secs 10000000 nsec 10 
iterations
pselect01.c:83: FAIL: pselect() woken up too early 99536us, expected 
100000us
pselect01.c:62: INFO: pselect() sleeping for 0 secs 100000000 nsec 1 
iterations
pselect01.c:95: PASS: pselect() slept for 100559us, requested 100000us, 
treshold 1200
=====================================================================================

It seems that pselect woke up early on RHEL5.11GA.

Thanks
Xiao Yang.
>> +
>> +	return (250 + 2 * monotonic_resolution + slack_per_scall) * iterations
>> +		+ (iterations>  1 ? 0 : 1500);
>> +}
>> +



