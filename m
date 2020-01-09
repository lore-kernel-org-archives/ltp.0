From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 9 Jan 2020 13:17:02 +0300
Subject: [LTP] [PATCH] network/iptables: add ipv6 support
In-Reply-To: <20200103124851.GA24603@dell5510>
References: <20191226135801.11839-1-alexey.kodanev@oracle.com>
 <20200103124851.GA24603@dell5510>
Message-ID: <f65c32e4-e426-e6c9-5627-51bed11c31e6@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 03.01.2020 15:48, Petr Vorel wrote:
> Hi Alexey,
> 
>> New tests: ip6tables, nft6.
> great idea, just there is a regression in nft01.sh, see below.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>> --- a/testcases/network/iptables/iptables_lib.sh
> ...
>>  init()
>>  {
>> +	if [ "$use_iptables" = 1 ]; then
>> +		toolname=ip${TST_IPV6}tables
>> +		cmds="$toolname"
>> +		tst_require_drivers ip${TST_IPV6}_tables
>> +	else
>> +		toolname=nft
>> +		cmds="$toolname ip${TST_IPV6}tables-translate"
>> +	fi
>> +
>> +	if [ "$TST_IPV6" ];then
>> +		loc_addr="::1"
>> +		proto="icmpv6"
>> +	else
>> +		loc_addr="127.0.0.1"
>> +		proto="icmp"
>> +	fi
>> +
>> +	ping_cmd="ping$TST_IPV6"
>> +	tst_require_cmds $cmds $ping_cmd
> 
> change to tst_require_cmds() does not catch missing nft:
> 
> nft check broke, original:
> nft01 1 TCONF: 'nft' not found
> 
> now:
> /bin/sh: 1: nft: not found
> nft01 1 TBROK: nft add table ip filter failed

Good catch, what about starting with init() in do_setup()?

diff --git a/testcases/network/iptables/nft01.sh b/testcases/network/iptables/nft01.sh
index 1ae086678..bf2a53c28 100755
--- a/testcases/network/iptables/nft01.sh
+++ b/testcases/network/iptables/nft01.sh
@@ -13,6 +13,7 @@ cleanup_chain=0
 
 do_setup()
 {
+       init
        local ip_table="ip${TST_IPV6}"
 
        if ! nft list table $ip_table filter > /dev/null 2>&1; then
@@ -23,7 +24,6 @@ do_setup()
                ROD nft add chain $ip_table filter INPUT '{ type filter hook input priority 0; }'
                cleanup_chain=1
        fi
-       init
 }


> 
> one of these fixes it (take whatever you like. Both variants check nft twice,
> I'd ignore it).
> 
> * use TST_NEEDS_CMDS
> diff --git testcases/network/iptables/iptables_lib.sh testcases/network/iptables/iptables_lib.sh
> index ad2a894b6..8d220bc0e 100755
> --- testcases/network/iptables/iptables_lib.sh
> +++ testcases/network/iptables/iptables_lib.sh
> @@ -12,7 +12,7 @@ TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
>  TST_SETUP="${TST_SETUP:-init}"
>  TST_CLEANUP="${TST_CLEANUP:-cleanup}"
> -TST_NEEDS_CMDS="grep telnet"
> +TST_NEEDS_CMDS="$TST_NEEDS_CMDS grep telnet"
>  
>  . tst_net.sh
>  
> diff --git testcases/network/iptables/nft01.sh testcases/network/iptables/nft01.sh
> index 1ae086678..225f59bc5 100755
> --- testcases/network/iptables/nft01.sh
> +++ testcases/network/iptables/nft01.sh
> @@ -5,6 +5,7 @@
>  TST_SETUP="do_setup"
>  TST_CLEANUP="do_cleanup"
>  TST_NEEDS_DRIVERS="nf_tables"
> +TST_NEEDS_CMDS="nft"
>  use_iptables=0
>  cleanup_table=0
>  cleanup_chain=0
> 
> * use tst_require_cmds
> diff --git testcases/network/iptables/nft01.sh testcases/network/iptables/nft01.sh
> index 1ae086678..e5799b918 100755
> --- testcases/network/iptables/nft01.sh
> +++ testcases/network/iptables/nft01.sh
> @@ -15,6 +15,7 @@ do_setup()
>  {
>  	local ip_table="ip${TST_IPV6}"
>  
> +	tst_require_cmds nft
>  	if ! nft list table $ip_table filter > /dev/null 2>&1; then
>  		ROD nft add table $ip_table filter
>  		cleanup_table=1
> 
> 
> Kind regards,
> Petr
> 

