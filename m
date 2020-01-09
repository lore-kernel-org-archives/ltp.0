From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 11:51:01 +0100
Subject: [LTP] [PATCH] network/iptables: add ipv6 support
In-Reply-To: <f65c32e4-e426-e6c9-5627-51bed11c31e6@oracle.com>
References: <20191226135801.11839-1-alexey.kodanev@oracle.com>
 <20200103124851.GA24603@dell5510>
 <f65c32e4-e426-e6c9-5627-51bed11c31e6@oracle.com>
Message-ID: <20200109105101.GA30367@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > now:
> > /bin/sh: 1: nft: not found
> > nft01 1 TBROK: nft add table ip filter failed

> Good catch, what about starting with init() in do_setup()?

> diff --git a/testcases/network/iptables/nft01.sh b/testcases/network/iptables/nft01.sh
> index 1ae086678..bf2a53c28 100755
> --- a/testcases/network/iptables/nft01.sh
> +++ b/testcases/network/iptables/nft01.sh
> @@ -13,6 +13,7 @@ cleanup_chain=0

>  do_setup()
>  {
> +       init
>         local ip_table="ip${TST_IPV6}"

>         if ! nft list table $ip_table filter > /dev/null 2>&1; then
> @@ -23,7 +24,6 @@ do_setup()
>                 ROD nft add chain $ip_table filter INPUT '{ type filter hook input priority 0; }'
>                 cleanup_chain=1
>         fi
> -       init
>  }

Great, what a simple fix :).

Kind regards,
Petr
