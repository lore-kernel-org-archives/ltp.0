Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Xh66B-0005xL-AT
	for ltp-list@lists.sourceforge.net; Thu, 23 Oct 2014 00:17:51 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xh66A-0007IK-61
	for ltp-list@lists.sourceforge.net; Thu, 23 Oct 2014 00:17:51 +0000
Message-ID: <54484943.30601@cn.fujitsu.com>
Date: Thu, 23 Oct 2014 08:18:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1413983374-8784-1-git-send-email-zlang@redhat.com>
In-Reply-To: <1413983374-8784-1-git-send-email-zlang@redhat.com>
Subject: Re: [LTP] [Patch V2] ext4-new-features: modify
 ext4_get_inode_version.sh not know $EXT4_DEV definition
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
To: Zorro Lang <zlang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 10/22/2014 09:09 PM, Zorro Lang wrote:
> ext4_get_inode_version.sh use $EXT4_DEV, but it really doesn't know what is $EXT4_DEV.
> That cause other cases which use ext4_get_inode_version.sh to fail.


Applied, thank you.

Wanlong Gao

> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  testcases/kernel/fs/ext4-new-features/ext4_funcs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> index 0ae534a..b51e942 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
> @@ -45,7 +45,7 @@ ext4_setup()
>  	if [ -z "$LTP_BIG_DEV" ];then
>  		tst_brkm TCONF "tests need a big block device(5G-10G)"
>  	else
> -		EXT4_DEV=$LTP_BIG_DEV
> +		export EXT4_DEV=$LTP_BIG_DEV
>  	fi
>  
>  	tst_tmpdir
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
