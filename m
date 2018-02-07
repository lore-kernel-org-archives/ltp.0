From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 7 Feb 2018 16:39:24 +0300
Subject: [LTP] [PATCH 8/9] network: add new test-cases with UDP LITE
 protocol
In-Reply-To: <20180130100323.uyhgyxw2bbinevdh@dell5510>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
 <1517226076-26436-9-git-send-email-alexey.kodanev@oracle.com>
 <20180130100323.uyhgyxw2bbinevdh@dell5510>
Message-ID: <fb1b26e0-5d60-c581-6973-a8183df4c5f0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30.01.2018 13:03, Petr Vorel wrote:
> Hi Alexey,
> 
>> Updated tests: busy_poll03, dccp01 and udp_ipsec.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
> <snip>
>> +do_test udp
>> +do_test udp_lite
> 
> <snip>
>>  test_run()
>>  {
>> -	tst_resm TINFO "compare UDP/DCCP performance"
>> +	tst_resm TINFO "compare UDP/DCCP/UDPLITE performance"
> <snip>
> 
>> -	if [ "$per" -gt "100" -o "$per" -lt "-100" ]; then
>> -		tst_resm TFAIL "dccp performance $per %"
>> -	else
>> -		tst_resm TPASS "dccp performance $per % in range -100 ... 100 %"
>> -	fi
>> +	tst_netload -H $(tst_ipaddr rhost) -T udp_lite
>> +	res1="$(cat tst_netload.res)"
>> +	compare udplite
> This is just a minor nit.
> You use udplite and udp_lite. I guess there is just one UDP-Lite protocol.
> I guess using just one variant for parameters would prevent typo errors in future.

Hi Petr,

Since compare() uses a protocol name for just showing it in the log,
changed it to UDP-Lite.

Thank you for review! Applied the patches.

Best regards,
Alexey
