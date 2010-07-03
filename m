Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OV7JK-0004jb-12
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:19:30 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OV7JJ-00076P-2g
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:19:29 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1278087148.6654.80.camel@moss-pluto.epoch.ncsc.mil>
References: <1278087148.6654.80.camel@moss-pluto.epoch.ncsc.mil>
Date: Sat, 03 Jul 2010 23:30:17 +0530
Message-Id: <1278180017.7665.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] ima:  Fix ima_measure
Reply-To: subrata@linux.vnet.ibm.com
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, Mimi Zohar <zohar@us.ibm.com>

On Fri, 2010-07-02 at 12:12 -0400, Stephen Smalley wrote: 
> ima_measure doesn't build correctly.  It needs config.h to determine
> whether openssl headers are present, and verbose needs to be global.
> Broken by commit ef77253961f909f87e82e6d2b620e87af33e9665.
> 
> Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

Thanks.

Regards--
Subrata

> 
> ---
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_measure.c b/testcases/kernel/security/integrity/ima/src/ima_measure.c
> index dd6b1d0..0484c04 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_measure.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_measure.c
> @@ -22,7 +22,7 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <unistd.h>
> -//#include "config.h"
> +#include "config.h"
>  #include "test.h"
>  #if HAVE_OPENSSL_SHA_H
>  #include <openssl/sha.h>
> @@ -33,6 +33,8 @@
>  char *TCID = "ima_measure";
>  int TST_TOTAL = 1;
> 
> +static int verbose;
> +
>  #define print_info(format, arg...) \
>  	if (verbose) \
>  		printf(format, ##arg)
> @@ -135,9 +137,8 @@ main(int argc, char *argv[])
>  	FILE *fp;
>  	struct event template;
>  	u_int8_t pcr[SHA_DIGEST_LENGTH];
> -	int i, count = 0, len;
> +	int i, count = 0;
> 
> -	int verbose = 0;
>  	int validate = 0;
>  	int verify = 0;
> 
> 
> 


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
