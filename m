Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1RT3PL-0005Vr-9B
	for ltp-list@lists.sourceforge.net; Wed, 23 Nov 2011 03:21:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RT3PJ-0001Gz-Pq
	for ltp-list@lists.sourceforge.net; Wed, 23 Nov 2011 03:21:59 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 7A896170044
	for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Nov 2011 11:21:51 +0800 (CST)
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id pAN3Lpwv020132
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Nov 2011 11:21:51 +0800
Message-ID: <4ECC666C.2070400@cn.fujitsu.com>
Date: Wed, 23 Nov 2011 11:20:12 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4ECC636A.3040300@cn.fujitsu.com> <4ECC65C1.4060904@cn.fujitsu.com>
In-Reply-To: <4ECC65C1.4060904@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/6] -H option for hugetlbfs is no longer needed.
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
To: ltp-list@lists.sourceforge.net

hi,

Please ignore this.
Thanks.

On 11/23/2011 11:17 AM, tangchen wrote:
> The hugetlbfs will be mounted automatically when doing hugemmap tests, so -H option is no longer needed.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  runtest/hugetlb |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index af45868..641c2a6 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -1,7 +1,7 @@
> -hugemmap01 hugemmap01 -H/tmp
> -hugemmap02 hugemmap02 -H/tmp -c10
> -hugemmap03 hugemmap03 -H/tmp -I2 -c10
> -hugemmap04 hugemmap04 -H/tmp
> +hugemmap01 hugemmap01
> +hugemmap02 hugemmap02 -c10
> +hugemmap03 hugemmap03 -I2 -c10
> +hugemmap04 hugemmap04
>  hugemmap05 hugemmap05
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s

-- 
Best Regards,
Tang chen

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
