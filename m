Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YqIFv-0002Vz-Sw
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 09:38:11 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YqIFu-0007SB-Oy
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 09:38:11 +0000
Message-ID: <554B326F.8050808@oracle.com>
Date: Thu, 07 May 2015 12:37:51 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <554A7CCB.5030601@oracle.com>
	<1430979479-29407-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1430979479-29407-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] kernel/syscalls/fallocate: fix array parameter
 degradation
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

Hi,
On 05/07/2015 09:17 AM, Wei,Jiangang wrote:
> Using 'sizeof' on array given as function argument
> returns size of a pointer, instead of the array's.
> So,
> It needs to pass an additional parameter size_t size
> indicating the number of elements in the array.
>
> Besides above,
> Set adjacent two bytes in 'exp_buf' to zero in test04().
>
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>   testcases/kernel/syscalls/fallocate/fallocate04.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
> index 723c886..911bbe8 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> @@ -98,9 +98,8 @@ static void setup(void)
>   	get_blocksize();
>   }
>   
> -static void check_file_data(const char exp_buf[])
> +static void check_file_data(const char exp_buf[], size_t size)
>   {
> -	size_t size = sizeof(exp_buf);
>   	char rbuf[size];
>   
>   	tst_resm(TINFO, "reading the file, compare with expected buffer");
> @@ -175,7 +174,7 @@ static void test02(void)
>   	fill_tst_buf(exp_buf);
>   	memset(exp_buf + block_size, 0, block_size);
>   
> -	check_file_data(exp_buf);
> +	check_file_data(exp_buf, buf_size);
>   
>   	tst_resm(TPASS, "test-case succeeded");
>   }
> @@ -215,7 +214,7 @@ static void test03(void)
>   	fill_tst_buf(exp_buf);
>   	memset(exp_buf + block_size - 1, 0, block_size + 2);
>   
> -	check_file_data(exp_buf);
> +	check_file_data(exp_buf, buf_size);
>   
>   	tst_resm(TPASS, "test-case succeeded");
>   }
> @@ -251,7 +250,8 @@ static void test04(void)
>   	memcpy(exp_buf, tmp_buf, block_size);
>   	memcpy(exp_buf + block_size, tmp_buf + size, block_size);
>   
> -	check_file_data(exp_buf);
> +	exp_buf[block_size - 1] = exp_buf[block_size] = '\0';
> +	check_file_data(exp_buf, size);
>   
>   	tst_resm(TPASS, "test-case succeeded");
>   }

Patch applied, thank you!

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
