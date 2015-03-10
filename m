Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1YVEmU-00089g-75
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 07:40:46 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YVEmS-0002i9-H8
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 07:40:46 +0000
Message-ID: <54FE9FB4.1080504@cn.fujitsu.com>
Date: Tue, 10 Mar 2015 15:39:32 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1425972660-2489-1-git-send-email-liwang@redhat.com>
In-Reply-To: <1425972660-2489-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH v2] commands/ade/ar01: the touched timestamp of
 file01.in should be newer than current
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
To: Li Wang <liwang@redhat.com>, ltp-list@lists.sourceforge.net

Applied, thanks!

On 03/10/2015 03:31 PM, Li Wang wrote:
> * Upate the timestamp form stable to dynamic.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/commands/ade/ar/ar01 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/commands/ade/ar/ar01 b/testcases/commands/ade/ar/ar01
> index 32fef11..ad88582 100755
> --- a/testcases/commands/ade/ar/ar01
> +++ b/testcases/commands/ade/ar/ar01
> @@ -483,7 +483,7 @@ do
>  	File2time=`ar -tv $TCtmp/lib.a | grep file2.in`
>  
>  	#sleep 5
> -	touch -c -t 201503030303.55 file0.in
> +	touch -c -t $(date --date='next day' +"%Y%m%d%H%M") file0.in
>  
>  	ar -ru $TCtmp/lib.a file0.in file2.in 2>&1 1>/dev/null
>  	File1time1=`ar -tv $TCtmp/lib.a | grep file0.in`
> 


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
