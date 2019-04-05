From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 5 Apr 2019 13:21:40 +0300
Subject: [LTP] [PATCH] network/dhcp: correct prefix for expected IPv6
 address
In-Reply-To: <20190404144415.GA2898@dell5510>
References: <1554310924-24751-1-git-send-email-alexey.kodanev@oracle.com>
 <20190404144415.GA2898@dell5510>
Message-ID: <a0862aa9-38bf-669f-044d-388bff7fd759@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 04.04.2019 17:44, Petr Vorel wrote:
> Hi Alexey,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Good catch, thanks for fixing it!
> 
>>  testcases/network/dhcp/dhcp_lib.sh |   15 +++++++++++----
> ...
>>  	if [ $TST_IPV6 ]; then
>>  		ip_addr="fd00:1:1:2::12/64"
>> -		ip_addr_check="fd00:1:1:2::100/64"
>> +		ip_addr_check_nm="fd00:1:1:2::100"
> Just curious what _nm stands for :).

no mask, will change it to _noprefix.

Thanks for review!

>> +		ip_addr_check="$ip_addr_check_nm/128"
> ...
> 
> Kind regards,
> Petr
> 
