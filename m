From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Apr 2021 20:59:05 +0200
Subject: [LTP] [PATCH 1/1] df01.sh: Fix DF_FS_TYPE assignment on bind
 mount
In-Reply-To: <20210401124724.25394-1-pvorel@suse.cz>
References: <20210401124724.25394-1-pvorel@suse.cz>
Message-ID: <YIcNeV0wbuK9wmPu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Merged this one.

Kind regards,
Petr

> In case of bind mount of testing directory, grep will assign filesystem
> twice, with new line:

> $ echo "DF_FS_TYPE: '$DF_FS_TYPE'"
> DF_FS_TYPE: 'ext2
> ext2'

> Limiting only first line to avoid failure with confusing message:

> df01 5 TFAIL: 'df' failed.
> df: ext2: No such file or directory

> +++ b/testcases/commands/df/df01.sh
> @@ -39,7 +39,7 @@ setup()
>  {
>  	tst_mkfs
>  	tst_mount
> -	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
> +	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk 'NR==1{print $5}')
>  }

>  df_test()
