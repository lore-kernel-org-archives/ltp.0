Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VadGT-0005k3-Ki
	for ltp-list@lists.sourceforge.net; Mon, 28 Oct 2013 03:13:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VadGS-0003rK-0o
	for ltp-list@lists.sourceforge.net; Mon, 28 Oct 2013 03:13:13 +0000
Message-ID: <526DD5FD.3070104@cn.fujitsu.com>
Date: Mon, 28 Oct 2013 11:11:57 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <00e501ced38a$b4b19e90$1e14dbb0$@gyu.kim@lge.com>
In-Reply-To: <00e501ced38a$b4b19e90$1e14dbb0$@gyu.kim@lge.com>
Subject: Re: [LTP] [PATCH] ext4-new-features: fix syntax error in configure
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
To: Honggyu Kim <hong.gyu.kim@lge.com>, ltp-list@lists.sourceforge.net

On 10/28/2013 11:06 AM, Honggyu Kim wrote:
> In configure, string comparison is done using double assignment.
> /bin/sh doesn't allow to compare strings using "==".
> So "==" is modified to "=".
> 
> Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/fs/ext4-new-features/configure |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/fs/ext4-new-features/configure b/testcases/kernel/fs/ext4-new-features/configure
> index 13f43f9..12849e5 100755
> --- a/testcases/kernel/fs/ext4-new-features/configure
> +++ b/testcases/kernel/fs/ext4-new-features/configure
> @@ -14,9 +14,9 @@ read EXT4_DEV
>  
>  echo "The partition is: $EXT4_DEV, Are you sure(Y/N)?"
>  read RESULT
> -if [ "$RESULT" == "Y" ] || [ "$RESULT" == "y" ]; then
> +if [ "$RESULT" = "Y" ] || [ "$RESULT" = "y" ]; then
>  	echo "EXT4_DEV=$EXT4_DEV" > ./ext4-test-config
> -elif [ "$RESULT" == "N" ]; then
> +elif [ "$RESULT" = "N" ]; then
>  	echo "Give up specifing a partition!"
>  else
>  	echo "Your input is wrong($RESULT)."
> 


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
