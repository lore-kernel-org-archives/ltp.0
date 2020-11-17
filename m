From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 Nov 2020 12:39:57 +0300
Subject: [LTP] [PATCH] net/host: update to new api
In-Reply-To: <20201116184143.GA171432@pevik>
References: <20201116101840.15433-1-kory.maincent@bootlin.com>
 <20201116184143.GA171432@pevik>
Message-ID: <80a391bf-b305-13ab-df79-169c8d4a0a28@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16.11.2020 21:41, Petr Vorel wrote:
> Hi Kory,
> 
> thanks for your patch.
> ...
>>  do_test()
>>  {
> 
>> -    tst_resm TINFO "test basic functionality of the \`$TC' command."
>> +    tst_res TINFO "test basic functionality of the host command."
> 
>> -    while [ $TST_COUNT -lt $NUMLOOPS ]; do
>> +    while [ $TST_COUNT -le $NUMLOOPS ]; do
> IMHO there is no need to have loop like this.
> If required, we'd just add -iN parameter to it in the runtest file (where N is
> <1,max int), but IMHO it's enough to test host only once.
> 
>>          if rhost_addr=$(host $RHOST); then
>> -            rhost_addr=$(echo "$rhost_addr" | awk -F, '{print $NF}') >/dev/null 2>&1
>> -            if ! host $rhost_addr >/dev/null 2>&1; then
>> -                end_testcase "reverse lookup with host failed"
>> -            fi
>> -
>> +            rhost_addr=$(echo "$rhost_addr" | awk '{print $NF}') >/dev/null 2>&1
>> +            EXPECT_PASS host $rhost_addr \>/dev/null 2>&1
> We need to redirect also second > and &:
> EXPECT_PASS host $rhost_addr \>/dev/null 2\>\&1
> 
>>          else
>> -            end_testcase "host $RHOST on local machine failed"
>> +            tst_brk TFAIL "host $RHOST on local machine failed"
>>          fi
> 
>> -        incr_tst_count
>> +        TST_COUNT=$((TST_COUNT + 1))
>>          sleep $SLEEPTIME
> Also sleep time is not really needed.
> 
> ...
> 
> Can I merge this simplified variant?
...
> 
> . tst_net.sh
> 
> do_test()
> {
> 	local rhost=${RHOST:-$(hostname)}

Hi Petr, Kory

For new API we shouldn't use RHOST. Also the naming is misleading,
it can be a local host name.


> 	local rhost_addr
> 
>     tst_res TINFO "test basic functionality of the host command"
> 
> 	if rhost_addr=$(host $rhost); then
> 		rhost_addr=$(echo "$rhost_addr" | awk '{print $NF}')
> 		EXPECT_PASS host $rhost_addr \>/dev/null 2\>\&1
> 	else
> 		tst_brk TFAIL "host $rhost on local machine failed"
> 	fi
> }
> 
> tst_run
> 

