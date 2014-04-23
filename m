Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wd0bO-0003HX-SJ
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 17:04:54 +0000
Date: Wed, 23 Apr 2014 19:04:02 +0200
From: chrubis@suse.cz
Message-ID: <20140423170402.GF16286@rei.suse.cz>
References: <1397211402-12361-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1397211402-12361-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397211402-12361-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/2] tools/apicmd: add tst_fs_has_free
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
> index c8099c5..de58c1e 100644
> --- a/tools/apicmds/ltpapicmd.c
> +++ b/tools/apicmds/ltpapicmd.c
> @@ -73,6 +73,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> +#include <stdint.h>
>  #include "test.h"
>  #include "usctest.h"
>  #include "safe_macros.h"
> @@ -324,6 +325,28 @@ err:
>  	exit(1);
>  }
>  
> +int apicmd_fs_has_free(int argc, char *argv[])
> +{
> +	if (argc != 3)
> +		goto fs_has_free_err;
> +
> +	char *endptr;
> +	uint64_t required_kib = strtoull(argv[1], &endptr, 0);
> +
> +	if (*argv[1] == '\0' || *endptr != '\0') {
> +		fprintf(stderr, "%s is not a valid numeric string\n", argv[1]);
> +		goto fs_has_free_err;
> +	}
> +
> +	return tst_fs_has_free(NULL, argv[0], required_kib);
> +
> +fs_has_free_err:
> +	fprintf(stderr, "Usage: tst_fs_has_free path required_kib\n"
> +		"path: the pathname of any file within the mounted filesystem\n"
> +		"required_kib: the required free space(count in KB)\n");
> +	exit(1);
> +}
> +
>  /*
>   * Function:    main - entry point of this program
>   *
> @@ -359,6 +382,7 @@ int main(int argc, char *argv[])
>  	if (TCID == NULL || tst_total == NULL || tst_cntstr == NULL) {
>  		if (!strcmp(cmd_name, "tst_kvercmp") &&
>  		    !strcmp(cmd_name, "tst_kvercmp2") &&
> +		    !strcmp(cmd_name, "tst_fs_has_free") &&
>  		    !strcmp(cmd_name, "tst_get_unused_port")) {
>  			fprintf(stderr,
>  				"\nSet variables TCID, TST_TOTAL, and TST_COUNT before each test:\n"
> @@ -409,6 +433,8 @@ int main(int argc, char *argv[])
>  		printf("%li\n", tst_ncpus_max());
>  	} else if (strcmp(cmd_name, "tst_get_unused_port") == 0) {
>  		printf("%u\n", apicmd_get_unused_port(argc, argv));
> +	} else if (strcmp(cmd_name, "tst_fs_has_free") == 0) {
> +		printf("%d\n", apicmd_fs_has_free(argc, argv));

It think that it would be better to return the result in exit value,
just as tst_kvercmp does so we can write:

if ! tst_fs_has_free . 32; then
	tst_brkm TCONF "Not enough free space"
fi

I would go for:

0 - everything ok
1 - not enough space
2 - error

The rest is Ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
