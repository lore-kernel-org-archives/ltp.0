Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxico-0007yC-9P
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:45:18 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxicn-0003oL-AF
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:45:18 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DEdLiu029860
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:39:21 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DEj5ex213816
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:45:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DEj5qL009224
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:45:05 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4ACEE1D4.5000202@cn.fujitsu.com>
References: <4ACEE1D4.5000202@cn.fujitsu.com>
Date: Tue, 13 Oct 2009 20:13:59 +0530
Message-Id: <1255445039.8438.73.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] : fix memcg_function_test's bug
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
To: liubo <liubo-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-10-09 at 15:10 +0800, liubo wrote: 
> testcase_25() uses a wrong "$?" value ,
> Now use "ret" to record the real "$?" 
> value for test .
> 
> 
> Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> 
> ---
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> index ea4c8a2..0f11835 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> @@ -398,11 +398,12 @@ testcase_24()
>  testcase_25()
>  {
>  	echo -1 > memory.limit_in_bytes 2> /dev/null
> +	ret=$?
>  	tst_kvercmp 2 6 31
>  	if [ $? -eq 0 ]; then
> -		result $(( !($? != 0) ))  "return value is $?"
> +		result $(( !($ret != 0) ))  "return value is $ret"
>         else
> -		result $(( !($? == 0) ))  "return value is $?"
> +		result $(( !($ret == 0) ))  "return value is $ret"
>  	fi
>  }
> 
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
