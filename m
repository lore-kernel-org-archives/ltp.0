From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 9 Jan 2020 17:16:18 +0300
Subject: [LTP] [PATCH] network/iptables: add ipv6 support
In-Reply-To: <20200109105101.GA30367@dell5510>
References: <20191226135801.11839-1-alexey.kodanev@oracle.com>
 <20200103124851.GA24603@dell5510>
 <f65c32e4-e426-e6c9-5627-51bed11c31e6@oracle.com>
 <20200109105101.GA30367@dell5510>
Message-ID: <b7290545-f106-3605-7a82-7854383ad3f8@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09.01.2020 13:51, Petr Vorel wrote:
> Hi Alexey,
> 
>>> now:
>>> /bin/sh: 1: nft: not found
>>> nft01 1 TBROK: nft add table ip filter failed
> 
>> Good catch, what about starting with init() in do_setup()?
> 
>> diff --git a/testcases/network/iptables/nft01.sh b/testcases/network/iptables/nft01.sh
>> index 1ae086678..bf2a53c28 100755
>> --- a/testcases/network/iptables/nft01.sh
>> +++ b/testcases/network/iptables/nft01.sh
>> @@ -13,6 +13,7 @@ cleanup_chain=0
> 
>>  do_setup()
>>  {
>> +       init
>>         local ip_table="ip${TST_IPV6}"
> 
>>         if ! nft list table $ip_table filter > /dev/null 2>&1; then
>> @@ -23,7 +24,6 @@ do_setup()
>>                 ROD nft add chain $ip_table filter INPUT '{ type filter hook input priority 0; }'
>>                 cleanup_chain=1
>>         fi
>> -       init
>>  }
> 
> Great, what a simple fix :).
> 

Applied with this change, thanks for your review Petr!
