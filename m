From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Sep 2019 15:12:49 +0300
Subject: [LTP] [PATCH v4 1/7] tst_net.sh: enhance tst_add_ipaddr(),
 add tst_del_ipaddr()
In-Reply-To: <20190903141610.28887-2-pvorel@suse.cz>
References: <20190903141610.28887-1-pvorel@suse.cz>
 <20190903141610.28887-2-pvorel@suse.cz>
Message-ID: <867402c7-9a38-9646-6936-1eb6988a48b8@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 03.09.2019 17:16, Petr Vorel wrote:
> These changes are intended for easier handling with IP addresses
> (not have to calculate dad for IPv6 when adding IP address).
> Add -a IP and -s options to tst_add_ipaddr()
> 
> tst_del_ipaddr() (which uses internally tst_add_ipaddr()) is defined
> mainly for better code readability.
...
>  
> -	tst_res_ TINFO "set remote addr $(tst_ipaddr rhost)/$mask"
> -	tst_rhost_run -c "ip addr add $(tst_ipaddr rhost)/$mask dev $iface $dad"
> +	tst_res_ TINFO "set remote addr $addr"

                         ^
                  Should be $action here?

> +	tst_rhost_run $rsafe -c "ip addr $action $addr dev $iface $dad"
> +}
> +
> +# tst_del_ipaddr [ tst_add_ipaddr options ]
> +# Delete IP address
> +tst_del_ipaddr()
> +{
> +	tst_add_ipaddr -d $@
>  }
>  
>  # tst_restore_ipaddr [TYPE] [LINK]
> 

