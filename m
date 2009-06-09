Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME61S-0001Ub-8J
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:26:10 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME61R-0002NO-5m
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:26:10 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59INAUl018735
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:23:10 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IPsRY149798
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:25:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59IPrmM031679
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:25:53 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906081327.53491.jpalecek@web.de>
References: <200906081327.53491.jpalecek@web.de>
Date: Tue, 09 Jun 2009 23:55:10 +0530
Message-Id: <1244571911.5497.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Change some absolute paths in the linkat
	test	to	point to its own files instead of /etc/passwd
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-06-08 at 13:27 +0200, Jiri Palecek wrote: 
> This avoids unwanted error when /etc and /tmp are on different
>  devices
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/linkat/linkat01.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
> index d62416b..72845f2 100644
> --- a/testcases/kernel/syscalls/linkat/linkat01.c
> +++ b/testcases/kernel/syscalls/linkat/linkat01.c
> @@ -79,6 +79,7 @@ static void mylinkat_test(struct test_struct* desc);
>  #define TEST_FIFO "fifo"
> 
>  static char dpathname[256] = "%s/"TEST_DIR2"/"TEST_FILE1;
> +static char spathname[256] = "%s/"TEST_DIR1"/"TEST_FILE1;
>  static int olddirfd, newdirfd = -1, cwd_fd = AT_FDCWD, stdinfd = 0, crapfd = -1, deldirfd;
> 
>  struct test_struct {
> @@ -94,7 +95,7 @@ struct test_struct {
>  	/* relative paths */
>  	{ &olddirfd, TEST_FILE1, &newdirfd, TEST_FILE1, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0 },
>  	/* abs path at source */
> -	{ &olddirfd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
> +	{ &olddirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
>  	/* abs path at dst */
>  	{ &olddirfd, TEST_FILE1, &newdirfd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
> 
> @@ -103,7 +104,7 @@ struct test_struct {
>  	/* relative paths to cwd */
>  	{ &olddirfd, TEST_FILE1, &cwd_fd, TEST_DIR2"/"TEST_FILE1, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0 },
>  	/* abs path at source */
> -	{ &cwd_fd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
> +	{ &cwd_fd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
>  	/* abs path at dst */
>  	{ &olddirfd, TEST_FILE1, &cwd_fd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
> 
> @@ -112,7 +113,7 @@ struct test_struct {
>  	/* relative paths to invalid */
>  	{ &olddirfd, TEST_FILE1, &stdinfd, TEST_DIR2"/"TEST_FILE1, 0, 0, 0, ENOTDIR },
>  	/* abs path at source */
> -	{ &stdinfd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
> +	{ &stdinfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
>  	/* abs path at dst */
>  	{ &olddirfd, TEST_FILE1, &stdinfd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
> 
> @@ -121,7 +122,7 @@ struct test_struct {
>  	/* relative paths to crap */
>  	{ &olddirfd, TEST_FILE1, &crapfd, TEST_DIR2"/"TEST_FILE1, 0, 0, 0, EBADF },
>  	/* abs path at source */
> -	{ &crapfd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
> +	{ &crapfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
>  	/* abs path at dst */
>  	{ &olddirfd, TEST_FILE1, &crapfd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
> 
> @@ -130,7 +131,7 @@ struct test_struct {
>  	/* relative paths to deleted */
>  	{ &olddirfd, TEST_FILE1, &deldirfd, TEST_DIR2"/"TEST_FILE1, 0, 0, 0, ENOENT },
>  	/* abs path at source */
> -	{ &deldirfd, "/etc/passwd", &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
> +	{ &deldirfd, spathname, &newdirfd, TEST_FILE1, 0, 0, 0, 0 },
>  	/* abs path at dst */
>  	{ &olddirfd, TEST_FILE1, &deldirfd, dpathname, 0, TEST_DIR1"/"TEST_FILE1, TEST_DIR2"/"TEST_FILE1, 0},
> 
> @@ -298,6 +299,9 @@ static void setup()
>  	tmp = strdup(dpathname);
>  	snprintf(dpathname, sizeof(dpathname), tmp, get_current_dir_name());
> 
> +	tmp = strdup(spathname);
> +	snprintf(spathname, sizeof(spathname), tmp, get_current_dir_name());
> +
>  	/* Pause if that option was specified */
>  	TEST_PAUSE;
>  }				/* End setup() */


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
