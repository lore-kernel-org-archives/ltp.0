Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N8Fbz-0000Un-24
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 15:59:59 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N8Fbu-00021I-O2
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 15:59:58 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nABFvtxB006659
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Nov 2009 10:57:56 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nABFxmFE095940
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Nov 2009 10:59:48 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nABFxjCr024943
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Nov 2009 10:59:45 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AFA18A6.50005@cn.fujitsu.com>
References: <4AFA18A6.50005@cn.fujitsu.com>
Date: Wed, 11 Nov 2009 21:29:40 +0530
Message-Id: <1257955180.27679.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] ext4: fix script error of
	ext4_nsec_timestamps_test.sh
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Miao Xie <miaox@cn.fujitsu.com>

On Wed, 2009-11-11 at 09:51 +0800, Wei Yongjun wrote: 
> Execute test case of ext4_nsec_timestamps_test.sh had some errors:
> ./ext4_nsec_timestamps_test.sh: line 183: [0: command not found
> ./ext4_nsec_timestamps_test.sh: line 189: [0: command not found
> 
> This patch fix them.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  .../ext4_nsec_timestamps_test.sh                   |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> index ad7729e..ced6576 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
> @@ -180,13 +180,13 @@ ext4_setup
>  RET=0
> 
>  ext4_test_sec_timestamps
> -if [$? -ne 0 ]; then
> +if [ $? -ne 0 ]; then
>  	RET=1
>  fi
>  : $((TST_COUNT++))
> 
>  ext4_test_nsec_timestamps
> -if [$? -ne 0 ]; then
> +if [ $? -ne 0 ]; then
>  	RET=1
>  fi
>  : $((TST_COUNT++))


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
