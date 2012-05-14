Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1STpWr-0007Rg-LI
	for ltp-list@lists.sourceforge.net; Mon, 14 May 2012 07:17:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1STpWo-0002di-Nf
	for ltp-list@lists.sourceforge.net; Mon, 14 May 2012 07:17:13 +0000
Message-ID: <4FB0B125.3020808@cn.fujitsu.com>
Date: Mon, 14 May 2012 15:15:49 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1336655089-26941-1-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1336655089-26941-1-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 1/3] Indentation and coding style fixes on
 /lib/str_to_bytes.c as well as /include/str_to_bytes.h
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Marios Makris <marios.makris@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 05/10/2012 09:04 PM, Marios Makris wrote:

> Fixed broken identation as well as replaced the old K&R
> function declarations.
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>


Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  include/str_to_bytes.h |    6 +-
>  lib/str_to_bytes.c     |  162 +++++++++++++++++++++++-------------------------
>  2 files changed, 80 insertions(+), 88 deletions(-)
> 
> diff --git a/include/str_to_bytes.h b/include/str_to_bytes.h
> index 977a6b1..314eb88 100644
> --- a/include/str_to_bytes.h
> +++ b/include/str_to_bytes.h
> @@ -32,8 +32,8 @@
>  #ifndef _STR_TO_BYTES_
>  #define _STR_TO_BYTES_
>  
> -int       str_to_bytes  ( char * );
> -long      str_to_lbytes ( char * );
> -long long str_to_llbytes( char * );
> +int str_to_bytes(char *);
> +long str_to_lbytes(char *);
> +long long str_to_llbytes(char *);
>  
>  #endif
> diff --git a/lib/str_to_bytes.c b/lib/str_to_bytes.c
> index 26e4897..f18291c 100644
> --- a/lib/str_to_bytes.c
> +++ b/lib/str_to_bytes.c
> @@ -67,144 +67,136 @@
>  #define B_MULT UBSIZE
>  #endif
>  
> -
>  #define K_MULT	1024		/* Kilo or 2^10 */
>  #define M_MULT	1048576		/* Mega or 2^20 */
>  #define G_MULT	1073741824	/* Giga or 2^30 */
>  #define T_MULT	1099511627776	/* tera or 2^40 */
>  
> -int
> -str_to_bytes(s)
> -char    *s;
> +int str_to_bytes(char *s)
>  {
> -    char    mult, junk;
> -    int	    nconv;
> -    float   num;
> +	char mult, junk;
> +	int nconv;
> +	float num;
>  
> -    nconv = sscanf(s, "%f%c%c", &num, &mult, &junk);
> -    if (nconv == 0 || nconv == 3)
> -	return -1;
> +	nconv = sscanf(s, "%f%c%c", &num, &mult, &junk);
> +	if (nconv == 0 || nconv == 3)
> +		return -1;
>  
> -    if (nconv == 1)
> -	return num;
> +	if (nconv == 1)
> +		return num;
>  
> -    switch (mult) {
> -    case 'b':
> +	switch (mult) {
> +	case 'b':
>  		return (int)(num * (float)B_MULT);
> -    case 'k':
> +	case 'k':
>  		return (int)(num * (float)K_MULT);
> -    case 'K':
> +	case 'K':
>  		return (int)((num * (float)K_MULT) * sizeof(long));
> -    case 'm':
> +	case 'm':
>  		return (int)(num * (float)M_MULT);
> -    case 'M':
> +	case 'M':
>  		return (int)((num * (float)M_MULT) * sizeof(long));
> -    case 'g':
> +	case 'g':
>  		return (int)(num * (float)G_MULT);
> -    case 'G':
> -    		return (int)((num * (float)G_MULT) * sizeof(long));
> -    default:
> -	return -1;
> -    }
> +	case 'G':
> +		return (int)((num * (float)G_MULT) * sizeof(long));
> +	default:
> +		return -1;
> +	}
>  }
>  
> -long
> -str_to_lbytes(s)
> -char    *s;
> +long str_to_lbytes(char *s)
>  {
> -    char    mult, junk;
> -    long    nconv;
> -    float   num;
> +	char mult, junk;
> +	long nconv;
> +	float num;
>  
> -    nconv = sscanf(s, "%f%c%c", &num, &mult, &junk);
> -    if (nconv == 0 || nconv == 3)
> -	return -1;
> +	nconv = sscanf(s, "%f%c%c", &num, &mult, &junk);
> +	if (nconv == 0 || nconv == 3)
> +		return -1;
>  
> -    if (nconv == 1)
> -	return (long)num;
> +	if (nconv == 1)
> +		return (long)num;
>  
> -    switch (mult) {
> -    case 'b':
> +	switch (mult) {
> +	case 'b':
>  		return (long)(num * (float)B_MULT);
> -    case 'k':
> +	case 'k':
>  		return (long)(num * (float)K_MULT);
> -    case 'K':
> +	case 'K':
>  		return (long)((num * (float)K_MULT) * sizeof(long));
> -    case 'm':
> +	case 'm':
>  		return (long)(num * (float)M_MULT);
> -    case 'M':
> +	case 'M':
>  		return (long)((num * (float)M_MULT) * sizeof(long));
> -    case 'g':
> +	case 'g':
>  		return (long)(num * (float)G_MULT);
> -    case 'G':
> -    		return (long)((num * (float)G_MULT) * sizeof(long));
> -    default:
> -	return -1;
> -    }
> +	case 'G':
> +		return (long)((num * (float)G_MULT) * sizeof(long));
> +	default:
> +		return -1;
> +	}
>  }
>  
>  /*
>   * Force 64 bits number when compiled as 32 IRIX binary.
>   * This allows for a number bigger than 2G.
>   */
> -
> -long long
> -str_to_llbytes(s)
> -char    *s;
> +long long str_to_llbytes(char *s)
>  {
> -    char    mult, junk;
> -    long    nconv;
> -    double  num;
> +	char mult, junk;
> +	long nconv;
> +	double num;
>  
> -    nconv = sscanf(s, "%lf%c%c", &num, &mult, &junk);
> -    if (nconv == 0 || nconv == 3)
> -	return -1;
> +	nconv = sscanf(s, "%lf%c%c", &num, &mult, &junk);
> +	if (nconv == 0 || nconv == 3)
> +		return -1;
>  
> -    if (nconv == 1)
> -	return (long long)num;
> +	if (nconv == 1)
> +		return (long long)num;
>  
> -    switch (mult) {
> -    case 'b':
> +	switch (mult) {
> +	case 'b':
>  		return (long long)(num * (float)B_MULT);
> -    case 'k':
> +	case 'k':
>  		return (long long)(num * (float)K_MULT);
> -    case 'K':
> +	case 'K':
>  		return (long long)((num * (float)K_MULT) * sizeof(long long));
> -    case 'm':
> +	case 'm':
>  		return (long long)(num * (float)M_MULT);
> -    case 'M':
> +	case 'M':
>  		return (long long)((num * (float)M_MULT) * sizeof(long long));
> -    case 'g':
> +	case 'g':
>  		return (long long)(num * (float)G_MULT);
> -    case 'G':
> -    		return (long long)((num * (float)G_MULT) * sizeof(long long));
> -    default:
> -	return -1;
> -    }
> +	case 'G':
> +		return (long long)((num * (float)G_MULT) * sizeof(long long));
> +	default:
> +		return -1;
> +	}
>  }
>  
>  #ifdef UNIT_TEST
>  
>  main(int argc, char **argv)
>  {
> -    int ind;
> +	int ind;
>  
> -    if (argc == 1) {
> -	fprintf(stderr, "missing str_to_bytes() parameteres\n");
> -	exit(1);
> -    }
> +	if (argc == 1) {
> +		fprintf(stderr, "missing str_to_bytes() parameteres\n");
> +		exit(1);
> +	}
>  
> -    for (ind=1; ind<argc; ind++) {
> +	for (ind = 1; ind < argc; ind++) {
>  
> -	printf("str_to_bytes(%s) returned %d\n",
> -	    argv[ind], str_to_bytes(argv[ind]));
> +		printf("str_to_bytes(%s) returned %d\n",
> +		       argv[ind], str_to_bytes(argv[ind]));
>  
> -	printf("str_to_lbytes(%s) returned %ld\n",
> -	    argv[ind], str_to_lbytes(argv[ind]));
> +		printf("str_to_lbytes(%s) returned %ld\n",
> +		       argv[ind], str_to_lbytes(argv[ind]));
>  
> -	printf("str_to_llbytes(%s) returned %lld\n",
> -	    argv[ind], str_to_llbytes(argv[ind]));
> -    }
> +		printf("str_to_llbytes(%s) returned %lld\n",
> +		       argv[ind], str_to_llbytes(argv[ind]));
> +	}
>  }
>  
> -#endif
> \ No newline at end of file
> +#endif



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
