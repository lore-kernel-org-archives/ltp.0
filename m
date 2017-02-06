From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Feb 2017 16:04:26 +0800
Subject: [LTP] [PATCH] ltp/numa: add new test11
In-Reply-To: <20170124193307.GA780@rei>
References: <1484898966-27753-1-git-send-email-liwang@redhat.com>
 <20170124193307.GA780@rei>
Message-ID: <CAEemH2e2RfsbKKQ6aJYDMUNmLCQzuPmS4d5Mvh-mRTDmmTCiCQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 25, 2017 at 3:33 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> +             numactl --cpunodebind=$node --membind=$node support_numa $HUGE_PAGE &
>> +             pid=$!
>> +             wait_for_support_numa $pid
>> +
>> +             Mem_huge=$(echo $(numastat -p $pid |grep '^Huge' |awk '{print $'$((node+2))'}'))
>> +             Mem_huge=$(echo "$Mem_huge * 1024" |bc)
>
> Eh, why not just $((Mem_huge * 1024)) ?

Hmm, from what I test this is not a  proper form here.

The Mem_huge is a Floating-point data(as: 2.00), so I prefer to keep
the original operate style.

>
>> +             if [ $(echo "$Mem_huge < $HPAGE_SIZE" | bc) -eq 1 ]; then
>
> Here as well, why not just if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then
>

Here likewise.

>> +                     tst_res TFAIL \
>> +                             "NUMA memory allocated in node$node is less than expected"
>> +                     return
>> +             fi

-- 
Regards,
Li Wang
Email: liwang@redhat.com
