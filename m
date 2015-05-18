Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YuLb9-0008G6-Oz
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 14:00:51 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YuLb4-0000jj-3p
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 14:00:51 +0000
Message-ID: <5559F134.7040705@oracle.com>
Date: Mon, 18 May 2015 17:03:32 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
	<1431944048.27486.14.camel@G08FNSTD140232>
In-Reply-To: <1431944048.27486.14.camel@G08FNSTD140232>
Subject: Re: [LTP] [PATCH] fallocate04: another check if SEEK_HOLE is not
	supported
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
On 05/18/2015 01:14 PM, Zeng Linggang wrote:
> SEEK_HOLE is only supported since version 3.1. Check the specified
> range blocks are zeroed while the kernel does not supported SEEK_HOLE.
>
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>   testcases/kernel/syscalls/fallocate/fallocate04.c | 49 ++++++++++++++++++-----
>   1 file changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
> index 911bbe8..9d9587b 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> @@ -50,6 +50,8 @@ static const option_t options[] = {
>   	{NULL, NULL, NULL}
>   };
>   
> +static off_t check_file_hole(int, off_t, off_t);
> +
>   static void help(void)
>   {
>   	printf("  -v      Verbose\n");
> @@ -150,17 +152,12 @@ static void test02(void)
>   	}
>   
>   	tst_resm(TINFO, "check that file has a hole with lseek(,,SEEK_HOLE)");
> -	off_t ret = lseek(fd, 0, SEEK_HOLE);
>   
> -	if (ret != (ssize_t)block_size) {
> -		/* exclude error when kernel doesn't have SEEK_HOLE support */
> -		if (errno != EINVAL) {
> -			tst_brkm(TFAIL | TERRNO, cleanup,
> -				 "fallocate() or lseek() failed");
> -		}
> -		tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
> -	}
> -	tst_resm(TINFO, "found a hole at '%ld' offset", ret);
> +	off_t ret = check_file_hole(fd, block_size, block_size);
> +	if (ret != (ssize_t)block_size)
> +		tst_resm(TWARN | TERRNO, "No file hole found");
> +	else
> +		tst_resm(TINFO, "found a hole at '%ld' offset", ret);

'check_file_data' function read the file and check for zeroes (a few 
lines after lseek), so 'check_file_hole' seems pointless here.

Best regards,
Alexey


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
