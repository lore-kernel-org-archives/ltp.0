From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Mar 2021 12:34:20 +0100
Subject: [LTP] [PATCH v2 4/4] doc: Update docs on filesystem detection
In-Reply-To: <20210311105509.2701-5-chrubis@suse.cz>
References: <20210311105509.2701-1-chrubis@suse.cz>
 <20210311105509.2701-5-chrubis@suse.cz>
Message-ID: <YEoAPF+1RUw2/wDD@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> -	/*
> -	 * Unsupported on NFS, TMPFS and RAMFS
> -	 */
> -	long type;
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	...

>  	switch ((type = tst_fs_type("."))) {
>  	case TST_NFS_MAGIC:
>  	case TST_TMPFS_MAGIC:
>  	case TST_RAMFS_MAGIC:
> -		tst_brk(TCONF, "Test not supported on %s filesystem",
> +		tst_brk(TCONF, "Subtest not supported on %s",
>  		        tst_fs_type_name(type));
> +		return;
>  	break;
>  	}
> +
> +	...
> +}
>  -------------------------------------------------------------------------------

> +If test needs to adjust expectations based on filesystem type it's also
> +possible to detect filesystem type at the runtime. This is preferably used
> +when only subset of the test is not applicable for a given filesystem.

Should be this paragraph above the previous code example and not below? As the
example illustrates the case of this paragraph.

Apart from that whole patchset LGTM, nice changes.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
