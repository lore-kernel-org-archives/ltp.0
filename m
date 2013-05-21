Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uelyt-0007BJ-RO
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 12:47:55 +0000
Date: Tue, 21 May 2013 14:49:05 +0200
From: chrubis@suse.cz
Message-ID: <20130521124905.GC28186@rei>
References: <1369066734-17683-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1369066734-17683-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] Create a function tst_resm_hexd to print a buffer
 in hex
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

A little more detailed description of the new function here please.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> @@ -40,6 +40,7 @@
>   *    FUNCTION NAME     :
>   *      tst_res() -       Print result message (include file contents)
>   *      tst_resm() -      Print result message
> + *      tst_resm_hexd() - Print result message (add buffer contents in hex)
>   *      tst_brk() -       Print result message (include file contents)
>   *                        and break remaining test cases
>   *      tst_brkm() -      Print result message and break remaining test
> @@ -62,6 +63,12 @@
>   *      int  ttype;
>   *      char *tmesg;
>   *
> + *      void tst_resm_hexd(ttype, buf, size, tmesg [,arg]...)
> + *      int  ttype;
> + *      const void *buf;
> + *      size_t size;
> + *      char *tmesg;

This part of the comment is IMHO useless as nobody will read the C code
when looking for documentation and evenmore this does not add more
information than the prototype in header. (I made a note to clean these
up later).

>   *      void tst_brk(ttype, fname, cleanup, tmesg, [,argv]...)
>   *      int  ttype;
>   *      char *fname;
> @@ -675,6 +682,47 @@ void tst_resm(int ttype, char *arg_fmt, ...)
>  }
>  
>  /*
> + * tst_resm_hexd() - Interface to tst_res(), with no filename.
> + * Also, dump specified buffer in hex.
> + */
> +void tst_resm_hexd(int ttype, const void *buf, size_t size, char *arg_fmt, ...)
> +{
> +	char tmesg[USERMESG];
> +
> +#if DEBUG
> +	printf("IN tst_resm_hexd\n");
> +	fflush(stdout);
> +#endif
> +
> +	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
> +
> +	static const char msg_end[] = " ...";
> +	static const size_t symb_num = 3; /* space + xx */
> +	size_t end_num = strlen(msg_end);

I think that todays compilers can avoid the call to strlen() on static
string but I would either hardcode the size of the string below or even
better use sizeof() which returns strlen() + 1 in this case.

> +	size_t offset = strlen(tmesg);
> +	int size_changed = 0;
> +
> +	if ((offset + symb_num * size + 1) >= USERMESG) {
> +		size = (USERMESG - offset) / symb_num - end_num - 1;

(USERMESG - offset - sizeof(msg_end)) / symb_num ?

> +		size_changed = 1;
> +	}
> +
> +	char *pmesg = tmesg + offset;
> +
> +	size_t i;
> +	for (i = 0; i < size; ++i) {
> +		sprintf(pmesg, " %02x", ((unsigned char *)buf)[i]);
> +		pmesg += symb_num;
> +	}
> +
> +	if (size_changed)
> +		strcat(pmesg, msg_end);

Shouldn't strcpy() suffice here?

> +	tst_res(ttype, NULL, "%s", tmesg);
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
