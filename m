Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OJnWk-0008Ik-MM
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 12:58:34 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OJnWj-00021j-OF
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 12:58:34 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o52CojHr021161
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 06:50:45 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o52CwHL0105706
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 06:58:17 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o52CwD2f021177
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 06:58:13 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C061631.3090407@rs.jp.nec.com>
References: <4C061631.3090407@rs.jp.nec.com>
Date: Wed, 02 Jun 2010 18:28:03 +0530
Message-Id: <1275483484.4899.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix ext4_subdir_limit fix
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
To: Akira Fujita <a-fujita@rs.jp.nec.com>
Cc: ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

On Wed, 2010-06-02 at 17:28 +0900, Akira Fujita wrote: 
> LTP: Fix ext4_subdir_limit fix
> 
> From: Akira Fujita <a-fujita@rs.jp.nec.com>

Thanks.

Regards--
Subrata

> 
> We get the following error results since the if condition
> in ext4_subdir_limit_tset.sh does not work fine.  The patch fixes this issue.
> 
> [root@bsd086 ltp]# ./runltp -f fs_ext4
> 
> <snip>
> 
> Ext4 subdir limit test
> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name,
> mkdir: No space left on device
> ext4-subdir-limit    2  TFAIL  :  failed to create directories - 19118
> 
> <snip>
> 
> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name,
> mkdir: No space left on device
> ext4-subdir-limit    4  TFAIL  :  failed to create directories - 19592
> 
> Signed-off-by: Akira Fujita <a-fujita@rs.jp.nec.com>
> ---
>  ext4_subdir_limit_test.sh |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> index 5631fe5..f0a3b50 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
> @@ -152,7 +152,8 @@ for ((i = 0; i < 3; i++))
>  	{
>  		for ((k = 0; k < 2; k++))
>  		{
> -			if [ $i -eq $LONG_DIR -a $k -eq 1024 ]; then
> +			if [ ${DIR_LEN[$k]} -eq $LONG_DIR -a \
> +				${BLOCK_SIZE[$i]} -eq 1024 ]; then
>  				continue
>  			fi
>  			ext4_run_case 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} \
> 
> 
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
