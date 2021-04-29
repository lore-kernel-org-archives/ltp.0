From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Apr 2021 19:12:25 +0200
Subject: [LTP] [PATCH v3] commands/lsmod01.sh: Replace tst_res with
 tst_brk
In-Reply-To: <20210429020922.24085-1-zhaogongyi@huawei.com>
References: <20210429020922.24085-1-zhaogongyi@huawei.com>
Message-ID: <YIro+aufl5Fr+QkB@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +++ b/testcases/commands/lsmod/lsmod01.sh
> @@ -23,7 +23,7 @@ setup()
>  		tst_require_cmds insmod
>  		insmod "$TST_MODPATH"
>  		if [ $? -ne 0 ]; then
> -			tst_res TBROK "insmod failed"
> +			tst_brk TBROK "insmod failed"
I replace whole block with ROD and merged. Thanks!

Kind regards,
Petr

>  			return
>  		fi
