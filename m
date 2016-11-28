From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Nov 2016 11:40:15 +0800
Subject: [LTP] [PATCH 1/3] ltp/numa: waiting for numastat refresh
In-Reply-To: <20161123125727.GF3346@rei.lan>
References: <1479872202-29920-1-git-send-email-liwang@redhat.com>
 <20161123125727.GF3346@rei.lan>
Message-ID: <CAEemH2fRor7ORDSzfDf8podzjXc5jAYWn+L6d3kcudkW7kcGmg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 23, 2016 at 8:57 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> +wait_for_update()
>> +{
>> +    NUMASTAT_PATH="/sys/devices/system/node/node$1/numastat"
>> +    local loop=0
>>
>> +    while [ $loop -lt 5 ]; do
>> +        sum_value=0
>> +
>> +        for i in $(seq 200); do
>> +            det_value=$(grep $2 ${NUMASTAT_PATH} | cut -d ' ' -f 2)
>> +            sum_value=$((sum_value + det_value))
>
> I do not understand this part, here you are summing the accumated value
> over and over. That is not making any sense.

My purpose here is to get the average value of numastat in 2sec to
compare with $det_value which was detected at beginning. If they are
not equal, it means the statistic is on refreshing road, we should do
wait for updating. Otherwise, we consider that refresh work completed
and do return.

>
>> +            sync && tst_sleep 10ms
>
> Why the sync here?
>
>> +        done
>> +
>> +        if [ $((sum_value/200)) -eq $det_value ]; then
>
> Here as well. It's higly unlikely that the value would be exactly equal

No, at least for 'other_node' and 'interleave_hit' are two exceptions.

> since the number is increased by other things the system does as well.

I understand your worries, but for function wait_for_update(), I hope
only to take use of it for 'other_node/interleave_hit' detecting in
codes. From what I observe, these two values do not increase until
your give a rule for numa system.

# cat /sys/devices/system/node/node1/numastat
numa_hit 125820814
numa_miss 0
numa_foreign 0
interleave_hit 50180  <------
local_node 125779789
other_node 41025    <------

# sleep 300

# cat /sys/devices/system/node/node1/numastat
numa_hit 125821176
numa_miss 0
numa_foreign 0
interleave_hit 50180   <---- no changes here
local_node 125780151
other_node 41025      <----no changes


# numactl --cpunodebind=0 --preferred=1 ./support_numa 2

# cat /sys/devices/system/node/node1/numastat
numa_hit 125822847
numa_miss 0
numa_foreign 0
interleave_hit 50180   <----no changes
local_node 125781641
other_node 41206     <---- here increase


>> +    done
>> +}
>
> This seems like a good idea generally but what would I do is something
> as:
>
> * Read the statistic with some small sleep in between as you do
> * Exit once the increase is at least the expected value
> * Give up if there was no increase in some well defined time or
>   if it generally took too much time, i.e. something as:

Hmm,  I think our method is nearly the same, isn't it?

>
>   if the last increase of the number was more than second ago -> fail
>   (this could be done easily by counting time since the last increase
>    and resetting it if there was some)
>
>   if the number was increased steadily for more than ten seconds but
>   hasn't reached at least the expected value -> fail
>
> The timing constants may need to be tuned, but AFAIC this is the best we
> can do in this tests.
>
> --
> Cyril Hrubis
> chrubis@suse.cz

Thanks for you reviewing.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
