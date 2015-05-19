Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YufXX-0004yU-Nf
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 11:18:27 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YufXU-00083y-5V
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2015 11:18:27 +0000
Date: Tue, 19 May 2015 07:18:14 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1273450911.1653813.1432034294768.JavaMail.zimbra@redhat.com>
In-Reply-To: <1432025422.16347.6.camel@G08FNSTD140232>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
	<1431944048.27486.14.camel@G08FNSTD140232>
	<5559F134.7040705@oracle.com>
	<1432025422.16347.6.camel@G08FNSTD140232>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] fallocate04: another check if SEEK_HOLE is
	not	supported
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
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net
> Sent: Tuesday, 19 May, 2015 10:50:22 AM
> Subject: [LTP] [PATCH v2] fallocate04: another check if SEEK_HOLE is not	supported
> 
> SEEK_HOLE is only supported since version 3.1. Check the specified
> range blocks are zeroed while the kernel does not supported SEEK_HOLE.
> 
> Signed-off-by: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/fallocate/fallocate04.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c
> b/testcases/kernel/syscalls/fallocate/fallocate04.c
> index 911bbe8..e94c572 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> @@ -98,13 +98,13 @@ static void setup(void)
>  	get_blocksize();
>  }
>  
> -static void check_file_data(const char exp_buf[], size_t size)
> +static void check_file_data_(const char exp_buf[], size_t size, off_t
> offset)
>  {
>  	char rbuf[size];
>  
>  	tst_resm(TINFO, "reading the file, compare with expected buffer");
>  
> -	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
> +	SAFE_LSEEK(cleanup, fd, offset, SEEK_SET);
>  	SAFE_READ(cleanup, 1, fd, rbuf, size);
>  
>  	if (memcmp(exp_buf, rbuf, size)) {
> @@ -116,6 +116,11 @@ static void check_file_data(const char exp_buf[], size_t
> size)
>  	}
>  }
>  
> +static inline void check_file_data(const char exp_buf[], size_t size)
> +{
> +	check_file_data_(exp_buf, size, 0);
> +}
> +
>  static void test01(void)
>  {
>  	tst_resm(TINFO, "allocate '%zu' bytes", buf_size);
> @@ -158,7 +163,9 @@ static void test02(void)
>  			tst_brkm(TFAIL | TERRNO, cleanup,
>  				 "fallocate() or lseek() failed");
>  		}
> -		tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
> +		char zeros[block_size];
> +		memset(zeros, 0, block_size);
> +		check_file_data_(zeros, block_size, block_size);

Hi,

Isn't this redundant?

Couple lines below is this check, which also checks that range
<block_size, block_size*2> is zeroed.

        char exp_buf[buf_size];

        fill_tst_buf(exp_buf);
        memset(exp_buf + block_size, 0, block_size);
        check_file_data(exp_buf, buf_size);

Wouldn't it be enough to turn that warning into TINFO, for kernels < 3.1?

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 911bbe8..45d9827 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -158,9 +158,12 @@ static void test02(void)
                        tst_brkm(TFAIL | TERRNO, cleanup,
                                 "fallocate() or lseek() failed");
                }
-               tst_resm(TWARN | TERRNO, "lseek() doesn't support SEEK_HOLE");
+               if (tst_kvercmp(3, 1, 0) < 0)
+                       tst_resm(TINFO, "lseek() doesn't support SEEK_HOLE, "
+                               "this is expected for < 3.1 kernels");
+       } else {
+               tst_resm(TINFO, "found a hole at '%ld' offset", ret);
        }
-       tst_resm(TINFO, "found a hole at '%ld' offset", ret);
 
        size_t alloc_size1 = get_allocsize();
 
Regards,
Jan

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
