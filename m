Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MXvb0-0007dL-5K
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:20:50 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXvas-00018r-TY
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:20:50 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73BOJB0001039
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:24:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73BKZ4g246652
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:20:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73BHpAw021500
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:17:51 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40907310138v2708c6dfmb378df4004669c4f@mail.gmail.com>
References: <364299f40907310138v2708c6dfmb378df4004669c4f@mail.gmail.com>
Date: Mon, 03 Aug 2009 16:50:30 +0530
Message-Id: <1249298430.7460.29.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix C coding issues and integrate ima into LTP
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
To: Mimi Zohar <zohar@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

This as well for Mimi.

Regards--
Subrata

On Fri, 2009-07-31 at 01:38 -0700, Garrett Cooper wrote: 
> 1. None of the ima C files which required openssl/sha.h were using the
> HAVE_OPENSSL_SHA_H macro define.
> 2. Add tst_resm support.
> 3. Fix some missing includes in ima_mmap.c.
> 4. Remove an unused var.
> 5. Shuffle around some fields in ima_boot_aggregate.c so that it
> compiles with -Wunused and consumes less memory when 1. applies.
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> 
> Index: testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c,v
> retrieving revision 1.1
> diff -u -r1.1 ima_boot_aggregate.c
> --- testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c	31
> Mar 2009 13:58:14 -0000	1.1
> +++ testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c	31
> Jul 2009 08:37:08 -0000
> @@ -23,14 +23,21 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include "config.h"
> +#include "test.h"
> +#if HAVE_OPENSSL_SHA_H
>  #include <openssl/sha.h>
> +#endif
> 
>  #define MAX_EVENT_SIZE 500
>  #define EVENT_HEADER_SIZE 32
>  #define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
>  #define NUM_PCRS 8	/*  PCR registers 0-7 in boot aggregate */
> 
> -static void *display_sha1_digest(char *pcr)
> +char *TCID = "ima_boot_aggregate";
> +int TST_TOTAL = 1;
> +
> +static void display_sha1_digest(unsigned char *pcr)
>  {
>  	int i;
> 
> @@ -39,8 +46,10 @@
>  	printf("\n");
>  }
> 
> -int main(int argc, char *argv[])
> +int
> +main(int argc, char *argv[])
>  {
> +#if HAVE_OPENSSL_SHA_H
>  	unsigned char boot_aggregate[SHA_DIGEST_LENGTH];
>  	struct {
>  		struct {
> @@ -74,7 +83,7 @@
>  		memset(&pcr[i].digest, 0, SHA_DIGEST_LENGTH);
> 
>  	/* Extend the pseudo PCRs with the event digest */
> -	while (fread(&event, sizeof event.header, 1, fp)) {
> +	while (fread(&event, sizeof(event.header), 1, fp)) {
>  		if (debug) {
>  			printf("%03u ", event.header.pcr);
>  			display_sha1_digest(event.header.digest);
> @@ -105,6 +114,8 @@
> 
>  	printf("boot_aggregate:");
>  	display_sha1_digest(boot_aggregate);
> -
> -	return 0;
> +#else
> +	tst_resm(TCONF, "System doesn't have openssl/sha.h");
> +#endif
> +	tst_exit();
>  }
> Index: testcases/kernel/security/integrity/ima/src/ima_measure.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/src/ima_measure.c,v
> retrieving revision 1.1
> diff -u -r1.1 ima_measure.c
> --- testcases/kernel/security/integrity/ima/src/ima_measure.c	31 Mar
> 2009 13:58:14 -0000	1.1
> +++ testcases/kernel/security/integrity/ima/src/ima_measure.c	31 Jul
> 2009 08:37:08 -0000
> @@ -22,18 +22,23 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <unistd.h>
> +//#include "config.h"
> +#include "test.h"
> +#if HAVE_OPENSSL_SHA_H
>  #include <openssl/sha.h>
> +#endif
> 
>  #define TCG_EVENT_NAME_LEN_MAX	255
> 
> -static int verbose = 0;
> -static int validate = 0;
> -static int verify = 0;
> +char *TCID = "ima_measure";
> +int TST_TOTAL = 1;
> 
>  #define print_info(format, arg...) \
>  	if (verbose) \
>  		printf(format, ##arg)
> 
> +#if HAVE_OPENSSL_SHA_H
> +
>  static u_int8_t zero[SHA_DIGEST_LENGTH];
>  static u_int8_t fox[SHA_DIGEST_LENGTH];
> 
> @@ -90,6 +95,8 @@
>  	return 0;
>  }
> 
> +#endif
> +
>  /*
>   * ima_measurements.c - calculate the SHA1 aggregate-pcr value based
>   * on the IMA runtime binary measurements.
> @@ -120,13 +127,19 @@
>   * Return code: if verification enabled, returns number of verification
>   * 		errors.
>   */
> -int main(int argc, char *argv[])
> +int
> +main(int argc, char *argv[])
>  {
> +
> +#if HAVE_OPENSSL_SHA_H
>  	FILE *fp;
>  	struct event template;
>  	u_int8_t pcr[SHA_DIGEST_LENGTH];
>  	int i, count = 0, len;
> -	int failed_count = 0;	/* number of template verifications failed */
> +
> +	int verbose = 0;
> +	int validate = 0;
> +	int verify = 0;
> 
>  	if (argc < 2) {
>  		printf("format: %s binary_runtime_measurements" \
> @@ -191,12 +204,17 @@
>  		print_info(" %s\n", template.ima_data.filename);
> 
>  		if (verify)
> -			failed_count += verify_template_hash(&template);
> +			if (verify_template_hash(&template) != 0) {
> +				tst_resm(TFAIL, "Hash failed");
> +			}
>  	}
>  	fclose(fp);
> 
>  	verbose=1;
>  	print_info("PCRAggr (re-calculated):");
>  	display_sha1_digest(pcr);
> -	return failed_count;
> +#else
> +	tst_resm(TCONF, "System doesn't have openssl/sha.h");
> +#endif
> +	tst_exit();
>  }
> Index: testcases/kernel/security/integrity/ima/src/ima_mmap.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/src/ima_mmap.c,v
> retrieving revision 1.2
> diff -u -r1.2 ima_mmap.c
> --- testcases/kernel/security/integrity/ima/src/ima_mmap.c	19 May 2009
> 09:57:42 -0000	1.2
> +++ testcases/kernel/security/integrity/ima/src/ima_mmap.c	31 Jul 2009
> 08:37:08 -0000
> @@ -16,16 +16,20 @@
>   */
>  #include <stdio.h>
>  #include <string.h>
> +#include <unistd.h>
>  #include <sys/stat.h>
>  #include <sys/mman.h>
>  #include <fcntl.h>
> +#include "test.h"
> +
> +char *TCID = "ima_mmap";
> +int TST_TOTAL = 1;
> 
>  int main(int argc, char *argv[])
>  {
>  	int fd;
>  	void *file;
>  	char *filename;
> -	int rc;
> 
>  	if (argc != 2)
>  		printf("%s: filename\n", argv[1]);
> @@ -48,6 +52,5 @@
>  		perror("unmap");
>  		return(-1);
>  	}
> -
> -	return 0;
> +	tst_exit();
>  }
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
