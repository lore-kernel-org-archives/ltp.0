From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 14 Sep 2018 14:54:00 +0300
Subject: [LTP] [PATCH v2 2/4] lib/tst_test.sh: add TST_NEEDS_DRIVERS
 parameter
In-Reply-To: <20180913123501.GC18036@rei.lan>
References: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
 <1534764229-26993-2-git-send-email-alexey.kodanev@oracle.com>
 <20180913123501.GC18036@rei.lan>
Message-ID: <e0b989e4-f301-21dc-302a-aaf0f3b755f3@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09/13/2018 03:35 PM, Cyril Hrubis wrote:
> Hi!
>> +tst_test_drivers()
>> +{
>> +	[ $# -eq 0 ] && return 0
>> +
>> +	local drv="$(tst_check_drivers $@ 2>&1)"
> 
> Wouldn't it be easier to just redirect the stderr into /dev/null here
> and check the $? instead of [ -n "$drv" ] ?
> 

It's better to print the error message if any, including the driver name that
is missing. And checking $? should work here too, will change that.
