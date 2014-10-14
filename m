Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XdsHc-00042S-Oz
	for ltp-list@lists.sourceforge.net; Tue, 14 Oct 2014 02:56:20 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XdsHb-0001YX-Ec
	for ltp-list@lists.sourceforge.net; Tue, 14 Oct 2014 02:56:20 +0000
Message-ID: <543C9084.6070501@cn.fujitsu.com>
Date: Tue, 14 Oct 2014 10:55:00 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1413212682-13117-1-git-send-email-zlang@redhat.com>
In-Reply-To: <1413212682-13117-1-git-send-email-zlang@redhat.com>
Subject: Re: [LTP] [PATCH] ext4-new-features: modify
 ext4_get_inode_version.sh not know $EXT4_DEV definition
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

Hi,

On 10/13/2014 11:04 PM, Zorro Lang wrote:
> ext4_get_inode_version.sh use $EXT4_DEV, but it really doesn't know what is $EXT4_DEV.
> That cause other cases which use ext4_get_inode_version.sh to fail.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> When I ran ext4-inode-version, I always hit TFAIL. But I can't reproduce the failure manually.
> Then I found ext4_inode_version_test.sh use ext4_get_inode_version.sh ->  
> ext4_get_inode_version.sh use $EXT4_DEV ->
> but ext4_get_inode_version.sh doesn't know what is $EXT4_DEV.

Yeah, this is a bug :)
> 
> About this patch, I export $EXT4_DEV in ext4_inode_version_test.sh, before it call ext4_get_inode_version.sh.
> But I think add the "export" in front of "EXT4_DEV=$LTP_BIG_DEV" in ext4_funcs.sh will be another method.

I think adding "export EXT4_DEV=$LTP_BIG_DEV" in ext4_funcs.sh would be better.

Regards,
Xiaoguang Wang

> 
> Please review, and tell me which one do you think is better for LTP? Or you have a better one;)
> 
> Thank you,
> Zorro Lang
> 
>  .../fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh  | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> index ac8f021..2549088 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
> @@ -138,6 +138,8 @@ test_inode_version()
>  
>  # main
>  ext4_setup
> +# export EXT4_DEV for ext4_get_inode_version.sh can know it
> +export EXT4_DEV=$EXT4_DEV
>  
>  ext4_test_128_inode_version
>  
> 


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
