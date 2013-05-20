Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UeP0D-0004ev-Ly
	for ltp-list@lists.sourceforge.net; Mon, 20 May 2013 12:15:45 +0000
Date: Mon, 20 May 2013 14:16:54 +0200
From: chrubis@suse.cz
Message-ID: <20130520121654.GB19493@rei>
References: <1368706811-14497-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1368706811-14497-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] Create a function tst_resm_hexd to print a buffer
 in hex values
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> ---
>  include/test.h |    2 ++
>  lib/tst_res.c  |   34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)

There is doc/man3/tst_res.3 that describes the rest of the interface
that should updated as well (we should at least add a line to the NAME
and SYNOPSIS). Bonus points for cleaning up the docs before that as well
;).

> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -675,6 +675,40 @@ void tst_resm(int ttype, char *arg_fmt, ...)
>  }
>  
>  /*
> + * tst_resm_hexd() - Interface to tst_res(), with no filename.
> + * Also, dump specified buffer in hex.
> + */
> +void tst_resm_hexd(int ttype, const char *buf, size_t size, char *arg_fmt, ...)

I think that the buffer should be better typed as 'const void *' as for
example in memcmp(3).

> +{
> +	char tmesg[USERMESG];
> +
> +#if DEBUG
> +	printf("IN tst_resm_hexd\n");
> +	fflush(stdout);
> +	fflush(stdout);

Why twice?

Ah some of the functions in the file does this too. I would expect that
this was some kind of workaround for obscure UNIX that is no longer
around us. Use only one here and we should remove the double fflush()
from the rest of the code.

> +#endif
> +
> +	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
> +
> +	static const size_t symb_num = 3; /* space + xx */
> +
> +	size_t offset = strlen(tmesg);
> +
> +	if ((offset + symb_num * size + 1) >= USERMESG) {
> +		printf("%s: %i: line too long\n", __func__, __LINE__);
> +		abort();

What about printing only the start of the buffer as:

'This is test message: 0x0F 0x04 0x33 0x44 ...'

instead of the abort?

> +	}
> +
> +	size_t i;
> +	for (i = 0; i < size; ++i) {
> +		sprintf(tmesg + offset + i * symb_num,
> +			" %02x", (unsigned char)buf[i]);
> +	}
> +
> +	tst_res(ttype, NULL, "%s", tmesg);
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
