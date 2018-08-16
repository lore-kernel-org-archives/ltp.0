From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 16 Aug 2018 14:49:02 +0300
Subject: [LTP] [PATCH RFC 2/4] lib/tst_test.sh: add TST_NEEDS_DRIVERS
 parameter
In-Reply-To: <20180816085458.GA19422@dell5510>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
 <1533828226-24753-2-git-send-email-alexey.kodanev@oracle.com>
 <20180816085458.GA19422@dell5510>
Message-ID: <4dd0cb19-fa72-c557-1a5f-20a6d990e4d5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/16/2018 11:54 AM, Petr Vorel wrote:
> Hi Alexey,
> 
>> The drivers are checked with tst_check_drivers.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
> 
>>  	tst_test_cmds $TST_NEEDS_CMDS
>> +	tst_test_drivers $TST_NEEDS_DRIVERS
> 
> I'm sorry here must be some fix:
> +	if [ -n "$TST_NEEDS_DRIVERS" ]; then
> +		tst_test_drivers $TST_NEEDS_DRIVERS
> +	fi
> 
> Otherwise tests without $TST_NEEDS_DRIVERS TCONF:
> tcp_ipsec_vti 1 TCONF: 'Please provide kernel driver list' driver not found

Hi Petr,

Yeah, noticed that too, so I've added the check to tst_test_drivers(),
it should just return if there are no arguments passed.

Thanks,
Alexey
