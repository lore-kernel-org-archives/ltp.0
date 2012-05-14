Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1STpXi-0007sr-CL
	for ltp-list@lists.sourceforge.net; Mon, 14 May 2012 07:18:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1STpXg-0002fT-8j
	for ltp-list@lists.sourceforge.net; Mon, 14 May 2012 07:18:06 +0000
Message-ID: <4FB0B15E.8090409@cn.fujitsu.com>
Date: Mon, 14 May 2012 15:16:46 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1336655089-26941-1-git-send-email-marios.makris@gmail.com>
	<1336655089-26941-2-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1336655089-26941-2-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 2/3] Renamed /lib/str_to_bytes.c and /include
 str_to bytes.h
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

> The str_to_bytes files have been renamed to bytes_by_prefix in order
> to make it easier for anyone to understand the purpose of the file,
> the functions of the file have also been ranmed accordingly.
> 
> Furthermore any call to the file or its functions by other functions,
> manpages etc. have been modified to comply with the new names.
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>


Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  README.ltp-devel.in                            |    2 +-
>  doc/man3/{str_to_bytes.3 => bytes_by_prefix.3} |   32 ++++++++++++------------
>  doc/man3/parse_ranges.3                        |    2 +-
>  include/{str_to_bytes.h => bytes_by_prefix.h}  |   10 +++---
>  lib/{str_to_bytes.c => bytes_by_prefix.c}      |   26 +++++++++---------
>  ltp-devel.spec.in                              |    4 +-
>  testcases/kernel/fs/doio/iogen.c               |   10 +++---
>  7 files changed, 43 insertions(+), 43 deletions(-)
>  rename doc/man3/{str_to_bytes.3 => bytes_by_prefix.3} (76%)
>  rename include/{str_to_bytes.h => bytes_by_prefix.h} (89%)
>  rename lib/{str_to_bytes.c => bytes_by_prefix.c} (89%)
> 
> diff --git a/README.ltp-devel.in b/README.ltp-devel.in
> index 5538997..50c377e 100644
> --- a/README.ltp-devel.in
> +++ b/README.ltp-devel.in
> @@ -44,5 +44,5 @@ To read manual pages, then the developer would type:
>  	man parse_ranges
>  	man random_range
>  	man rmobj
> -	man str_to_bytes
> +	man bytes_by_prefix
>  	man write_log
> diff --git a/doc/man3/str_to_bytes.3 b/doc/man3/bytes_by_prefix.3
> similarity index 76%
> rename from doc/man3/str_to_bytes.3
> rename to doc/man3/bytes_by_prefix.3
> index 0c5d2fc..ae20b60 100644
> --- a/doc/man3/str_to_bytes.3
> +++ b/doc/man3/bytes_by_prefix.3
> @@ -1,5 +1,5 @@
>  .\"
> -.\" $Id: str_to_bytes.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
> +.\" $Id: bytes_by_prefix.3,v 1.1 2000/07/27 16:59:03 alaffin Exp $
>  .\"
>  .\" Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>  .\" 
> @@ -31,19 +31,19 @@
>  .\" 
>  .\" http://oss.sgi.com/projects/GenInfo/NoticeExplan/
>  .\"
> -.TH STR_TO_BYTES 3 07/25/2000 "Linux Test Project"
> +.TH BYTES_BY_PREFIX 3 07/25/2000 "Linux Test Project"
>  .SH NAME
> -str_to_bytes \- convert a string to a int byte count
> -str_to_lbytes \- convert a string to a long byte count
> -str_to_llbytes \- convert a string to a long long byte count
> +bytes_by_prefix \- convert a string to a int byte count
> +lbytes_by_prefix \- convert a string to a long byte count
> +llbytes_by_prefix \- convert a string to a long long byte count
>  .SH SYNOPSIS
> -int str_to_byte(char *\fIstr\fR);
> +int bytes_by_prefix(char *\fIstr\fR);
>  .br
> -long str_to_lbyte(char *\fIstr\fR);
> +long lbytes_by_prefix(char *\fIstr\fR);
>  .br
> -long long str_to_llbyte(char *\fIstr\fR);
> +long long llbytes_by_prefix(char *\fIstr\fR);
>  .SH DESCRIPTION
> -\fBstr_to_bytes()\fR, \fBstr_to_lbytes()\fR, and \fBstr_to_llbytes()\fR converts
> +\fBbytes_by_prefix()\fR, \fBlbytes_by_prefix()\fR, and \fBllbytes_by_prefix()\fR converts
>  \fIstr\fR to an integer, long, or long long  byte count.  \fIstr\fR is an
>  floating point number optionally followed by a single character multiplier.
>  Currently the following multipliers are supported:
> @@ -61,7 +61,7 @@ Currently the following multipliers are supported:
>  .fi
>  .sp
>  \fIstr\fR is interpreted as floating point number (base 10).
> -When using \fBstr_to_llbytes()\fR, the uppercase suffix will result
> +When using \fBllbytes_by_prefix()\fR, the uppercase suffix will result
>  in multiplying by the size of a (long long) or 8.
>  .SH RETURNS
>  -1 if the integer portion of \fIstr\fR is invalid, if an unsupported
> @@ -69,18 +69,18 @@ multiplier is supplied, or if \fIstr\fR has extra leading or trailing
>  characters.  If \fIstr\fR contains a negative number, the return
>  value will be negative.
>  .SH EXAMPLES
> -\fBstr_to_bytes("1000")\fR
> +\fBbytes_by_prefix("1000")\fR
>  .br
>  .RS 8
>  Returns 1000
>  .RE
>  .br
> -\fBstr_to_bytes("5b")\fR
> +\fBbytes_by_prefix("5b")\fR
>  .br 
>  .RS 8 
>  Returns 5 * BSIZE.
>  .RE
> -\fBstr_to_bytes("1.5m")\fR
> +\fBbytes_by_prefix("1.5m")\fR
>  .br
>  .RS 8
>  Returns 1.5 * 1048576 or 1572864
> @@ -88,10 +88,10 @@ Returns 1.5 * 1048576 or 1572864
>  
>  .SH LIMITATIONS
>  
> -\fBstr_to_bytes()\fR and \fBstr_to_lbytes()\fR when compiled as
> +\fBbytes_by_prefix()\fR and \fBlbytes_by_prefix()\fR when compiled as
>  a 32 bit IRIX binary can only return a max number of 2g (2147483647).
> -However, \fBstr_to_lbytes()\fR is not limited by the 2g limit when
> -compiled as 64 bit binary, where \fBstr_to_bytes()\fR still is limited.
> +However, \fBlbytes_by_prefix()\fR is not limited by the 2g limit when
> +compiled as 64 bit binary, where \fBbytes_by_prefix()\fR still is limited.
>  
>  Note that the size of long will vary depending how if compiled as
>  a 32 or 64 bit binary.  The size of a long long is always 8.
> diff --git a/doc/man3/parse_ranges.3 b/doc/man3/parse_ranges.3
> index 9259317..d7830a3 100644
> --- a/doc/man3/parse_ranges.3
> +++ b/doc/man3/parse_ranges.3
> @@ -161,7 +161,7 @@ main()
>  .SH "SEE ALSO"
>  random_range(3),
>  random_range_seed(3),
> -str_to_bytes(3).
> +bytes_by_prefix(3).
>  .SH DIAGNOSTICS
>  parse_ranges() returns -1 on error or the number of ranges parsed.  No space
>  will be malloc'd if parse_ranges() fails.  Error
> diff --git a/include/str_to_bytes.h b/include/bytes_by_prefix.h
> similarity index 89%
> rename from include/str_to_bytes.h
> rename to include/bytes_by_prefix.h
> index 314eb88..f3465fa 100644
> --- a/include/str_to_bytes.h
> +++ b/include/bytes_by_prefix.h
> @@ -29,11 +29,11 @@
>   *
>   * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
>   */
> -#ifndef _STR_TO_BYTES_
> -#define _STR_TO_BYTES_
> +#ifndef _BYTES_BY_PREFIX_
> +#define _BYTES_BY_PREFIX_
>  
> -int str_to_bytes(char *);
> -long str_to_lbytes(char *);
> -long long str_to_llbytes(char *);
> +int bytes_by_prefix(char *);
> +long lbytes_by_prefix(char *);
> +long long llbytes_by_prefix(char *);
>  
>  #endif
> diff --git a/lib/str_to_bytes.c b/lib/bytes_by_prefix.c
> similarity index 89%
> rename from lib/str_to_bytes.c
> rename to lib/bytes_by_prefix.c
> index f18291c..b9ac565 100644
> --- a/lib/str_to_bytes.c
> +++ b/lib/bytes_by_prefix.c
> @@ -31,10 +31,10 @@
>   */
>  #include <stdio.h>
>  #include <sys/param.h>
> -#include "str_to_bytes.h"
> +#include "bytes_by_prefix.h"
>  
>  /****************************************************************************
> - * str_to_bytes(s)
> + * bytes_by_prefix(s)
>   *
>   * Computes the number of bytes described by string s.  s is assumed to be
>   * a base 10 positive (ie. >= 0) number followed by an optional single
> @@ -50,7 +50,7 @@
>   *              g       2^30 (1073741824)
>   *              G       2^30 (1073741824) * sizeof(long)
>   *
> - * for instance, "1k" and "1024" would both cause str_to_bytes to return 1024.
> + * for instance, "1k" and "1024" would both cause bytes_by_prefix to return 1024
>   *
>   * Returns -1 if mult is an invalid character, or if the integer portion of
>   * s is not a positive integer.
> @@ -72,7 +72,7 @@
>  #define G_MULT	1073741824	/* Giga or 2^30 */
>  #define T_MULT	1099511627776	/* tera or 2^40 */
>  
> -int str_to_bytes(char *s)
> +int bytes_by_prefix(char *s)
>  {
>  	char mult, junk;
>  	int nconv;
> @@ -105,7 +105,7 @@ int str_to_bytes(char *s)
>  	}
>  }
>  
> -long str_to_lbytes(char *s)
> +long lbytes_by_prefix(char *s)
>  {
>  	char mult, junk;
>  	long nconv;
> @@ -142,7 +142,7 @@ long str_to_lbytes(char *s)
>   * Force 64 bits number when compiled as 32 IRIX binary.
>   * This allows for a number bigger than 2G.
>   */
> -long long str_to_llbytes(char *s)
> +long long llbytes_by_prefix(char *s)
>  {
>  	char mult, junk;
>  	long nconv;
> @@ -182,20 +182,20 @@ main(int argc, char **argv)
>  	int ind;
>  
>  	if (argc == 1) {
> -		fprintf(stderr, "missing str_to_bytes() parameteres\n");
> +		fprintf(stderr, "missing bytes_by_prefix() parameteres\n");
>  		exit(1);
>  	}
>  
>  	for (ind = 1; ind < argc; ind++) {
>  
> -		printf("str_to_bytes(%s) returned %d\n",
> -		       argv[ind], str_to_bytes(argv[ind]));
> +		printf("bytes_by_prefix(%s) returned %d\n",
> +		       argv[ind], bytes_by_prefix(argv[ind]));
>  
> -		printf("str_to_lbytes(%s) returned %ld\n",
> -		       argv[ind], str_to_lbytes(argv[ind]));
> +		printf("lbytes_by_prefix(%s) returned %ld\n",
> +		       argv[ind], lbytes_by_prefix(argv[ind]));
>  
> -		printf("str_to_llbytes(%s) returned %lld\n",
> -		       argv[ind], str_to_llbytes(argv[ind]));
> +		printf("llbytes_by_prefix(%s) returned %lld\n",
> +		       argv[ind], llbytes_by_prefix(argv[ind]));
>  	}
>  }
>  
> diff --git a/ltp-devel.spec.in b/ltp-devel.spec.in
> index 83d0942..8205723 100644
> --- a/ltp-devel.spec.in
> +++ b/ltp-devel.spec.in
> @@ -28,7 +28,7 @@ It is intended to be used to build testcases using the provided API.
>  @prefix@/include/libtestsuite.h
>  @prefix@/include/usctest.h
>  @prefix@/include/string_to_tokens.h
> -@prefix@/include/str_to_bytes.h
> +@prefix@/include/bytes_by_prefix.h
>  @prefix@/include/databin.h
>  @prefix@/include/open_flags.h
>  @prefix@/include/write_log.h
> @@ -53,7 +53,7 @@ It is intended to be used to build testcases using the provided API.
>  @mandir@/man3/parse_open_flags.3
>  @mandir@/man3/tst_res.3
>  @mandir@/man3/write_log.3
> -@mandir@/man3/str_to_bytes.3
> +@mandir@/man3/bytes_by_prefix.3
>  @mandir@/man3/tst_set_error.3
>  @mandir@/man3/parse_opts.3
>  @mandir@/man3/string_to_tokens.3
> diff --git a/testcases/kernel/fs/doio/iogen.c b/testcases/kernel/fs/doio/iogen.c
> index 167edbd..f594007 100644
> --- a/testcases/kernel/fs/doio/iogen.c
> +++ b/testcases/kernel/fs/doio/iogen.c
> @@ -61,7 +61,7 @@
>  #include "libkern.h"
>  #endif
>  #include "doio.h"
> -#include "str_to_bytes.h"
> +#include "bytes_by_prefix.h"
>  #include "string_to_tokens.h"
>  #include "open_flags.h"
>  #include "random_range.h"
> @@ -1555,7 +1555,7 @@ parse_cmdline(int argc, char **argv, char *opts)
>  	    break;
>  
>  	case 'r':
> -	    if ((Rawmult = str_to_bytes(optarg)) == -1 ||
> +	    if ((Rawmult = bytes_by_prefix(optarg)) == -1 ||
>  		          Rawmult < 11 || Rawmult % BSIZE) {
>  		fprintf(stderr, "iogen%s:  Illegal -r arg (%s).  Must be > 0 and multipe of BSIZE (%d)\n",
>  			TagName, optarg, BSIZE);
> @@ -1587,7 +1587,7 @@ parse_cmdline(int argc, char **argv, char *opts)
>  	    break;
>  
>  	case 't':
> -	    if ((Mintrans = str_to_bytes(optarg)) == -1) {
> +	    if ((Mintrans = bytes_by_prefix(optarg)) == -1) {
>  		fprintf(stderr, "iogen%s:  Illegal -t arg (%s):  Must have the form num[bkm]\n", TagName, optarg);
>  		exit(1);
>  	    }
> @@ -1595,7 +1595,7 @@ parse_cmdline(int argc, char **argv, char *opts)
>  	    break;
>  
>  	case 'T':
> -	    if ((Maxtrans = str_to_bytes(optarg)) == -1) {
> +	    if ((Maxtrans = bytes_by_prefix(optarg)) == -1) {
>  		fprintf(stderr, "iogen%s:  Illegal -T arg (%s):  Must have the form num[bkm]\n", TagName, optarg);
>  		exit(1);
>  	    }
> @@ -1740,7 +1740,7 @@ parse_cmdline(int argc, char **argv, char *opts)
>  
>  	    if ((cp = strchr(argv[optind], ':')) != NULL) {
>  	        *cp = '\0';
> -	        if ((len = str_to_bytes(argv[optind])) == -1) {
> +	        if ((len = bytes_by_prefix(argv[optind])) == -1) {
>  		    fprintf(stderr,
>  			    "iogen%s:  illegal file length (%s) for file %s\n",
>  			    TagName, argv[optind], cp+1);



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
