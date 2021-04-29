From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Apr 2021 08:56:28 +0200
Subject: [LTP] [PATCH v3] network/sit01.sh: Replace tst_res with tst_brk
In-Reply-To: <20210429022839.24503-1-zhaogongyi@huawei.com>
References: <20210429022839.24503-1-zhaogongyi@huawei.com>
Message-ID: <YIpYnDpL6uv3ejHb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> We need replace tst_res with tst_brk to terminate the test
> immediately since there is no sence to go on.

> +++ b/testcases/network/virt/sit01.sh
>  do_setup()
>  {
> -	[ -n "$TST_IPV6" ] && tst_res TBROK "invalid option '-6' for sit tunnel"
> +	[ -n "$TST_IPV6" ] && tst_brk TBROK "invalid option '-6' for sit tunnel"

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
