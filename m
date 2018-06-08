From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 8 Jun 2018 16:42:50 +0300
Subject: [LTP] [PATCH 6/6] network/tcp_cc: add new test bbr02
In-Reply-To: <20180528042139.GF1717@x230>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
 <1526903310-2833-7-git-send-email-alexey.kodanev@oracle.com>
 <20180528042139.GF1717@x230>
Message-ID: <566ba75c-0cbe-b7a1-2f87-16abca2a236b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/28/2018 07:21 AM, Petr Vorel wrote:
> Hi Alexey,
> 
>> Difference, comparing to bbr01:
> 
>> * Uses different (not default) qdisc: pfifo_fast, codel, pfifo, fq, hfsc,
>>   hhf, htb, pie, prio, sfb and sfq.
>> * Emulates congestion not only with packet loss but with delay, corrupt
>>   and reorder.
> 
>> The test expects that 'bbr' congestion-control algorithm not
>> significantly worse than 'cubic'.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>

...

>> +do_test()
>> +{
>> +	for q in $qdisc_list; do
>> +		if tc qdisc add $q >/dev/null 2>&1; then
>> +			tst_res TCONF "$q qdisc not supported"
>> +			continue
>> +		fi
> Yes, this one would of using TST_TEST_DATA.
> 

Thanks for the review Petr!

The patch-set applied and now using new TST_TEST_DATA.

Also I've added one more patch that checks support in kernel.
