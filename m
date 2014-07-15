Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X6zWh-0005Cp-BD
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 09:59:59 +0000
Date: Tue, 15 Jul 2014 11:59:29 +0200
From: chrubis@suse.cz
Message-ID: <20140715095929.GA27102@rei>
References: <1404985422-6546-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1404985422-6546-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] remove meaningless TRETR flag
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
> diff --git a/include/test.h b/include/test.h
> index 011866d..2013a36 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -118,16 +118,42 @@ extern int Forker_npids;
>  
>  /* lib/tst_res.c */
>  const char *strttype(int ttype);
> -void tst_res(int ttype, const char *fname, const char *arg_fmt, ...)
> -	__attribute__ ((format (printf, 3, 4)));
> -void tst_resm(int ttype, const char *arg_fmt, ...)
> -	__attribute__ ((format (printf, 2, 3)));
> -void tst_resm_hexd(int ttype, const void *buf, size_t size, const char *arg_fmt, ...)
> -	__attribute__ ((format (printf, 4, 5)));
> -void tst_brk(int ttype, const char *fname, void (*func)(void), const char *arg_fmt, ...)
> +void tst_res_(const char *file, const int lineno, int ttype,
> +	const char *fname, const char *arg_fmt, ...)
> +	__attribute__ ((format (printf, 5, 6)));
> +
> +#define tst_res(ttype, fname, arg_fmt, ...) \
> +	tst_res_(__FILE__, __LINE__, (ttype), (fname), \
> +		 (arg_fmt), ##__VA_ARGS__)
> +
> +void tst_resm_(const char *file, const int lineno, int ttype,
> +	const char *arg_fmt, ...)
>  	__attribute__ ((format (printf, 4, 5)));
> -void tst_brkm(int ttype, void (*func)(void), const char *arg_fmt, ...)
> -	__attribute__ ((format (printf, 3, 4))) LTP_ATTRIBUTE_NORETURN;
> +#define tst_resm(ttype, arg_fmt, ...) \
> +	tst_resm_(__FILE__, __LINE__, (ttype), \
> +		  (arg_fmt), ##__VA_ARGS__)
> +
> +void tst_resm_hexd_(const char *file, const int lineno, int ttype,
> +	const void *buf, size_t size, const char *arg_fmt, ...)
> +	__attribute__ ((format (printf, 6, 7)));
> +#define tst_resm_hexd(ttype, buf, size, arg_fmt, ...) \
> +	tst_resm_hexd_(__FILE__, __LINE__, (ttype), (buf), (size), \
> +		       (arg_fmt), ##__VA_ARGS__)
> +
> +void tst_brk_(const char *file, const int lineno, int ttype,
> +	const char *fname, void (*func)(void), const char *arg_fmt, ...)
> +	__attribute__ ((format (printf, 6, 7)));
> +#define tst_brk(ttype, fname, func, arg_fmt, ...) \
> +	tst_brk_(__FILE__, __LINE__, (ttype), (fname), (func), \
> +		 (arg_fmt), ##__VA_ARGS__)
> +
> +void tst_brkm_(const char *file, const int lineno, int ttype,
> +	void (*func)(void), const char *arg_fmt, ...)
> +	__attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
> +#define tst_brkm(ttype, func, arg_fmt, ...) \
> +	tst_brkm_(__FILE__, __LINE__, (ttype), (func), \
> +		  (arg_fmt), ##__VA_ARGS__)
> +
>  void tst_require_root(void (*func)(void));
>  int  tst_environ(void);
>  void tst_exit(void) LTP_ATTRIBUTE_NORETURN;

This changes should be part of the next patch.

> diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
> index 5c5ab4c..bb1bfd6 100644
> --- a/include/tst_res_flags.h
> +++ b/include/tst_res_flags.h
> @@ -12,14 +12,13 @@
>  #define TST_RES_FLAGS_H
>  
>  /* Use low 6 bits to encode test type */
> -#define TTYPE_MASK	0x3f
> +#define TTYPE_MASK	0x1f
>  #define TPASS	0	/* Test passed flag */
>  #define TFAIL	1	/* Test failed flag */
>  #define TBROK	2	/* Test broken flag */
>  #define TWARN	4	/* Test warning flag */
> -#define TRETR	8	/* Test retire flag */
> -#define TINFO	16	/* Test information flag */
> -#define TCONF	32	/* Test not appropriate for configuration flag */
> +#define TINFO	8	/* Test information flag */
> +#define TCONF	16	/* Test not appropriate for configuration flag */
>  #define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)

Hmm, I would avoid renumbering these flags for compatibility reasons. Or
is there a good reason not to have unused bit there?


The rest looks ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
