From: Li Wang <liwang@redhat.com>
Date: Wed, 24 May 2017 09:48:23 +0800
Subject: [LTP] [PATCH v3 3/3] ltp/numa: use string to describe operation
In-Reply-To: <20170523121515.GC19602@rei.suse.cz>
References: <20170519082724.10232-1-liwang@redhat.com>
 <20170519122326.GA17258@rei.lan>
 <CAEemH2c2zzixjetBj8hKCgD_2tCiSN9FrE=0aNUmo4P9vDwD2A@mail.gmail.com>
 <20170523121515.GC19602@rei.suse.cz>
Message-ID: <CAEemH2dFb0X9+w=G177PgqR2qn_8wgPMcpHxdzYykAargzFMTw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 23, 2017 at 8:15 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> $ git diff
>> diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
>> index 4eda3f1..e3fe854 100755
>> --- a/testcases/kernel/numa/numa01.sh
>> +++ b/testcases/kernel/numa/numa01.sh
>> @@ -315,9 +315,20 @@ test8()
>>         # Memory will be allocated using round robin on nodes.
>>         Exp_incr=$(echo "$MB / $total_nodes" |bc)
>>
>> -       numactl --interleave=all memhog -r1000000 1MB 2>&1 >/dev/null &
>> +       numactl --interleave=all memhog -r1000000 1MB 2>&1 >ltp_numa_test8.log &
>>         pid=$!
>>
>> +       local retries=20
>> +       while [ $retries -gt 0 ]; do
>> +
>> +               if grep -m1 -q '.' ltp_numa_test8.log; then
>> +                       break
>> +               fi
>> +
>> +               retries=$((retries-1))
>> +               tst_sleep 50ms
>> +       done
>> +
>>         for node in $nodes_list; do
>>                 Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
>
> This fixes the problem for me, can you, pretty please, send a signed
> patch?

Sure, my pleasure.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
